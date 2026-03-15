/**
 * Visit Validation Schemas — Create & Update visits
 */
import { z } from 'zod';
import { idSchema, dateTimeSchema, notesSchema } from './common';

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
