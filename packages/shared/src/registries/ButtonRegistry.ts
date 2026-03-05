import { ApiRegistry } from './ApiRegistry';

export interface ButtonDef {
    id: string;
    label: string;
    role: string;
    module: string;
    type: 'primary' | 'secondary' | 'ghost' | 'danger';
    action: string;
    description: string;
    apiPath?: string;
}

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
    { id: 'btn-coord-sos-dispatch', label: 'Dispatch Hero', role: 'coordinator', module: 'OPERATIONS', type: 'primary', action: 'OPEN_MODAL', description: 'Emergency dispatch for SOS alerts.' },
    { id: 'btn-coord-optimize', label: 'Optimize Routes', role: 'coordinator', module: 'OPERATIONS', type: 'secondary', action: 'API_TRIGGER', description: 'Runs AI route optimization for the current shift.' },
    { id: 'btn-client-request-care', label: 'Book New Service', role: 'client', module: 'CLIENT', type: 'primary', action: 'OPEN_MODAL', description: 'Triggers the service booking flow.' },
    { id: 'btn-client-pay-invoice', label: 'Pay Invoice', role: 'client', module: 'CLIENT', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.CLIENT.INVOICES, description: 'Direct payment for outstanding invoices.' },
    { id: 'btn-allied-sign-visit', label: 'Sign Clinical Note', role: 'rmt', module: 'CLINICAL', type: 'primary', action: 'API_SIGNATURE', description: 'Clinical sign-off for Allied Health professionals.' },
    { id: 'btn-superuser-tenant-new', label: 'Provision New Tenant', role: 'super_admin', module: 'PLATFORM', type: 'primary', action: 'OPEN_MODAL', description: 'Initializes a new multi-tenant environment.' },
    { id: 'btn-superuser-risk-scan', label: 'Run Risk Surveillance', role: 'super_admin', module: 'PLATFORM', type: 'danger', action: 'API_TRIGGER', description: 'Triggers platform-wide anomaly detection.' },
    { id: 'btn-adm-admission-new', label: 'New Admission', role: 'admin', module: 'ADMISSION', type: 'primary', action: 'OPEN_MODAL', description: 'Starts the clinical admission intake.' },
    { id: 'btn-adm-automation-trigger', label: 'Launch Autopilot', role: 'admin', module: 'AUTOMATION', type: 'primary', action: 'API_TRIGGER', description: 'Triggers clinical autopilot routines.' },
    { id: 'btn-adm-leads-convert', label: 'Convert Lead', role: 'admin', module: 'LEADS', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.ADMIN.LEADS_CONVERT(':id'), description: 'Converts a business lead to a customer.' },
    { id: 'btn-adm-schedule-optimize', label: 'AI Shift Match', role: 'admin', module: 'SCHEDULE', type: 'primary', action: 'API_TRIGGER', description: 'Runs AI matching for unassigned shifts.' },
    { id: 'btn-adm-billing-finalize', label: 'Lock Master Ledger', role: 'admin', module: 'INVOICES', type: 'danger', action: 'API_TRIGGER', apiPath: ApiRegistry.TENANCY.MANAGER.BILLING_FINALIZE, description: 'Finalizes global billing state.' },
    { id: 'btn-mgr-training-create', label: 'Create Training Module', role: 'manager', module: 'OPERATIONS', type: 'primary', action: 'OPEN_MODAL', description: 'Initializes a new clinical training module.' },
    { id: 'btn-mgr-survey-new', label: 'New Satisfaction Survey', role: 'manager', module: 'OPERATIONS', type: 'primary', action: 'OPEN_MODAL', description: 'Launches a new survey for staff or clients.' },
    { id: 'btn-mgr-evaluation-new', label: 'New Performance Evaluation', role: 'manager', module: 'OPERATIONS', type: 'primary', action: 'OPEN_MODAL', description: 'Starts a staff performance review process.' },
    { id: 'btn-adm-ops-optimize', label: 'Optimize Logistics', role: 'admin', module: 'OPERATIONS', type: 'primary', action: 'API_TRIGGER', apiPath: ApiRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB, description: 'Triggers AI logistics optimization.' },
    { id: 'btn-adm-region-new', label: 'Define New Region', role: 'admin', module: 'OPERATIONS', type: 'secondary', action: 'OPEN_MODAL', description: 'Creates a new operational geographic region.' },
    { id: 'btn-sm-build-deploy', label: 'Deploy Staging', role: 'scrum_master', module: 'BUILDS', type: 'primary', action: 'CI_TRIGGER', description: 'Triggers a manual CI/CD deployment.' },
    { id: 'btn-sm-scan-security', label: 'Full Security Scan', role: 'scrum_master', module: 'SCANS', type: 'danger', action: 'API_TRIGGER', description: 'Triggers a platform-wide vulnerability audit.' },
    { id: 'btn-adm-fhir-export', label: 'Export FHIR Record', role: 'admin', module: 'INTEROP', type: 'primary', action: 'API_TRIGGER', description: 'Generates an HL7 FHIR R4 clinical JSON.' },
    { id: 'btn-wallet-did-verify', label: 'Authorize Secure Access', role: 'client', module: 'SOVEREIGN', type: 'primary', action: 'API_TRIGGER', description: 'Authenticates via Decentralized Identity (DID).' },
    { id: 'btn-ai-insights-refresh', label: 'Recalculate Insights', role: 'admin', module: 'AI', type: 'secondary', action: 'API_TRIGGER', description: 'Triggers a full AI analytics refresh.' },
    { id: 'btn-ai-autopilot-engage', label: 'Engage Auto-Pilot', role: 'admin', module: 'AUTOMATION', type: 'primary', action: 'API_TRIGGER', description: 'Initializes autonomous shift matchmaking.' },
    { id: 'btn-sec-threat-scan', label: 'Scan for Threats', role: 'admin', module: 'SECURITY', type: 'danger', action: 'API_TRIGGER', description: 'Triggers a real-time platform threat detection sweep.' },
    { id: 'btn-sec-session-flush', label: 'Flush Suspicious Sessions', role: 'admin', module: 'SECURITY', type: 'secondary', action: 'API_TRIGGER', description: 'Terminates all sessions flagged with anomalous behavior.' },
    { id: 'btn-sup-health-refresh', label: 'Refresh Global Health', role: 'superuser', module: 'GOVERNANCE', type: 'primary', action: 'API_TRIGGER', description: 'Triggers a platform-wide infrastructure health check.' },
    { id: 'btn-sup-policy-push', label: 'Deploy System Policy', role: 'superuser', module: 'GOVERNANCE', type: 'secondary', action: 'API_TRIGGER', description: 'Enforces new core policies across all active tenants.' },
    // Batch 15: Reseller Mastery
    { id: 'btn-reseller-provision', label: 'Spawn Child Agency', role: 'reseller', module: 'FRANCHISE', type: 'primary', action: 'OPEN_MODAL', description: 'Initializes a new white-label agency under the reseller.' },
    { id: 'btn-reseller-suspend', label: 'Suspend Franchise', role: 'reseller', module: 'FRANCHISE', type: 'danger', action: 'API_TRIGGER', description: 'Temporarily revokes access for a child agency.' },
    // Batch 16: ERP Mastery
    { id: 'btn-erp-inventory-add', label: 'Register Stock Item', role: 'admin', module: 'ERP', type: 'primary', action: 'OPEN_MODAL', description: 'Adds new inventory unit to the systemic registry.' },
    { id: 'btn-erp-po-create', label: 'Generate Purchase Order', role: 'operations_manager', module: 'ERP', type: 'primary', action: 'OPEN_MODAL', description: 'Initiates procurement request for external suppliers.' }
];
