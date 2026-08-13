'use server'

import { createClient } from '@/utils/supabase/server'
import type { SupabaseClient } from '@supabase/supabase-js'
import type { ZodError } from 'zod'
import type { Database } from '@/types_db'
import { businessDraftSchema, businessSubmitSchema } from './schemas'
import type { ActionState } from './types'

type SupplierInsert = Database['public']['Tables']['suppliers']['Insert']
type SupplierUpdate = Database['public']['Tables']['suppliers']['Update']
type SupplierDocumentInsert = Database['public']['Tables']['kyc_documents']['Insert']
type SupabasePublicClient = SupabaseClient<Database>

type DbResponse<T> = { data: T | null; error: { code?: string | null; message: string } | null }

type DbError = { code?: string | null; message: string }

export const initialState: ActionState = { success: false, error: '' }

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
  const supabase = createClient() as SupabasePublicClient
  const { data: { user }, error: authError } = await supabase.auth.getUser()
  if (authError || !user) return { success: false, error: 'Session expirée. Veuillez vous reconnecter.' }

  const parsed = businessDraftSchema.safeParse(formDataToObject(formData))
  if (!parsed.success) return zodErrors(parsed.error)
  const d = parsed.data

  // Chercher le supplier existant pour cet utilisateur
  const { data: existingSupplier, error: supplierError } = await supabase
    .from('suppliers')
    .select('id')
    .eq('user_id', user.id)
    .maybeSingle()
  
  if (supplierError) return dbError(supplierError)

  // Construire le payload pour suppliers
  // Concaténer first_name et last_name pour contact_name
  const contactName = [d.first_name?.trim(), d.last_name?.trim()].filter(Boolean).join(' ')
  
  // Utiliser trade_name ou legal_name pour company_name
  const companyName = d.trade_name?.trim() || d.legal_name?.trim() || 'Entreprise sans nom'

  const payload: SupplierUpdate = {
    company_name: companyName,
    contact_name: contactName || null,
    wilaya_code: d.wilaya_code,
    address: emptyToNull(d.address),
    phone: emptyToNull(d.phone),
    email: emptyToNull(d.email),
    active: true,
  }

  if (existingSupplier) {
    // Mettre à jour le supplier existant
    const { data: updated, error } = await supabase
      .from('suppliers')
      .update(payload)
      .eq('id', existingSupplier.id)
      .select('id')
      .maybeSingle()
    
    if (error) return dbError(error)
    if (!updated) return { success: false, error: 'Fiche introuvable ou plus modifiable.' }
    
    return { success: true, message: 'Brouillon enregistré.', businessId: updated.id }
  }

  // Créer un nouveau supplier
  const insertPayload = { ...payload, user_id: user.id } as SupplierInsert

  const { data: created, error: insertError } = await supabase
    .from('suppliers')
    .insert(insertPayload)
    .select('id')
    .single()
  
  if (insertError) return dbError(insertError)

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

  // Chercher le supplier pour cet utilisateur
  const { data: supplier, error: supplierError } = await supabase
    .from('suppliers')
    .select('id')
    .eq('user_id', user.id)
    .maybeSingle()
  
  if (supplierError) return dbError(supplierError)
  if (!supplier) return { success: false, error: "Enregistrez d'abord votre brouillon." }

  // Uploader le fichier dans le storage
  const storagePath = `${supplier.id}/NRC`
  const { error: storageError } = await supabase.storage
    .from('supplier-docs')
    .upload(storagePath, file, { upsert: true, contentType: file.type })
  
  if (storageError) return { success: false, error: `Échec upload : ${storageError.message}` }

  // Supprimer les anciens documents NRC
  await supabase
    .from('kyc_documents')
    .delete()
    .eq('entity_id', supplier.id)
    .eq('entity_type', 'supplier')
    .eq('doc_type', 'nrc')

  // Créer une nouvelle entrée de document
  const docPayload: SupplierDocumentInsert = {
    entity_type: 'supplier',
    entity_id: supplier.id,
    doc_type: 'nrc',
    file_url: storagePath,
    status: 'pending',
  }
  
  const { error: docError } = await supabase.from('kyc_documents').insert(docPayload)
  if (docError) return dbError(docError)

  return { success: true, message: 'Registre de Commerce téléversé.', businessId: supplier.id }
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

  // Chercher le supplier pour cet utilisateur
  const { data: supplier, error: supplierError } = await supabase
    .from('suppliers')
    .select('id')
    .eq('user_id', user.id)
    .maybeSingle()
  
  if (supplierError) return dbError(supplierError)
  if (!supplier) return { success: false, error: "Enregistrez d'abord votre brouillon." }

  // Vérifier que le NRC a été téléversé
  const { data: docs, error: docsError } = await supabase
    .from('kyc_documents')
    .select('id')
    .eq('entity_id', supplier.id)
    .eq('entity_type', 'supplier')
    .eq('doc_type', 'nrc')
  
  if (docsError) return dbError(docsError)
  if (!docs || docs.length === 0) {
    return { success: false, error: 'Le NRC doit être téléversé avant de soumettre.' }
  }

  // Construire le payload pour suppliers
  const contactName = [d.first_name?.trim(), d.last_name?.trim()].filter(Boolean).join(' ')
  const companyName = d.trade_name?.trim() || d.legal_name?.trim() || 'Entreprise sans nom'

  const payload: SupplierUpdate = {
    company_name: companyName,
    contact_name: contactName || null,
    wilaya_code: d.wilaya_code,
    address: emptyToNull(d.address),
    phone: emptyToNull(d.phone),
    email: emptyToNull(d.email),
    active: true,
  }

  const { data: updated, error } = await supabase
    .from('suppliers')
    .update(payload)
    .eq('id', supplier.id)
    .select('id')
    .maybeSingle()

  if (error) {
    if (error.code === '42501' || /row-level security/i.test(error.message)) {
      return { success: false, error: 'Impossible de soumettre : vérifiez vos permissions.' }
    }
    return dbError(error)
  }
  
  if (!updated) return { success: false, error: 'Fiche non modifiable ou déjà soumise.' }

  return { success: true, message: 'Votre fiche a été soumise pour validation.', businessId: updated.id }
}
