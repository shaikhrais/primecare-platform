// ──────────────────────────────────────────────────────────────────────────────
// ApiRegistry — Platform-level API paths (admin, scrum-master, system, etc.)
//
// Split from platform.ts to keep each file under 200 lines.
// This file contains domain extension API paths (EVV, Authorizations, etc.)
// ──────────────────────────────────────────────────────────────────────────────

export const ADMIN_DOMAIN_EXTENSIONS = {
    // Domain Feature Extensions
    EVV: {
        LIST: '/v1/admin/evv',
        EXCEPTIONS: '/v1/admin/evv/exceptions',
        APPROVE_EXCEPTION: (id: string) => `/v1/admin/evv/exceptions/${id}/approve`,
        COMPLIANCE_SUMMARY: '/v1/admin/evv/compliance-summary',
        EXPORT: '/v1/admin/evv/export',
    },
    AUTHORIZATIONS: {
        LIST: '/v1/admin/authorizations',
        CREATE: '/v1/admin/authorizations',
        ALERTS: '/v1/admin/authorizations/alerts',
        UTILIZATION: (clientId: string) => `/v1/admin/authorizations/utilization/${clientId}`,
    },
    CONSENT: {
        CLIENT: (clientId: string) => `/v1/admin/consent/client/${clientId}`,
        SUBMIT: '/v1/admin/consent',
        TEMPLATES: '/v1/admin/consent/templates',
        EXPIRING: '/v1/admin/consent/expiring',
    },
    REFERRALS: {
        LIST: '/v1/admin/referrals',
        CREATE: '/v1/admin/referrals',
        CONVERT: (id: string) => `/v1/admin/referrals/${id}/convert`,
        ANALYTICS: '/v1/admin/referrals/analytics',
    },
    CLAIMS: {
        LIST: '/v1/admin/claims',
        SCRUB: '/v1/admin/claims/scrub',
        SUBMIT: (id: string) => `/v1/admin/claims/submit/${id}`,
        APPEAL: (id: string) => `/v1/admin/claims/appeal/${id}`,
        ERA: '/v1/admin/claims/era',
    },
    WEBHOOKS: {
        LIST: '/v1/admin/webhooks',
        REGISTER: '/v1/admin/webhooks',
        DELIVERIES: '/v1/admin/webhooks/deliveries',
        TEST: (id: string) => `/v1/admin/webhooks/test/${id}`,
    },
    AUDIT_EXPORT: {
        DOWNLOAD: '/v1/admin/audit-export/download',
        COMPLIANCE_DASHBOARD: '/v1/admin/audit-export/compliance-dashboard',
        REGULATORY_REPORT: '/v1/admin/audit-export/regulatory-report',
    },
    AI_IOT: {
        PREDICTIONS: '/v1/admin/ai-iot/predictions',
        VITALS: (clientId: string) => `/v1/admin/ai-iot/vitals/${clientId}`,
        TELEHEALTH_SESSION: '/v1/admin/ai-iot/telehealth/session',
    },
    NOTIFICATIONS: {
        LIST: '/v1/admin/notifications',
        BROADCAST: '/v1/admin/notifications/broadcast',
        READ: (id: string) => `/v1/admin/notifications/${id}/read`,
        FAMILY: (clientId: string) => `/v1/admin/notifications/family/${clientId}`,
    },
    DOCUMENTS: {
        LIST: '/v1/admin/documents',
        UPLOAD: '/v1/admin/documents/upload',
        DOWNLOAD: (id: string) => `/v1/admin/documents/${id}/download`,
        VERIFY: (id: string) => `/v1/admin/documents/${id}/verify`,
    },
    PAYROLL: {
        PENDING: '/v1/admin/payroll/pending',
        BATCH_APPROVE: '/v1/admin/payroll/batch/approve',
        RUN: '/v1/admin/payroll/run',
        SUMMARY: (weekId: string) => `/v1/admin/payroll/summary/${weekId}`,
    },
    DISCHARGE: {
        DISCHARGE: (clientId: string) => `/v1/admin/clients/${clientId}/discharge`,
        READMIT: (clientId: string) => `/v1/admin/clients/${clientId}/readmit`,
        SUMMARY: (clientId: string) => `/v1/admin/clients/${clientId}/discharge-summary`,
    },
    BOOKING_REQUESTS: {
        LIST: '/v1/admin/booking-requests',
        APPROVE: (id: string) => `/v1/admin/booking-requests/${id}/approve`,
        REJECT: (id: string) => `/v1/admin/booking-requests/${id}/reject`,
    },
    INSURANCE_PROVIDERS: {
        LIST: '/v1/admin/insurance-providers',
        CREATE: '/v1/admin/insurance-providers',
        DELETE: (id: string) => `/v1/admin/insurance-providers/${id}`,
    },
    BILLING_CODES: {
        LIST: '/v1/admin/billing-codes',
        CREATE: '/v1/admin/billing-codes',
        UPDATE: (id: string) => `/v1/admin/billing-codes/${id}`,
    },
    FHIR: {
        EXPORT: '/v1/admin/interop/fhir/export',
        IMPORT: '/v1/admin/interop/fhir/import',
        SYNC_LOG: '/v1/admin/interop/fhir/sync-log',
    },
    CRON: {
        COMPLIANCE_SWEEP: '/v1/admin/cron/compliance-sweep',
        TRAINING_REMINDERS: '/v1/admin/cron/training-reminders',
        AUTH_EXHAUSTION: '/v1/admin/cron/authorization-exhaustion',
        INVENTORY_REORDER: '/v1/admin/cron/inventory-reorder',
    },
    SYSTEM_DATA: {
        NOTIFICATIONS: '/v1/admin/system-data/notifications',
        IOT_EVENTS: '/v1/admin/system-data/iot-events',
        GAMIFICATION: '/v1/admin/system-data/gamification',
        AI_INFERENCES: '/v1/admin/system-data/ai-inferences',
        COMMUNICATION_LOGS: '/v1/admin/system-data/communication-logs',
    },
} as const;
