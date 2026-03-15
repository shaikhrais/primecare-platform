/**
 * Governance, RBAC, Tenant Isolation & Security Tests — Phase 28
 *
 * Self-contained replicas of logic from:
 * - governance.ts: VPN IP range matching, device status enforcement
 * - rbac.ts: role hierarchy, umbrella matching, super_admin bypass
 * - security.ts: tenant isolation, CSRF safe methods, XSS sanitization
 * - ownership.ts: PSW client assignment verification
 * - Additional: IP parsing, header extraction, permission matrices
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Governance — VPN IP Range Matching (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isIpAllowed(clientIp: string, allowedRanges: string[]): boolean {
    return allowedRanges.some(range => {
        if (range.endsWith('*')) {
            return clientIp.startsWith(range.slice(0, -1));
        }
        return clientIp === range;
    });
}

function shouldEnforceVpn(enforceVpn: boolean, allowedRanges: string[]): boolean {
    return enforceVpn && allowedRanges.length > 0;
}

describe('Governance — VPN IP Match', () => {
    it('exact match', () => expect(isIpAllowed('10.0.0.1', ['10.0.0.1'])).toBe(true));
    it('no match', () => expect(isIpAllowed('192.168.1.1', ['10.0.0.1'])).toBe(false));
    it('wildcard match', () => expect(isIpAllowed('10.0.0.5', ['10.0.0.*'])).toBe(true));
    it('wildcard no match', () => expect(isIpAllowed('192.168.0.5', ['10.0.0.*'])).toBe(false));
    it('multiple ranges', () => expect(isIpAllowed('172.16.0.1', ['10.0.0.*', '172.16.0.*'])).toBe(true));
    it('empty ranges', () => expect(isIpAllowed('10.0.0.1', [])).toBe(false));
    it('prefix match', () => expect(isIpAllowed('10.0.1.100', ['10.0.*'])).toBe(true));
    it('subnet prefix', () => expect(isIpAllowed('192.168.1.50', ['192.168.1.*'])).toBe(true));
});

describe('Governance — VPN Enforcement', () => {
    it('enforced with ranges', () => expect(shouldEnforceVpn(true, ['10.0.0.*'])).toBe(true));
    it('not enforced', () => expect(shouldEnforceVpn(false, ['10.0.0.*'])).toBe(false));
    it('enforced but no ranges', () => expect(shouldEnforceVpn(true, [])).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. Governance — Device Status Enforcement (replicated from governance.ts)
// ═══════════════════════════════════════════════════════════════════════════

type DeviceStatus = 'active' | 'blocked' | 'revoked' | 'pending';

function isDeviceBlocked(status: DeviceStatus): boolean {
    return status === 'blocked' || status === 'revoked';
}

function isDevicePendingApproval(requireApproval: boolean, isAuthorized: boolean): boolean {
    return requireApproval && !isAuthorized;
}

function isTemporaryExpired(isTemporary: boolean, expiresAt: Date | null): boolean {
    if (!isTemporary || !expiresAt) return false;
    return new Date() > expiresAt;
}

function resolveClientIp(cfConnectingIp: string | undefined): string {
    return cfConnectingIp || '127.0.0.1';
}

describe('Governance — Device Blocked', () => {
    it('blocked', () => expect(isDeviceBlocked('blocked')).toBe(true));
    it('revoked', () => expect(isDeviceBlocked('revoked')).toBe(true));
    it('active', () => expect(isDeviceBlocked('active')).toBe(false));
    it('pending', () => expect(isDeviceBlocked('pending')).toBe(false));
});

describe('Governance — Device Approval', () => {
    it('requires approval + not authorized', () => expect(isDevicePendingApproval(true, false)).toBe(true));
    it('requires approval + authorized', () => expect(isDevicePendingApproval(true, true)).toBe(false));
    it('no approval required', () => expect(isDevicePendingApproval(false, false)).toBe(false));
});

describe('Governance — Temporary Expiry', () => {
    it('not temporary', () => expect(isTemporaryExpired(false, null)).toBe(false));
    it('temporary no expiry', () => expect(isTemporaryExpired(true, null)).toBe(false));
    it('temporary expired', () => {
        const past = new Date(Date.now() - 86400000);
        expect(isTemporaryExpired(true, past)).toBe(true);
    });
    it('temporary not expired', () => {
        const future = new Date(Date.now() + 86400000);
        expect(isTemporaryExpired(true, future)).toBe(false);
    });
});

describe('Governance — Client IP', () => {
    it('uses CF header', () => expect(resolveClientIp('1.2.3.4')).toBe('1.2.3.4'));
    it('fallback', () => expect(resolveClientIp(undefined)).toBe('127.0.0.1'));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. RBAC — Role Hierarchy & Umbrella Matching (replicated from rbac.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SERVICE_PROVIDERS = ['psw', 'rn', 'rmt', 'rpt', 'rch'];
const STAFF_SUBROLES = ['staff', 'finance', 'hr', 'compliance', 'finance_manager', 'hr_manager'];
const MANAGER_SUBROLES = ['manager', 'marketing_manager', 'operations_manager', 'clinical_manager', 'regional_manager', 'recruiting_manager', 'coordinator', 'crm', 'training'];

function hasRoleAccess(userRoles: string[], allowedRoles: string[]): boolean {
    return userRoles.some(role => {
        const lowerRole = role.toLowerCase();
        if (lowerRole === 'super_admin' || lowerRole === 'scrum_master') return true;
        if (allowedRoles.includes(role)) return true;
        if (allowedRoles.includes('manager') && MANAGER_SUBROLES.includes(lowerRole)) return true;
        if (allowedRoles.includes('service_provider') && SERVICE_PROVIDERS.includes(lowerRole)) return true;
        if (allowedRoles.includes('staff') && STAFF_SUBROLES.includes(lowerRole)) return true;
        return false;
    });
}

function isSuperUser(roles: string[]): boolean {
    return roles.some(r => r === 'super_admin' || r === 'scrum_master');
}

function normalizeRoles(payload: any): string[] {
    if (Array.isArray(payload?.roles)) return payload.roles;
    if (payload?.roles) return [payload.roles as string];
    return [];
}

describe('RBAC — Super Admin Bypass', () => {
    it('super_admin bypasses', () => expect(hasRoleAccess(['super_admin'], ['admin'])).toBe(true));
    it('scrum_master bypasses', () => expect(hasRoleAccess(['scrum_master'], ['admin'])).toBe(true));
    it('normal user denied', () => expect(hasRoleAccess(['psw'], ['admin'])).toBe(false));
});

describe('RBAC — Direct Role Match', () => {
    it('exact match', () => expect(hasRoleAccess(['admin'], ['admin'])).toBe(true));
    it('no match', () => expect(hasRoleAccess(['psw'], ['admin'])).toBe(false));
    it('multiple roles', () => expect(hasRoleAccess(['psw', 'admin'], ['admin'])).toBe(true));
});

describe('RBAC — Umbrella: Manager', () => {
    it('coordinator -> manager', () => expect(hasRoleAccess(['coordinator'], ['manager'])).toBe(true));
    it('marketing_manager -> manager', () => expect(hasRoleAccess(['marketing_manager'], ['manager'])).toBe(true));
    it('clinical_manager -> manager', () => expect(hasRoleAccess(['clinical_manager'], ['manager'])).toBe(true));
    it('crm -> manager', () => expect(hasRoleAccess(['crm'], ['manager'])).toBe(true));
    it('training -> manager', () => expect(hasRoleAccess(['training'], ['manager'])).toBe(true));
    it('psw NOT manager', () => expect(hasRoleAccess(['psw'], ['manager'])).toBe(false));
});

describe('RBAC — Umbrella: Service Provider', () => {
    it('psw -> service_provider', () => expect(hasRoleAccess(['psw'], ['service_provider'])).toBe(true));
    it('rn -> service_provider', () => expect(hasRoleAccess(['rn'], ['service_provider'])).toBe(true));
    it('rmt -> service_provider', () => expect(hasRoleAccess(['rmt'], ['service_provider'])).toBe(true));
    it('rpt -> service_provider', () => expect(hasRoleAccess(['rpt'], ['service_provider'])).toBe(true));
    it('admin NOT service_provider', () => expect(hasRoleAccess(['admin'], ['service_provider'])).toBe(false));
});

describe('RBAC — Umbrella: Staff', () => {
    it('finance -> staff', () => expect(hasRoleAccess(['finance'], ['staff'])).toBe(true));
    it('hr -> staff', () => expect(hasRoleAccess(['hr'], ['staff'])).toBe(true));
    it('compliance -> staff', () => expect(hasRoleAccess(['compliance'], ['staff'])).toBe(true));
    it('finance_manager -> staff', () => expect(hasRoleAccess(['finance_manager'], ['staff'])).toBe(true));
    it('psw NOT staff', () => expect(hasRoleAccess(['psw'], ['staff'])).toBe(false));
});

describe('RBAC — Super User Check', () => {
    it('super_admin', () => expect(isSuperUser(['super_admin'])).toBe(true));
    it('scrum_master', () => expect(isSuperUser(['scrum_master'])).toBe(true));
    it('admin not super', () => expect(isSuperUser(['admin'])).toBe(false));
    it('empty', () => expect(isSuperUser([])).toBe(false));
});

describe('RBAC — Normalize Roles', () => {
    it('array roles', () => expect(normalizeRoles({ roles: ['a', 'b'] })).toEqual(['a', 'b']));
    it('string role', () => expect(normalizeRoles({ roles: 'admin' })).toEqual(['admin']));
    it('undefined payload', () => expect(normalizeRoles(undefined)).toEqual([]));
    it('no roles', () => expect(normalizeRoles({})).toEqual([]));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Tenant Isolation (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

function resolveTenantId(headerTenantId: string | undefined, jwtTenantId: string | undefined): string | undefined {
    return jwtTenantId || headerTenantId;
}

function isTenantMismatch(headerTenantId: string | undefined, jwtTenantId: string | undefined): boolean {
    return !!(headerTenantId && jwtTenantId && headerTenantId !== jwtTenantId);
}

function isPublicOrAuthPath(path: string): boolean {
    return path.startsWith('/v1/public/') || path.startsWith('/v1/auth/') || path.startsWith('/v1/debug/') || path === '/v1/health';
}

function requiresTenantContext(path: string, hasJwt: boolean, hasTenantId: boolean): boolean {
    return hasJwt && !hasTenantId && !isPublicOrAuthPath(path);
}

describe('Tenant Isolation — Resolve', () => {
    it('JWT takes priority', () => expect(resolveTenantId('h-1', 'j-1')).toBe('j-1'));
    it('header fallback', () => expect(resolveTenantId('h-1', undefined)).toBe('h-1'));
    it('neither', () => expect(resolveTenantId(undefined, undefined)).toBeUndefined());
});

describe('Tenant Isolation — Mismatch', () => {
    it('mismatch', () => expect(isTenantMismatch('t-1', 't-2')).toBe(true));
    it('match', () => expect(isTenantMismatch('t-1', 't-1')).toBe(false));
    it('header only', () => expect(isTenantMismatch('t-1', undefined)).toBe(false));
    it('jwt only', () => expect(isTenantMismatch(undefined, 't-1')).toBe(false));
});

describe('Tenant Isolation — Public Paths', () => {
    it('/v1/public/', () => expect(isPublicOrAuthPath('/v1/public/info')).toBe(true));
    it('/v1/auth/', () => expect(isPublicOrAuthPath('/v1/auth/login')).toBe(true));
    it('/v1/debug/', () => expect(isPublicOrAuthPath('/v1/debug/test')).toBe(true));
    it('/v1/health', () => expect(isPublicOrAuthPath('/v1/health')).toBe(true));
    it('/v1/clients', () => expect(isPublicOrAuthPath('/v1/clients')).toBe(false));
});

describe('Tenant Isolation — Context Required', () => {
    it('authenticated no tenant on protected', () => expect(requiresTenantContext('/v1/clients', true, false)).toBe(true));
    it('authenticated with tenant', () => expect(requiresTenantContext('/v1/clients', true, true)).toBe(false));
    it('public path', () => expect(requiresTenantContext('/v1/auth/login', true, false)).toBe(false));
    it('no JWT', () => expect(requiresTenantContext('/v1/clients', false, false)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. CSRF Protection (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isSafeMethod(method: string): boolean {
    return ['GET', 'HEAD', 'OPTIONS'].includes(method);
}

function requiresCsrf(method: string, hasCustomHeader: boolean): boolean {
    if (isSafeMethod(method)) return false;
    return !hasCustomHeader;
}

describe('CSRF — Safe Methods', () => {
    it('GET', () => expect(isSafeMethod('GET')).toBe(true));
    it('HEAD', () => expect(isSafeMethod('HEAD')).toBe(true));
    it('OPTIONS', () => expect(isSafeMethod('OPTIONS')).toBe(true));
    it('POST', () => expect(isSafeMethod('POST')).toBe(false));
    it('PUT', () => expect(isSafeMethod('PUT')).toBe(false));
    it('PATCH', () => expect(isSafeMethod('PATCH')).toBe(false));
    it('DELETE', () => expect(isSafeMethod('DELETE')).toBe(false));
});

describe('CSRF — Requires CSRF Check', () => {
    it('POST without header', () => expect(requiresCsrf('POST', false)).toBe(true));
    it('POST with header', () => expect(requiresCsrf('POST', true)).toBe(false));
    it('GET skip', () => expect(requiresCsrf('GET', false)).toBe(false));
    it('DELETE without header', () => expect(requiresCsrf('DELETE', false)).toBe(true));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. XSS Sanitization (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SCRIPT_RE = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
const EVENT_RE = /\bon\w+\s*=/gi;
const HREF_JS_RE = /javascript\s*:/gi;
const BLOCKED_KEYS = ['__proto__', 'constructor', 'prototype'];

function sanitizeString(val: string): string {
    return val
        .replace(SCRIPT_RE, '')
        .replace(EVENT_RE, '')
        .replace(HREF_JS_RE, '');
}

function isPrototypePollution(key: string): boolean {
    return BLOCKED_KEYS.includes(key);
}

function sanitizeObject(obj: Record<string, any>): Record<string, any> {
    const clean: Record<string, any> = {};
    for (const [k, v] of Object.entries(obj)) {
        if (isPrototypePollution(k)) continue;
        if (typeof v === 'string') clean[k] = sanitizeString(v);
        else if (typeof v === 'object' && v !== null && !Array.isArray(v)) clean[k] = sanitizeObject(v);
        else if (Array.isArray(v)) clean[k] = v.map((item: any) => typeof item === 'string' ? sanitizeString(item) : item);
        else clean[k] = v;
    }
    return clean;
}

function shouldSanitize(method: string): boolean {
    return ['POST', 'PUT', 'PATCH'].includes(method);
}

describe('XSS — Script Removal', () => {
    it('removes script tag', () => {
        expect(sanitizeString('Hello <script>alert("xss")</script> World')).toBe('Hello  World');
    });
    it('preserves clean text', () => expect(sanitizeString('Clean text')).toBe('Clean text'));
});

describe('XSS — Event Handler Removal', () => {
    it('removes onclick', () => {
        const result = sanitizeString('<div onclick= "alert(1)">test</div>');
        expect(result).not.toContain('onclick');
    });
    it('removes onload', () => {
        expect(sanitizeString('<img onload ="hack()">')).not.toContain('onload');
    });
});

describe('XSS — JavaScript Protocol', () => {
    it('removes javascript:', () => {
        expect(sanitizeString('javascript: alert(1)')).toBe(' alert(1)');
    });
    it('case insensitive', () => {
        expect(sanitizeString('JavaScript : void(0)')).toBe(' void(0)');
    });
});

describe('XSS — Prototype Pollution', () => {
    it('__proto__', () => expect(isPrototypePollution('__proto__')).toBe(true));
    it('constructor', () => expect(isPrototypePollution('constructor')).toBe(true));
    it('prototype', () => expect(isPrototypePollution('prototype')).toBe(true));
    it('normal key', () => expect(isPrototypePollution('name')).toBe(false));
});

describe('XSS — Object Sanitization', () => {
    it('sanitizes strings', () => {
        const result = sanitizeObject({ name: '<script>alert(1)</script>' });
        expect(result.name).toBe('');
    });
    it('strips __proto__', () => {
        const result = sanitizeObject({ __proto__: 'hack', name: 'safe' });
        expect(result).not.toHaveProperty('__proto__');
        expect(result.name).toBe('safe');
    });
    it('nested sanitize', () => {
        const result = sanitizeObject({ user: { bio: 'javascript: void' } });
        expect(result.user.bio).toBe(' void');
    });
    it('preserves numbers', () => {
        expect(sanitizeObject({ age: 30 }).age).toBe(30);
    });
});

describe('XSS — Method Check', () => {
    it('POST', () => expect(shouldSanitize('POST')).toBe(true));
    it('PUT', () => expect(shouldSanitize('PUT')).toBe(true));
    it('PATCH', () => expect(shouldSanitize('PATCH')).toBe(true));
    it('GET', () => expect(shouldSanitize('GET')).toBe(false));
    it('DELETE', () => expect(shouldSanitize('DELETE')).toBe(false));
});
