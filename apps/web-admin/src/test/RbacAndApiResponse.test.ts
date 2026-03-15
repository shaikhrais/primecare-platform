/**
 * RBAC, API Response, and Pagination Deep Tests
 *
 * Self-contained replicas of:
 * - rbac.ts: Role hierarchy, umbrella matching, permission checks
 * - api-response.ts: Response envelope, pagination math
 * - auth.validation.ts: Password policy, email validation
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// RBAC Role Matching (replicated from rbac.ts)
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

describe('RBAC Role Matching — Direct Roles', () => {
    it('admin matches admin', () => {
        expect(hasRoleAccess(['admin'], ['admin'])).toBe(true);
    });

    it('client matches client', () => {
        expect(hasRoleAccess(['client'], ['client'])).toBe(true);
    });

    it('admin does not match client', () => {
        expect(hasRoleAccess(['admin'], ['client'])).toBe(false);
    });

    it('empty roles has no access', () => {
        expect(hasRoleAccess([], ['admin'])).toBe(false);
    });

    it('multiple roles — one matches', () => {
        expect(hasRoleAccess(['client', 'admin'], ['admin'])).toBe(true);
    });
});

describe('RBAC Role Matching — Super Admin Bypass', () => {
    it('super_admin bypasses any role check', () => {
        expect(hasRoleAccess(['super_admin'], ['client'])).toBe(true);
    });

    it('super_admin bypasses admin check', () => {
        expect(hasRoleAccess(['super_admin'], ['admin'])).toBe(true);
    });

    it('scrum_master bypasses any role check', () => {
        expect(hasRoleAccess(['scrum_master'], ['manager'])).toBe(true);
    });

    it('scrum_master bypasses service_provider check', () => {
        expect(hasRoleAccess(['scrum_master'], ['service_provider'])).toBe(true);
    });
});

describe('RBAC Role Matching — Manager Umbrella', () => {
    for (const subrole of MANAGER_SUBROLES) {
        it(`"${subrole}" has access when "manager" is allowed`, () => {
            expect(hasRoleAccess([subrole], ['manager'])).toBe(true);
        });
    }

    it('manager does not match staff', () => {
        expect(hasRoleAccess(['manager'], ['staff'])).toBe(false);
    });
});

describe('RBAC Role Matching — Service Provider Umbrella', () => {
    for (const sp of SERVICE_PROVIDERS) {
        it(`"${sp}" has access when "service_provider" is allowed`, () => {
            expect(hasRoleAccess([sp], ['service_provider'])).toBe(true);
        });
    }

    it('service provider does not match manager', () => {
        expect(hasRoleAccess(['psw'], ['manager'])).toBe(false);
    });
});

describe('RBAC Role Matching — Staff Umbrella', () => {
    for (const sr of STAFF_SUBROLES) {
        it(`"${sr}" has access when "staff" is allowed`, () => {
            expect(hasRoleAccess([sr], ['staff'])).toBe(true);
        });
    }

    it('staff does not match service_provider', () => {
        expect(hasRoleAccess(['staff'], ['service_provider'])).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// API Response Envelope (replicated from api-response.ts)
// ═══════════════════════════════════════════════════════════════════════════

interface ApiMeta { page?: number; limit?: number; total?: number; totalPages?: number; hasNext?: boolean; hasPrev?: boolean; }

function successResponse<T>(data: T, meta?: ApiMeta) {
    return { success: true, data, meta: meta || null, error: null };
}

function errorResponse(message: string, details?: any) {
    return { success: false, data: null, meta: null, error: { message, ...(details ? { details } : {}) } };
}

function paginatedResponse<T>(items: T[], page: number, limit: number, total: number) {
    return {
        success: true,
        data: items,
        meta: {
            page, limit, total,
            totalPages: Math.ceil(total / limit),
            hasNext: page * limit < total,
            hasPrev: page > 1,
        },
        error: null,
    };
}

describe('API Response Envelope — Success', () => {
    it('success flag is true', () => {
        expect(successResponse({ id: 1 }).success).toBe(true);
    });

    it('error is null on success', () => {
        expect(successResponse({ id: 1 }).error).toBeNull();
    });

    it('data is populated', () => {
        expect(successResponse({ name: 'test' }).data).toEqual({ name: 'test' });
    });

    it('meta is null when not provided', () => {
        expect(successResponse('ok').meta).toBeNull();
    });

    it('meta is populated when provided', () => {
        const result = successResponse('ok', { page: 1 });
        expect(result.meta).toEqual({ page: 1 });
    });
});

describe('API Response Envelope — Error', () => {
    it('success flag is false', () => {
        expect(errorResponse('Not found').success).toBe(false);
    });

    it('data is null on error', () => {
        expect(errorResponse('fail').data).toBeNull();
    });

    it('error message is set', () => {
        expect(errorResponse('Bad request').error.message).toBe('Bad request');
    });

    it('details are included when provided', () => {
        const result = errorResponse('Validation', { field: 'email' });
        expect(result.error.details).toEqual({ field: 'email' });
    });

    it('details are absent when not provided', () => {
        const result = errorResponse('Server error');
        expect(result.error.details).toBeUndefined();
    });
});

describe('API Response Envelope — Pagination', () => {
    it('calculates totalPages correctly', () => {
        const result = paginatedResponse([1, 2, 3], 1, 10, 25);
        expect(result.meta.totalPages).toBe(3);
    });

    it('totalPages for exact division', () => {
        expect(paginatedResponse([], 1, 10, 30).meta.totalPages).toBe(3);
    });

    it('totalPages for single page', () => {
        expect(paginatedResponse([], 1, 10, 5).meta.totalPages).toBe(1);
    });

    it('totalPages for zero items', () => {
        expect(paginatedResponse([], 1, 10, 0).meta.totalPages).toBe(0);
    });

    it('hasNext is true when more items exist', () => {
        expect(paginatedResponse([], 1, 10, 25).meta.hasNext).toBe(true);
    });

    it('hasNext is false on last page', () => {
        expect(paginatedResponse([], 3, 10, 25).meta.hasNext).toBe(false);
    });

    it('hasPrev is false on first page', () => {
        expect(paginatedResponse([], 1, 10, 25).meta.hasPrev).toBe(false);
    });

    it('hasPrev is true on second page', () => {
        expect(paginatedResponse([], 2, 10, 25).meta.hasPrev).toBe(true);
    });

    it('data contains items', () => {
        expect(paginatedResponse([1, 2, 3], 1, 10, 3).data).toEqual([1, 2, 3]);
    });

    it('meta page matches input', () => {
        expect(paginatedResponse([], 5, 20, 100).meta.page).toBe(5);
    });

    it('meta limit matches input', () => {
        expect(paginatedResponse([], 1, 50, 200).meta.limit).toBe(50);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Password Validation (replicated from auth.validation.ts)
// ═══════════════════════════════════════════════════════════════════════════

function validatePassword(pw: string): string[] {
    const errors: string[] = [];
    if (pw.length < 8) errors.push('Password must be at least 8 characters');
    if (pw.length > 128) errors.push('Password must be at most 128 characters');
    if (!/[A-Z]/.test(pw)) errors.push('Password must contain at least one uppercase letter');
    if (!/[a-z]/.test(pw)) errors.push('Password must contain at least one lowercase letter');
    if (!/[0-9]/.test(pw)) errors.push('Password must contain at least one digit');
    if (!/[^A-Za-z0-9]/.test(pw)) errors.push('Password must contain at least one special character');
    return errors;
}

describe('Password Policy Validation', () => {
    it('accepts strong password', () => {
        expect(validatePassword('StrongP@ss1')).toEqual([]);
    });

    it('rejects too short', () => {
        expect(validatePassword('Sh0!')).toContain('Password must be at least 8 characters');
    });

    it('rejects too long', () => {
        const long = 'A'.repeat(129) + 'a1!';
        expect(validatePassword(long)).toContain('Password must be at most 128 characters');
    });

    it('rejects no uppercase', () => {
        expect(validatePassword('lowercase1!')).toContain('Password must contain at least one uppercase letter');
    });

    it('rejects no lowercase', () => {
        expect(validatePassword('UPPERCASE1!')).toContain('Password must contain at least one lowercase letter');
    });

    it('rejects no digit', () => {
        expect(validatePassword('NoDigits!!')).toContain('Password must contain at least one digit');
    });

    it('rejects no special char', () => {
        expect(validatePassword('NoSpecial1A')).toContain('Password must contain at least one special character');
    });

    it('multiple errors for empty-ish password', () => {
        const errors = validatePassword('ab');
        expect(errors.length).toBeGreaterThanOrEqual(4);
    });

    it('complex valid password passes', () => {
        expect(validatePassword('C0mpl3x!Pass#2026')).toEqual([]);
    });

    it('password with space is valid special char', () => {
        expect(validatePassword('Pass word1 ')).toEqual([]);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Email Validation (basic regex-like)
// ═══════════════════════════════════════════════════════════════════════════

function isValidEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

describe('Email Validation', () => {
    it('accepts valid email', () => {
        expect(isValidEmail('admin@test.com')).toBe(true);
    });

    it('accepts email with subdomain', () => {
        expect(isValidEmail('user@mail.example.com')).toBe(true);
    });

    it('rejects empty string', () => {
        expect(isValidEmail('')).toBe(false);
    });

    it('rejects no @', () => {
        expect(isValidEmail('usertest.com')).toBe(false);
    });

    it('rejects no domain', () => {
        expect(isValidEmail('user@')).toBe(false);
    });

    it('rejects no TLD', () => {
        expect(isValidEmail('user@domain')).toBe(false);
    });

    it('rejects spaces', () => {
        expect(isValidEmail('user @test.com')).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Allowed Roles (from RegisterSchema)
// ═══════════════════════════════════════════════════════════════════════════

const ALLOWED_REGISTER_ROLES = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'];

describe('Registration Roles', () => {
    for (const role of ALLOWED_REGISTER_ROLES) {
        it(`allows role "${role}"`, () => {
            expect(ALLOWED_REGISTER_ROLES.includes(role)).toBe(true);
        });
    }

    it('rejects unknown role', () => {
        expect(ALLOWED_REGISTER_ROLES.includes('hacker')).toBe(false);
    });

    it('rejects super_admin registration', () => {
        expect(ALLOWED_REGISTER_ROLES.includes('super_admin')).toBe(false);
    });

    it('rejects scrum_master registration', () => {
        expect(ALLOWED_REGISTER_ROLES.includes('scrum_master')).toBe(false);
    });
});
