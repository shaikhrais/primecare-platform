// Governance - Category: model | Purpose: ── Lead Schemas ─────────────────────────────────────────────────────────
import { z } from 'zod';

// ── Lead Schemas ─────────────────────────────────────────────────────────

export const LeadStatusSchema = z.enum([
    'new',
    'contacted',
    'qualified',
    'converted',
    'lost',
]);

export const UpdateLeadStatusSchema = z.object({
    status: LeadStatusSchema,
});

/** Lead submission from public contact / consultation forms */
export const CreateLeadSchema = z.object({
    firstName: z.string().min(1),
    lastName: z.string().min(1),
    email: z.string().email(),
    phone: z.string().optional(),
    source: z.string().optional(),
    notes: z.string().optional(),
});

// ── Derived Types ────────────────────────────────────────────────────────

export type LeadStatus = z.infer<typeof LeadStatusSchema>;
export type UpdateLeadStatusInput = z.infer<typeof UpdateLeadStatusSchema>;
export type CreateLeadInput = z.infer<typeof CreateLeadSchema>;
