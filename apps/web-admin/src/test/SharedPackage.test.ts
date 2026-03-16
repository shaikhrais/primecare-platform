/**
 * Shared Package Tests
 *
 * Tests the prime-care-shared package exports: schemas, permissions,
 * app registries, and cross-package integrity.
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Shared Package Module Export
// ═══════════════════════════════════════════════════════════════════════════

describe('Shared Package', () => {
    it('module is importable', async () => {
        const mod: any = await import('prime-care-shared');
        expect(mod).toBeDefined();
        expect(typeof mod).toBe('object');
    });

    it('has multiple exports', async () => {
        const mod: any = await import('prime-care-shared');
        expect(Object.keys(mod).length).toBeGreaterThan(5);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Permission System
// ═══════════════════════════════════════════════════════════════════════════

describe('Permission System', () => {
    it('exports ROLE_PERMISSIONS', async () => {
        const { ROLE_PERMISSIONS } = await import('prime-care-shared');
        expect(ROLE_PERMISSIONS).toBeDefined();
        expect(typeof ROLE_PERMISSIONS).toBe('object');
    });

    it('exports PLATFORM_ROLES', async () => {
        const { PLATFORM_ROLES } = await import('prime-care-shared');
        expect(PLATFORM_ROLES).toBeDefined();
        expect(Array.isArray(PLATFORM_ROLES)).toBe(true);
    });

    it('exports can function', async () => {
        const { can } = await import('prime-care-shared');
        expect(can).toBeDefined();
        expect(typeof can).toBe('function');
    });

    it('PLATFORM_ROLES contains admin', async () => {
        const { PLATFORM_ROLES } = await import('prime-care-shared');
        expect(PLATFORM_ROLES).toContain('admin');
    });

    it('PLATFORM_ROLES contains client', async () => {
        const { PLATFORM_ROLES } = await import('prime-care-shared');
        expect(PLATFORM_ROLES).toContain('client');
    });

    it('PLATFORM_ROLES contains psw', async () => {
        const { PLATFORM_ROLES } = await import('prime-care-shared');
        expect(PLATFORM_ROLES).toContain('psw');
    });

    it('ROLE_PERMISSIONS maps every role', async () => {
        const { PLATFORM_ROLES, ROLE_PERMISSIONS } = await import('prime-care-shared');
        PLATFORM_ROLES.forEach((role: string) => {
            expect(ROLE_PERMISSIONS[role]).toBeDefined();
            expect(Array.isArray(ROLE_PERMISSIONS[role])).toBe(true);
        });
    });

    it('admin has broadest permissions', async () => {
        const { ROLE_PERMISSIONS } = await import('prime-care-shared');
        const adminPerms = ROLE_PERMISSIONS['admin'];
        const clientPerms = ROLE_PERMISSIONS['client'];
        expect(adminPerms.length).toBeGreaterThan(clientPerms.length);
    });

    it('can() returns true for admin with admin permission', async () => {
        const { can, ROLE_PERMISSIONS } = await import('prime-care-shared');
        const adminPerms = ROLE_PERMISSIONS['admin'];
        if (adminPerms && adminPerms.length > 0) {
            expect(can('admin', adminPerms[0])).toBe(true);
        }
    });

    it('can() returns false for nonexistent permission', async () => {
        const { can } = await import('prime-care-shared');
        expect(can('client', 'NONEXISTENT_PERMISSION_XYZ' as any)).toBe(false);
    });

    it('can() returns false for nonexistent role', async () => {
        const { can } = await import('prime-care-shared');
        expect(can('fake_role' as any, 'VIEW_DASHBOARD' as any)).toBe(false);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Schemas
// ═══════════════════════════════════════════════════════════════════════════

describe('Schemas', () => {
    it('exports LeadSchema', async () => {
        const { LeadSchema } = await import('prime-care-shared');
        expect(LeadSchema).toBeDefined();
    });

    it('exports LoginSchema', async () => {
        const { LoginSchema } = await import('prime-care-shared');
        expect(LoginSchema).toBeDefined();
    });

    it('exports RegisterSchema', async () => {
        const { RegisterSchema } = await import('prime-care-shared');
        expect(RegisterSchema).toBeDefined();
    });

    it('LeadSchema validates correct data', async () => {
        const { LeadSchema } = await import('prime-care-shared');
        const result = LeadSchema.safeParse({ full_name: 'John Doe', email: 'john@example.com', source: 'contact_form' });
        expect(result.success).toBe(true);
    });

    it('LeadSchema rejects invalid data', async () => {
        const { LeadSchema } = await import('prime-care-shared');
        const result = LeadSchema.safeParse({ full_name: 'J', email: 'bad' });
        expect(result.success).toBe(false);
    });

    it('LeadSchema requires source enum', async () => {
        const { LeadSchema } = await import('prime-care-shared');
        const result = LeadSchema.safeParse({ full_name: 'John', email: 'a@b.com', source: 'invalid_source' });
        expect(result.success).toBe(false);
    });

    it('LeadSchema accepts all 3 sources', async () => {
        const { LeadSchema } = await import('prime-care-shared');
        ['contact_form', 'book_consultation', 'careers'].forEach(source => {
            const result = LeadSchema.safeParse({ full_name: 'John', email: 'a@b.com', source });
            expect(result.success).toBe(true);
        });
    });

    it('LoginSchema validates correct data', async () => {
        const { LoginSchema } = await import('prime-care-shared');
        const result = LoginSchema.safeParse({ email: 'a@b.com', password: 'password123' });
        expect(result.success).toBe(true);
    });

    it('LoginSchema rejects short password', async () => {
        const { LoginSchema } = await import('prime-care-shared');
        const result = LoginSchema.safeParse({ email: 'a@b.com', password: 'short' });
        expect(result.success).toBe(false);
    });

    it('RegisterSchema validates correct data', async () => {
        const { RegisterSchema } = await import('prime-care-shared');
        const result = RegisterSchema.safeParse({ email: 'a@b.com', password: 'password123', role: 'client' });
        expect(result.success).toBe(true);
    });

    it('RegisterSchema rejects invalid role', async () => {
        const { RegisterSchema } = await import('prime-care-shared');
        const result = RegisterSchema.safeParse({ email: 'a@b.com', password: 'password123', role: 'hacker' });
        expect(result.success).toBe(false);
    });

    it('RegisterSchema accepts psw role', async () => {
        const { RegisterSchema } = await import('prime-care-shared');
        const result = RegisterSchema.safeParse({ email: 'a@b.com', password: 'password123', role: 'psw' });
        expect(result.success).toBe(true);
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// App Registries
// ═══════════════════════════════════════════════════════════════════════════

describe('App Registries', () => {
    it('exports AdminRegistry', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(AdminRegistry).toBeDefined();
    });

    it('exports MarketingRegistry', async () => {
        const { MarketingRegistry } = await import('prime-care-shared');
        expect(MarketingRegistry).toBeDefined();
    });

    it('AdminRegistry is an object', async () => {
        const { AdminRegistry } = await import('prime-care-shared');
        expect(typeof AdminRegistry).toBe('object');
    });

    it('MarketingRegistry is an object', async () => {
        const { MarketingRegistry } = await import('prime-care-shared');
        expect(typeof MarketingRegistry).toBe('object');
    });
});
