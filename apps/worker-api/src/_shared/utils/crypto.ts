/**
 * #R3-1: Upgraded password hashing from plain SHA-256 to PBKDF2 with random salt.
 *
 * SHA-256 (unsalted) is vulnerable to rainbow table attacks — a single lookup
 * table can crack all passwords. PBKDF2 adds:
 *   - Random 128-bit salt per password (prevents rainbow tables)
 *   - 100k iterations (makes brute force computationally expensive)
 *   - Compatible with Cloudflare Workers (no native bcrypt)
 *
 * MIGRATION: Existing SHA-256 hashes are auto-detected by format.
 * On next login, users are transparently re-hashed to PBKDF2.
 */

const ITERATIONS = 100_000;
const KEY_LENGTH = 64;  // bytes
const SALT_LENGTH = 16; // bytes

/**
 * R21: Constant-time string comparison to prevent timing attacks.
 * Always checks all characters regardless of mismatch position.
 */
function timingSafeEqual(a: string, b: string): boolean {
    if (a.length !== b.length) return false;
    let result = 0;
    for (let i = 0; i < a.length; i++) {
        result |= a.charCodeAt(i) ^ b.charCodeAt(i);
    }
    return result === 0;
}

/**
 * Hash a password using PBKDF2-SHA256 with a random salt.
 * Output format: `pbkdf2:iterations:salt_hex:hash_hex`
 */
export async function hashPassword(password: string): Promise<string> {
    const salt = crypto.getRandomValues(new Uint8Array(SALT_LENGTH));
    const encoder = new TextEncoder();
    const keyMaterial = await crypto.subtle.importKey(
        'raw', encoder.encode(password), 'PBKDF2', false, ['deriveBits']
    );
    const derivedBits = await crypto.subtle.deriveBits(
        { name: 'PBKDF2', salt, iterations: ITERATIONS, hash: 'SHA-256' },
        keyMaterial, KEY_LENGTH * 8
    );
    const hashHex = Array.from(new Uint8Array(derivedBits)).map(b => b.toString(16).padStart(2, '0')).join('');
    const saltHex = Array.from(salt).map(b => b.toString(16).padStart(2, '0')).join('');
    return `pbkdf2:${ITERATIONS}:${saltHex}:${hashHex}`;
}

/**
 * Compare a plaintext password against a stored hash.
 * Supports both new PBKDF2 format and legacy SHA-256 (for migration).
 */
export async function comparePassword(password: string, storedHash: string): Promise<boolean> {
    // New PBKDF2 format
    if (storedHash.startsWith('pbkdf2:')) {
        const [, iterStr, saltHex, hashHex] = storedHash.split(':');
        const iterations = parseInt(iterStr!, 10);
        const salt = new Uint8Array(saltHex!.match(/.{2}/g)!.map(h => parseInt(h, 16)));
        const encoder = new TextEncoder();
        const keyMaterial = await crypto.subtle.importKey(
            'raw', encoder.encode(password), 'PBKDF2', false, ['deriveBits']
        );
        const derivedBits = await crypto.subtle.deriveBits(
            { name: 'PBKDF2', salt, iterations, hash: 'SHA-256' },
            keyMaterial, KEY_LENGTH * 8
        );
        const computedHex = Array.from(new Uint8Array(derivedBits)).map(b => b.toString(16).padStart(2, '0')).join('');
        // R21: Constant-time comparison — prevents timing attacks
        return timingSafeEqual(computedHex, hashHex!);
    }

    // Legacy SHA-256 (unsalted) — for backwards compatibility during migration
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const legacyHash = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
    // R21: Constant-time comparison for legacy hashes too
    return timingSafeEqual(legacyHash, storedHash);
}

/**
 * Check if a stored hash is using the legacy (weak) format.
 * Used to trigger re-hash on next successful login.
 */
export function isLegacyHash(storedHash: string): boolean {
    return !storedHash.startsWith('pbkdf2:');
}
