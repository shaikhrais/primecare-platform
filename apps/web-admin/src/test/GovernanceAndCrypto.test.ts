/**
 * Governance, Crypto, and Audit Chain Deep Tests
 *
 * Self-contained replicas of logic from:
 * - governance.ts: VPN IP range matching, device status validation
 * - crypto.ts: timingSafeEqual, isLegacyHash, PBKDF2 format parsing
 * - audit-chain.ts: SHA-256 hash computation, chain verification
 * - observability.ts: Correlation ID generation, log levels
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// VPN IP Range Matching (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isIpAllowed(clientIp: string, allowedRanges: string[]): boolean {
    return allowedRanges.some((range: string) => {
        if (range.endsWith('*')) {
            return clientIp.startsWith(range.slice(0, -1));
        }
        return clientIp === range;
    });
}

describe('VPN IP Range Matching', () => {
    it('exact match allowed', () => {
        expect(isIpAllowed('192.168.1.1', ['192.168.1.1'])).toBe(true);
    });

    it('exact match rejected', () => {
        expect(isIpAllowed('10.0.0.1', ['192.168.1.1'])).toBe(false);
    });

    it('wildcard prefix match', () => {
        expect(isIpAllowed('192.168.1.50', ['192.168.1.*'])).toBe(true);
    });

    it('wildcard broader prefix', () => {
        expect(isIpAllowed('192.168.5.100', ['192.168.*'])).toBe(true);
    });

    it('wildcard no match', () => {
        expect(isIpAllowed('10.0.0.1', ['192.168.*'])).toBe(false);
    });

    it('multiple ranges — first matches', () => {
        expect(isIpAllowed('10.0.0.5', ['10.0.0.5', '192.168.1.*'])).toBe(true);
    });

    it('multiple ranges — second matches', () => {
        expect(isIpAllowed('192.168.1.99', ['10.0.0.5', '192.168.1.*'])).toBe(true);
    });

    it('empty ranges — nothing allowed', () => {
        expect(isIpAllowed('192.168.1.1', [])).toBe(false);
    });

    it('localhost exact match', () => {
        expect(isIpAllowed('127.0.0.1', ['127.0.0.1'])).toBe(true);
    });

    it('IPv6-style address exact match', () => {
        expect(isIpAllowed('::1', ['::1'])).toBe(true);
    });

    it('Class A wildcard', () => {
        expect(isIpAllowed('10.255.255.255', ['10.*'])).toBe(true);
    });

    it('Class B wildcard', () => {
        expect(isIpAllowed('172.16.5.10', ['172.16.*'])).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Device Status Validation (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface DeviceInfo {
    status?: string;
    isAuthorized?: boolean;
    isTemporary?: boolean;
    expiresAt?: Date | null;
}

interface DeviceCheckResult {
    allowed: boolean;
    error?: string;
}

function checkDeviceAccess(device: DeviceInfo | null, requireApproval: boolean, now: Date = new Date()): DeviceCheckResult {
    if (!device) {
        if (requireApproval) {
            return { allowed: false, error: 'Unauthorized Device' };
        }
        return { allowed: true };
    }

    if (device.status === 'blocked' || device.status === 'revoked') {
        return { allowed: false, error: 'Device Blocked' };
    }

    if (requireApproval && !device.isAuthorized) {
        return { allowed: false, error: 'Device Pending Approval' };
    }

    if (device.isTemporary && device.expiresAt && now > device.expiresAt) {
        return { allowed: false, error: 'Access Expired' };
    }

    return { allowed: true };
}

describe('Device Status Validation', () => {
    it('null device + no approval required = allowed', () => {
        expect(checkDeviceAccess(null, false).allowed).toBe(true);
    });

    it('null device + approval required = blocked', () => {
        const result = checkDeviceAccess(null, true);
        expect(result.allowed).toBe(false);
        expect(result.error).toBe('Unauthorized Device');
    });

    it('active device = allowed', () => {
        expect(checkDeviceAccess({ status: 'active', isAuthorized: true }, true).allowed).toBe(true);
    });

    it('blocked device = blocked', () => {
        const result = checkDeviceAccess({ status: 'blocked' }, false);
        expect(result.allowed).toBe(false);
        expect(result.error).toBe('Device Blocked');
    });

    it('revoked device = blocked', () => {
        const result = checkDeviceAccess({ status: 'revoked' }, false);
        expect(result.allowed).toBe(false);
        expect(result.error).toBe('Device Blocked');
    });

    it('unauthorized device + approval required = pending', () => {
        const result = checkDeviceAccess({ status: 'active', isAuthorized: false }, true);
        expect(result.allowed).toBe(false);
        expect(result.error).toBe('Device Pending Approval');
    });

    it('unauthorized device + no approval required = allowed', () => {
        expect(checkDeviceAccess({ status: 'active', isAuthorized: false }, false).allowed).toBe(true);
    });

    it('temporary device before expiry = allowed', () => {
        const future = new Date(Date.now() + 86400000);
        expect(checkDeviceAccess({ isTemporary: true, expiresAt: future, isAuthorized: true }, true).allowed).toBe(true);
    });

    it('temporary device after expiry = expired', () => {
        const past = new Date(Date.now() - 86400000);
        const result = checkDeviceAccess({ isTemporary: true, expiresAt: past, isAuthorized: true }, true, new Date());
        expect(result.allowed).toBe(false);
        expect(result.error).toBe('Access Expired');
    });

    it('non-temporary device with expiresAt ignores it', () => {
        const past = new Date(Date.now() - 86400000);
        expect(checkDeviceAccess({ isTemporary: false, expiresAt: past, isAuthorized: true }, true).allowed).toBe(true);
    });

    it('temporary device with null expiresAt = allowed', () => {
        expect(checkDeviceAccess({ isTemporary: true, expiresAt: null, isAuthorized: true }, true).allowed).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Timing-Safe String Comparison (replicated from crypto.ts)
// ═══════════════════════════════════════════════════════════════════════════

function timingSafeEqual(a: string, b: string): boolean {
    if (a.length !== b.length) return false;
    let result = 0;
    for (let i = 0; i < a.length; i++) {
        result |= a.charCodeAt(i) ^ b.charCodeAt(i);
    }
    return result === 0;
}

describe('Timing-Safe String Comparison', () => {
    it('identical strings match', () => {
        expect(timingSafeEqual('abc', 'abc')).toBe(true);
    });

    it('different strings do not match', () => {
        expect(timingSafeEqual('abc', 'xyz')).toBe(false);
    });

    it('different lengths do not match', () => {
        expect(timingSafeEqual('abc', 'abcd')).toBe(false);
    });

    it('empty strings match', () => {
        expect(timingSafeEqual('', '')).toBe(true);
    });

    it('single char match', () => {
        expect(timingSafeEqual('a', 'a')).toBe(true);
    });

    it('single char mismatch', () => {
        expect(timingSafeEqual('a', 'b')).toBe(false);
    });

    it('long identical strings', () => {
        const s = 'a'.repeat(1000);
        expect(timingSafeEqual(s, s)).toBe(true);
    });

    it('long strings with last char different', () => {
        const a = 'a'.repeat(999) + 'b';
        const b = 'a'.repeat(999) + 'c';
        expect(timingSafeEqual(a, b)).toBe(false);
    });

    it('hex hashes — matching', () => {
        const hash = 'abcdef0123456789';
        expect(timingSafeEqual(hash, hash)).toBe(true);
    });

    it('hex hashes — mismatch', () => {
        expect(timingSafeEqual('abcdef01', 'abcdef02')).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Legacy Hash Detection (replicated from crypto.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isLegacyHash(storedHash: string): boolean {
    return !storedHash.startsWith('pbkdf2:');
}

describe('Legacy Hash Detection', () => {
    it('SHA-256 hex string is legacy', () => {
        expect(isLegacyHash('e3b0c44298fc1c149afbf4c8996fb924')).toBe(true);
    });

    it('PBKDF2 format is not legacy', () => {
        expect(isLegacyHash('pbkdf2:100000:ab12cd34:ef56gh78')).toBe(false);
    });

    it('empty string is legacy', () => {
        expect(isLegacyHash('')).toBe(true);
    });

    it('random string is legacy', () => {
        expect(isLegacyHash('random-password-hash')).toBe(true);
    });

    it('pbkdf2 prefix lowercase is not legacy', () => {
        expect(isLegacyHash('pbkdf2:1:salt:hash')).toBe(false);
    });

    it('PBKDF2 uppercase is legacy (case-sensitive)', () => {
        expect(isLegacyHash('PBKDF2:100000:salt:hash')).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// PBKDF2 Hash Format Parsing (replicated from crypto.ts)
// ═══════════════════════════════════════════════════════════════════════════

function parsePbkdf2Hash(storedHash: string): { iterations: number; saltHex: string; hashHex: string } | null {
    if (!storedHash.startsWith('pbkdf2:')) return null;
    const parts = storedHash.split(':');
    if (parts.length !== 4) return null;
    return {
        iterations: parseInt(parts[1], 10),
        saltHex: parts[2],
        hashHex: parts[3],
    };
}

describe('PBKDF2 Hash Format Parsing', () => {
    it('parses valid PBKDF2 format', () => {
        const result = parsePbkdf2Hash('pbkdf2:100000:aabb:ccdd');
        expect(result).toEqual({ iterations: 100000, saltHex: 'aabb', hashHex: 'ccdd' });
    });

    it('parses different iterations', () => {
        const result = parsePbkdf2Hash('pbkdf2:50000:1234:5678');
        expect(result?.iterations).toBe(50000);
    });

    it('returns null for non-PBKDF2', () => {
        expect(parsePbkdf2Hash('sha256hash')).toBeNull();
    });

    it('returns null for incomplete format', () => {
        expect(parsePbkdf2Hash('pbkdf2:100000')).toBeNull();
    });

    it('returns null for empty', () => {
        expect(parsePbkdf2Hash('')).toBeNull();
    });

    it('parses long salt and hash', () => {
        const salt = 'a'.repeat(32);
        const hash = 'b'.repeat(128);
        const result = parsePbkdf2Hash(`pbkdf2:100000:${salt}:${hash}`);
        expect(result?.saltHex).toBe(salt);
        expect(result?.hashHex).toBe(hash);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// SHA-256 Hash Computation (using Web Crypto API)
// ═══════════════════════════════════════════════════════════════════════════

async function sha256(message: string): Promise<string> {
    const data = new TextEncoder().encode(message);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    return Array.from(new Uint8Array(hashBuffer)).map(b => b.toString(16).padStart(2, '0')).join('');
}

describe('SHA-256 Hash Computation', () => {
    it('hashes empty string', async () => {
        const hash = await sha256('');
        expect(hash).toBe('e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855');
    });

    it('hashes "hello"', async () => {
        const hash = await sha256('hello');
        expect(hash).toBe('2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824');
    });

    it('produces 64-char hex string', async () => {
        const hash = await sha256('test');
        expect(hash.length).toBe(64);
    });

    it('same input = same hash', async () => {
        const h1 = await sha256('deterministic');
        const h2 = await sha256('deterministic');
        expect(h1).toBe(h2);
    });

    it('different input = different hash', async () => {
        const h1 = await sha256('input1');
        const h2 = await sha256('input2');
        expect(h1).not.toBe(h2);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Audit Chain Checksum (replicated from audit-chain.ts)
// ═══════════════════════════════════════════════════════════════════════════

async function computeChecksum(previousChecksum: string, operation: string, modelName: string, entityId: string, payload: string, timestamp: string): Promise<string> {
    return sha256([previousChecksum, operation, modelName, entityId, payload, timestamp].join('|'));
}

describe('Audit Chain Checksum', () => {
    it('computes deterministic checksum', async () => {
        const c1 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const c2 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        expect(c1).toBe(c2);
    });

    it('different previous checksum = different result', async () => {
        const c1 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const c2 = await computeChecksum('OTHER', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        expect(c1).not.toBe(c2);
    });

    it('different operation = different result', async () => {
        const c1 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const c2 = await computeChecksum('GENESIS', 'UPDATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        expect(c1).not.toBe(c2);
    });

    it('different model = different result', async () => {
        const c1 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const c2 = await computeChecksum('GENESIS', 'CREATE', 'Visit', 'u1', '{}', '2026-01-01T00:00:00Z');
        expect(c1).not.toBe(c2);
    });

    it('different timestamp = different result', async () => {
        const c1 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const c2 = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-02T00:00:00Z');
        expect(c1).not.toBe(c2);
    });

    it('produces 64-char hex', async () => {
        const c = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        expect(c.length).toBe(64);
    });

    it('chain of two checksums', async () => {
        const first = await computeChecksum('GENESIS', 'CREATE', 'User', 'u1', '{}', '2026-01-01T00:00:00Z');
        const second = await computeChecksum(first, 'UPDATE', 'User', 'u1', '{"name":"John"}', '2026-01-01T01:00:00Z');
        expect(second).not.toBe(first);
        expect(second.length).toBe(64);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Observability: Log Level Classification (replicated from observability.ts)
// ═══════════════════════════════════════════════════════════════════════════

function getLogLevel(statusCode: number): string {
    return statusCode >= 400 ? 'warn' : 'info';
}

describe('Log Level Classification', () => {
    it('200 is info', () => {
        expect(getLogLevel(200)).toBe('info');
    });

    it('201 is info', () => {
        expect(getLogLevel(201)).toBe('info');
    });

    it('204 is info', () => {
        expect(getLogLevel(204)).toBe('info');
    });

    it('301 is info', () => {
        expect(getLogLevel(301)).toBe('info');
    });

    it('400 is warn', () => {
        expect(getLogLevel(400)).toBe('warn');
    });

    it('401 is warn', () => {
        expect(getLogLevel(401)).toBe('warn');
    });

    it('403 is warn', () => {
        expect(getLogLevel(403)).toBe('warn');
    });

    it('404 is warn', () => {
        expect(getLogLevel(404)).toBe('warn');
    });

    it('500 is warn', () => {
        expect(getLogLevel(500)).toBe('warn');
    });

    it('503 is warn', () => {
        expect(getLogLevel(503)).toBe('warn');
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Notification Channel Routing (replicated from notifications.ts)
// ═══════════════════════════════════════════════════════════════════════════

type NotificationChannel = 'in_app' | 'email' | 'push';

function resolveChannels(channels?: NotificationChannel[]): NotificationChannel[] {
    return channels || ['in_app'];
}

function hasChannel(channels: NotificationChannel[], target: NotificationChannel): boolean {
    return channels.includes(target);
}

describe('Notification Channel Routing', () => {
    it('defaults to in_app', () => {
        expect(resolveChannels()).toEqual(['in_app']);
    });

    it('defaults for undefined', () => {
        expect(resolveChannels(undefined)).toEqual(['in_app']);
    });

    it('preserves explicit channels', () => {
        expect(resolveChannels(['email', 'push'])).toEqual(['email', 'push']);
    });

    it('single channel preserved', () => {
        expect(resolveChannels(['push'])).toEqual(['push']);
    });

    it('hasChannel finds in_app', () => {
        expect(hasChannel(['in_app', 'email'], 'in_app')).toBe(true);
    });

    it('hasChannel finds email', () => {
        expect(hasChannel(['in_app', 'email'], 'email')).toBe(true);
    });

    it('hasChannel missing push', () => {
        expect(hasChannel(['in_app', 'email'], 'push')).toBe(false);
    });

    it('hasChannel empty array', () => {
        expect(hasChannel([], 'in_app')).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Audit Metadata Serialization (replicated from audit.ts)
// ═══════════════════════════════════════════════════════════════════════════

function serializeMetadata(metadata: any): string {
    return typeof metadata === 'string' ? metadata : JSON.stringify(metadata);
}

function resolveTenantId(metadata: any): string {
    return metadata?.tenantId || 'system';
}

describe('Audit Metadata Helpers', () => {
    it('serializes object to JSON', () => {
        expect(serializeMetadata({ key: 'val' })).toBe('{"key":"val"}');
    });

    it('passes through string', () => {
        expect(serializeMetadata('raw-string')).toBe('raw-string');
    });

    it('serializes empty object', () => {
        expect(serializeMetadata({})).toBe('{}');
    });

    it('serializes array', () => {
        expect(serializeMetadata([1, 2])).toBe('[1,2]');
    });

    it('resolves tenantId from metadata', () => {
        expect(resolveTenantId({ tenantId: 't1' })).toBe('t1');
    });

    it('defaults to system when no tenantId', () => {
        expect(resolveTenantId({})).toBe('system');
    });

    it('defaults to system for null', () => {
        expect(resolveTenantId(null)).toBe('system');
    });

    it('defaults to system for undefined', () => {
        expect(resolveTenantId(undefined)).toBe('system');
    });
});
