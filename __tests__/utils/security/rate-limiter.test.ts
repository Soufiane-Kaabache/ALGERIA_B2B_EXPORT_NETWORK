import { describe, it, expect, beforeEach } from 'vitest'
import { checkRateLimit, resetRateLimit, RATE_LIMIT_CONFIG } from '@/utils/security/rate-limiter'

describe('Rate Limiter', () => {
  beforeEach(() => {
    // Reset rate limits before each test
    Object.keys(RATE_LIMIT_CONFIG).forEach((key) => {
      resetRateLimit('test-user', key as any)
    })
  })

  describe('checkRateLimit', () => {
    it('should allow requests within limit', () => {
      const result = checkRateLimit('test-user', 'api_call')
      
      expect(result.isAllowed).toBe(true)
      expect(result.remaining).toBeGreaterThanOrEqual(0)
      expect(result.retryAfter).toBeUndefined()
    })

    it('should track remaining requests', () => {
      const maxRequests = RATE_LIMIT_CONFIG.api_call.maxRequests
      let remaining = maxRequests - 1

      for (let i = 0; i < maxRequests; i++) {
        const result = checkRateLimit('test-user', 'api_call')
        expect(result.remaining).toBe(remaining)
        remaining--
      }
    })

    it('should block requests exceeding limit', () => {
      const maxRequests = RATE_LIMIT_CONFIG.api_call.maxRequests

      // Use up all allowed requests
      for (let i = 0; i < maxRequests; i++) {
        checkRateLimit('test-user', 'api_call')
      }

      // Next request should be blocked
      const result = checkRateLimit('test-user', 'api_call')
      expect(result.isAllowed).toBe(false)
      expect(result.remaining).toBe(0)
      expect(result.retryAfter).toBeDefined()
      expect(result.retryAfter).toBeGreaterThan(0)
    })

    it('should return reset time', () => {
      const result = checkRateLimit('test-user', 'api_call')
      
      expect(result.resetTime).toBeDefined()
      expect(result.resetTime).toBeGreaterThan(Date.now())
    })

    it('should apply different limits for different operations', () => {
      const uploadLimit = RATE_LIMIT_CONFIG.upload_document.maxRequests
      const apiLimit = RATE_LIMIT_CONFIG.api_call.maxRequests

      // Upload limit should be lower than API limit
      expect(uploadLimit).toBeLessThan(apiLimit)

      // Use up upload limit
      for (let i = 0; i < uploadLimit; i++) {
        checkRateLimit('test-user', 'upload_document')
      }

      // Next upload should fail
      const uploadResult = checkRateLimit('test-user', 'upload_document')
      expect(uploadResult.isAllowed).toBe(false)

      // But API calls should still work
      const apiResult = checkRateLimit('test-user', 'api_call')
      expect(apiResult.isAllowed).toBe(true)
    })

    it('should isolate limits per user', () => {
      const result1 = checkRateLimit('user-1', 'api_call')
      const result2 = checkRateLimit('user-2', 'api_call')

      // Both should be allowed initially
      expect(result1.isAllowed).toBe(true)
      expect(result2.isAllowed).toBe(true)

      // Remaining should be independent
      expect(result1.remaining).toBe(result2.remaining)
    })

    it('should handle upload_document rate limit specifically', () => {
      const maxUploads = RATE_LIMIT_CONFIG.upload_document.maxRequests

      for (let i = 0; i < maxUploads; i++) {
        const result = checkRateLimit('test-user', 'upload_document')
        expect(result.isAllowed).toBe(true)
      }

      // Next upload should be blocked
      const result = checkRateLimit('test-user', 'upload_document')
      expect(result.isAllowed).toBe(false)
      expect(result.retryAfter).toBeDefined()
    })

    it('should handle submit_for_review rate limit', () => {
      const maxSubmits = RATE_LIMIT_CONFIG.submit_for_review.maxRequests

      for (let i = 0; i < maxSubmits; i++) {
        checkRateLimit('test-user', 'submit_for_review')
      }

      const result = checkRateLimit('test-user', 'submit_for_review')
      expect(result.isAllowed).toBe(false)
    })
  })

  describe('resetRateLimit', () => {
    it('should reset rate limit for a user', () => {
      const maxRequests = RATE_LIMIT_CONFIG.api_call.maxRequests

      // Use up requests
      for (let i = 0; i < maxRequests; i++) {
        checkRateLimit('test-user', 'api_call')
      }

      // Should be blocked
      let result = checkRateLimit('test-user', 'api_call')
      expect(result.isAllowed).toBe(false)

      // Reset
      resetRateLimit('test-user', 'api_call')

      // Should be allowed again
      result = checkRateLimit('test-user', 'api_call')
      expect(result.isAllowed).toBe(true)
    })
  })
})
