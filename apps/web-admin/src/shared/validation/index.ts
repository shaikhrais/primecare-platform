/**
 * Validation Schemas — Barrel re-export
 *
 * All schemas are split into domain files for maintainability.
 * This barrel file preserves backward compatibility for existing imports:
 *   import { loginSchema, createVisitSchema } from '@/shared/validation';
 */

// Common primitives
export {
    emailSchema, passwordSchema, phoneSchema, dateSchema, dateTimeSchema,
    idSchema, nameSchema, notesSchema, addressSchema,
    paginationSchema, dateRangeSchema,
} from './common';

// Domain schemas
export { loginSchema, registerSchema } from './auth';
export { createVisitSchema, updateVisitSchema } from './visits';
export { createUserSchema, updateUserSchema } from './users';
export { createIncidentSchema } from './incidents';
export { createInvoiceSchema } from './invoices';
export { createLeadSchema } from './leads';
export { createServiceSchema } from './services';
