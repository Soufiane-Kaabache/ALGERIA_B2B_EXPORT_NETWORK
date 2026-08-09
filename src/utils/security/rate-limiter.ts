interface RateLimitConfig {
  maxRequests: number;
  windowMs: number; // milliseconds
}

interface RateLimitStore {
  [key: string]: {
    count: number;
    resetTime: number;
  };
}

/**
 * Simple in-memory rate limiter
 */
export class RateLimiter {
  private store: RateLimitStore = {};
  private config: RateLimitConfig;

  constructor(config: RateLimitConfig = { maxRequests: 10, windowMs: 60000 }) {
    this.config = config;
  }

  /**
   * Check if request is allowed
   */
  isAllowed(identifier: string): boolean {
    const now = Date.now();
    const record = this.store[identifier];

    if (!record || now > record.resetTime) {
      // Reset if expired
      this.store[identifier] = {
        count: 1,
        resetTime: now + this.config.windowMs,
      };
      return true;
    }

    // Increment and check
    record.count++;
    return record.count <= this.config.maxRequests;
  }

  /**
   * Get remaining requests
   */
  getRemaining(identifier: string): number {
    const record = this.store[identifier];
    if (!record || Date.now() > record.resetTime) {
      return this.config.maxRequests;
    }
    return Math.max(0, this.config.maxRequests - record.count);
  }

  /**
   * Reset for identifier
   */
  reset(identifier: string): void {
    delete this.store[identifier];
  }

  /**
   * Clear all records
   */
  clear(): void {
    this.store = {};
  }
}
