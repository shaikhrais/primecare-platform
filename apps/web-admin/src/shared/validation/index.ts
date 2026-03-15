/**
 * Validation Schemas — Reusable Zod schemas for all domain entities
 *
 * Provides typed validation for forms, API requests, and data integrity.
 * Usage: import { visitSchema } from '@/shared/validation';
 */
import { z } from 'zod';

// ── Common Fields ─────────────────────────────────────────────────────────

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

// ── Auth Schemas ──────────────────────────────────────────────────────────

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

// ── Visit Schemas ─────────────────────────────────────────────────────────

export const createVisitSchema = z.object({
    clientId: idSchema,
    serviceId: idSchema,
    pswId: idSchema.optional(),
    scheduledStart: dateTimeSchema,
    scheduledEnd: dateTimeSchema,
    notes: notesSchema,
}).refine((data) => new Date(data.scheduledEnd) > new Date(data.scheduledStart), {
    message: 'End time must be after start time',
    path: ['scheduledEnd'],
});

export const updateVisitSchema = z.object({
    status: z.enum(['scheduled', 'in_progress', 'completed', 'cancelled', 'no_show']).optional(),
    pswId: idSchema.optional(),
    scheduledStart: dateTimeSchema.optional(),
    scheduledEnd: dateTimeSchema.optional(),
    notes: notesSchema,
    actualStart: dateTimeSchema.optional(),
    actualEnd: dateTimeSchema.optional(),
});

// ── User Schemas ──────────────────────────────────────────────────────────

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

// ── Incident Schemas ──────────────────────────────────────────────────────

export const createIncidentSchema = z.object({
    type: z.string().min(1, 'Incident type required'),
    severity: z.enum(['low', 'medium', 'high', 'critical']),
    description: z.string().min(10, 'Description must be at least 10 characters').max(5000),
    clientId: idSchema.optional(),
    visitId: idSchema.optional(),
    pswId: idSchema.optional(),
});

// ── Invoice Schemas ───────────────────────────────────────────────────────

export const createInvoiceSchema = z.object({
    clientId: idSchema,
    items: z.array(z.object({
        description: z.string().min(1),
        quantity: z.number().min(1),
        unitPrice: z.number().min(0),
        taxRate: z.number().min(0).max(1).default(0.13),
    })).min(1, 'At least one item required'),
    dueDate: dateSchema,
    notes: notesSchema,
});

// ── Lead Schemas ──────────────────────────────────────────────────────────

export const createLeadSchema = z.object({
    name: nameSchema,
    email: emailSchema.optional().or(z.literal('')),
    phone: phoneSchema,
    source: z.enum(['website', 'referral', 'social', 'advertisement', 'other']).default('other'),
    notes: notesSchema,
    serviceInterest: z.string().optional(),
});

// ── Service Schemas ───────────────────────────────────────────────────────

export const createServiceSchema = z.object({
    name: z.string().min(2).max(200),
    description: z.string().max(2000).optional(),
    category: z.string().min(1, 'Category required'),
    hourlyRate: z.number().min(0, 'Rate must be positive'),
    isActive: z.boolean().default(true),
});

// ── Pagination & Filter Schema ────────────────────────────────────────────

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
