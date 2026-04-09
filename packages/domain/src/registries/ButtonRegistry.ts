// ──────────────────────────────────────────────────────────────────────────────
// ButtonRegistry — UNIFIED interactive element registry.
// Consolidates: Buttons, Links, Interactions, and Interactive Elements.
// Each entry declares: role, module, action type, API path, and description.
//
// Data is split into sub-files under ./ButtonRegistry/
// This skeleton contains types, aggregate, derived maps, and helpers only.
// ──────────────────────────────────────────────────────────────────────────────

import { ApiRegistry } from './ApiRegistry';
import { RouteRegistry } from '../apps/web-admin/RouteRegistry';
import { ContentRegistry } from './ContentRegistry';

// ── Types ────────────────────────────────────────────────────────────────────

export interface ButtonDef {
    id: string;
    label: string;
    role: string;
    module: string;
    type: 'primary' | 'secondary' | 'ghost' | 'danger' | 'link' | 'interaction' | 'touchpoint';
    action: string;
    description: string;
    apiPath?: string;
    /** RouteRegistry key for UI_NAVIGATION buttons */
    routeKey?: string;
    /** Route parameter names this button's route requires */
    routeParams?: string[];
    /** Navigation path (for links and touchpoints) */
    path?: string;
    /** External link flag */
    isExternal?: boolean;
    /** Trigger type (for interactions) */
    trigger?: 'click' | 'hover' | 'submit';
    /** Consequence of the interaction */
    consequence?: string;
    /** Target for interaction triggers */
    target?: string;
    /** Response Bot: check type for health sweep */
    checkType?: 'ROUTE' | 'API' | 'EXTERNAL';
    /** Response Bot: expected HTTP status */
    expectedStatus?: number;
    /** Interactive element category for classification */
    category?: 'button' | 'link' | 'submit' | 'tab' | 'navigation' | 'action';
}

// ── Backward-compatible type aliases ─────────────────────────────────────────
/** @deprecated Use ButtonDef instead */
export type LinkDef = ButtonDef;
/** @deprecated Use ButtonDef instead */
export type InteractionADef = ButtonDef;
/** @deprecated Use ButtonDef instead */
export type InteractiveElement = ButtonDef;
export type InteractiveCategory = 'button' | 'link' | 'submit' | 'tab' | 'navigation' | 'action';

// ── Import sub-files ─────────────────────────────────────────────────────────

import { PLATFORM_BUTTONS } from './ButtonRegistry/platform-buttons';
import { TENANCY_BUTTONS } from './ButtonRegistry/tenancy-buttons';
import { OPERATIONS_BUTTONS } from './ButtonRegistry/operations-buttons';
import { BTN, PAGE_CODE_TO_ID } from './ButtonRegistry/btn-constants';
import type { ButtonId } from './ButtonRegistry/btn-constants';

// Re-export constants
export { BTN, PAGE_CODE_TO_ID };
export type { ButtonId };

// ── Absorbed: LinkRegistry (formerly LinkRegistry.ts) ────────────────────────

const { LINKS, ACCOUNTING_HOME } = ContentRegistry as any;

const LINK_ENTRIES: ButtonDef[] = [
    { id: 'lnk-admin-audit-logs', label: LINKS.ADMIN.AUDITS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.AUDITS, description: 'Direct access to platform-wide security logs.' },
    { id: 'lnk-admin-users', label: LINKS.ADMIN.USERS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.USERS, description: 'Global user directory and access control.' },
    { id: 'lnk-admin-schedule', label: LINKS.ADMIN.SCHEDULE, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SCHEDULE, description: 'Master view of all shifts and visits across the platform.' },
    { id: 'lnk-admin-incidents', label: LINKS.ADMIN.INCIDENTS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.INCIDENTS, description: 'Incident response and resolution tracking.' },
    { id: 'lnk-admin-timesheets', label: LINKS.ADMIN.TIMESHEETS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.TIMESHEETS, description: 'Master timesheet approval and auditing.' },
    { id: 'lnk-admin-leads', label: LINKS.ADMIN.LEADS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.LEADS, description: 'Access to business development and intake leads.' },
    { id: 'lnk-admin-services', label: LINKS.ADMIN.SERVICES, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SERVICES, description: 'Management of platform-wide clinical and support services.' },
    { id: 'lnk-admin-settings', label: LINKS.ADMIN.SETTINGS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SETTINGS, description: 'Platform configuration and business rules.' },
    { id: 'lnk-admin-content', label: LINKS.ADMIN.CONTENT, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.CONTENT, description: 'UI string and localized content management.' },
    { id: 'lnk-admin-admission', label: LINKS.ADMIN.ADMISSION, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.ADMISSION, description: 'Clinical intake and patient admission workflows.' },
    { id: 'lnk-admin-reports', label: LINKS.ADMIN.REPORTS, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.REPORTS, description: 'Consolidated platform-wide reporting home.' },
    { id: 'lnk-admin-setup-wizard', label: LINKS.ADMIN.SETUP_WIZARD, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SETUP_WIZARD, description: 'Step-by-step business initialization and onboarding.' },
    { id: 'lnk-admin-search', label: LINKS.ADMIN.SEARCH, role: 'admin', module: 'ADMIN', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SEARCH, description: 'System-wide search for patients, staff, and records.' },
    { id: 'lnk-sm-api-hub', label: LINKS.SCRUM_MASTER.API_HUB, role: 'scrum_master', module: 'SCRUM_MASTER', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, description: 'Technical home for endpoint health and connectivity.' },
    { id: 'lnk-sm-monitoring', label: LINKS.SCRUM_MASTER.MONITORING, role: 'scrum_master', module: 'MONITORING', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.MONITORING, description: 'Live platform resource and health surveillance.' },
    { id: 'lnk-sm-env-audit', label: LINKS.SCRUM_MASTER.ENV_AUDIT, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.ENV_AUDIT, description: 'Validation of infrastructure and environment variables.' },
    { id: 'lnk-sm-registry-check', label: LINKS.SCRUM_MASTER.REGISTRY, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK, description: 'Programmatic validation of master registry synchronization.' },
    { id: 'lnk-sm-db-schema', label: LINKS.SCRUM_MASTER.SCHEMA, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA, description: 'Live validation of Prisma schema against active database.' },
    { id: 'lnk-sm-build-health', label: LINKS.SCRUM_MASTER.BUILDS, role: 'scrum_master', module: 'BUILDS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.BUILD_HEALTH, description: 'CI/CD pipeline monitoring and build integrity logs.' },
    { id: 'lnk-sm-security-scans', label: LINKS.SCRUM_MASTER.SCANS, role: 'scrum_master', module: 'SCANS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.SECURITY_SCANS, description: 'Centralized security audit and threat surface analysis.' },
    { id: 'lnk-sm-localization', label: LINKS.SCRUM_MASTER.LOCALIZATION, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.LOCALIZATION, description: 'Validation of i18n coverage across all system modules.' },
    { id: 'lnk-sm-auto-fix', label: LINKS.SCRUM_MASTER.AUTO_FIX, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous systemic repair for registry mismatches.' },
    { id: 'lnk-sm-impersonate', label: LINKS.SCRUM_MASTER.IMPERSONATE, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.IMPERSONATE, description: 'Debug tool for shadowing active user sessions.' },
    { id: 'lnk-sm-response-bot', label: LINKS.SCRUM_MASTER.RESPONSE_BOT, role: 'scrum_master', module: 'GOVERNANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.RESPONSE_BOT, description: 'Autonomous health-check agent for platform-wide audits.' },
    { id: 'lnk-sm-perf-metrics', label: LINKS.SCRUM_MASTER.PERFORMANCE, role: 'scrum_master', module: 'PERFORMANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.PERFORMANCE, description: 'Real-time V8 monitoring.' },
    { id: 'lnk-sm-theme-lab', label: LINKS.SCRUM_MASTER.THEME_LAB, role: 'scrum_master', module: 'THEME', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SCRUM_MASTER.THEME_CENTER, description: 'Live registry-driven CSS variable lab.' },
    { id: 'lnk-mgr-pl', label: LINKS.MANAGER.PL, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.FINANCE, description: 'Financial visibility into branch-level performance.' },
    { id: 'lnk-coord-hub', label: LINKS.COORDINATOR.HUB, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.HUB, description: 'Coordinator real-time dispatch and shift monitoring.' },
    { id: 'lnk-staff-incidents', label: LINKS.ADMIN.INCIDENTS, role: 'staff', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.STAFF.INCIDENTS, description: 'Review and manage reported field incidents.' },
    { id: 'lnk-psw-offers', label: LINKS.PSW.OFFERS, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.OFFERS, description: 'Browse and accept open shift opportunities.' },
    { id: 'lnk-rn-supervision', label: LINKS.RN.SUPERVISION, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.SUPERVISION, description: 'RN oversight portal for PSW performance.' },
    { id: 'lnk-client-support', label: LINKS.CLIENT.SUPPORT, role: 'client', module: 'CLIENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.CLIENT.SUPPORT, description: 'Family line to clinical support staff.' },
    { id: 'lnk-client-team', label: LINKS.CLIENT.TEAM, role: 'client', module: 'CLIENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.CLIENT.TEAM, description: 'View and contact assigned healthcare professionals.' },
    { id: 'lnk-client-billing', label: LINKS.CLIENT.BILLING, role: 'client', module: 'CLIENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.CLIENT.BILLING, description: 'Manage care payments and service history.' },
    { id: 'lnk-rn-ops-verify', label: LINKS.RN.OPS_VERIFY, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.DAILY_AUDIT, description: 'RN review platform for all clinical visit notes.' },
    { id: 'lnk-rn-supervision-field', label: LINKS.RN.SUPERVISION, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.SUPERVISION, description: 'Field oversight and competency tracking for frontline caregivers.' },
    { id: 'lnk-rn-care-plans', label: LINKS.RN.CARE_PLANS, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.CARE_PLANS, description: 'Authoring and lifecycle management of digital care plans.' },
    { id: 'lnk-superuser-tenants', label: LINKS.ADMIN.LOCATIONS, role: 'super_admin', module: 'PLATFORM', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SUPERUSER.TENANTS, description: 'High-level oversight of all system instances.' },
    { id: 'lnk-superuser-sla', label: LINKS.SCRUM_MASTER.BUILDS, role: 'super_admin', module: 'PLATFORM', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.SUPERUSER.SLA, description: 'Uptime and performance monitoring across the platform.' },
    { id: 'lnk-adm-customers', label: LINKS.ADMIN.CUSTOMERS, role: 'admin', module: 'CUSTOMERS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.CUSTOMERS, description: 'Global customer management portal.' },
    { id: 'lnk-adm-earnings', label: LINKS.ADMIN.EARNINGS, role: 'admin', module: 'EARNINGS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.EARNINGS, description: 'View across all platform revenue stream.' },
    { id: 'lnk-adm-interop', label: LINKS.ADMIN.INTEROP, role: 'admin', module: 'INTEROP', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.INTEROP, description: 'HL7/FHIR gateway status.' },
    { id: 'lnk-adm-locations', label: LINKS.ADMIN.LOCATIONS, role: 'admin', module: 'LOCATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.LOCATIONS, description: 'Manage geographic branch boundaries.' },
    { id: 'lnk-ops-logistics', label: LINKS.ADMIN.LOGISTICS, role: 'admin', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB, description: 'Advanced fleet and region monitoring.' },
    { id: 'lnk-ops-regions', label: LINKS.ADMIN.REGIONS, role: 'admin', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.OPERATIONS.REGION_MAPPING, description: 'Geographic operational boundary management.' },
    { id: 'lnk-erp-inventory', label: LINKS.SHARED.STOCK, role: 'admin', module: 'ERP', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.ERP.INVENTORY, description: 'Real-time consumable and asset tracking.' },
    { id: 'lnk-erp-procurement', label: LINKS.SHARED.PROCUREMENT, role: 'operations_manager', module: 'ERP', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.ERP.PROCUREMENT, description: 'Supplier management and purchase order tracking.' },
    { id: 'lnk-telehealth-center', label: LINKS.SHARED.TELEHEALTH, role: 'rn', module: 'TELEHEALTH', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.TELEHEALTH.CENTER, description: 'Live video consultations and remote patient monitoring.' },
    { id: 'lnk-rpm-alerts', label: LINKS.SHARED.REMOTE_ALERTS, role: 'coordinator', module: 'TELEHEALTH', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.TELEHEALTH.ALERTS, description: 'Critical health alerts from remote monitoring devices.' },
    { id: 'lnk-rcm-claims', label: LINKS.SHARED.CLAIMS, role: 'billing_manager', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.RCM.CLAIMS, description: 'Centralized management of insurance claim lifecycles.' },
    { id: 'lnk-rcm-revenue', label: LINKS.SHARED.REVENUE, role: 'admin', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.RCM.REVENUE, description: 'Detailed financial modeling and revenue cycle health monitoring.' },
    { id: 'lnk-pharmacy-hub', label: LINKS.RN.PHARMACY, role: 'rn', module: 'PHARMACY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.PHARMACY.HUB, description: 'E-prescribing and medication management center.' },
    { id: 'lnk-pharmacy-mar', label: LINKS.SHARED.MAR, role: 'psw', module: 'PHARMACY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.PHARMACY.MAR, description: 'Medication Administration Record for active care delivery.' },
    { id: 'lnk-psw-handover', label: LINKS.PSW.HANDOVER, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.HANDOVER, description: 'Interface for submitting shift handover reports.' },
    { id: 'lnk-psw-availability', label: LINKS.PSW.AVAILABILITY, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.AVAILABILITY, description: 'Manage date-specific work availability and overrides.' },
    { id: 'lnk-psw-earnings', label: LINKS.PSW.EARNINGS, role: 'psw', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.EARNINGS, description: 'Track verified earnings and processed payout history.' },
    { id: 'lnk-rn-care-plans-2', label: LINKS.RN.CARE_PLANS, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.CARE_PLANS, description: 'Direct access to clinical goal tracking and interventions.' },
    { id: 'lnk-rn-assessments', label: LINKS.RN.ASSESSMENTS, role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.ASSESSMENTS, description: 'Structured clinical assessments and intake forms.' },
    { id: 'lnk-coord-sos', label: LINKS.COORDINATOR.SOS, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.SOS, description: 'Emergency shift fulfillment and field incident management.' },
    { id: 'lnk-coord-map', label: LINKS.COORDINATOR.MAP, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.MAP, description: 'Visual intelligence for regional shift and staff locations.' },
    { id: 'lnk-coord-waitlist', label: LINKS.COORDINATOR.WAITLIST, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.WAITLIST, description: 'Managing unassigned client demand and waitlist priorities.' },
    { id: 'lnk-mgr-ops', label: LINKS.MANAGER.OPS_TRIAGE, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.OPERATIONS, description: 'Management of late shifts, missed clock-ins, and field alerts.' },
    { id: 'lnk-mgr-compliance', label: LINKS.MANAGER.COMPLIANCE, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.COMPLIANCE, description: 'Branch-wide credential and regulatory tracking.' },
    { id: 'lnk-staff-tasks', label: LINKS.MANAGER.TEAM, role: 'staff', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.STAFF.TASKS, description: 'Active recruitment and task fulfillment board.' },
    { id: 'lnk-staff-messages', label: LINKS.COORDINATOR.HUB, role: 'staff', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.STAFF.MESSAGES, description: 'Unified messaging for branch-wide coordination.' },
    { id: 'lnk-psw-live-visit', label: LINKS.PSW.LIVE_VISIT, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.LIVE_VISIT, description: 'Active visit management and real-time ADL tracking.' },
    { id: 'lnk-coordinator-sos-hub', label: LINKS.COORDINATOR.SOS_HUB, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.SOS_HUB, description: 'Real-time emergency shift fulfillment and field alert management.' },
    { id: 'lnk-rd-regional', label: LINKS.REGIONAL.INTELLIGENCE, role: 'regional_manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.REGIONAL_STATS, description: 'High-level regional operational KPIs and radar.' },
    { id: 'lnk-rd-finance', label: LINKS.REGIONAL.FINANCE, role: 'regional_manager', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.FINANCE, description: 'Consolidated regional financial governance and P&L.' },
    { id: 'lnk-mgr-home', label: LINKS.MANAGER.HOME, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.HOME, description: 'Daily operational overview for branch managers.' },
    { id: 'lnk-mgr-ops-hub', label: LINKS.MANAGER.AGENCY_HUB, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.OPERATIONS, description: 'Centralized hub for branch-wide coordination and triage.' },
    { id: 'lnk-mgr-finance', label: LINKS.MANAGER.FINANCIALS, role: 'manager', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.FINANCE, description: 'Branch-level billing, invoices, and financial performance.' },
    { id: 'lnk-mgr-team', label: LINKS.MANAGER.TEAM, role: 'manager', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.TEAM, description: 'Management of branch staff profiles and performance.' },
    { id: 'lnk-coord-master-schedule', label: LINKS.COORDINATOR.MASTER_SCHEDULE, role: 'coordinator', module: 'OPERATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.COORDINATOR.SCHEDULE, description: 'Unified master schedule for branch-wide shift oversight.' },
    { id: 'lnk-psw-availability-my', label: LINKS.PSW.MY_AVAILABILITY, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.AVAILABILITY, description: 'Manage your weekly availability and service areas.' },
    { id: 'lnk-fd-home', label: ACCOUNTING_HOME.TITLE, role: 'finance_director', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.FINANCE.HOME, description: 'High-level financial intelligence and real-time ledger oversight.' },
    { id: 'lnk-fd-ledger', label: 'Financial Ledger', role: 'finance_director', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SECURITY.FINANCIAL_LEDGER, description: 'Forensic audit trail and immutable ledger verification.' },
    { id: 'lnk-fd-tax-hub', label: 'Tax Compliance Hub', role: 'finance_director', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SECURITY.TAX_HUB, description: 'Periodic HST/GST filing and automated remittance processing.' },
    { id: 'lnk-fd-reconciliation', label: 'Reconciliation Hub', role: 'finance_director', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.FINANCE.RECONCILIATION, description: 'Deterministic auto-matching engine for bank feeds.' },
    { id: 'lnk-client-medical-summary', label: 'Medical Summary', role: 'client', module: 'CLIENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.CLIENT.MEDICAL_SUMMARY, description: 'Consolidated view of clinical and medical history.' },
    { id: 'lnk-client-family-portal', label: 'Family Engagement', role: 'client', module: 'CLIENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.CLIENT.FAMILY_PORTAL, description: 'Portal for authorized family members to track care.' },
    { id: 'lnk-telehealth-admin-home', label: 'Telehealth Command', role: 'admin', module: 'TELEHEALTH', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.TELEHEALTH.CENTER, description: 'Platform-wide telehealth session monitoring.' },
    { id: 'lnk-evv-exceptions', label: 'EVV Corrections', role: 'admin', module: 'EVV', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.EVV.EXCEPTIONS, description: 'Audit and approve Electronic Visit Verification exceptions.' },
    { id: 'lnk-rn-wound-care', label: 'Wound Care Flow', role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.WOUND_CARE, description: 'Dedicated clinical module for wound progression tracking.' },
    { id: 'lnk-rn-rai-assessments', label: 'MDS/RAI Hub', role: 'rn', module: 'CLINICAL', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.RN.RAI_ASSESSMENTS, description: 'Standardized Resident Assessment Instrument management.' },
    { id: 'lnk-admin-consent-forms', label: 'Consent Forms', role: 'admin', module: 'AUTHORIZATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.CONSENT.LIST, description: 'Management of PHIPA/HIPAA digital consent forms.' },
    { id: 'lnk-admin-authorizations', label: 'Funding Auth', role: 'admin', module: 'AUTHORIZATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.AUTHORIZATIONS.LIST, description: 'Tracking of funding source service hour authorizations.' },
    // ── Premium Pages (Sprint 3-6) ──
    { id: 'lnk-mgr-gamification', label: LINKS.MANAGER.GAMIFICATION, role: 'manager', module: 'ENGAGEMENT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.GAMIFICATION, description: 'Staff engagement through CareCoins and leaderboard gamification.' },
    { id: 'lnk-mgr-iot', label: LINKS.MANAGER.IOT_MONITORING, role: 'manager', module: 'IOT', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.IOT_MONITORING, description: 'Real-time IoT device monitoring and event analytics.' },
    { id: 'lnk-mgr-doc-signing', label: LINKS.MANAGER.DOCUMENT_SIGNING, role: 'manager', module: 'DOCUMENTS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.DOCUMENT_SIGNING, description: 'E-signature workflows for care agreements and compliance forms.' },
    { id: 'lnk-mgr-sms-hub', label: LINKS.MANAGER.SMS_HUB, role: 'manager', module: 'COMMUNICATIONS', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.SMS_HUB, description: 'SMS campaign management and Twilio communication logs.' },
    { id: 'lnk-mgr-perf-reviews', label: LINKS.MANAGER.PERFORMANCE_REVIEWS, role: 'manager', module: 'HR', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.PERFORMANCE_REVIEWS, description: 'KPI-driven staff performance reviews and goal tracking.' },
    { id: 'lnk-mgr-training-academy', label: LINKS.MANAGER.TRAINING_ACADEMY, role: 'manager', module: 'TRAINING', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.MANAGER.TRAINING_ACADEMY, description: 'Certification tracking, module assignments, and learning paths.' },
    { id: 'lnk-psw-guide', label: LINKS.PSW.GUIDE, role: 'psw', module: 'CARE_DELIVERY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.PSW.GUIDE, description: 'Step-by-step user guide for PSW daily operations.' },
    { id: 'lnk-admin-ai-command', label: LINKS.ADMIN.AI_COMMAND, role: 'admin', module: 'AI', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.AI_COMMAND, description: 'Centralized AI model management and inference home.' },
    { id: 'lnk-admin-multi-currency', label: LINKS.ADMIN.MULTI_CURRENCY, role: 'admin', module: 'FINANCE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.MULTI_CURRENCY, description: 'Multi-currency configuration for international billing.' },
    { id: 'lnk-admin-audit-trail', label: LINKS.ADMIN.AUDIT_TRAIL, role: 'admin', module: 'SECURITY', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.AUDIT_TRAIL, description: 'Deep forensic audit trail viewer with advanced filtering.' },
    { id: 'lnk-admin-franchise', label: LINKS.ADMIN.FRANCHISE, role: 'admin', module: 'FRANCHISE', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.FRANCHISE, description: 'Franchise and reseller network management portal.' },
    { id: 'lnk-admin-supply-chain', label: LINKS.ADMIN.SUPPLY_CHAIN, role: 'admin', module: 'ERP', type: 'link', action: 'UI_NAVIGATION', path: RouteRegistry.ADMIN.SUPPLY_CHAIN, description: 'End-to-end supply chain, PO, and vendor management.' },
];

// ── Absorbed: InteractionARegistry (formerly InteractionARegistry.ts) ────────

const INTERACTION_ENTRIES: ButtonDef[] = [
    { id: 'ia-sm-registry-repair', label: 'Auto-Repair Registry', role: 'scrum_master', module: 'SCRUM_MASTER', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous attempt to resolve broken registry mappings.' },
    { id: 'ia-hr-bulk-notify', label: 'Compliance Notifications', role: 'hr_manager', module: 'HR', type: 'interaction', action: 'MODAL', trigger: 'click', consequence: 'openModal', description: 'Open bulk notification composer for certification renewals.' },
    { id: 'ia-adm-provision-flow', label: 'Enterprise Provisioning', role: 'admin', module: 'SETUP', type: 'interaction', action: 'MODAL', trigger: 'click', consequence: 'openModal', description: 'Multi-step wizard for new enterprise on-boarding.' },
    { id: 'ia-sm-recovery-full', label: 'Disaster Recovery', role: 'scrum_master', module: 'GOVERNANCE', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Emergency restoration of platform registry state.' },
    { id: 'ia-ops-dispatch-predictive', label: 'Launch Predictive Router', role: 'admin', module: 'OPERATIONS', type: 'interaction', action: 'MODAL', trigger: 'click', consequence: 'openModal', description: 'Triggers AI-driven fleet dispatch and route optimization.' },
    { id: 'ia-adm-search-reindex', label: 'Commit Global Index', role: 'admin', module: 'ADMIN', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.SEARCH, description: 'Autonomous systemic audit of search relevance and indexing.' },
    { id: 'ia-sm-response-bot-audit', label: 'Execute Full Registry Sweep', role: 'scrum_master', module: 'GOVERNANCE', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.RESPONSE_BOT_SCAN, description: 'Automated Response Bot diagnostic of all system touchpoints.' },
    { id: 'ia-sm-audit-flush', label: 'Execute Retention Purge', role: 'scrum_master', module: 'GOVERNANCE', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', description: 'Systemic forensic log rotation based on regulatory compliance windows.' },
    { id: 'ia-erp-stock-sync', label: 'Sync Global Stock', role: 'admin', module: 'ERP', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.ERP.STOCK_SYNC, description: 'Triggers a systemic synchronization of inventory levels across all branches.' },
    { id: 'ia-rpm-vitals-broadcast', label: 'Broadcast Vitals Heartbeat', role: 'system', module: 'TELEHEALTH', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.TELEHEALTH.VITAL_SIGN_PUSH, description: 'Generates a real-time data push from integrated patient wearable devices.' },
    { id: 'ia-rcm-claim-batch', label: 'Execute Batch Adjudication', role: 'admin', module: 'FINANCE', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.RCM.REVENUE_SYNC, description: 'Autonomous systemic audit of all pending claims against insurance payment cycles.' },
    { id: 'ia-pharmacy-mar-audit', label: 'Audit MAR Compliance', role: 'clinical_manager', module: 'PHARMACY', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.PHARMACY.MAR_SYNC, description: 'Triggers a systemic audit of medication administration compliance for the current shift.' },
    { id: 'ia-rn-assess-submit', label: 'Submit Clinical Assessment', role: 'rn', module: 'CLINICAL', type: 'interaction', action: 'API_TRIGGER', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.CLINICAL_ASSESS, description: 'Commits a formal clinical assessment to the client record.' },
    { id: 'ia-rn-careplan-save', label: 'Save Care Plan Review', role: 'rn', module: 'CLINICAL', type: 'interaction', action: 'API_TRIGGER', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.CARE_PLAN_REVIEW('target'), description: 'Updates the clinical interventions and goals for a client care plan.' },
    { id: 'ia-rn-supervision-log', label: 'Commit Supervision Log', role: 'rn', module: 'CLINICAL', type: 'interaction', action: 'API_TRIGGER', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.RN_SUPERVISION, description: 'Records a formal supervision log for a field PSW.' },
    { id: 'ia-psw-live-visit-pulse', label: 'Pulse Live Visit', role: 'psw', module: 'CARE_DELIVERY', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.PSW.CHECK_IN(':id'), description: 'Triggers a heartbeat check for an active visit.' },
    { id: 'ia-coord-sos-dispatch-pulse', label: 'SOS Heartbeat', role: 'coordinator', module: 'OPERATIONS', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.COORDINATOR.SOS_ACK, description: 'Triggers a real-time status check for an active SOS alert.' },
    { id: 'ia-client-family-hub-load', label: 'Init Family Hub', role: 'client', module: 'CLIENT', type: 'interaction', action: 'ROUTE_CHANGE', trigger: 'hover', consequence: 'routeChange', description: 'Pre-fetches family care timeline data.' },
    { id: 'ia-rd-ops-stats-refresh', label: 'Regional KPIs Refresh', role: 'regional_manager', module: 'OPERATIONS', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.MANAGER.OPS_STATS, description: 'Triggers a recalculation of regional metrics.' },
    { id: 'ia-rd-pl-export', label: 'Export Regional P&L', role: 'regional_manager', module: 'FINANCE', type: 'interaction', action: 'API_TRIGGER', trigger: 'click', consequence: 'apiTrigger', description: 'Generates a consolidated regional profit and loss statement.' },
    { id: 'ia-rd-audit-request', label: 'Strategic Triage', role: 'regional_manager', module: 'GOVERNANCE', type: 'interaction', action: 'MODAL', trigger: 'click', consequence: 'openModal', description: 'Initiates a formal strategic audit across all sub-branches.' },
];

// ── Absorbed: InteractiveElementRegistry (formerly InteractiveElementRegistry.ts) ─

const TOUCHPOINT_ENTRIES: ButtonDef[] = [
    { id: 'admin-user-invite', category: 'action', label: 'Invite User', path: '/v1/admin/users', role: 'admin', module: 'ADMIN', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Invite a new user.' },
    { id: 'admin-settings-biz', category: 'navigation', label: ContentRegistry.BUSINESS_STATUS.DOMAINS.STRATEGY, path: RouteRegistry.ADMIN.SETTINGS, role: 'admin', module: 'ADMIN', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Business strategy settings.' },
    { id: 'sm-auto-fix', category: 'action', label: 'Start Auto-Fix', path: '/v1/admin/scrum/auto-fix', role: 'scrum_master', module: 'SCRUM_MASTER', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Start auto-fix.' },
    { id: 'sm-registry-sweep', category: 'action', label: 'Registry Sweep', path: '/v1/admin/scrum/env-audit', role: 'scrum_master', module: 'SCRUM_MASTER', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Registry sweep.' },
    { id: 'mgr-perf-rank', category: 'navigation', label: 'Performance Ranker', path: RouteRegistry.MANAGER.PERFORMANCE, role: 'manager', module: 'MANAGER', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Performance ranker.' },
    { id: 'mgr-payroll-audit', category: 'action', label: 'Audit Payroll', path: '/v1/manager/finance/payroll-audit', role: 'manager', module: 'MANAGER', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Audit payroll.' },
    { id: 'coord-sos-dispatch', category: 'action', label: 'SOS Dispatch', path: '/v1/manager/coordinator/sos-dispatch', role: 'coordinator', module: 'OPERATIONS', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'SOS dispatch.' },
    { id: 'coord-live-pulse', category: 'navigation', label: 'Live Monitoring', path: RouteRegistry.COORDINATOR.HOME, role: 'coordinator', module: 'OPERATIONS', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Live monitoring.' },
    { id: 'rn-care-plan-rev', category: 'action', label: 'Review Care Plan', path: '/v1/rn/clinical/care-plans/review', role: 'rn', module: 'CLINICAL', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Review care plan.' },
    { id: 'rn-entry-verify', category: 'action', label: 'Verify Entry', path: '/v1/rn/clinical/audit/entries/verify', role: 'rn', module: 'CLINICAL', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Verify entry.' },
    { id: 'psw-check-in', category: 'action', label: 'Check-in', path: '/v1/psw/schedule/visits/check-in', role: 'psw', module: 'CARE_DELIVERY', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Visit check-in.' },
    { id: 'psw-earnings-req', category: 'action', label: 'Req Payout', path: '/v1/psw/schedule/payouts/request', role: 'psw', module: 'CARE_DELIVERY', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Request payout.' },
    { id: 'staff-task-create', category: 'action', label: 'New Task', path: '/v1/staff/tasks/grid', role: 'staff', module: 'STAFF', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Create task.' },
    { id: 'staff-incident-log', category: 'action', label: 'Log Incident', path: '/v1/staff/ops/incidents/submit', role: 'staff', module: 'STAFF', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Log incident.' },
    { id: 'client-book-req', category: 'action', label: 'Request Booking', path: '/v1/client/bookings', role: 'client', module: 'CLIENT', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Request booking.' },
    { id: 'client-nursing-chat', category: 'navigation', label: 'Nursing Chat', path: RouteRegistry.CLIENT.SUPPORT, role: 'client', module: 'CLIENT', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Nursing chat.' },
    { id: 'mkt-campaign-launch', category: 'action', label: 'Launch Campaign', path: '/v1/admin/marketing/campaigns', role: 'marketing_manager', module: 'MARKETING', type: 'touchpoint', action: 'API_CALL', checkType: 'API', description: 'Launch campaign.' },
    { id: 'hr-recruitment-post', category: 'action', label: 'Post Job', path: RouteRegistry.MANAGER.RECRUITING, role: 'recruiting_manager', module: 'HR', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Post job.' },
    { id: 'fin-regional-pl', category: 'navigation', label: 'Regional P&L', path: RouteRegistry.MANAGER.FINANCE, role: 'finance_manager', module: 'FINANCE', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Regional P&L.' },
    { id: 'fin-dir-dash', category: 'navigation', label: 'Financial Intelligence', path: RouteRegistry.ADMIN.FINANCE.HOME, role: 'finance_director', module: 'FINANCE', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Financial intelligence.' },
    { id: 'fin-dir-ledger', category: 'navigation', label: 'Ledger Audit', path: RouteRegistry.ADMIN.SECURITY.FINANCIAL_LEDGER, role: 'finance_director', module: 'FINANCE', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'Ledger audit.' },
    { id: 'qa-safety-sweep', category: 'action', label: 'QA Sweep', path: RouteRegistry.MANAGER.CLINICAL, role: 'clinical_manager', module: 'QA', type: 'touchpoint', action: 'NAVIGATE', checkType: 'ROUTE', description: 'QA sweep.' },
];

// ── Aggregate ────────────────────────────────────────────────────────────────

export const ButtonRegistry: ButtonDef[] = [
    ...PLATFORM_BUTTONS,
    ...TENANCY_BUTTONS,
    ...OPERATIONS_BUTTONS,
    ...LINK_ENTRIES,
    ...INTERACTION_ENTRIES,
    ...TOUCHPOINT_ENTRIES,
];

// ── Backward-compatible aliases ──────────────────────────────────────────────
/** @deprecated Use ButtonRegistry filtered by type === 'link' */
export const LinkRegistry: ButtonDef[] = LINK_ENTRIES;
/** @deprecated Use ButtonRegistry filtered by type === 'interaction' */
export const InteractionARegistry: ButtonDef[] = INTERACTION_ENTRIES;
/** @deprecated Use ButtonRegistry filtered by type === 'touchpoint' */
export const InteractiveElementRegistry: ButtonDef[] = TOUCHPOINT_ENTRIES;
/** @deprecated Use ButtonRegistry directly */
export const UnifiedInteractiveRegistry = { buttons: ButtonRegistry, links: LINK_ENTRIES, interactions: INTERACTION_ENTRIES };
/** InteractionRegistry is an alias of InteractiveElementRegistry */
export const InteractionRegistry = TOUCHPOINT_ENTRIES;

// ── Derived: ButtonGroups — role → module → buttons ─────────────────────────

type NestedGroups = Record<string, Record<string, ButtonDef[]>>;

function buildButtonGroups(): NestedGroups {
    const groups: NestedGroups = {};
    for (const b of ButtonRegistry) {
        (groups[b.role] ??= {})[b.module] ??= [];
        groups[b.role]![b.module]!.push(b);
    }
    return groups;
}

export const ButtonGroups: NestedGroups = buildButtonGroups();

// ── Derived: ButtonsByPage ───────────────────────────────────────────────────

import { PageActionRegistry } from './PageActionRegistry';

function buildButtonsByPage(): Record<string, ButtonDef[]> {
    const idx = new Map(ButtonRegistry.map(b => [b.id, b]));
    const result: Record<string, ButtonDef[]> = {};
    for (const [pageId, pa] of Object.entries(PageActionRegistry)) {
        const btns: ButtonDef[] = [];
        if (pa.primary) { const b = idx.get(pa.primary); if (b) btns.push(b); }
        for (const id of pa.actions) { const b = idx.get(id); if (b) btns.push(b); }
        if (btns.length) result[pageId] = btns;
    }
    return result;
}

export const ButtonsByPage: Record<string, ButtonDef[]> = buildButtonsByPage();

// ── Lookup Helpers ───────────────────────────────────────────────────────────

export function getButtonsForPage(code: string): ButtonDef[] { return ButtonsByPage[code] ?? []; }
export function getButtonsByRole(role: string): ButtonDef[] { return ButtonRegistry.filter(b => b.role === role); }
export function getButtonsByModule(module: string): ButtonDef[] { return ButtonRegistry.filter(b => b.module === module); }
export function getButtonById(id: string): ButtonDef | undefined { return ButtonRegistry.find(b => b.id === id); }
export function getLinksForRole(role: string): ButtonDef[] { return LINK_ENTRIES.filter(l => l.role === role); }
export function getTouchpointsForSweep(): ButtonDef[] { return TOUCHPOINT_ENTRIES; }
export function getInteractionsByTrigger(trigger: 'click' | 'hover' | 'submit'): ButtonDef[] { return INTERACTION_ENTRIES.filter(i => i.trigger === trigger); }

export const BUTTON_REGISTRY_COUNT = ButtonRegistry.length;
