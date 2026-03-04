import { RouteRegistry } from '../apps/web-admin/RouteRegistry';
import { ApiRegistry } from './ApiRegistry';

export interface InteractiveBase {
    id: string;
    label: string;
    role: string;
    module: string;
    description: string;
}

export interface ButtonDef extends InteractiveBase {
    type: 'primary' | 'secondary' | 'ghost' | 'danger';
    action: string;
    apiPath?: string;
}

export interface LinkDef extends InteractiveBase {
    path: string;
    isExternal?: boolean;
}

export interface InteractionADef extends InteractiveBase {
    trigger: 'click' | 'hover' | 'submit';
    consequence: string; // e.g., 'openModal', 'apiTrigger', 'routeChange'
    target?: string;
}

/**
 * ButtonRegistry: Every primary and secondary CTA platform-wide.
 */
export const ButtonRegistry: ButtonDef[] = [
    { id: 'btn-admin-user-invite', label: 'Invite User', role: 'admin', module: 'ADMIN', type: 'primary', action: 'OPEN_MODAL', description: 'Triggers the global user invitation dialog.' },
    { id: 'btn-admin-report-export', label: 'Generate Global Export', role: 'admin', module: 'ADMIN', type: 'secondary', action: 'API_TRIGGER', apiPath: ApiRegistry.ADMIN.REPORTS, description: 'Triggers a full-platform data export for auditing.' },
    { id: 'btn-sm-auto-fix', label: 'Launch Auto-Fixer', role: 'scrum_master', module: 'SCRUM_MASTER', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Executes the autonomous registry repair engine.' },
    { id: 'btn-mgr-payroll-verify', label: 'Verify Weekly Payroll', role: 'manager', module: 'OPERATIONS', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.TENANCY.MANAGER.PAYROLL_AUDIT, description: 'Finalizes and locks the regional payroll records.' },
    { id: 'btn-coord-sos-ack', label: 'Respond to SOS', role: 'coordinator', module: 'OPERATIONS', type: 'danger', action: 'API_DISPATCH', apiPath: ApiRegistry.TENANCY.STAFF.COORDINATOR.SOS_DISPATCH, description: 'Immediate coordinator acknowledgement of a field SOS.' },
    { id: 'btn-staff-task-add', label: 'Create New Task', role: 'staff', module: 'OPERATIONS', type: 'primary', action: 'UI_NAVIGATION', description: 'Opens the task creation interface for staff.' },
    { id: 'btn-staff-compliance-scan', label: 'Run Compliance Scan', role: 'staff', module: 'OPERATIONS', type: 'secondary', action: 'API_TRIGGER', apiPath: ApiRegistry.TENANCY.STAFF.COMPLIANCE_SCAN, description: 'Triggers a branch-wide compliance health check.' },
    { id: 'btn-psw-check-in', label: 'Check-in Now', role: 'psw', module: 'CARE_DELIVERY', type: 'primary', action: 'GEOLOCATION_STAMP', apiPath: ApiRegistry.TENANCY.PSW.CHECK_IN(':id'), description: 'Geofenced visit start for PSWs.' },
    { id: 'btn-psw-check-out', label: 'Complete Visit', role: 'psw', module: 'CARE_DELIVERY', type: 'secondary', action: 'GEOLOCATION_STAMP', apiPath: ApiRegistry.TENANCY.PSW.CHECK_OUT(':id'), description: 'Finalizes a patient visit with a timestamp.' },
    { id: 'btn-rn-entry-verify', label: 'Sign & Verify Entry', role: 'rn', module: 'CLINICAL', type: 'primary', action: 'API_SIGNATURE', apiPath: ApiRegistry.TENANCY.RN.DAILY_AUDIT_VERIFY(':id'), description: 'RN clinical verification of a visit daily entry.' },
    { id: 'btn-mkt-campaign-new', label: 'New Campaign', role: 'marketing_manager', module: 'MARKETING', type: 'primary', action: 'OPEN_MODAL', description: 'Launches the campaign creation wizard.' },
    { id: 'btn-mkt-crm-export', label: 'Export CRM Data', role: 'marketing_manager', module: 'MARKETING', type: 'secondary', action: 'API_TRIGGER', apiPath: ApiRegistry.ADMIN.REPORTS, description: 'Exports the current CRM lead pipeline.' },
    { id: 'btn-hr-post-role', label: 'Post Core Role', role: 'hr_manager', module: 'HR', type: 'primary', action: 'OPEN_MODAL', description: 'Initializes a new job posting for recruitment.' },
    { id: 'btn-sm-universal-sweep', label: 'Start Universal Sweep', role: 'scrum_master', module: 'GOVERNANCE', type: 'primary', action: 'API_TRIGGER', description: 'Triggers the Response Bot for a platform-wide heartbeat check.' },
    { id: 'btn-sm-auto-fix', label: 'Auto-Fix Registry', role: 'scrum_master', module: 'GOVERNANCE', type: 'secondary', action: 'API_TRIGGER', description: 'Automatically repairs orphan registry entries.' },
    { id: 'btn-coord-sos-dispatch', label: 'Dispatch Hero', role: 'coordinator', module: 'OPERATIONS', type: 'primary', action: 'OPEN_MODAL', description: 'Emergency dispatch for SOS alerts.' },
    { id: 'btn-coord-optimize', label: 'Optimize Routes', role: 'coordinator', module: 'OPERATIONS', type: 'secondary', action: 'API_TRIGGER', description: 'Runs AI route optimization for the current shift.' },
    { id: 'btn-client-request-care', label: 'Book New Service', role: 'client', module: 'CLIENT', type: 'primary', action: 'OPEN_MODAL', description: 'Triggers the service booking flow.' },
    { id: 'btn-client-pay-invoice', label: 'Pay Invoice', role: 'client', module: 'CLIENT', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.CLIENT.INVOICES, description: 'Direct payment for outstanding invoices.' },
    { id: 'btn-allied-sign-visit', label: 'Sign Clinical Note', role: 'rmt', module: 'CLINICAL', type: 'primary', action: 'API_SIGNATURE', description: 'Clinical sign-off for Allied Health professionals.' }
];

/**
 * LinkRegistry: All internal and external navigation links.
 */
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
    { id: 'lnk-allied-history', label: 'Treatment History', role: 'rmt', module: 'CLINICAL', path: RouteRegistry.RN.DASHBOARD, description: 'Historical view of clinical treatments.' }
];

/**
 * InteractionARegistry: Complex interactions (Modals, Multi-step actions).
 */
export const InteractionARegistry: InteractionADef[] = [
    { id: 'ia-sm-registry-repair', label: 'Auto-Repair Registry', role: 'scrum_master', module: 'SCRUM_MASTER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous attempt to resolve broken registry mappings.' },
    { id: 'ia-hr-bulk-notify', label: 'Compliance Notifications', role: 'hr_manager', module: 'HR', trigger: 'click', consequence: 'openModal', description: 'Open bulk notification composer for certification renewals.' }
];

export const UnifiedInteractiveRegistry = {
    buttons: ButtonRegistry,
    links: LinkRegistry,
    interactions: InteractionARegistry
};
