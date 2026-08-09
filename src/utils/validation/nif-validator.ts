/**
 * Validate Algerian NIF (Numéro d'Identification Fiscale)
 * Format: 10 digits
 * Rules:
 * - Must be exactly 10 digits
 * - First digit cannot be 0
 */
export function isValidNIF(nif: string): boolean {
  // Remove spaces and hyphens
  const cleaned = nif.replace(/[\s-]/g, '');

  // Must be 10 digits
  if (!/^\d{10}$/.test(cleaned)) {
    return false;
  }

  // First digit cannot be 0
  if (cleaned[0] === '0') {
    return false;
  }

  return true;
}

/**
 * Format NIF with hyphens (e.g., "123-456-789-01")
 */
export function formatNIF(nif: string): string {
  const cleaned = nif.replace(/[\s-]/g, '');
  if (!/^\d{10}$/.test(cleaned)) {
    return nif; // Return original if invalid
  }
  return `${cleaned.slice(0, 3)}-${cleaned.slice(3, 6)}-${cleaned.slice(6, 9)}-${cleaned.slice(9)}`;
}

/**
 * Validate Algerian NRC (Numéro de Registre de Commerce)
 * Format: 10 digits or alphanumeric
 */
export function isValidNRC(nrc: string): boolean {
  // Remove spaces and hyphens
  const cleaned = nrc.replace(/[\s-]/g, '');

  // Must be 10 characters (digits or letters)
  if (!/^[A-Z0-9]{10}$/i.test(cleaned)) {
    return false;
  }

  return true;
}

/**
 * Format NRC with hyphens
 */
export function formatNRC(nrc: string): string {
  const cleaned = nrc.replace(/[\s-]/g, '').toUpperCase();
  if (!/^[A-Z0-9]{10}$/i.test(cleaned)) {
    return nrc; // Return original if invalid
  }
  return `${cleaned.slice(0, 3)}-${cleaned.slice(3, 6)}-${cleaned.slice(6, 9)}-${cleaned.slice(9)}`;
}
