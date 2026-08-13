export type ActionState = {
  success?: boolean
  error?: string
  message?: string
  fieldErrors?: Record<string, string>
  businessId?: string
}

export const initialState: ActionState = {}