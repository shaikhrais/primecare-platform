/**
 * Crypto Utilities — Behavioral Tests
 *
 * Tests actual source functions from crypto.ts:
 * - isLegacyHash (pure, synchronous)
 * - hashPassword + comparePassword (async, Web Crypto API)
 */
import { describe, it, expect } from 'vitest';
import { hashPassword, comparePassword, isLegacyHash } from '../_shared/utils/crypto';

// ═══════════════════════════════════════════════════════════════════════════
// isLegacyHash — Pure Synchronous
// ═══════════════════════════════════════════════════════════════════════════

describe('isLegacyHash (source)', () => {
    it('detects PBKDF2 format as modern', () => {
        expect(isLegacyHash('pbkdf2:100000:abc123:def456')).toBe(false);
    });

    it('detects plain SHA-256 hex as legacy', () => {
        expect(isLegacyHash('a'.repeat(64))).toBe(true);
    });

    it('detects empty string as legacy', () => {
        expect(isLegacyHash('')).toBe(true);
    });

    it('detects random string as legacy', () => {
        expect(isLegacyHash('not-a-pbkdf2-hash')).toBe(true);
    });

    it('detects exact "pbkdf2:" prefix', () => {
        // Must start with exactly "pbkdf2:"
        expect(isLegacyHash('pbkdf2:')).toBe(false);
        expect(isLegacyHash('PBKDF2:100000:abc:def')).toBe(true); // case-sensitive
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// hashPassword + comparePassword — Async (Web Crypto API)
// ═══════════════════════════════════════════════════════════════════════════

describe('hashPassword (source)', () => {
    it('produces PBKDF2-formatted hash', async () => {
        const hash = await hashPassword('TestP@ssw0rd');
        expect(hash).toMatch(/^pbkdf2:\d+:[0-9a-f]+:[0-9a-f]+$/);
    });

    it('includes 100000 iterations', async () => {
        const hash = await hashPassword('TestP@ssw0rd');
        const parts = hash.split(':');
        expect(parts[1]).toBe('100000');
    });

    it('produces unique salts for same password', async () => {
        const hash1 = await hashPassword('SamePassword!1');
        const hash2 = await hashPassword('SamePassword!1');
        // Different salts → different hashes
        expect(hash1).not.toBe(hash2);
    });

    it('salt is 32 hex chars (16 bytes)', async () => {
        const hash = await hashPassword('TestP@ssw0rd');
        const salt = hash.split(':')[2]!;
        expect(salt.length).toBe(32);
    });

    it('hash is 128 hex chars (64 bytes)', async () => {
        const hash = await hashPassword('TestP@ssw0rd');
        const hashPart = hash.split(':')[3]!;
        expect(hashPart.length).toBe(128);
    });
});

describe('comparePassword (source)', () => {
    it('returns true for matching password (PBKDF2)', async () => {
        const hash = await hashPassword('CorrectP@ss1');
        expect(await comparePassword('CorrectP@ss1', hash)).toBe(true);
    });

    it('returns false for wrong password (PBKDF2)', async () => {
        const hash = await hashPassword('CorrectP@ss1');
        expect(await comparePassword('WrongP@ss1', hash)).toBe(false);
    });

    it('handles empty password', async () => {
        const hash = await hashPassword('');
        expect(await comparePassword('', hash)).toBe(true);
        expect(await comparePassword('notempty', hash)).toBe(false);
    });

    it('handles special characters', async () => {
        const password = '!@#$%^&*()_+-=[]{}|;:",.<>?';
        const hash = await hashPassword(password);
        expect(await comparePassword(password, hash)).toBe(true);
    });

    it('handles unicode characters', async () => {
        const password = '密码テスト🔒';
        const hash = await hashPassword(password);
        expect(await comparePassword(password, hash)).toBe(true);
    });
});
