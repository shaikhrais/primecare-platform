import { z } from 'zod';

export const LoginSchema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
});

export const RegisterSchema = z.object({
    email: z.string().email(),
    password: z.string().min(8),
    role: z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn']),
    tenantName: z.string().optional(),
    tenantSlug: z.string().optional(),
});

export const ForgotPasswordSchema = z.object({
    email: z.string().email(),
});

export const ResetPasswordSchema = z.object({
    token: z.string(),
    newPassword: z.string().min(8),
});
