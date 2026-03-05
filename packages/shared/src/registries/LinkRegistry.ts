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
    { id: 'lnk-admin-leads', label: 'Growth Pipeline', role: 'admin', module: 'ADMIN', path: RouteRegistry.ADMIN.LEADS, description: 'Access to business development and intake leads.' },
    { id: 'lnk-sm-api-hub', label: 'API Integrity Hub', role: 'scrum_master', module: 'SCRUM_MASTER', path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, description: 'Technical dashboard for endpoint health and connectivity.' },
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
    { id: 'lnk-sm-perf-metrics', label: 'Node Performance', role: 'scrum_master', module: 'PERFORMANCE', path: RouteRegistry.SCRUM_MASTER.PERFORMANCE, description: 'Real-time V8 monitoring.' },
    { id: 'lnk-sm-theme-lab', label: 'Theme Studio', role: 'scrum_master', module: 'THEME', path: RouteRegistry.SCRUM_MASTER.THEME_CENTER, description: 'Live registry-driven CSS variable lab.' },
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
    { id: 'lnk-rpm-alerts', label: 'Remote Alerts', role: 'coordinator', module: 'TELEHEALTH', path: '/platform/admin/telehealth/alerts', description: 'Critical health alerts from remote monitoring devices.' }
];
