import { z } from 'zod'

// Règles métier Algérie
export const DZ_PHONE_REGEX = /^0[5-7]\d{8}$/
export const NIF_REGEX = /^(\d{15}|\d{19})$/
export const WILAYA_REGEX = /^\d{2}$/

const optionalString = z.string().optional().or(z.literal(''))
const optionalPhone = z
  .string()
  .regex(DZ_PHONE_REGEX, 'Téléphone DZ invalide (05/06/07 + 8 chiffres)')
  .optional()
  .or(z.literal(''))
const optionalNif = z
  .string()
  .regex(NIF_REGEX, 'NIF invalide : 15 ou 19 chiffres')
  .optional()
  .or(z.literal(''))
const optionalEmail = z.string().email('Email invalide').optional().or(z.literal(''))

const legalFormSchema = z.enum(
  ['sarl', 'spa', 'eurl', 'snc', 'surl', 'sas', 'auto_entrepreneur', 'association'],
  { errorMap: () => ({ message: 'Forme juridique invalide' }) }
)

export const LEGAL_FORMS: Array<{ value: string; label: string }> = [
  { value: 'sarl', label: 'SARL' },
  { value: 'spa', label: 'SPA' },
  { value: 'eurl', label: 'EURL' },
  { value: 'snc', label: 'SNC' },
  { value: 'surl', label: 'SURL' },
  { value: 'sas', label: 'SAS' },
  { value: 'auto_entrepreneur', label: 'Auto-entrepreneur' },
  { value: 'association', label: 'Association' },
]

export const businessDraftSchema = z.object({
  first_name: optionalString,
  last_name: optionalString,
  trade_name: z.string().min(2, 'Nom commercial requis'),
  legal_name: z.string().min(2, 'Raison sociale requise'),
  legal_form: legalFormSchema,
  nif: optionalNif,
  nrc: optionalString,
  wilaya_code: z
    .string()
    .regex(WILAYA_REGEX, 'Code wilaya invalide')
    .refine((code) => Number(code) >= 1 && Number(code) <= 69, 'Wilaya invalide'),
  address: optionalString,
  phone: optionalPhone,
  email: optionalEmail,
})

export const businessSubmitSchema = businessDraftSchema.extend({
  phone: z.string().regex(DZ_PHONE_REGEX, 'Téléphone DZ invalide (05/06/07 + 8 chiffres)'),
  nif: z.string().regex(NIF_REGEX, 'NIF invalide : 15 ou 19 chiffres'),
  nrc: z.string().min(3, 'NRC requis').max(20, 'NRC trop long'),
})

export type BusinessDraftValues = z.infer<typeof businessDraftSchema>
export type BusinessSubmitValues = z.infer<typeof businessSubmitSchema>