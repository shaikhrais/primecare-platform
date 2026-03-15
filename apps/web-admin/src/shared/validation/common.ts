/**
 * Common Validation Schemas — Reusable Zod primitives for all domains
 */
import { z } from 'zod';

// ── Primitive Fields ──────────────────────────────────────────────────────

export const emailSchema = z.string()
    .email('Invalid email address')
    .min(5, 'Email too short')
    .max(254, 'Email too long')
    .toLowerCase()
    .trim();

export const passwordSchema = z.string()
    .min(8, 'Password must be at least 8 characters')
    .max(128, 'Password too long')
    .regex(/[A-Z]/, 'Must contain at least one uppercase letter')
    .regex(/[a-z]/, 'Must contain at least one lowercase letter')
    .regex(/[0-9]/, 'Must contain at least one number');

export const phoneSchema = z.string()
    .regex(/^\+?[1-9]\d{7,14}$/, 'Invalid phone number')
    .optional()
    .or(z.literal(''));

export const dateSchema = z.string()
    .regex(/^\d{4}-\d{2}-\d{2}/, 'Must be a valid date (YYYY-MM-DD)')
    .refine((d) => !isNaN(Date.parse(d)), 'Invalid date');

export const dateTimeSchema = z.string()
    .refine((d) => !isNaN(Date.parse(d)), 'Invalid datetime');

export const idSchema = z.string().min(1, 'ID is required');

export const nameSchema = z.string()
    .min(2, 'Name must be at least 2 characters')
    .max(100, 'Name too long')
    .trim();

export const notesSchema = z.string()
    .max(5000, 'Notes too long')
    .optional()
    .or(z.literal(''));

export const addressSchema = z.object({
    street: z.string().min(1, 'Street required').max(200),
    city: z.string().min(1, 'City required').max(100),
    province: z.string().min(1, 'Province required').max(50),
    postalCode: z.string().regex(/^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$/, 'Invalid Canadian postal code'),
    country: z.string().default('CA'),
});

// ── Pagination & Filter ───────────────────────────────────────────────────

export const paginationSchema = z.object({
    page: z.number().int().min(1).default(1),
    pageSize: z.number().int().min(1).max(100).default(20),
    sort: z.string().optional(),
    order: z.enum(['asc', 'desc']).default('asc'),
    search: z.string().optional(),
});

export const dateRangeSchema = z.object({
    start: dateSchema,
    end: dateSchema,
}).refine((data) => new Date(data.end) >= new Date(data.start), {
    message: 'End date must be on or after start date',
    path: ['end'],
});
