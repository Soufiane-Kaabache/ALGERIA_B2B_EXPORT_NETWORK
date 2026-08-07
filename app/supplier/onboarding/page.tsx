'use client'

import { useEffect, useState } from 'react'
import { useFormState, useFormStatus } from 'react-dom'
import { createClient } from '@/utils/supabase/client'
import { cn } from '@/utils/cn'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle
} from '@/components/ui/card'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue
} from '@/components/ui/select'
import {
  AlertCircle,
  CheckCircle2,
  Loader2,
  Save,
  Send,
  Upload
} from 'lucide-react'
import {
  initialState,
  saveDraft,
  submitForReview,
  uploadNRC
} from './_lib/actions'
import { LEGAL_FORMS } from './_lib/schemas'
import type { Database } from '@/types_db'

type Wilaya = Database['public']['Tables']['wilayas']['Row']

// ---------------------------------------------------------------------------
// Champ texte réutilisable
// ---------------------------------------------------------------------------
function TextField({
  name,
  label,
  error,
  required,
  placeholder,
  type = 'text'
}: {
  name: string
  label: string
  error?: string
  required?: boolean
  placeholder?: string
  type?: string
}) {
  return (
    <div className="space-y-1.5">
      <Label htmlFor={name} className="text-sm font-medium">
        {label} {required && <span className="text-red-500">*</span>}
      </Label>
      <Input
        id={name}
        name={name}
        type={type}
        placeholder={placeholder}
        className={cn(error && 'border-red-500 focus-visible:ring-red-500')}
        aria-invalid={!!error}
      />
      {error && <p className="text-xs text-red-500">{error}</p>}
    </div>
  )
}

// ---------------------------------------------------------------------------
// Bouton avec indicateur de chargement
// ---------------------------------------------------------------------------
function SubmitButton({
  children,
  variant = 'default',
  disabled,
  formAction
}: {
  children: React.ReactNode
  variant?: 'default' | 'outline' | 'secondary'
  disabled?: boolean
  formAction?: (formData: FormData) => void
}) {
  const { pending } = useFormStatus()

  return (
    <Button
      type="submit"
      variant={variant}
      disabled={pending || disabled}
      formAction={formAction}
      className="w-full sm:w-auto"
    >
      {pending ? <Loader2 className="mr-2 h-4 w-4 animate-spin" /> : null}
      {children}
    </Button>
  )
}

// ---------------------------------------------------------------------------
// Page principale
// ---------------------------------------------------------------------------
export default function SupplierOnboardingPage() {
  const [wilayas, setWilayas] = useState<Wilaya[]>([])
  const [wilayaCode, setWilayaCode] = useState('')
  const [legalForm, setLegalForm] = useState('sarl')
  const [nrcUploaded, setNrcUploaded] = useState(false)
  const [editable, setEditable] = useState(true)
  const [loading, setLoading] = useState(true)

  const [draftState, draftAction] = useFormState(saveDraft, initialState)
  const [uploadState, uploadAction] = useFormState(uploadNRC, initialState)
  const [submitState, submitAction] = useFormState(submitForReview, initialState)

  useEffect(() => {
    const supabase = createClient()

    async function load() {
      const { data: wilayasData } = await supabase
        .from('wilayas')
        .select('*')
        .order('code')
      setWilayas(wilayasData ?? [])

      const { data: { user } } = await supabase.auth.getUser()

      if (user) {
        const { data: profile } = await supabase
          .from('user_profiles')
          .select('business_id')
          .eq('id', user.id)
          .maybeSingle()

        if (profile?.business_id) {
          const [{ data: business }, { data: docs }] = await Promise.all([
            supabase
              .from('businesses')
              .select('status')
              .eq('id', profile.business_id)
              .maybeSingle(),
            supabase
              .from('supplier_documents')
              .select('document_type, status')
              .eq('business_id', profile.business_id)
          ])

          const status = business?.status
          setEditable(!status || status === 'draft' || status === 'rejected')
          setNrcUploaded(
            docs?.some(
              (doc) => doc.document_type === 'nrc' && doc.status !== 'rejected'
            ) ?? false
          )
        }
      }

      setLoading(false)
    }

    load()
  }, [])

  useEffect(() => {
    if (uploadState?.success) setNrcUploaded(true)
  }, [uploadState?.success])

  const fieldErrors = {
    ...draftState?.fieldErrors,
    ...submitState?.fieldErrors
  }

  const err = (key: string) => fieldErrors[key]
  const canSubmit = nrcUploaded && editable

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center">
        <Loader2 className="h-8 w-8 animate-spin text-gray-500" />
      </div>
    )
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-10">
      <header className="mb-8">
        <h1 className="text-2xl font-bold tracking-tight">Onboarding fournisseur</h1>
        <p className="mt-1 text-sm text-gray-500">
          Complétez votre fiche entreprise, téléversez votre Registre de Commerce, puis soumettez pour validation.
        </p>
      </header>

      {!editable && (
        <div className="mb-6 flex items-center gap-2 rounded-md border border-amber-300 bg-amber-50 px-4 py-3 text-sm text-amber-800">
          <AlertCircle className="h-4 w-4" />
          Votre fiche n&apos;est plus modifiable car elle est déjà soumise ou validée.
        </div>
      )}

      <form className="space-y-6">
        <Card>
          <CardHeader>
            <CardTitle className="text-lg">1. Informations de l&apos;entreprise</CardTitle>
            <CardDescription>
              Les champs marqués * sont obligatoires pour la soumission.
            </CardDescription>
          </CardHeader>

          <CardContent className="grid gap-4 md:grid-cols-2">
            <TextField
              name="first_name"
              label="Prénom du responsable"
              error={err('first_name')}
              placeholder="Ex. Mohamed"
            />

            <TextField
              name="last_name"
              label="Nom du responsable"
              error={err('last_name')}
              placeholder="Ex. Benali"
            />

            <TextField
              name="trade_name"
              label="Nom commercial"
              required
              error={err('trade_name')}
              placeholder="Ex. Dattes Export"
            />

            <TextField
              name="legal_name"
              label="Raison sociale"
              required
              error={err('legal_name')}
              placeholder="Ex. SARL Dattes Export"
            />

            <div className="space-y-1.5">
              <Label htmlFor="legal_form" className="text-sm font-medium">
                Forme juridique <span className="text-red-500">*</span>
              </Label>
              <Select value={legalForm} onValueChange={setLegalForm}>
                <SelectTrigger
                  id="legal_form"
                  className={cn('w-full', err('legal_form') && 'border-red-500')}
                >
                  <SelectValue placeholder="Sélectionnez la forme juridique" />
                </SelectTrigger>
                <SelectContent>
                  {LEGAL_FORMS.map((form) => (
                    <SelectItem key={form.value} value={form.value}>
                      {form.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <input type="hidden" name="legal_form" value={legalForm} />
              {err('legal_form') && (
                <p className="text-xs text-red-500">{err('legal_form')}</p>
              )}
            </div>

            <TextField
              name="nif"
              label="NIF"
              error={err('nif')}
              placeholder="15 ou 19 chiffres"
            />

            <TextField
              name="nrc"
              label="NRC"
              error={err('nrc')}
              placeholder="Numéro de Registre de Commerce"
            />

            <TextField
              name="email"
              label="Email"
              type="email"
              error={err('email')}
              placeholder="contact@entreprise.dz"
            />

            <TextField
              name="phone"
              label="Téléphone"
              type="tel"
              error={err('phone')}
              placeholder="05 55 12 34 56"
            />

            <div className="space-y-1.5 md:col-span-2">
              <Label htmlFor="wilaya_code" className="text-sm font-medium">
                Wilaya <span className="text-red-500">*</span>
              </Label>
              <Select value={wilayaCode} onValueChange={setWilayaCode}>
                <SelectTrigger
                  id="wilaya_code"
                  className={cn('w-full', err('wilaya_code') && 'border-red-500')}
                >
                  <SelectValue placeholder="Sélectionnez votre wilaya" />
                </SelectTrigger>
                <SelectContent>
                  {wilayas.map((wilaya) => (
                    <SelectItem key={wilaya.code} value={wilaya.code}>
                      {wilaya.code} — {wilaya.name_en}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
              <input type="hidden" name="wilaya_code" value={wilayaCode} />
              {err('wilaya_code') && (
                <p className="text-xs text-red-500">{err('wilaya_code')}</p>
              )}
            </div>

            <div className="md:col-span-2">
              <TextField
                name="address"
                label="Adresse"
                error={err('address')}
                placeholder="Adresse complète"
              />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="text-lg">2. Registre de Commerce</CardTitle>
            <CardDescription>
              Document obligatoire pour soumettre (PDF, JPG, PNG — 5 Mo max).
            </CardDescription>
          </CardHeader>

          <CardContent className="space-y-3">
            <div className="flex flex-col gap-2 sm:flex-row">
              <Input
                id="nrc_file"
                name="nrc_file"
                type="file"
                accept=".pdf,.jpg,.jpeg,.png"
                className="flex-1"
                disabled={!editable}
              />
              <SubmitButton
                variant="secondary"
                disabled={!editable}
                formAction={uploadAction}
              >
                <Upload className="mr-2 h-4 w-4" />
                Téléverser
              </SubmitButton>
            </div>

            {nrcUploaded && (
              <p className="flex items-center gap-1.5 text-sm text-green-600">
                <CheckCircle2 className="h-4 w-4" />
                Registre de Commerce téléversé — vous pouvez soumettre.
              </p>
            )}

            {uploadState?.error && (
              <p className="flex items-center gap-1.5 text-sm text-red-500">
                <AlertCircle className="h-4 w-4" />
                {uploadState.error}
              </p>
            )}
          </CardContent>
        </Card>

        <Card>
          <CardContent className="space-y-3 pt-6">
            <div className="flex flex-col gap-3 sm:flex-row">
              <SubmitButton
                variant="outline"
                disabled={!editable}
                formAction={draftAction}
              >
                <Save className="mr-2 h-4 w-4" />
                Sauvegarder le brouillon
              </SubmitButton>

              <SubmitButton
                disabled={!canSubmit}
                formAction={submitAction}
              >
                <Send className="mr-2 h-4 w-4" />
                Soumettre pour validation
              </SubmitButton>
            </div>

            {draftState?.message && (
              <p className="text-sm text-green-600">{draftState.message}</p>
            )}

            {draftState?.error && (
              <p className="flex items-center gap-1.5 text-sm text-red-500">
                <AlertCircle className="h-4 w-4" />
                {draftState.error}
              </p>
            )}

            {submitState?.message && (
              <p className="text-sm text-green-600">{submitState.message}</p>
            )}

            {submitState?.error && (
              <p className="flex items-center gap-1.5 text-sm text-red-500">
                <AlertCircle className="h-4 w-4" />
                {submitState.error}
              </p>
            )}

            {!nrcUploaded && editable && (
              <p className="text-xs text-gray-500">
                Le bouton « Soumettre » est désactivé tant que le Registre de Commerce n&apos;est pas téléversé.
              </p>
            )}
          </CardContent>
        </Card>
      </form>
    </div>
  )
}