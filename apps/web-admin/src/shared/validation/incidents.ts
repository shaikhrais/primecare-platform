/**
 * Incident Validation Schemas
 */
import { z } from 'zod';
import { idSchema } from './common';

export const createIncidentSchema = z.object({
    type: z.string().min(1, 'Incident type required'),
    severity: z.enum(['low', 'medium', 'high', 'critical']),
    description: z.string().min(10, 'Description must be at least 10 characters').max(5000),
    clientId: idSchema.optional(),
    visitId: idSchema.optional(),
    pswId: idSchema.optional(),
});
