/**
 * Service Validation Schemas
 */
import { z } from 'zod';

export const createServiceSchema = z.object({
    name: z.string().min(2).max(200),
    description: z.string().max(2000).optional(),
    category: z.string().min(1, 'Category required'),
    hourlyRate: z.number().min(0, 'Rate must be positive'),
    isActive: z.boolean().default(true),
});
