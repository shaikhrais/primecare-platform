import { z } from 'zod';

// ── Create / Update Schemas ──────────────────────────────────────────────

export const CreateVisitSchema = z.object({
    clientId: z.string().uuid(),
    serviceId: z.string().uuid(),
    requestedStartAt: z.string().datetime(),
    durationMinutes: z.number().min(30),
    assignedPswId: z.string().uuid().optional(),
    clientNotes: z.string().optional(),
    priority: z.string().optional().default('normal'),
    requiredSkills: z.array(z.string()).optional().default([]),
    recurrenceRuleString: z.string().optional(),
    recurrenceEndDate: z.string().datetime().nullable().optional(),
});

export const UpdateVisitSchema = z.object({
    status: z.string().optional(),
    requestedStartAt: z.string().datetime().optional(),
    durationMinutes: z.number().optional(),
});

// ── Derived Types ────────────────────────────────────────────────────────

export type CreateVisitInput = z.infer<typeof CreateVisitSchema>;
export type UpdateVisitInput = z.infer<typeof UpdateVisitSchema>;
