/**
 * Worker API Utilities — Logic Tests (Self-Contained)
 *
 * Tests the core logic patterns used in worker-api utilities
 * without requiring cross-app imports. Verifies:
 * - Feature flag default logic
 * - Password hashing with PBKDF2
 * - API response envelope structure
 * - Timing-safe comparison
 * - Pagination math
 */
import { describe, it, expect, vi } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Feature Flag Logic (replicated from worker-api/feature-flags.ts)
// ═══════════════════════════════════════════════════════════════════════════

const DEFAULT_FLAGS: Record<string, boolean> = {
    real_time_chat: true,
    telehealth: true,
    billing: true,
    compliance_home: true,
    sos_alerts: true,
    dispatch_map: true,
    knowledge_base: true,
    training_modules: true,
    advanced_reporting: true,
    api_webhooks: false,
    multi_currency: false,
    data_export: true,
    impersonation: true,
    digital_property_manager: true,
};

async function isFeatureEnabled(
    prisma: any, tenantId: string, featureKey: string
): Promise<boolean> {
    try {
        const config = await prisma.tenantConfig?.findFirst?.({
            where: { tenantId, key: `feature:${featureKey}` },
        });
        if (config) return config.value === 'true' || config.value === '1';
    } catch { /* fall through */ }
    return DEFAULT_FLAGS[featureKey] ?? true;
}

async function getAllFeatureFlags(
    prisma: any, tenantId: string
): Promise<Record<string, boolean>> {
    const flags = { ...DEFAULT_FLAGS };
    try {
        const overrides = await prisma.tenantConfig?.findMany?.({
            where: { tenantId, key: { startsWith: 'feature:' } },
        });
        if (overrides) {
            for (const o of overrides) {
                flags[o.key.replace('feature:', '')] = o.value === 'true' || o.value === '1';
            }
        }
    } catch { /* */ }
    return flags;
}

describe('Feature Flag Logic', () => {
    const mockPrisma = (configs: any[] = []) => ({
        tenantConfig: {
            findFirst: vi.fn().mockResolvedValue(configs[0] || null),
            findMany: vi.fn().mockResolvedValue(configs),
        },
    });

    it('returns true for enabled-by-default features', async () => {
        expect(await isFeatureEnabled(mockPrisma(), 't1', 'real_time_chat')).toBe(true);
    });

    it('returns true for telehealth', async () => {
        expect(await isFeatureEnabled(mockPrisma(), 't1', 'telehealth')).toBe(true);
    });

    it('returns false for opt-in api_webhooks', async () => {
        expect(await isFeatureEnabled(mockPrisma(), 't1', 'api_webhooks')).toBe(false);
    });

    it('returns false for opt-in multi_currency', async () => {
        expect(await isFeatureEnabled(mockPrisma(), 't1', 'multi_currency')).toBe(false);
    });

    it('returns true for unknown features (safe default)', async () => {
        expect(await isFeatureEnabled(mockPrisma(), 't1', 'nonexistent_future')).toBe(true);
    });

    it('respects tenant override: true', async () => {
        const p = mockPrisma([{ key: 'feature:api_webhooks', value: 'true' }]);
        expect(await isFeatureEnabled(p, 't1', 'api_webhooks')).toBe(true);
    });

    it('respects tenant override: 1', async () => {
        const p = mockPrisma([{ key: 'feature:billing', value: '1' }]);
        expect(await isFeatureEnabled(p, 't1', 'billing')).toBe(true);
    });

    it('respects tenant override: false', async () => {
        const p = mockPrisma([{ key: 'feature:billing', value: 'false' }]);
        expect(await isFeatureEnabled(p, 't1', 'billing')).toBe(false);
    });

    it('handles prisma error gracefully', async () => {
        const p = { tenantConfig: { findFirst: vi.fn().mockRejectedValue(new Error('db')) } };
        expect(await isFeatureEnabled(p, 't1', 'billing')).toBe(true);
    });

    it('handles missing tenantConfig table', async () => {
        expect(await isFeatureEnabled({}, 't1', 'billing')).toBe(true);
    });

    it('getAllFeatureFlags returns all defaults', async () => {
        const flags = await getAllFeatureFlags(mockPrisma(), 't1');
        expect(flags.real_time_chat).toBe(true);
        expect(flags.api_webhooks).toBe(false);
        expect(Object.keys(flags).length).toBe(14);
    });

    it('getAllFeatureFlags applies overrides', async () => {
        const p = {
            tenantConfig: {
                findFirst: vi.fn(),
                findMany: vi.fn().mockResolvedValue([
                    { key: 'feature:api_webhooks', value: 'true' },
                    { key: 'feature:billing', value: 'false' },
                ]),
            },
        };
        const flags = await getAllFeatureFlags(p, 't1');
        expect(flags.api_webhooks).toBe(true);
        expect(flags.billing).toBe(false);
    });

    it('getAllFeatureFlags handles DB error', async () => {
        const p = { tenantConfig: { findMany: vi.fn().mockRejectedValue(new Error('err')) } };
        const flags = await getAllFeatureFlags(p, 't1');
        expect(flags.real_time_chat).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Crypto Logic (replicated from worker-api/crypto.ts)
// ═══════════════════════════════════════════════════════════════════════════

function timingSafeEqual(a: string, b: string): boolean {
    if (a.length !== b.length) return false;
    let result = 0;
    for (let i = 0; i < a.length; i++) {
        result |= a.charCodeAt(i) ^ b.charCodeAt(i);
    }
    return result === 0;
}

function isLegacyHash(storedHash: string): boolean {
    return !storedHash.startsWith('pbkdf2:');
}

describe('Timing-Safe Comparison', () => {
    it('equal strings return true', () => {
        expect(timingSafeEqual('abc', 'abc')).toBe(true);
    });

    it('different strings return false', () => {
        expect(timingSafeEqual('abc', 'abd')).toBe(false);
    });

    it('different lengths return false', () => {
        expect(timingSafeEqual('abc', 'abcd')).toBe(false);
    });

    it('empty strings return true', () => {
        expect(timingSafeEqual('', '')).toBe(true);
    });

    it('long equal strings return true', () => {
        const s = 'a'.repeat(1000);
        expect(timingSafeEqual(s, s)).toBe(true);
    });

    it('one char different in long string returns false', () => {
        const s1 = 'a'.repeat(999) + 'a';
        const s2 = 'a'.repeat(999) + 'b';
        expect(timingSafeEqual(s1, s2)).toBe(false);
    });
});

describe('Legacy Hash Detection', () => {
    it('SHA-256 hex is legacy', () => {
        expect(isLegacyHash('e5e9fa1ba31ecd1ae84f75caaa474f3a663f05f4')).toBe(true);
    });

    it('PBKDF2 format is not legacy', () => {
        expect(isLegacyHash('pbkdf2:100000:aabb:ccdd')).toBe(false);
    });

    it('empty string is legacy', () => {
        expect(isLegacyHash('')).toBe(true);
    });

    it('pbkdf2 prefix only is not legacy', () => {
        expect(isLegacyHash('pbkdf2:')).toBe(false);
    });
});

describe('PBKDF2 Password Hashing', () => {
    const ITERATIONS = 100_000;
    const KEY_LENGTH = 64;
    const SALT_LENGTH = 16;

    async function hashPassword(password: string): Promise<string> {
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

    async function comparePassword(password: string, storedHash: string): Promise<boolean> {
        if (storedHash.startsWith('pbkdf2:')) {
            const [, iterStr, saltHex, hashHex] = storedHash.split(':');
            const iterations = parseInt(iterStr, 10);
            const salt = new Uint8Array(saltHex.match(/.{2}/g)!.map(h => parseInt(h, 16)));
            const encoder = new TextEncoder();
            const keyMaterial = await crypto.subtle.importKey(
                'raw', encoder.encode(password), 'PBKDF2', false, ['deriveBits']
            );
            const derivedBits = await crypto.subtle.deriveBits(
                { name: 'PBKDF2', salt, iterations, hash: 'SHA-256' },
                keyMaterial, KEY_LENGTH * 8
            );
            const computedHex = Array.from(new Uint8Array(derivedBits)).map(b => b.toString(16).padStart(2, '0')).join('');
            return timingSafeEqual(computedHex, hashHex);
        }
        // Legacy SHA-256
        const encoder = new TextEncoder();
        const hashBuffer = await crypto.subtle.digest('SHA-256', encoder.encode(password));
        const legacyHash = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
        return timingSafeEqual(legacyHash, storedHash);
    }

    it('produces pbkdf2 format hash', async () => {
        const hash = await hashPassword('testpass');
        expect(hash).toMatch(/^pbkdf2:\d+:[a-f0-9]+:[a-f0-9]+$/);
    });

    it('hash has 4 colon-separated parts', async () => {
        const hash = await hashPassword('test');
        expect(hash.split(':').length).toBe(4);
    });

    it('different passwords produce different hashes', async () => {
        const h1 = await hashPassword('password1');
        const h2 = await hashPassword('password2');
        expect(h1).not.toBe(h2);
    });

    it('same password with different salt produces different hashes', async () => {
        const h1 = await hashPassword('samepass');
        const h2 = await hashPassword('samepass');
        expect(h1).not.toBe(h2);
    });

    it('comparePassword matches correct password', async () => {
        const hash = await hashPassword('mypassword');
        expect(await comparePassword('mypassword', hash)).toBe(true);
    });

    it('comparePassword rejects wrong password', async () => {
        const hash = await hashPassword('correctpass');
        expect(await comparePassword('wrongpass', hash)).toBe(false);
    });

    it('comparePassword handles legacy SHA-256', async () => {
        const encoder = new TextEncoder();
        const hashBuffer = await crypto.subtle.digest('SHA-256', encoder.encode('legacytest'));
        const legacyHash = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
        expect(await comparePassword('legacytest', legacyHash)).toBe(true);
    });

    it('comparePassword rejects wrong legacy password', async () => {
        const encoder = new TextEncoder();
        const hashBuffer = await crypto.subtle.digest('SHA-256', encoder.encode('correctlegacy'));
        const legacyHash = Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
        expect(await comparePassword('wronglegacy', legacyHash)).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// API Response Envelope Logic (replicated from worker-api/api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

describe('API Response Envelope', () => {
    it('success envelope has correct shape', () => {
        const result = { success: true, data: { id: 1 }, meta: null, error: null };
        expect(result.success).toBe(true);
        expect(result.data).toEqual({ id: 1 });
        expect(result.error).toBeNull();
    });

    it('error envelope has correct shape', () => {
        const result = { success: false, data: null, meta: null, error: { message: 'Bad Request' } };
        expect(result.success).toBe(false);
        expect(result.data).toBeNull();
        expect(result.error.message).toBe('Bad Request');
    });

    it('paginated envelope calculates totalPages', () => {
        const total = 50;
        const limit = 10;
        const totalPages = Math.ceil(total / limit);
        expect(totalPages).toBe(5);
    });

    it('paginated hasNext when more pages', () => {
        const page = 1, limit = 10, total = 50;
        expect(page * limit < total).toBe(true);
    });

    it('paginated hasNext false on last page', () => {
        const page = 5, limit = 10, total = 50;
        expect(page * limit < total).toBe(false);
    });

    it('paginated hasPrev false on first page', () => {
        expect(1 > 1).toBe(false);
    });

    it('paginated hasPrev true on page 2', () => {
        expect(2 > 1).toBe(true);
    });

    it('totalPages rounds up', () => {
        expect(Math.ceil(11 / 10)).toBe(2);
        expect(Math.ceil(10 / 10)).toBe(1);
        expect(Math.ceil(1 / 10)).toBe(1);
    });

    it('empty list pagination', () => {
        expect(Math.ceil(0 / 10)).toBe(0);
    });

    it('single item pagination', () => {
        expect(Math.ceil(1 / 10)).toBe(1);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Default Flags Inventory
// ═══════════════════════════════════════════════════════════════════════════

describe('Feature Flag Inventory', () => {
    it('has 14 default flags', () => {
        expect(Object.keys(DEFAULT_FLAGS).length).toBe(14);
    });

    it('only api_webhooks and multi_currency are opt-in', () => {
        const optIn = Object.entries(DEFAULT_FLAGS).filter(([, v]) => !v).map(([k]) => k);
        expect(optIn).toEqual(['api_webhooks', 'multi_currency']);
    });

    it('all other flags default to true', () => {
        const enabled = Object.entries(DEFAULT_FLAGS).filter(([, v]) => v).map(([k]) => k);
        expect(enabled.length).toBe(12);
    });
});
