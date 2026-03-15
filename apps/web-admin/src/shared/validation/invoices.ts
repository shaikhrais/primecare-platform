/**
 * Invoice Validation Schemas
 */
import { z } from 'zod';
import { idSchema, dateSchema, notesSchema } from './common';

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
