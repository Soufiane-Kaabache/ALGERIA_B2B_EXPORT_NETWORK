import { vi } from 'vitest'

// Mock environment variables
process.env.NEXT_PUBLIC_SUPABASE_URL = 'https://test.supabase.co'
process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = 'test-key'

// Mock crypto for Node.js environment
if (!globalThis.crypto) {
  const crypto = require('crypto')
  globalThis.crypto = {
    getRandomValues: (arr: any) => crypto.randomBytes(arr.length),
    subtle: crypto.webcrypto.subtle,
  }
}

// Suppress console errors in tests
global.console.error = vi.fn()
global.console.warn = vi.fn()
