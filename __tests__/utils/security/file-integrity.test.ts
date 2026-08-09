import { describe, it, expect } from 'vitest'
import {
  validateFile,
  sanitizeFilename,
  generateFileHash,
  verifyFileIntegrity,
} from '@/utils/security/file-integrity'

describe('File Integrity & Security', () => {
  describe('validateFile', () => {
    it('should accept valid PDF file', () => {
      const mockFile = new File(['test content'], 'document.pdf', {
        type: 'application/pdf',
      })
      Object.defineProperty(mockFile, 'size', { value: 1024 * 1024 }) // 1 MB

      const result = validateFile(mockFile, 'nrc')
      expect(result.isValid).toBe(true)
    })

    it('should reject file exceeding size limit', () => {
      const mockFile = new File(['x'.repeat(10 * 1024 * 1024)], 'large.pdf', {
        type: 'application/pdf',
      })
      Object.defineProperty(mockFile, 'size', { value: 10 * 1024 * 1024 }) // 10 MB

      const result = validateFile(mockFile, 'nrc')
      expect(result.isValid).toBe(false)
      expect(result.error).toContain('trop volumineux')
    })

    it('should reject unsupported MIME type', () => {
      const mockFile = new File(['test'], 'document.exe', {
        type: 'application/x-msdownload',
      })

      const result = validateFile(mockFile, 'nrc')
      expect(result.isValid).toBe(false)
      expect(result.error).toContain('Format non accepté')
    })

    it('should accept multiple valid formats for NRC', () => {
      const formats = [
        { name: 'test.pdf', type: 'application/pdf' },
        { name: 'test.jpg', type: 'image/jpeg' },
        { name: 'test.png', type: 'image/png' },
      ]

      formats.forEach(({ name, type }) => {
        const mockFile = new File(['test'], name, { type })
        Object.defineProperty(mockFile, 'size', { value: 1024 * 1024 })

        const result = validateFile(mockFile, 'nrc')
        expect(result.isValid).toBe(true)
      })
    })
  })

  describe('sanitizeFilename', () => {
    it('should remove null bytes', () => {
      const filename = 'file\x00name.pdf'
      const result = sanitizeFilename(filename)
      expect(result).toBe('filename.pdf')
    })

    it('should remove path traversal attempts', () => {
      const filename = '../../../etc/passwd'
      const result = sanitizeFilename(filename)
      expect(result.includes('..')).toBe(false)
    })

    it('should replace path separators', () => {
      const filename = 'path/to\\file.pdf'
      const result = sanitizeFilename(filename)
      expect(result).not.toContain('/')
      expect(result).not.toContain('\\')
    })

    it('should remove special characters', () => {
      const filename = 'file<>:|?.pdf'
      const result = sanitizeFilename(filename)
      expect(result).toBe('file.pdf')
    })

    it('should limit filename length', () => {
      const filename = 'a'.repeat(300) + '.pdf'
      const result = sanitizeFilename(filename)
      expect(result.length).toBeLessThanOrEqual(255)
    })

    it('should preserve valid filenames', () => {
      const filename = 'my-document_v2.pdf'
      const result = sanitizeFilename(filename)
      expect(result).toBe('my-document_v2.pdf')
    })
  })

  describe('generateFileHash', () => {
    it('should generate SHA-256 hash', () => {
      const buffer = Buffer.from('test content')
      const hash = generateFileHash(buffer)

      expect(hash.algorithm).toBe('sha256')
      expect(hash.digest).toBeDefined()
      expect(hash.digest.length).toBe(64) // SHA-256 hex is 64 chars
      expect(hash.fileSize).toBe(12)
    })

    it('should generate consistent hash for same content', () => {
      const buffer = Buffer.from('test content')
      const hash1 = generateFileHash(buffer)
      const hash2 = generateFileHash(buffer)

      expect(hash1.digest).toBe(hash2.digest)
    })

    it('should generate different hash for different content', () => {
      const hash1 = generateFileHash(Buffer.from('content1'))
      const hash2 = generateFileHash(Buffer.from('content2'))

      expect(hash1.digest).not.toBe(hash2.digest)
    })
  })

  describe('verifyFileIntegrity', () => {
    it('should verify matching hashes', () => {
      const buffer = Buffer.from('test content')
      const hash = generateFileHash(buffer)

      const isValid = verifyFileIntegrity(hash, hash.digest)
      expect(isValid).toBe(true)
    })

    it('should reject mismatched hashes', () => {
      const hash = generateFileHash(Buffer.from('test content'))
      const differentHash = 'abc123def456'

      const isValid = verifyFileIntegrity(hash, differentHash)
      expect(isValid).toBe(false)
    })
  })
})
