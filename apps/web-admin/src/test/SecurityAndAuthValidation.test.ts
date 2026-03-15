/**
 * Security Middleware, Auth Validation, Error Handling & Ownership Tests — Phase 35
 *
 * Self-contained replicas of logic from:
 * - security.ts: tenant isolation, CSRF protection, XSS sanitization (prototype pollution)
 * - auth.validation.ts: password policy, email validation, role enum, Zod schemas
 * - errors.ts: origin validation, preview domain matching, safe origin resolution
 * - ownership.ts: PSW → client assignment verification patterns
 * - API response builder: structured error responses, HTTP status codes
 * - Route security: public vs protected paths, safe methods
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// 1. Tenant Isolation Logic (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

function resolveTenantId(headerTenantId: string | undefined, jwtTenantId: string | undefined): { tenantId: string | undefined; error: string | null } {
    if (headerTenantId && jwtTenantId && headerTenantId !== jwtTenantId) {
        return { tenantId: undefined, error: 'Tenant Mismatch' };
    }
    return { tenantId: jwtTenantId || headerTenantId, error: null };
}

function isPublicPath(path: string): boolean {
    return path.startsWith('/v1/public/') || path.startsWith('/v1/auth/') || path.startsWith('/v1/debug/') || path === '/v1/health';
}

function requiresTenantContext(path: string, hasJwt: boolean, hasTenant: boolean): boolean {
    if (hasTenant) return false;
    if (!hasJwt) return false;
    return !isPublicPath(path);
}

describe('Tenant Isolation — Resolution', () => {
    it('header only', () => {
        const r = resolveTenantId('t-1', undefined);
        expect(r.tenantId).toBe('t-1');
        expect(r.error).toBeNull();
    });
    it('JWT only', () => {
        const r = resolveTenantId(undefined, 'jwt-t');
        expect(r.tenantId).toBe('jwt-t');
        expect(r.error).toBeNull();
    });
    it('both match', () => {
        const r = resolveTenantId('t-1', 't-1');
        expect(r.tenantId).toBe('t-1');
        expect(r.error).toBeNull();
    });
    it('mismatch', () => {
        const r = resolveTenantId('t-1', 't-2');
        expect(r.error).toBe('Tenant Mismatch');
    });
    it('neither', () => {
        const r = resolveTenantId(undefined, undefined);
        expect(r.tenantId).toBeUndefined();
        expect(r.error).toBeNull();
    });
});

describe('Tenant Isolation — Public Paths', () => {
    it('/v1/public/', () => expect(isPublicPath('/v1/public/status')).toBe(true));
    it('/v1/auth/', () => expect(isPublicPath('/v1/auth/login')).toBe(true));
    it('/v1/debug/', () => expect(isPublicPath('/v1/debug/info')).toBe(true));
    it('/v1/health', () => expect(isPublicPath('/v1/health')).toBe(true));
    it('/v1/users', () => expect(isPublicPath('/v1/users')).toBe(false));
    it('/v1/admin', () => expect(isPublicPath('/v1/admin/settings')).toBe(false));
});

describe('Tenant Isolation — Context Required', () => {
    it('no JWT no context', () => expect(requiresTenantContext('/v1/users', false, false)).toBe(false));
    it('JWT + tenant OK', () => expect(requiresTenantContext('/v1/users', true, true)).toBe(false));
    it('JWT no tenant for users', () => expect(requiresTenantContext('/v1/users', true, false)).toBe(true));
    it('JWT no tenant for public', () => expect(requiresTenantContext('/v1/public/data', true, false)).toBe(false));
    it('JWT no tenant for auth', () => expect(requiresTenantContext('/v1/auth/callback', true, false)).toBe(false));
    it('JWT no tenant for health', () => expect(requiresTenantContext('/v1/health', true, false)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 2. CSRF Protection Logic (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

function isSafeMethod(method: string): boolean {
    return ['GET', 'HEAD', 'OPTIONS'].includes(method);
}

function requiresCsrfCheck(method: string): boolean {
    return !isSafeMethod(method);
}

function validateCsrf(method: string, hasCustomHeader: boolean): { allowed: boolean; reason?: string } {
    if (isSafeMethod(method)) return { allowed: true };
    if (!hasCustomHeader) return { allowed: false, reason: 'Missing required request headers.' };
    return { allowed: true };
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

describe('CSRF — Requires Check', () => {
    it('POST', () => expect(requiresCsrfCheck('POST')).toBe(true));
    it('PUT', () => expect(requiresCsrfCheck('PUT')).toBe(true));
    it('DELETE', () => expect(requiresCsrfCheck('DELETE')).toBe(true));
    it('GET', () => expect(requiresCsrfCheck('GET')).toBe(false));
});

describe('CSRF — Validation', () => {
    it('GET always OK', () => expect(validateCsrf('GET', false).allowed).toBe(true));
    it('POST with header OK', () => expect(validateCsrf('POST', true).allowed).toBe(true));
    it('POST no header fails', () => {
        const r = validateCsrf('POST', false);
        expect(r.allowed).toBe(false);
        expect(r.reason).toContain('Missing');
    });
    it('DELETE with header OK', () => expect(validateCsrf('DELETE', true).allowed).toBe(true));
    it('PUT no header fails', () => expect(validateCsrf('PUT', false).allowed).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 3. XSS Sanitization (replicated from security.ts)
// ═══════════════════════════════════════════════════════════════════════════

const SCRIPT_RE = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi;
const EVENT_RE = /\bon\w+\s*=/gi;
const HREF_JS_RE = /javascript\s*:/gi;
const PROTO_KEYS = ['__proto__', 'constructor', 'prototype'];

function sanitizeString(val: string): string {
    return val.replace(SCRIPT_RE, '').replace(EVENT_RE, '').replace(HREF_JS_RE, '');
}

function sanitize(val: any): any {
    if (typeof val === 'string') return sanitizeString(val);
    if (Array.isArray(val)) return val.map(sanitize);
    if (val && typeof val === 'object') {
        const clean: any = {};
        for (const [k, v] of Object.entries(val)) {
            if (PROTO_KEYS.includes(k)) continue;
            clean[k] = sanitize(v);
        }
        return clean;
    }
    return val;
}

function needsSanitization(method: string, contentType: string): boolean {
    return ['POST', 'PUT', 'PATCH'].includes(method) && contentType.includes('application/json');
}

describe('XSS — Script Tags', () => {
    it('removes script', () => expect(sanitizeString('Hello<script>alert(1)</script>World')).toBe('HelloWorld'));
    it('no script', () => expect(sanitizeString('Hello World')).toBe('Hello World'));
    it('nested script', () => expect(sanitizeString('<script><script>x</script></script>')).not.toContain('<script'));
});

describe('XSS — Event Handlers', () => {
    it('removes onclick', () => expect(sanitizeString('div onclick=alert(1)')).not.toContain('onclick'));
    it('removes onmouseover', () => expect(sanitizeString('span onmouseover=hack()')).not.toContain('onmouseover'));
    it('preserves content', () => expect(sanitizeString('onclick= removed')).toBe(' removed'));
});

describe('XSS — JavaScript URLs', () => {
    it('removes javascript:', () => expect(sanitizeString('javascript:alert(1)')).not.toContain('javascript:'));
    it('removes javascript with space', () => expect(sanitizeString('javascript :void(0)')).not.toContain('javascript'));
});

describe('XSS — Prototype Pollution', () => {
    it('strips __proto__', () => {
        const r = sanitize({ __proto__: { admin: true }, name: 'test' });
        expect(r).toEqual({ name: 'test' });
    });
    it('strips constructor', () => {
        const r = sanitize({ constructor: 'hack', name: 'test' });
        expect(r).toEqual({ name: 'test' });
    });
    it('strips prototype', () => {
        const r = sanitize({ prototype: {}, name: 'test' });
        expect(r).toEqual({ name: 'test' });
    });
});

describe('XSS — Deep Sanitization', () => {
    it('nested object', () => {
        const r = sanitize({ nested: { value: '<script>x</script>safe' } });
        expect(r.nested.value).toBe('safe');
    });
    it('array', () => {
        const r = sanitize(['<script>x</script>', 'clean']);
        expect(r).toEqual(['', 'clean']);
    });
    it('number pass-through', () => expect(sanitize(42)).toBe(42));
    it('null pass-through', () => expect(sanitize(null)).toBeNull());
    it('boolean pass-through', () => expect(sanitize(true)).toBe(true));
});

describe('XSS — Needs Sanitization', () => {
    it('POST JSON', () => expect(needsSanitization('POST', 'application/json')).toBe(true));
    it('PUT JSON', () => expect(needsSanitization('PUT', 'application/json; charset=utf-8')).toBe(true));
    it('GET', () => expect(needsSanitization('GET', 'application/json')).toBe(false));
    it('POST form', () => expect(needsSanitization('POST', 'multipart/form-data')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 4. Auth Validation — Password Policy (replicated from auth.validation.ts)
// ═══════════════════════════════════════════════════════════════════════════

function validatePassword(password: string): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    if (password.length < 8) errors.push('Password must be at least 8 characters');
    if (password.length > 128) errors.push('Password must be at most 128 characters');
    if (!/[A-Z]/.test(password)) errors.push('Must contain uppercase letter');
    if (!/[a-z]/.test(password)) errors.push('Must contain lowercase letter');
    if (!/[0-9]/.test(password)) errors.push('Must contain digit');
    if (!/[^A-Za-z0-9]/.test(password)) errors.push('Must contain special character');
    return { valid: errors.length === 0, errors };
}

function isValidEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

const VALID_ROLES = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'] as const;

function isValidRegistrationRole(role: string): boolean {
    return (VALID_ROLES as readonly string[]).includes(role);
}

function validateRegistration(email: string, password: string, role: string): { valid: boolean; errors: string[] } {
    const errors: string[] = [];
    if (!isValidEmail(email)) errors.push('Invalid email');
    const pwResult = validatePassword(password);
    errors.push(...pwResult.errors);
    if (!isValidRegistrationRole(role)) errors.push('Invalid role');
    return { valid: errors.length === 0, errors };
}

function validateSlug(slug: string): boolean {
    return slug.length >= 3 && /^[a-z0-9-]+$/.test(slug);
}

describe('Password Policy — Valid', () => {
    it('strong password', () => expect(validatePassword('Abcd123!').valid).toBe(true));
    it('complex password', () => expect(validatePassword('MyP@ssw0rd!').valid).toBe(true));
});

describe('Password Policy — Too Short', () => {
    it('short', () => {
        const r = validatePassword('Ab1!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Password must be at least 8 characters');
    });
});

describe('Password Policy — Missing Components', () => {
    it('no uppercase', () => {
        const r = validatePassword('abcd123!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Must contain uppercase letter');
    });
    it('no lowercase', () => {
        const r = validatePassword('ABCD123!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Must contain lowercase letter');
    });
    it('no digit', () => {
        const r = validatePassword('Abcdefgh!');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Must contain digit');
    });
    it('no special', () => {
        const r = validatePassword('Abcdefg1');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Must contain special character');
    });
});

describe('Email Validation', () => {
    it('valid', () => expect(isValidEmail('user@example.com')).toBe(true));
    it('subdomain', () => expect(isValidEmail('user@sub.example.com')).toBe(true));
    it('no @', () => expect(isValidEmail('userexample.com')).toBe(false));
    it('spaces', () => expect(isValidEmail('user @example.com')).toBe(false));
    it('empty', () => expect(isValidEmail('')).toBe(false));
});

describe('Registration Roles', () => {
    it('client', () => expect(isValidRegistrationRole('client')).toBe(true));
    it('psw', () => expect(isValidRegistrationRole('psw')).toBe(true));
    it('admin', () => expect(isValidRegistrationRole('admin')).toBe(true));
    it('coordinator', () => expect(isValidRegistrationRole('coordinator')).toBe(true));
    it('finance', () => expect(isValidRegistrationRole('finance')).toBe(true));
    it('rn', () => expect(isValidRegistrationRole('rn')).toBe(true));
    it('manager', () => expect(isValidRegistrationRole('manager')).toBe(true));
    it('super_admin invalid', () => expect(isValidRegistrationRole('super_admin')).toBe(false));
    it('ceo invalid', () => expect(isValidRegistrationRole('ceo')).toBe(false));
});

describe('Registration — Full Validation', () => {
    it('valid', () => expect(validateRegistration('u@e.com', 'Abcd123!', 'admin').valid).toBe(true));
    it('bad email', () => {
        const r = validateRegistration('bad', 'Abcd123!', 'admin');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Invalid email');
    });
    it('bad password', () => {
        const r = validateRegistration('u@e.com', 'weak', 'admin');
        expect(r.valid).toBe(false);
    });
    it('bad role', () => {
        const r = validateRegistration('u@e.com', 'Abcd123!', 'ceo');
        expect(r.valid).toBe(false);
        expect(r.errors).toContain('Invalid role');
    });
    it('all bad', () => {
        const r = validateRegistration('bad', 'x', 'ceo');
        expect(r.valid).toBe(false);
        expect(r.errors.length).toBeGreaterThanOrEqual(3);
    });
});

describe('Slug Validation', () => {
    it('valid', () => expect(validateSlug('my-company')).toBe(true));
    it('too short', () => expect(validateSlug('ab')).toBe(false));
    it('uppercase', () => expect(validateSlug('MyCompany')).toBe(false));
    it('spaces', () => expect(validateSlug('my company')).toBe(false));
    it('special chars', () => expect(validateSlug('my_company!')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 5. Error Handler — Origin Validation (replicated from errors.ts)
// ═══════════════════════════════════════════════════════════════════════════

const ALLOWED_ORIGINS = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
const PREVIEW_RE = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/;

function resolveOrigin(origin: string): string {
    if (ALLOWED_ORIGINS.includes(origin)) return origin;
    if (PREVIEW_RE.test(origin)) return origin;
    return ALLOWED_ORIGINS[0];
}

function isPreviewDomain(origin: string): boolean {
    return PREVIEW_RE.test(origin);
}

describe('Origin Validation — Known', () => {
    it('production', () => expect(resolveOrigin('https://primecare-admin.pages.dev')).toBe('https://primecare-admin.pages.dev'));
    it('localhost 5173', () => expect(resolveOrigin('http://localhost:5173')).toBe('http://localhost:5173'));
    it('localhost 8787', () => expect(resolveOrigin('http://localhost:8787')).toBe('http://localhost:8787'));
});

describe('Origin Validation — Preview', () => {
    it('valid preview', () => expect(resolveOrigin('https://abc123.primecare-admin.pages.dev')).toBe('https://abc123.primecare-admin.pages.dev'));
    it('preview check', () => expect(isPreviewDomain('https://abc123.primecare-admin.pages.dev')).toBe(true));
    it('not preview (main)', () => expect(isPreviewDomain('https://primecare-admin.pages.dev')).toBe(false));
});

describe('Origin Validation — Unknown', () => {
    it('evil.com fallback', () => expect(resolveOrigin('https://evil.com')).toBe(ALLOWED_ORIGINS[0]));
    it('empty fallback', () => expect(resolveOrigin('')).toBe(ALLOWED_ORIGINS[0]));
    it('random fallback', () => expect(resolveOrigin('https://random.io')).toBe(ALLOWED_ORIGINS[0]));
});

// ═══════════════════════════════════════════════════════════════════════════
// 6. Ownership — PSW Client Assignment Patterns
// ═══════════════════════════════════════════════════════════════════════════

function shouldEnforceOwnership(roles: string[]): boolean {
    return roles.includes('psw');
}

function resolveClientId(body: any, paramClientId: string | undefined): string | undefined {
    return body?.clientId || paramClientId;
}

function hasPswAccessToClient(assignments: Array<{ clientId: string; pswId: string }>, pswId: string, clientId: string): boolean {
    return assignments.some(a => a.clientId === clientId && a.pswId === pswId);
}

describe('Ownership — Enforcement', () => {
    it('psw enforced', () => expect(shouldEnforceOwnership(['psw'])).toBe(true));
    it('admin not enforced', () => expect(shouldEnforceOwnership(['admin'])).toBe(false));
    it('multi-role with psw', () => expect(shouldEnforceOwnership(['staff', 'psw'])).toBe(true));
});

describe('Ownership — Client ID Resolution', () => {
    it('from body', () => expect(resolveClientId({ clientId: 'c-1' }, undefined)).toBe('c-1'));
    it('from param', () => expect(resolveClientId({}, 'c-2')).toBe('c-2'));
    it('body over param', () => expect(resolveClientId({ clientId: 'c-1' }, 'c-2')).toBe('c-1'));
    it('neither', () => expect(resolveClientId({}, undefined)).toBeUndefined());
});

describe('Ownership — Assignment Check', () => {
    const assignments = [
        { clientId: 'c-1', pswId: 'p-1' },
        { clientId: 'c-2', pswId: 'p-1' },
        { clientId: 'c-3', pswId: 'p-2' },
    ];
    it('assigned', () => expect(hasPswAccessToClient(assignments, 'p-1', 'c-1')).toBe(true));
    it('assigned 2', () => expect(hasPswAccessToClient(assignments, 'p-1', 'c-2')).toBe(true));
    it('not assigned', () => expect(hasPswAccessToClient(assignments, 'p-1', 'c-3')).toBe(false));
    it('wrong psw', () => expect(hasPswAccessToClient(assignments, 'p-2', 'c-1')).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 7. API Response Patterns
// ═══════════════════════════════════════════════════════════════════════════

function buildErrorResponse(error: string, message: string, status: number) {
    return { body: { error, message }, status };
}

function getErrorLabel(status: number): string {
    const labels: Record<number, string> = {
        400: 'Bad Request',
        401: 'Unauthorized',
        403: 'Forbidden',
        404: 'Not Found',
        409: 'Conflict',
        422: 'Unprocessable Entity',
        429: 'Too Many Requests',
        500: 'Internal Server Error',
    };
    return labels[status] || 'Unknown Error';
}

function isClientError(status: number): boolean {
    return status >= 400 && status < 500;
}

function isServerError(status: number): boolean {
    return status >= 500 && status < 600;
}

describe('API Response — Error Builder', () => {
    it('401', () => {
        const r = buildErrorResponse('Unauthorized', 'Not logged in', 401);
        expect(r.status).toBe(401);
        expect(r.body.error).toBe('Unauthorized');
    });
    it('403', () => {
        const r = buildErrorResponse('Forbidden', 'No access', 403);
        expect(r.status).toBe(403);
    });
    it('500', () => {
        const r = buildErrorResponse('Internal Server Error', 'Bug', 500);
        expect(r.status).toBe(500);
    });
});

describe('API Response — Labels', () => {
    it('400', () => expect(getErrorLabel(400)).toBe('Bad Request'));
    it('401', () => expect(getErrorLabel(401)).toBe('Unauthorized'));
    it('403', () => expect(getErrorLabel(403)).toBe('Forbidden'));
    it('404', () => expect(getErrorLabel(404)).toBe('Not Found'));
    it('409', () => expect(getErrorLabel(409)).toBe('Conflict'));
    it('422', () => expect(getErrorLabel(422)).toBe('Unprocessable Entity'));
    it('429', () => expect(getErrorLabel(429)).toBe('Too Many Requests'));
    it('500', () => expect(getErrorLabel(500)).toBe('Internal Server Error'));
    it('unknown', () => expect(getErrorLabel(418)).toBe('Unknown Error'));
});

describe('API Response — Classification', () => {
    it('400 client', () => expect(isClientError(400)).toBe(true));
    it('404 client', () => expect(isClientError(404)).toBe(true));
    it('500 not client', () => expect(isClientError(500)).toBe(false));
    it('500 server', () => expect(isServerError(500)).toBe(true));
    it('503 server', () => expect(isServerError(503)).toBe(true));
    it('404 not server', () => expect(isServerError(404)).toBe(false));
});

// ═══════════════════════════════════════════════════════════════════════════
// 8. Content Type & Method Guards
// ═══════════════════════════════════════════════════════════════════════════

function isJsonRequest(contentType: string): boolean {
    return contentType.includes('application/json');
}

function isFormRequest(contentType: string): boolean {
    return contentType.includes('multipart/form-data') || contentType.includes('application/x-www-form-urlencoded');
}

function isMutationMethod(method: string): boolean {
    return ['POST', 'PUT', 'PATCH', 'DELETE'].includes(method);
}

function getRequiredHeaders(method: string): string[] {
    const headers = ['Content-Type'];
    if (isMutationMethod(method)) headers.push('X-Requested-With');
    return headers;
}

describe('Content Type Guards', () => {
    it('JSON', () => expect(isJsonRequest('application/json')).toBe(true));
    it('JSON charset', () => expect(isJsonRequest('application/json; charset=utf-8')).toBe(true));
    it('form', () => expect(isFormRequest('multipart/form-data')).toBe(true));
    it('urlencoded', () => expect(isFormRequest('application/x-www-form-urlencoded')).toBe(true));
    it('not form', () => expect(isFormRequest('application/json')).toBe(false));
});

describe('Method Guards', () => {
    it('POST', () => expect(isMutationMethod('POST')).toBe(true));
    it('DELETE', () => expect(isMutationMethod('DELETE')).toBe(true));
    it('GET', () => expect(isMutationMethod('GET')).toBe(false));
});

describe('Required Headers', () => {
    it('GET', () => expect(getRequiredHeaders('GET')).toEqual(['Content-Type']));
    it('POST', () => expect(getRequiredHeaders('POST')).toEqual(['Content-Type', 'X-Requested-With']));
});
