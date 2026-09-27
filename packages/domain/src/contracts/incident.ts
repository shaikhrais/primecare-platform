// Governance - Category: model | Purpose: ── Incident Schemas ───────────────────────────────────────────────────── ── Derived Types ──────────────────────────...
import { z } from 'zod';

// ── Incident Schemas ─────────────────────────────────────────────────────

export const IncidentStatusSchema = z.enum([
    'open',
    'investigating',
    'resolved',
    'closed',
]);

export const UpdateIncidentSchema = z.object({
    status: IncidentStatusSchema,
    resolutionNotes: z.string().optional(),
});

// ── Derived Types ────────────────────────────────────────────────────────

export type IncidentStatus = z.infer<typeof IncidentStatusSchema>;
export type UpdateIncidentInput = z.infer<typeof UpdateIncidentSchema>;
