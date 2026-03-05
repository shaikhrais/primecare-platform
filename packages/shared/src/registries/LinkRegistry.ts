import { RouteRegistry } from '../apps/web-admin/RouteRegistry';

export interface LinkDef {
    id: string;
    label: string;
    role: string;
    module: string;
    path: string;
    description: string;
    isExternal?: boolean;
}

export const LinkRegistry: LinkDef[] = [
    { id: 'lnk-admin-audit-logs', label: 'Security Audits', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.AUDITS, description: 'Direct access to platform-wide security logs.' },
    { id: 'lnk-admin-users', label: 'User Management', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.USERS, description: 'Global user directory and access control.' },
    { id: 'lnk-admin-schedule', label: 'Global Schedule', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SCHEDULE, description: 'Master view of all shifts and visits across the platform.' },
    { id: 'lnk-admin-incidents', label: 'Global Incidents', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.INCIDENTS, description: 'Incident response and resolution tracking.' },
    { id: 'lnk-admin-timesheets', label: 'Payroll Timesheets', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.TIMESHEETS, description: 'Master timesheet approval and auditing.' },
    { id: 'lnk-admin-leads', label: 'Growth Pipeline', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.LEADS, description: 'Access to business development and intake leads.' },
    { id: 'lnk-admin-services', label: 'Service Catalog', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SERVICES, description: 'Management of platform-wide clinical and support services.' },
    { id: 'lnk-admin-settings', label: 'Global Settings', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SETTINGS, description: 'Platform configuration and business rules.' },
    { id: 'lnk-admin-content', label: 'Content Manager', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.CONTENT, description: 'UI string and localized content management.' },
    { id: 'lnk-admin-admission', label: 'Admission Center', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.ADMISSION, description: 'Clinical intake and patient admission workflows.' },
    { id: 'lnk-admin-reports', label: 'Report Center', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.REPORTS, description: 'Consolidated platform-wide reporting dashboard.' },
    { id: 'lnk-admin-setup-wizard', label: 'Setup Wizard', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SETUP_WIZARD, description: 'Step-by-step business initialization and onboarding.' },
    { id: 'lnk-admin-search', label: 'Global Search', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.SEARCH, description: 'System-wide search for patients, staff, and records.' },
    { id: 'lnk-sm-api-hub', label: 'API Integrity Hub', role: 'scrum_master', module: 'SCRUM_MASTER', path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, description: 'Technical dashboard for endpoint health and connectivity.' },
    { id: 'lnk-sm-monitoring', label: 'System Health', role: 'scrum_master', module: 'MONITORING', path: RouteRegistry.SCRUM_MASTER.MONITORING, description: 'Live platform resource and health surveillance.' },
    { id: 'lnk-sm-env-audit', label: 'Environment Audit', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.ENV_AUDIT, description: 'Validation of infrastructure and environment variables.' },
    { id: 'lnk-sm-registry-check', label: 'Registry Integrity', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK, description: 'Programmatic validation of master registry synchronization.' },
    { id: 'lnk-sm-db-schema', label: 'Schema Audit', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA, description: 'Live validation of Prisma schema against active database.' },
    { id: 'lnk-sm-build-health', label: 'Build Surveillance', role: 'scrum_master', module: 'BUILDS', path: RouteRegistry.SCRUM_MASTER.BUILD_HEALTH, description: 'CI/CD pipeline monitoring and build integrity logs.' },
    { id: 'lnk-sm-security-scans', label: 'Vulnerability Scans', role: 'scrum_master', module: 'SCANS', path: RouteRegistry.SCRUM_MASTER.SECURITY_SCANS, description: 'Centralized security audit and threat surface analysis.' },
    { id: 'lnk-sm-localization', label: 'Localization Audit', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.LOCALIZATION, description: 'Validation of i18n coverage across all system modules.' },
    { id: 'lnk-sm-auto-fix', label: 'Auto-Repair Engine', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous systemic repair for registry mismatches.' },
    { id: 'lnk-sm-impersonate', label: 'Role Shadowing', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.IMPERSONATE, description: 'Debug tool for shadowing active user sessions.' },
    { id: 'lnk-sm-response-bot', label: 'Response Bot AI', role: 'scrum_master', module: 'GOVERNANCE', path: RouteRegistry.SCRUM_MASTER.RESPONSE_BOT, description: 'Autonomous health-check agent for platform-wide audits.' },
    { id: 'lnk-sm-perf-metrics', label: 'Node Performance', role: 'scrum_master', module: 'PERFORMANCE', path: RouteRegistry.SCRUM_MASTER.PERFORMANCE, description: 'Real-time V8 monitoring.' },
    { id: 'lnk-sm-theme-lab', label: 'Theme Studio', role: 'scrum_master', module: 'THEME', path: RouteRegistry.SCRUM_MASTER.THEME_CENTER, description: 'Live registry-driven CSS variable lab.' },
    { id: 'lnk-mgr-pl', label: 'Branch Profit & Loss', role: 'manager', module: 'OPERATIONS', path: RouteRegistry.MANAGER.FINANCE, description: 'Financial visibility into branch-level performance.' },
    { id: 'lnk-coord-hub', label: 'Dispatch Center', role: 'coordinator', module: 'OPERATIONS', path: RouteRegistry.MANAGER.DASHBOARD, description: 'Coordinator real-time dispatch and shift monitoring.' },
    { id: 'lnk-staff-incidents', label: 'Incident Desk', role: 'staff', module: 'OPERATIONS', path: RouteRegistry.STAFF.INCIDENTS, description: 'Review and manage reported field incidents.' },
    { id: 'lnk-psw-offers', label: 'Shift Marketplace', role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.OFFERS, description: 'Browse and accept open shift opportunities.' },
    { id: 'lnk-rn-supervision', label: 'Supervision Hub', role: 'rn', module: 'CLINICAL', path: RouteRegistry.RN.SUPERVISION, description: 'RN oversight portal for PSW performance.' },
    { id: 'lnk-client-support', label: 'Nursing Chat', role: 'client', module: 'CLIENT', path: RouteRegistry.CLIENT.SUPPORT, description: 'Family line to clinical support staff.' },
    { id: 'lnk-client-team', label: 'My Care Team', role: 'client', module: 'CLIENT', path: RouteRegistry.CLIENT.TEAM, description: 'View and contact assigned healthcare professionals.' },
    { id: 'lnk-allied-history', label: 'Treatment History', role: 'rmt', module: 'CLINICAL', path: RouteRegistry.RN.DASHBOARD, description: 'Historical view of clinical treatments.' },
    { id: 'lnk-superuser-tenants', label: 'Global Tenant Map', role: 'super_admin', module: 'PLATFORM', path: RouteRegistry.SUPERUSER.TENANTS, description: 'High-level oversight of all system instances.' },
    { id: 'lnk-superuser-sla', label: 'SLA Performance', role: 'super_admin', module: 'PLATFORM', path: RouteRegistry.SUPERUSER.SLA, description: 'Uptime and performance monitoring across the platform.' },
    { id: 'lnk-adm-customers', label: 'Customer CRM', role: 'admin', module: 'CUSTOMERS', path: RouteRegistry.ADMIN.CUSTOMERS, description: 'Global customer management portal.' },
    { id: 'lnk-adm-earnings', label: 'Earnings Ledger', role: 'admin', module: 'EARNINGS', path: RouteRegistry.ADMIN.EARNINGS, description: 'View across all platform revenue stream.' },
    { id: 'lnk-adm-interop', label: 'Electronic Health Link', role: 'admin', module: 'INTEROP', path: RouteRegistry.ADMIN.INTEROP, description: 'HL7/FHIR gateway status.' },
    { id: 'lnk-adm-locations', label: 'Branch Mapping', role: 'admin', module: 'LOCATIONS', path: RouteRegistry.ADMIN.LOCATIONS, description: 'Manage geographic branch boundaries.' },
    // Batch 14 Links
    { id: 'lnk-ops-logistics', label: 'Logistics Hub', role: 'admin', module: 'OPERATIONS', path: RouteRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB, description: 'Advanced fleet and region monitoring.' },
    { id: 'lnk-ops-regions', label: 'Region Mapping', role: 'admin', module: 'OPERATIONS', path: RouteRegistry.ADMIN.OPERATIONS.REGION_MAPPING, description: 'Geographic operational boundary management.' },
    // Batch 15: Reseller Links
    { id: 'lnk-reseller-hub', label: 'Agency Portfolio', role: 'reseller', module: 'FRANCHISE', path: RouteRegistry.ADMIN.RESELLER, description: 'Management hub for white-label agencies.' },
    { id: 'lnk-reseller-agreements', label: 'Partner Agreements', role: 'reseller', module: 'FRANCHISE', path: '/platform/reseller/agreements', description: 'Review and sign franchise partner contracts.' },
    // Batch 16: ERP Links
    { id: 'lnk-erp-inventory', label: 'Stock & Inventory', role: 'admin', module: 'ERP', path: '/platform/admin/erp/inventory', description: 'Real-time consumable and asset tracking.' },
    { id: 'lnk-erp-procurement', label: 'Procurement Hub', role: 'operations_manager', module: 'ERP', path: '/platform/admin/erp/procurement', description: 'Supplier management and purchase order tracking.' },
    // Batch 17: Telehealth Links
    { id: 'lnk-telehealth-center', label: 'Telehealth Center', role: 'rn', module: 'TELEHEALTH', path: '/platform/admin/telehealth/center', description: 'Live video consultations and remote patient monitoring.' },
    { id: 'lnk-rpm-alerts', label: 'Remote Alerts', role: 'coordinator', module: 'TELEHEALTH', path: '/platform/admin/telehealth/alerts', description: 'Critical health alerts from remote monitoring devices.' },
    // Batch 18: Insurance & RCM Links
    { id: 'lnk-rcm-claims', label: 'Claims Command Center', role: 'billing_manager', module: 'FINANCE', path: '/platform/admin/rcm/claims', description: 'Centralized management of insurance claim lifecycles.' },
    { id: 'lnk-rcm-revenue', label: 'Revenue Analytics', role: 'admin', module: 'FINANCE', path: '/platform/admin/rcm/revenue', description: 'Detailed financial modeling and revenue cycle health monitoring.' },
    // Batch 19: Pharmacy Links
    { id: 'lnk-pharmacy-hub', label: 'Pharmacy Hub', role: 'rn', module: 'PHARMACY', path: '/platform/admin/pharmacy/hub', description: 'E-prescribing and medication management center.' },
    { id: 'lnk-pharmacy-mar', label: 'Digital MAR', role: 'psw', module: 'PHARMACY', path: '/platform/admin/pharmacy/mar', description: 'Medication Administration Record for active care delivery.' },
    // Batch 20: PSW Foundational Mastery
    { id: 'lnk-psw-handover', label: 'Shift Handover', role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.HANDOVER, description: 'Interface for submitting shift handover reports.' },
    { id: 'lnk-psw-availability', label: 'Availability Overrides', role: 'psw', module: 'CARE_DELIVERY', path: RouteRegistry.PSW.AVAILABILITY, description: 'Manage date-specific work availability and overrides.' },
    { id: 'lnk-psw-earnings', label: 'Earnings & Payouts', role: 'psw', module: 'FINANCE', path: RouteRegistry.PSW.EARNINGS, description: 'Track verified earnings and processed payout history.' }
];
