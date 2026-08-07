'use server'

import { createClient } from '@/utils/supabase/server'
import type { ZodError } from 'zod'
import type { Database } from '@/types_db'
import { businessDraftSchema, businessSubmitSchema } from './schemas'

type Business = Database['public']['Tables']['businesses']['Row']
type BusinessInsert = Database['public']['Tables']['businesses']['Insert']
type BusinessUpdate = Database['public']['Tables']['businesses']['Update']
type UserProfile = Database['public']['Tables']['user_profiles']['Row']
type SupplierDocumentInsert = Database['public']['Tables']['supplier_documents']['Insert']

export type ActionState = {
  success?: boolean
  error?: string
  message?: string
  fieldErrors?: Record<string, string>
  businessId?: string
}

export const initialState: ActionState = {}

type DbError = { code?: string | null; message: string }

const emptyToNull = (value?: string): string | null =>
  value && value.trim().length > 0 ? value.trim() : null

function formDataToObject(formData: FormData): Record<string, string> {
  const result: Record<string, string> = {}
  formData.forEach((value, key) => {
    if (typeof value === 'string') result[key] = value
  })
  return result
}

function zodErrors(error: ZodError): ActionState {
  const fieldErrors: Record<string, string> = {}
  for (const issue of error.issues) {
    const key = String(issue.path[0])
    if (!fieldErrors[key]) fieldErrors[key] = issue.message
  }
  return { success: false, error: 'Veuillez corriger les champs signalés.', fieldErrors }
}

function dbError(error: DbError): ActionState {
  if (error.code === '23505') {
    return { success: false, error: 'Un NIF ou NRC identique existe déjà sur une autre fiche.' }
  }
  if (error.code === '42501' || /row-level security/i.test(error.message)) {
    return { success: false, error: 'Opération refusée par les règles de sécurité de la plateforme.' }
  }
  return { success: false, error: error.message }
}

// ---------------------------------------------------------------------------
// BROUILLON
// ---------------------------------------------------------------------------
export async function saveDraft(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const supabase = createClient()
  const { data: { user }, error: authError } = await supabase.auth.getUser()
  if (authError || !user) return { success: false, error: 'Session expirée. Veuillez vous reconnecter.' }

  const parsed = businessDraftSchema.safeParse(formDataToObject(formData))
  if (!parsed.success) return zodErrors(parsed.error)
  const d = parsed.data

  const { data: profile, error: profileError } = await supabase
    .from('user_profiles')
    .select('business_id')
    .eq('id', user.id)
    .maybeSingle<{ business_id: string | null }>()

  if (profileError) return dbError(profileError)

  if (!profile) {
    const fieldErrors: Record<string, string> = {}
    if (!d.first_name?.trim()) fieldErrors.first_name = 'Prénom requis.'
    if (!d.last_name?.trim()) fieldErrors.last_name = 'Nom requis.'
    if (Object.keys(fieldErrors).length > 0) {
      return { success: false, error: 'Profil utilisateur incomplet.', fieldErrors }
    }
  }

  const payload: BusinessUpdate = {
    trade_name: d.trade_name.trim(),
    legal_name: d.legal_name.trim(),
    legal_form: d.legal_form,
    nif: emptyToNull(d.nif),
    nrc: emptyToNull(d.nrc),
    wilaya_code: d.wilaya_code,
    address: emptyToNull(d.address),
    phone: emptyToNull(d.phone),
    email: emptyToNull(d.email),
    status: 'draft',
  }

  if (profile?.business_id) {
    const { data: updated, error } = await supabase
      .from('businesses')
      .update(payload)
      .eq('id', profile.business_id)
      .select('id')
      .maybeSingle<Pick<Business, 'id'>>()

    if (error) return dbError(error)
    if (!updated) return { success: false, error: 'Fiche introuvable ou plus modifiable.' }
    return { success: true, message: 'Brouillon enregistré.', businessId: updated.id }
  }

  const { data: created, error: insertError } = await supabase
    .from('businesses')
    .insert({ ...payload, created_by: user.id } as BusinessInsert)
    .select('id')
    .single<Pick<Business, 'id'>>()

  if (insertError) return dbError(insertError)

  if (!profile) {
    const { error: profileInsertError } = await supabase.from('user_profiles').insert({
      id: user.id,
      business_id: created.id,
      first_name: d.first_name?.trim()!,
      last_name: d.last_name?.trim()!,
    })
    if (profileInsertError) return dbError(profileInsertError)
  } else {
    const { error: linkError } = await supabase
      .from('user_profiles')
      .update({ business_id: created.id })
      .eq('id', user.id)
    if (linkError) return dbError(linkError)
  }

  return { success: true, message: 'Brouillon enregistré.', businessId: created.id }
}

// ---------------------------------------------------------------------------
// UPLOAD NRC
// ---------------------------------------------------------------------------
export async function uploadNRC(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const supabase = createClient()
  const { data: { user }, error: authError } = await supabase.auth.getUser()
  if (authError || !user) return { success: false, error: 'Session expirée.' }

  const file = formData.get('nrc_file')
  if (!file || !(file instanceof File) || file.size === 0) {
    return { success: false, error: 'Veuillez sélectionner un fichier.' }
  }
  if (file.size > 5 * 1024 * 1024) return { success: false, error: 'Fichier trop lourd (5 Mo max).' }
  if (!['application/pdf', 'image/jpeg', 'image/png'].includes(file.type)) {
    return { success: false, error: 'Formats acceptés : PDF, JPG, PNG.' }
  }

  const { data: profile, error: profileError } = await supabase
    .from('user_profiles')
    .select('business_id')
    .eq('id', user.id)
    .maybeSingle<{ business_id: string | null }>()

  if (profileError) return dbError(profileError)
  if (!profile?.business_id) return { success: false, error: "Enregistrez d'abord votre brouillon." }

  const { data: business, error: businessError } = await supabase
    .from('businesses')
    .select('status')
    .eq('id', profile.business_id)
    .maybeSingle<Pick<Business, 'status'>>()

  if (businessError) return dbError(businessError)
  if (!business || !['draft', 'rejected'].includes(business.status)) {
    return { success: false, error: "La fiche n'est plus modifiable." }
  }

  const storagePath = `${profile.business_id}/NRC`
  const { error: storageError } = await supabase.storage
    .from('supplier-docs')
    .upload(storagePath, file, { upsert: true, contentType: file.type })

  if (storageError) return { success: false, error: `Échec upload : ${storageError.message}` }

  await supabase
    .from('supplier_documents')
    .delete()
    .eq('business_id', profile.business_id)
    .eq('document_type', 'nrc')

  const docPayload: SupplierDocumentInsert = {
    business_id: profile.business_id,
    document_type: 'nrc',
    file_path: storagePath,
  }
  const { error: docError } = await supabase.from('supplier_documents').insert(docPayload)
  if (docError) return dbError(docError)

  return { success: true, message: 'Registre de Commerce téléversé.', businessId: profile.business_id }
}

// ---------------------------------------------------------------------------
// SOUMISSION
// ---------------------------------------------------------------------------
export async function submitForReview(_prev: ActionState, formData: FormData): Promise<ActionState> {
  const supabase = createClient()
  const { data: { user }, error: authError } = await supabase.auth.getUser()
  if (authError || !user) return { success: false, error: 'Session expirée.' }

  const parsed = businessSubmitSchema.safeParse(formDataToObject(formData))
  if (!parsed.success) return zodErrors(parsed.error)
  const d = parsed.data

  const { data: profile, error: profileError } = await supabase
    .from('user_profiles')
    .select('business_id')
    .eq('id', user.id)
    .maybeSingle<{ business_id: string | null }>()

  if (profileError) return dbError(profileError)
  if (!profile?.business_id) return { success: false, error: "Enregistrez d'abord votre brouillon." }

  const payload: BusinessUpdate = {
    trade_name: d.trade_name.trim(),
    legal_name: d.legal_name.trim(),
    legal_form: d.legal_form,
    nif: emptyToNull(d.nif),
    nrc: emptyToNull(d.nrc),
    wilaya_code: d.wilaya_code,
    address: emptyToNull(d.address),
    phone: emptyToNull(d.phone),
    email: emptyToNull(d.email),
    status: 'pending_review',
  }

  const { data: updated, error } = await supabase
    .from('businesses')
    .update(payload)
    .eq('id', profile.business_id)
    .select('id, status')
    .maybeSingle<Pick<Business, 'id' | 'status'>>()

  if (error) {
    if (error.code === '42501' || /row-level security/i.test(error.message)) {
      return { success: false, error: 'Impossible de soumettre : le NRC doit être téléversé.' }
    }
    return dbError(error)
  }
  if (!updated) return { success: false, error: 'Fiche non modifiable ou déjà soumise.' }

  return { success: true, message: 'Votre fiche a été soumise pour validation.', businessId: updated.id }
}
