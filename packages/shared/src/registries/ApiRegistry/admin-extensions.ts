import { API_VARS } from './api-vars';
// ──────────────────────────────────────────────────────────────────────────────
// ApiRegistry — Platform-level API paths (admin, scrum-master, system, etc.)
//
// Split from platform.ts to keep each file under 200 lines.
// This file contains domain extension API paths (EVV, Authorizations, etc.)
// ──────────────────────────────────────────────────────────────────────────────

export const ADMIN_DOMAIN_EXTENSIONS = {
    // Domain Feature Extensions
    EVV: {
        LIST: API_VARS.API_V1_ADMIN_EVV,
        EXCEPTIONS: API_VARS.API_V1_ADMIN_EVV_EXCEPTIONS,
        APPROVE_EXCEPTION: (id: string) => `/v1/admin/evv/exceptions/${id}/approve`,
        COMPLIANCE_SUMMARY: API_VARS.API_V1_ADMIN_EVV_COMPLIANCE_SUMMARY,
        EXPORT: API_VARS.API_V1_ADMIN_EVV_EXPORT,
    },
    AUTHORIZATIONS: {
        LIST: API_VARS.API_V1_ADMIN_AUTHORIZATIONS,
        CREATE: API_VARS.API_V1_ADMIN_AUTHORIZATIONS,
        ALERTS: API_VARS.API_V1_ADMIN_AUTHORIZATIONS_ALERTS,
        UTILIZATION: (clientId: string) => `/v1/admin/authorizations/utilization/${clientId}`,
    },
    CONSENT: {
        CLIENT: (clientId: string) => `/v1/admin/consent/client/${clientId}`,
        SUBMIT: API_VARS.API_V1_ADMIN_CONSENT,
        TEMPLATES: API_VARS.API_V1_ADMIN_CONSENT_TEMPLATES,
        EXPIRING: API_VARS.API_V1_ADMIN_CONSENT_EXPIRING,
    },
    REFERRALS: {
        LIST: API_VARS.API_V1_ADMIN_REFERRALS,
        CREATE: API_VARS.API_V1_ADMIN_REFERRALS,
        CONVERT: (id: string) => `/v1/admin/referrals/${id}/convert`,
        ANALYTICS: API_VARS.API_V1_ADMIN_REFERRALS_ANALYTICS,
    },
    CLAIMS: {
        LIST: API_VARS.API_V1_ADMIN_CLAIMS,
        SCRUB: API_VARS.API_V1_ADMIN_CLAIMS_SCRUB,
        SUBMIT: (id: string) => `/v1/admin/claims/submit/${id}`,
        APPEAL: (id: string) => `/v1/admin/claims/appeal/${id}`,
        ERA: API_VARS.API_V1_ADMIN_CLAIMS_ERA,
    },
    WEBHOOKS: {
        LIST: API_VARS.API_V1_ADMIN_WEBHOOKS,
        REGISTER: API_VARS.API_V1_ADMIN_WEBHOOKS,
        DELIVERIES: API_VARS.API_V1_ADMIN_WEBHOOKS_DELIVERIES,
        TEST: (id: string) => `/v1/admin/webhooks/test/${id}`,
    },
    AUDIT_EXPORT: {
        DOWNLOAD: API_VARS.API_V1_ADMIN_AUDIT_EXPORT_DOWNLOAD,
        COMPLIANCE_DASHBOARD: API_VARS.API_V1_ADMIN_AUDIT_EXPORT_COMPLIANCE_DASHBOARD,
        REGULATORY_REPORT: API_VARS.API_V1_ADMIN_AUDIT_EXPORT_REGULATORY_REPORT,
    },
    AI_IOT: {
        PREDICTIONS: API_VARS.API_V1_ADMIN_AI_IOT_PREDICTIONS,
        VITALS: (clientId: string) => `/v1/admin/ai-iot/vitals/${clientId}`,
        TELEHEALTH_SESSION: API_VARS.API_V1_ADMIN_AI_IOT_TELEHEALTH_SESSION,
    },
    NOTIFICATIONS: {
        LIST: API_VARS.API_V1_ADMIN_NOTIFICATIONS,
        BROADCAST: API_VARS.API_V1_ADMIN_NOTIFICATIONS_BROADCAST,
        READ: (id: string) => `/v1/admin/notifications/${id}/read`,
        FAMILY: (clientId: string) => `/v1/admin/notifications/family/${clientId}`,
    },
    DOCUMENTS: {
        LIST: API_VARS.API_V1_ADMIN_DOCUMENTS,
        UPLOAD: API_VARS.API_V1_ADMIN_DOCUMENTS_UPLOAD,
        DOWNLOAD: (id: string) => `/v1/admin/documents/${id}/download`,
        VERIFY: (id: string) => `/v1/admin/documents/${id}/verify`,
    },
    PAYROLL: {
        PENDING: API_VARS.API_V1_ADMIN_PAYROLL_PENDING,
        BATCH_APPROVE: API_VARS.API_V1_ADMIN_PAYROLL_BATCH_APPROVE,
        RUN: API_VARS.API_V1_ADMIN_PAYROLL_RUN,
        SUMMARY: (weekId: string) => `/v1/admin/payroll/summary/${weekId}`,
    },
    DISCHARGE: {
        DISCHARGE: (clientId: string) => `/v1/admin/clients/${clientId}/discharge`,
        READMIT: (clientId: string) => `/v1/admin/clients/${clientId}/readmit`,
        SUMMARY: (clientId: string) => `/v1/admin/clients/${clientId}/discharge-summary`,
    },
    BOOKING_REQUESTS: {
        LIST: API_VARS.API_V1_ADMIN_BOOKING_REQUESTS,
        APPROVE: (id: string) => `/v1/admin/booking-requests/${id}/approve`,
        REJECT: (id: string) => `/v1/admin/booking-requests/${id}/reject`,
    },
    INSURANCE_PROVIDERS: {
        LIST: API_VARS.API_V1_ADMIN_INSURANCE_PROVIDERS,
        CREATE: API_VARS.API_V1_ADMIN_INSURANCE_PROVIDERS,
        DELETE: (id: string) => `/v1/admin/insurance-providers/${id}`,
    },
    BILLING_CODES: {
        LIST: API_VARS.API_V1_ADMIN_BILLING_CODES,
        CREATE: API_VARS.API_V1_ADMIN_BILLING_CODES,
        UPDATE: (id: string) => `/v1/admin/billing-codes/${id}`,
    },
    FHIR: {
        EXPORT: API_VARS.API_V1_ADMIN_INTEROP_FHIR_EXPORT,
        IMPORT: API_VARS.API_V1_ADMIN_INTEROP_FHIR_IMPORT,
        SYNC_LOG: API_VARS.API_V1_ADMIN_INTEROP_FHIR_SYNC_LOG,
    },
    CRON: {
        COMPLIANCE_SWEEP: API_VARS.API_V1_ADMIN_CRON_COMPLIANCE_SWEEP,
        TRAINING_REMINDERS: API_VARS.API_V1_ADMIN_CRON_TRAINING_REMINDERS,
        AUTH_EXHAUSTION: API_VARS.API_V1_ADMIN_CRON_AUTHORIZATION_EXHAUSTION,
        INVENTORY_REORDER: API_VARS.API_V1_ADMIN_CRON_INVENTORY_REORDER,
    },
    SYSTEM_DATA: {
        NOTIFICATIONS: API_VARS.API_V1_ADMIN_SYSTEM_DATA_NOTIFICATIONS,
        IOT_EVENTS: API_VARS.API_V1_ADMIN_SYSTEM_DATA_IOT_EVENTS,
        GAMIFICATION: API_VARS.API_V1_ADMIN_SYSTEM_DATA_GAMIFICATION,
        AI_INFERENCES: API_VARS.API_V1_ADMIN_SYSTEM_DATA_AI_INFERENCES,
        COMMUNICATION_LOGS: API_VARS.API_V1_ADMIN_SYSTEM_DATA_COMMUNICATION_LOGS,
    },
    // Premium features (Sprint 3-6)
    AI_COMMAND: {
        DASHBOARD: API_VARS.API_V1_ADMIN_AI_COMMAND,
        MODELS: API_VARS.API_V1_ADMIN_AI_COMMAND_MODELS,
        INFERENCES: API_VARS.API_V1_ADMIN_AI_COMMAND_INFERENCES,
        CONFIG: API_VARS.API_V1_ADMIN_AI_COMMAND_CONFIG,
    },
    MULTI_CURRENCY: {
        SETTINGS: API_VARS.API_V1_ADMIN_FINANCE_MULTI_CURRENCY,
        EXCHANGE_RATES: API_VARS.API_V1_ADMIN_FINANCE_MULTI_CURRENCY_RATES,
        CONVERSIONS: API_VARS.API_V1_ADMIN_FINANCE_MULTI_CURRENCY_CONVERSIONS,
    },
    AUDIT_TRAIL: {
        LIST: API_VARS.API_V1_ADMIN_AUDIT_TRAIL,
        DETAIL: (id: string) => `/v1/admin/audit-trail/${id}`,
        EXPORT: API_VARS.API_V1_ADMIN_AUDIT_TRAIL_EXPORT,
    },
    FRANCHISE: {
        LIST: API_VARS.API_V1_ADMIN_FRANCHISE,
        CREATE: API_VARS.API_V1_ADMIN_FRANCHISE,
        DETAIL: (id: string) => `/v1/admin/franchise/${id}`,
        PERFORMANCE: API_VARS.API_V1_ADMIN_FRANCHISE_PERFORMANCE,
    },
    SUPPLY_CHAIN: {
        LIST: API_VARS.API_V1_ADMIN_SUPPLY_CHAIN,
        VENDORS: API_VARS.API_V1_ADMIN_SUPPLY_CHAIN_VENDORS,
        PURCHASE_ORDERS: API_VARS.API_V1_ADMIN_SUPPLY_CHAIN_PURCHASE_ORDERS,
        INVENTORY_SYNC: API_VARS.API_V1_ADMIN_SUPPLY_CHAIN_INVENTORY_SYNC,
    },
} as const;
