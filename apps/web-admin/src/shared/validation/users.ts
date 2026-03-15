/**
 * User Validation Schemas — Create & Update users
 */
import { z } from 'zod';
import { emailSchema, nameSchema, phoneSchema } from './common';

export const createUserSchema = z.object({
    email: emailSchema,
    name: nameSchema,
    role: z.enum(['client', 'psw', 'staff', 'admin', 'coordinator', 'finance', 'rn', 'manager']),
    phone: phoneSchema,
});

export const updateUserSchema = z.object({
    name: nameSchema.optional(),
    phone: phoneSchema,
    email: emailSchema.optional(),
    status: z.enum(['active', 'inactive', 'pending']).optional(),
});
