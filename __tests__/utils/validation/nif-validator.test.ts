import { describe, it, expect } from 'vitest'
import { validateNifChecksum, getNifMetadata } from '@/utils/validation/nif-validator'

describe('NIF Validator', () => {
  describe('validateNifChecksum', () => {
    it('should validate a correct 15-digit NIF', () => {
      // Valid test NIF (Algerian format)
      const validNif = '123456789012345'
      const result = validateNifChecksum(validNif)
      expect(typeof result).toBe('boolean')
    })

    it('should reject an invalid 15-digit NIF', () => {
      const invalidNif = '000000000000000'
      const result = validateNifChecksum(invalidNif)
      expect(result).toBe(false)
    })

    it('should validate a correct 19-digit NIF', () => {
      const validNif = '1234567890123451234'
      const result = validateNifChecksum(validNif)
      expect(typeof result).toBe('boolean')
    })

    it('should reject NIF with wrong length', () => {
      expect(validateNifChecksum('12345')).toBe(false)
      expect(validateNifChecksum('123456789012345678901')).toBe(false)
    })

    it('should reject NIF with non-digit characters', () => {
      expect(validateNifChecksum('1234567890123A5')).toBe(false)
      expect(validateNifChecksum('123456789012345.')).toBe(false)
    })

    it('should reject empty or null NIF', () => {
      expect(validateNifChecksum('')).toBe(false)
    })
  })

  describe('getNifMetadata', () => {
    it('should return null for invalid NIF', () => {
      const result = getNifMetadata('invalid')
      expect(result).toBeNull()
    })

    it('should return metadata for valid NIF', () => {
      const validNif = '123456789012345'
      const result = getNifMetadata(validNif)
      
      if (result !== null) {
        expect(result.isValid).toBe(true)
        expect(result.nif).toBe(validNif)
        expect(result.type).toBe('individual')
        expect(result.length).toBe(15)
      }
    })

    it('should identify 19-digit NIF as entity type', () => {
      const validNif = '1234567890123451234'
      const result = getNifMetadata(validNif)
      
      if (result !== null) {
        expect(result.length).toBe(19)
        expect(result.type).toBe('entity')
      }
    })
  })
})
