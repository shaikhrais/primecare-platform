/**
 * Lead Validation Schemas
 */
import { z } from 'zod';
import { nameSchema, emailSchema, phoneSchema, notesSchema } from './common';

export const createLeadSchema = z.object({
    name: nameSchema,
    email: emailSchema.optional().or(z.literal('')),
    phone: phoneSchema,
    source: z.enum(['website', 'referral', 'social', 'advertisement', 'other']).default('other'),
    notes: notesSchema,
    serviceInterest: z.string().optional(),
});
