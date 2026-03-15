/**
 * Auth Validation Schemas — Login & Registration
 */
import { z } from 'zod';
import { emailSchema, passwordSchema, nameSchema, phoneSchema } from './common';

export const loginSchema = z.object({
    email: emailSchema,
    password: z.string().min(1, 'Password is required'),
});

export const registerSchema = z.object({
    email: emailSchema,
    password: passwordSchema,
    confirmPassword: z.string(),
    name: nameSchema,
    role: z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager']),
    phone: phoneSchema,
}).refine((data) => data.password === data.confirmPassword, {
    message: "Passwords don't match",
    path: ['confirmPassword'],
});
