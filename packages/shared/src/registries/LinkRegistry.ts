import { RouteRegistry } from '../apps/web-admin/RouteRegistry';
import { ContentRegistry } from './ContentRegistry';

export interface LinkDef {
    id: string;
    label: string;
    role: string;
    module: string;
    path: string;
    description: string;
    isExternal?: boolean;
}

const { LINKS } = ContentRegistry;

export const LinkRegistry: LinkDef[] = [
    { id: 'lnk-admin-audit-logs', label: LINKS.ADMIN.AUDITS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.AUDITS, description: 'Direct access to platform-wide security logs.' },
    { id: 'lnk-admin-users', label: LINKS.ADMIN.USERS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.USERS, description: 'Global user directory and access control.' },
    { id: 'lnk-admin-schedule', label: LINKS.ADMIN.SCHEDULE, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SCHEDULE, description: 'Master view of all shifts and visits across the platform.' },
    { id: 'lnk-admin-incidents', label: LINKS.ADMIN.INCIDENTS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.INCIDENTS, description: 'Incident response and resolution tracking.' },
    { id: 'lnk-admin-timesheets', label: LINKS.ADMIN.TIMESHEETS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.TIMESHEETS, description: 'Master timesheet approval and auditing.' },
    { id: 'lnk-admin-leads', label: LINKS.ADMIN.LEADS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.LEADS, description: 'Access to business development and intake leads.' },
    { id: 'lnk-admin-services', label: LINKS.ADMIN.SERVICES, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SERVICES, description: 'Management of platform-wide clinical and support services.' },
    { id: 'lnk-admin-settings', label: LINKS.ADMIN.SETTINGS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SETTINGS, description: 'Platform configuration and business rules.' },
    { id: 'lnk-admin-content', label: LINKS.ADMIN.CONTENT, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.CONTENT, description: 'UI string and localized content management.' },
    { id: 'lnk-admin-admission', label: LINKS.ADMIN.ADMISSION, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.ADMISSION, description: 'Clinical intake and patient admission workflows.' },
    { id: 'lnk-admin-reports', label: LINKS.ADMIN.REPORTS, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.REPORTS, description: 'Consolidated platform-wide reporting dashboard.' },
    { id: 'lnk-admin-setup-wizard', label: LINKS.ADMIN.SETUP_WIZARD, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SETUP_WIZARD, description: 'Step-by-step business initialization and onboarding.' },
    { id: 'lnk-admin-search', label: LINKS.ADMIN.SEARCH, role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SEARCH, description: 'System-wide search for patients, staff, and records.' },
    { id: 'lnk-sm-api-hub', label: LINKS.SCRUM_MASTER.API_HUB, role: 'scrum_master', module: 'SCRUM_MASTER', path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, description: 'Technical dashboard for endpoint health and connectivity.' },
    { id: 'lnk-sm-monitoring', label: LINKS.SCRUM_MASTER.MONITORING, role: 'scrum_master', module: 'MONITORING', path: RouteRegistry.SCRUM_MASTER.MONITORING, description: 'Live platform resource and health surveillance.' },
    { id: 'lnk-sm-env-audit', label: LINKS.SCRUM_MASTER.ENV_AUDIT, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.ENV_AUDIT, description: 'Validation of infrastructure and environment variables.' },
    { id: 'lnk-sm-registry-check', label: LINKS.SCRUM_MASTER.REGISTRY, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK, description: 'Programmatic validation of master registry synchronization.' },
    { id: 'lnk-sm-db-schema', label: LINKS.SCRUM_MASTER.SCHEMA, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA, description: 'Live validation of Prisma schema against active database.' },
    { id: 'lnk-sm-build-health', label: LINKS.SCRUM_MASTER.BUILDS, role: 'scrum_master', module: 'BUILDS', path: RouteRegistry.SCRUM_MASTER.BUILD_HEALTH, description: 'CI/CD pipeline monitoring and build integrity logs.' },
    { id: 'lnk-sm-security-scans', label: LINKS.SCRUM_MASTER.SCANS, role: 'scrum_master', module: 'SCANS', path: RouteRegistry.SCRUM_MASTER.SECURITY_SCANS, description: 'Centralized security audit and threat surface analysis.' },
    { id: 'lnk-sm-localization', label: LINKS.SCRUM_MASTER.LOCALIZATION, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.LOCALIZATION, description: 'Validation of i18n coverage across all system modules.' },
    { id: 'lnk-sm-auto-fix', label: LINKS.SCRUM_MASTER.AUTO_FIX, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous systemic repair for registry mismatches.' },
    { id: 'lnk-sm-impersonate', label: LINKS.SCRUM_MASTER.IMPERSONATE, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.IMPERSONATE, description: 'Debug tool for shadowing active user sessions.' },
    { id: 'lnk-sm-response-bot', label: LINKS.SCRUM_MASTER.RESPONSE_BOT, role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.RESPONSE_BOT, description: 'Autonomous health-check agent for platform-wide audits.' },
    { id: 'lnk-sm-perf-metrics', label: LINKS.SCRUM_MASTER.PERFORMANCE, role: 'scrum_master', module: 'PERFORMANCE', path: RouteRegistry.SCRUM_MASTER.PERFORMANCE, description: 'Real-time V8 monitoring.' },
    { id: 'lnk-sm-theme-lab', label: LINKS.SCRUM_MASTER.THEME_LAB, role: 'scrum_master', module: 'THEME', path: RouteRegistry.SCRUM_MASTER.THEME_CENTER, description: 'Live registry-driven CSS variable lab.' },
    { id: 'lnk-mgr-pl', label: LINKS.MANAGER.PL, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.FINANCE, description: 'Financial visibility into branch-level performance.' },
    { id: 'lnk-coord-hub', label: LINKS.COORDINATOR.HUB, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.HUB, description: 'Coordinator real-time dispatch and shift monitoring.' },
    { id: 'lnk-staff-incidents', label: LINKS.ADMIN.INCIDENTS, role: 'staff', module: 'OPERATIONS', path: RouteRegistry.STAFF.INCIDENTS, description: 'Review and manage reported field incidents.' },
    { id: 'lnk-psw-offers', label: LINKS.PSW.OFFERS, role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.OFFERS, description: 'Browse and accept open shift opportunities.' },
    { id: 'lnk-rn-supervision', label: LINKS.RN.SUPERVISION, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.SUPERVISION, description: 'RN oversight portal for PSW performance.' },
    { id: 'lnk-client-support', label: LINKS.CLIENT.SUPPORT, role: 'client', module: 'CLIENT', path: RouteRegistry.CLIENT.SUPPORT, description: 'Family line to clinical support staff.' },
    { id: 'lnk-client-team', label: LINKS.CLIENT.TEAM, role: 'client', module: 'CLIENT', path: RouteRegistry.CLIENT.TEAM, description: 'View and contact assigned healthcare professionals.' },
    { id: 'lnk-client-billing', label: LINKS.CLIENT.BILLING, role: 'client', module: 'CLIENT', path: RouteRegistry.CLIENT.BILLING, description: 'Manage care payments and service history.' },
    { id: 'lnk-rn-ops-verify', label: LINKS.RN.OPS_VERIFY, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.DAILY_AUDIT, description: 'RN review platform for all clinical visit notes.' },
    { id: 'lnk-rn-supervision-field', label: LINKS.RN.SUPERVISION, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.SUPERVISION, description: 'Field oversight and competency tracking for frontline caregivers.' },
    { id: 'lnk-rn-care-plans', label: LINKS.RN.CARE_PLANS, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.CARE_PLANS, description: 'Authoring and lifecycle management of digital care plans.' },
    { id: 'lnk-superuser-tenants', label: LINKS.ADMIN.LOCATIONS, role: 'super_admin', module: 'PLATFORM', path: RouteRegistry.SUPERUSER.TENANTS, description: 'High-level oversight of all system instances.' },
    { id: 'lnk-superuser-sla', label: LINKS.SCRUM_MASTER.BUILDS, role: 'super_admin', module: 'PLATFORM', path: RouteRegistry.SUPERUSER.SLA, description: 'Uptime and performance monitoring across the platform.' },
    { id: 'lnk-adm-customers', label: LINKS.ADMIN.CUSTOMERS, role: 'admin', module: 'CUSTOMERS', path: RouteRegistry.ADMIN.CUSTOMERS, description: 'Global customer management portal.' },
    { id: 'lnk-adm-earnings', label: LINKS.ADMIN.EARNINGS, role: 'admin', module: 'EARNINGS', path: RouteRegistry.ADMIN.EARNINGS, description: 'View across all platform revenue stream.' },
    { id: 'lnk-adm-interop', label: LINKS.ADMIN.INTEROP, role: 'admin', module: 'INTEROP', path: RouteRegistry.ADMIN.INTEROP, description: 'HL7/FHIR gateway status.' },
    { id: 'lnk-adm-locations', label: LINKS.ADMIN.LOCATIONS, role: 'admin', module: 'LOCATIONS', path: RouteRegistry.ADMIN.LOCATIONS, description: 'Manage geographic branch boundaries.' },
    // Batch 14 Links
    { id: 'lnk-ops-logistics', label: LINKS.ADMIN.LOGISTICS, role: 'admin', module: 'OPERATIONS', path: RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB, description: 'Advanced fleet and region monitoring.' },
    { id: 'lnk-ops-regions', label: LINKS.ADMIN.REGIONS, role: 'admin', module: 'OPERATIONS', path: RouteRegistry.ADMIN.OPERATIONS.REGION_MAPPING, description: 'Geographic operational boundary management.' },
    // Batch 15: Reseller Links - REMOVED (Stale)
    // Batch 16: ERP Links
    { id: 'lnk-erp-inventory', label: LINKS.SHARED.STOCK, role: 'admin', module: 'ERP', path: RouteRegistry.ADMIN.ERP.INVENTORY, description: 'Real-time consumable and asset tracking.' },
    { id: 'lnk-erp-procurement', label: LINKS.SHARED.PROCUREMENT, role: 'operations_manager', module: 'ERP', path: RouteRegistry.ADMIN.ERP.PROCUREMENT, description: 'Supplier management and purchase order tracking.' },
    // Batch 17: Telehealth Links
    { id: 'lnk-telehealth-center', label: LINKS.SHARED.TELEHEALTH, role: 'rn', module: 'TELEHEALTH', path: RouteRegistry.ADMIN.TELEHEALTH.CENTER, description: 'Live video consultations and remote patient monitoring.' },
    { id: 'lnk-rpm-alerts', label: LINKS.SHARED.REMOTE_ALERTS, role: 'coordinator', module: 'TELEHEALTH', path: RouteRegistry.ADMIN.TELEHEALTH.ALERTS, description: 'Critical health alerts from remote monitoring devices.' },
    // Batch 18: Insurance & RCM Links
    { id: 'lnk-rcm-claims', label: LINKS.SHARED.CLAIMS, role: 'billing_manager', module: 'FINANCE', path: RouteRegistry.ADMIN.RCM.CLAIMS, description: 'Centralized management of insurance claim lifecycles.' },
    { id: 'lnk-rcm-revenue', label: LINKS.SHARED.REVENUE, role: 'admin', module: 'FINANCE', path: RouteRegistry.ADMIN.RCM.REVENUE, description: 'Detailed financial modeling and revenue cycle health monitoring.' },
    // Batch 19: Pharmacy Links
    { id: 'lnk-pharmacy-hub', label: LINKS.RN.PHARMACY, role: 'rn', module: 'PHARMACY', path: RouteRegistry.ADMIN.PHARMACY.HUB, description: 'E-prescribing and medication management center.' },
    { id: 'lnk-pharmacy-mar', label: LINKS.SHARED.MAR, role: 'psw', module: 'PHARMACY', path: RouteRegistry.ADMIN.PHARMACY.MAR, description: 'Medication Administration Record for active care delivery.' },
    // Batch 20: PSW Foundational Mastery
    { id: 'lnk-psw-handover', label: LINKS.PSW.HANDOVER, role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.HANDOVER, description: 'Interface for submitting shift handover reports.' },
    { id: 'lnk-psw-availability', label: LINKS.PSW.AVAILABILITY, role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.AVAILABILITY, description: 'Manage date-specific work availability and overrides.' },
    { id: 'lnk-psw-earnings', label: LINKS.PSW.EARNINGS, role: 'psw', module: 'FINANCE', path: RouteRegistry.PSW.EARNINGS, description: 'Track verified earnings and processed payout history.' },
    // Batch 25: Role Foundation Mastery
    // RN Foundation
    { id: 'lnk-rn-care-plans', label: LINKS.RN.CARE_PLANS, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.CARE_PLANS, description: 'Direct access to clinical goal tracking and interventions.' },
    { id: 'lnk-rn-assessments', label: LINKS.RN.ASSESSMENTS, role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.ASSESSMENTS, description: 'Structured clinical assessments and intake forms.' },
    // Coordinator Foundation
    { id: 'lnk-coord-sos', label: LINKS.COORDINATOR.SOS, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.SOS, description: 'Emergency shift fulfillment and field incident management.' },
    { id: 'lnk-coord-map', label: LINKS.COORDINATOR.MAP, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.MAP, description: 'Visual intelligence for regional shift and staff locations.' },
    { id: 'lnk-coord-waitlist', label: LINKS.COORDINATOR.WAITLIST, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.WAITLIST, description: 'Managing unassigned client demand and waitlist priorities.' },
    // Manager Foundation
    { id: 'lnk-mgr-ops', label: LINKS.MANAGER.OPS_TRIAGE, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.OPERATIONS, description: 'Management of late shifts, missed clock-ins, and field alerts.' },
    { id: 'lnk-mgr-compliance', label: LINKS.MANAGER.COMPLIANCE, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.COMPLIANCE, description: 'Branch-wide credential and regulatory tracking.' },
    // Staff Foundation
    { id: 'lnk-staff-tasks', label: LINKS.MANAGER.TEAM, role: 'staff', module: 'OPERATIONS', path: RouteRegistry.STAFF.TASKS, description: 'Active recruitment and task fulfillment board.' },
    { id: 'lnk-staff-messages', label: LINKS.COORDINATOR.HUB, role: 'staff', module: 'OPERATIONS', path: RouteRegistry.STAFF.MESSAGES, description: 'Unified messaging for branch-wide coordination.' },
    // Phase 1 Foundation Expansion
    { id: 'lnk-psw-live-visit', label: LINKS.PSW.LIVE_VISIT, role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.LIVE_VISIT, description: 'Active visit management and real-time ADL tracking.' },
    { id: 'lnk-coordinator-sos-hub', label: LINKS.COORDINATOR.SOS_HUB, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.SOS_HUB, description: 'Real-time emergency shift fulfillment and field alert management.' },
    // Batch 26: Regional Director Mastery
    { id: 'lnk-rd-regional', label: LINKS.REGIONAL.INTELLIGENCE, role: 'regional_manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.REGIONAL_STATS, description: 'High-level regional operational KPIs and radar.' },
    { id: 'lnk-rd-finance', label: LINKS.REGIONAL.FINANCE, role: 'regional_manager', module: 'FINANCE', path: RouteRegistry.MANAGER.FINANCE, description: 'Consolidated regional financial governance and P&L.' },
    { id: 'lnk-mgr-dashboard', label: LINKS.MANAGER.DASHBOARD, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.DASHBOARD, description: 'Daily operational overview for branch managers.' },
    { id: 'lnk-mgr-ops-hub', label: LINKS.MANAGER.AGENCY_HUB, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.OPERATIONS, description: 'Centralized hub for branch-wide coordination and triage.' },
    { id: 'lnk-mgr-finance', label: LINKS.MANAGER.FINANCIALS, role: 'manager', module: 'FINANCE', path: RouteRegistry.MANAGER.FINANCE, description: 'Branch-level billing, invoices, and financial performance.' },
    { id: 'lnk-mgr-team', label: LINKS.MANAGER.TEAM, role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.TEAM, description: 'Management of branch staff profiles and performance.' },
    { id: 'lnk-coord-master-schedule', label: LINKS.COORDINATOR.MASTER_SCHEDULE, role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.COORDINATOR.SCHEDULE, description: 'Unified master schedule for branch-wide shift oversight.' },
    { id: 'lnk-psw-availability-my', label: LINKS.PSW.MY_AVAILABILITY, role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.AVAILABILITY, description: 'Manage your weekly availability and service areas.' },
];
