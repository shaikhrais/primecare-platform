// Governance - Category: service | Purpose: ────────────────────────────────────────────────────────────────────────────── FormRegistry — Centralized catalogue o...
// ──────────────────────────────────────────────────────────────────────────────
// FormRegistry — Centralized catalogue of every form across the platform.
// Each entry declares its route, API endpoints, required fields, dependent
// entities (inline creators), and the data-cy attribute prefix used in tests.
//
// Data is split into domain-specific sub-files under ./FormRegistry/
// This skeleton contains types, aggregate, and lookup helpers only.
// ──────────────────────────────────────────────────────────────────────────────

// ── Types ────────────────────────────────────────────────────────────────────

export interface FormField {
    name: string;
    label: string;
    type: 'text' | 'email' | 'password' | 'select' | 'textarea' | 'date' |
          'number' | 'checkbox' | 'tel' | 'file' | 'datetime-local' | 'time' | 'hidden';
    required: boolean;
    /** API endpoint to dynamically load <select> options */
    fetchOptionsFrom?: string;
    placeholder?: string;
    defaultValue?: string;
}

export interface FormDependency {
    /** The select/dropdown field that depends on this record */
    field: string;
    /** Semantic entity type (e.g. 'serviceType', 'client', 'psw') */
    entityType: string;
    /** API endpoint to create a new dependent record inline */
    inlineCreateEndpoint: string;
    /** API endpoint to refresh dropdown options after inline creation */
    fetchEndpoint: string;
    /** Human label for the inline creator button */
    inlineCreateLabel: string;
}

export interface FormEntry {
    /** Unique form identifier (dot-namespace, e.g. 'auth.login') */
    id: string;
    /** Human-readable form title */
    label: string;
    /** Frontend route where the form lives */
    route?: string;
    /** POST/PUT endpoint for form submission */
    apiEndpoint?: string;
    /** GET endpoint for editing / pre-fill */
    fetchEndpoint?: string;
    method?: 'POST' | 'PUT' | 'PATCH';
    /** Headers required by the backend; submission retries must retain the same idempotency key. */
    requiredHeaders?: string[];
    /** data-cy attribute prefix used for testing hooks */
    dataCyPrefix?: string;
    /** Ordered list of form fields */
    fields: FormField[];
    /** Dependencies that need inline creation components */
    dependencies?: FormDependency[];
    /** Category grouping for UI discovery */
    category: 'auth' | 'admin' | 'admin-wizard' | 'client' | 'psw' | 'manager' |
              'rn' | 'shared' | 'marketing' | 'platform' | 'dam' | 'coordinator' | 'finance' |
              'training' | 'compliance' | 'skeleton' | 'dashboard';
    /** Optional description of the form */
    description?: string;
}

// ── Import domain sub-files ──────────────────────────────────────────────────

import { AUTH_FORMS } from './FormRegistry/auth-forms';
import { ADMIN_FORMS } from './FormRegistry/admin-forms';
import { ADMIN_OPS_FORMS } from './FormRegistry/admin-ops-forms';
import { ADMIN_WIZARD_FORMS } from './FormRegistry/admin-wizard-forms';
import { CLIENT_FORMS } from './FormRegistry/client-forms';
import { PSW_FORMS } from './FormRegistry/psw-forms';
import { MANAGER_FORMS } from './FormRegistry/manager-forms';
import { RN_FORMS } from './FormRegistry/rn-forms';
import { SHARED_FORMS } from './FormRegistry/shared-forms';
import { MARKETING_FORMS, PLATFORM_FORMS, COORDINATOR_FORMS } from './FormRegistry/platform-forms';
import { FINANCE_FORMS } from './FormRegistry/finance-forms';
import { TRAINING_FORMS } from './FormRegistry/training-forms';
import { SKELETON_FORMS } from './FormRegistry/skeleton-forms';

// ── Aggregate Export ─────────────────────────────────────────────────────────

export const FormRegistry = [
    ...AUTH_FORMS,
    ...ADMIN_FORMS,
    ...ADMIN_OPS_FORMS,
    ...ADMIN_WIZARD_FORMS,
    ...CLIENT_FORMS,
    ...PSW_FORMS,
    ...MANAGER_FORMS,
    ...RN_FORMS,
    ...SHARED_FORMS,
    ...MARKETING_FORMS,
    ...PLATFORM_FORMS,
    ...COORDINATOR_FORMS,
    ...FINANCE_FORMS,
    ...TRAINING_FORMS,
    ...SKELETON_FORMS,
] as const;

// ── Lookup Helpers ───────────────────────────────────────────────────────────

/** Find a form by its unique ID */
export const getFormById = (id: string): FormEntry | undefined =>
    FormRegistry.find(f => f.id === id);

/** Get all forms that belong to a category */
export const getFormsByCategory = (category: FormEntry['category']): FormEntry[] =>
    FormRegistry.filter(f => f.category === category);

/** Get all forms that have at least one dependency (inline creators) */
export const getFormsWithDependencies = (): FormEntry[] =>
    FormRegistry.filter(f => f.dependencies && f.dependencies.length > 0);

/** Get the total count of forms */
export const FORM_REGISTRY_COUNT = FormRegistry.length;
