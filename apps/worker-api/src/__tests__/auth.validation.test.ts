import { describe, it, expect } from 'vitest';
import { LoginSchema, RegisterSchema, ForgotPasswordSchema, ResetPasswordSchema, BusinessOnboardSchema } from '../auth/auth.validation';

describe('Auth Validation Schemas', () => {
    // ── LoginSchema ──────────────────────────────────────────────────────
    describe('LoginSchema', () => {
        it('accepts valid login credentials', () => {
            const result = LoginSchema.safeParse({ email: 'admin@primecare.ca', password: 'secret123' });
            expect(result.success).toBe(true);
        });

        it('rejects missing email', () => {
            const result = LoginSchema.safeParse({ password: 'secret123' });
            expect(result.success).toBe(false);
        });

        it('rejects invalid email format', () => {
            const result = LoginSchema.safeParse({ email: 'not-an-email', password: 'secret123' });
            expect(result.success).toBe(false);
        });

        it('rejects empty password', () => {
            const result = LoginSchema.safeParse({ email: 'admin@primecare.ca', password: '' });
            expect(result.success).toBe(false);
        });

        it('accepts any non-empty password (validation is on registration)', () => {
            const result = LoginSchema.safeParse({ email: 'admin@primecare.ca', password: 'x' });
            expect(result.success).toBe(true);
        });
    });

    // ── RegisterSchema ───────────────────────────────────────────────────
    describe('RegisterSchema', () => {
        const validPayload = {
            email: 'newuser@primecare.ca',
            password: 'StrongP@ss1',
            role: 'client' as const,
        };

        it('accepts valid registration', () => {
            const result = RegisterSchema.safeParse(validPayload);
            expect(result.success).toBe(true);
        });

        it('rejects password without uppercase', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, password: 'weakp@ss1' });
            expect(result.success).toBe(false);
        });

        it('rejects password without lowercase', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, password: 'STRONGP@SS1' });
            expect(result.success).toBe(false);
        });

        it('rejects password without digit', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, password: 'StrongP@ss' });
            expect(result.success).toBe(false);
        });

        it('rejects password without special character', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, password: 'StrongPass1' });
            expect(result.success).toBe(false);
        });

        it('rejects password shorter than 8 characters', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, password: 'Ab@1' });
            expect(result.success).toBe(false);
        });

        it('rejects password longer than 128 characters', () => {
            const longPassword = 'A'.repeat(121) + 'a@1bcdef';  // 129 chars total
            const result = RegisterSchema.safeParse({ ...validPayload, password: longPassword });
            expect(result.success).toBe(false);
        });

        it('rejects invalid role', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, role: 'superadmin' });
            expect(result.success).toBe(false);
        });

        it('accepts all valid roles', () => {
            const roles = ['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager'];
            for (const role of roles) {
                const result = RegisterSchema.safeParse({ ...validPayload, role });
                expect(result.success).toBe(true);
            }
        });

        it('accepts optional tenant fields', () => {
            const result = RegisterSchema.safeParse({ ...validPayload, tenantName: 'My Org', tenantSlug: 'my-org' });
            expect(result.success).toBe(true);
        });
    });

    // ── ForgotPasswordSchema ────────────────────────────────────────────
    describe('ForgotPasswordSchema', () => {
        it('accepts valid email', () => {
            const result = ForgotPasswordSchema.safeParse({ email: 'user@example.com' });
            expect(result.success).toBe(true);
        });

        it('rejects invalid email', () => {
            const result = ForgotPasswordSchema.safeParse({ email: 'bad' });
            expect(result.success).toBe(false);
        });
    });

    // ── ResetPasswordSchema ─────────────────────────────────────────────
    describe('ResetPasswordSchema', () => {
        it('accepts valid token + strong password', () => {
            const result = ResetPasswordSchema.safeParse({ token: 'abc123', newPassword: 'NewP@ss1' });
            expect(result.success).toBe(true);
        });

        it('rejects weak new password', () => {
            const result = ResetPasswordSchema.safeParse({ token: 'abc123', newPassword: 'weak' });
            expect(result.success).toBe(false);
        });
    });

    // ── BusinessOnboardSchema ───────────────────────────────────────────
    describe('BusinessOnboardSchema', () => {
        const validPayload = {
            email: 'owner@company.com',
            password: 'Owner@Pass1',
            tenantName: 'My Company',
            tenantSlug: 'my-company',
        };

        it('accepts valid business onboarding', () => {
            const result = BusinessOnboardSchema.safeParse(validPayload);
            expect(result.success).toBe(true);
        });

        it('rejects tenant name shorter than 3 chars', () => {
            const result = BusinessOnboardSchema.safeParse({ ...validPayload, tenantName: 'AB' });
            expect(result.success).toBe(false);
        });

        it('rejects tenant slug with uppercase letters', () => {
            const result = BusinessOnboardSchema.safeParse({ ...validPayload, tenantSlug: 'My-Company' });
            expect(result.success).toBe(false);
        });

        it('rejects tenant slug with spaces', () => {
            const result = BusinessOnboardSchema.safeParse({ ...validPayload, tenantSlug: 'my company' });
            expect(result.success).toBe(false);
        });
    });
});
