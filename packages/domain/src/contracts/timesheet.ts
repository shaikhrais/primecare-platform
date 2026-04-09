import { z } from 'zod';

// ── Timesheet Schemas ────────────────────────────────────────────────────

export const TimesheetStatusSchema = z.enum([
    'draft',
    'submitted',
    'approved',
    'rejected',
]);

export const UpdateTimesheetStatusSchema = z.object({
    status: TimesheetStatusSchema,
});

// ── Derived Types ────────────────────────────────────────────────────────

export type TimesheetStatus = z.infer<typeof TimesheetStatusSchema>;
export type UpdateTimesheetStatusInput = z.infer<typeof UpdateTimesheetStatusSchema>;
