import { z } from 'zod';

// R23: Password policy — min 8 chars, must include uppercase, lowercase, digit, and special char
const PasswordSchema = z.string()
    .min(8, 'Password must be at least 8 characters')
    .max(128, 'Password must be at most 128 characters')
    .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
    .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
    .regex(/[0-9]/, 'Password must contain at least one digit')
    .regex(/[^A-Za-z0-9]/, 'Password must contain at least one special character');

export const LoginSchema = z.object({
    email: z.string().email(),
    password: z.string().min(1),  // Login accepts any password — validation is on registration
});

export const RegisterSchema = z.object({
    email: z.string().email(),
    password: PasswordSchema,
    role: z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager']),
    tenantName: z.string().optional(),
    tenantSlug: z.string().optional(),
});

export const ForgotPasswordSchema = z.object({
    email: z.string().email(),
});

export const ResetPasswordSchema = z.object({
    token: z.string(),
    newPassword: PasswordSchema,
});

export const BusinessOnboardSchema = z.object({
    email: z.string().email(),
    password: PasswordSchema,
    tenantName: z.string().min(3),
    tenantSlug: z.string().min(3).regex(/^[a-z0-9-]+$/, "Slug must be lowercase alphanumeric with hyphens"),
});
