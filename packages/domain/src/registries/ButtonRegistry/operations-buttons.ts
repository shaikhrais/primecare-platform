// Governance - Category: service | Purpose: Core implementation file for the Operations Buttons platform logic.
import type { ButtonDef } from '../button_registry';
import { ApiRegistry } from '../ApiRegistry';

const R = {
    ADM: 'admin', COORD: 'coordinator', RN: 'rn',
    CLIENT: 'client', RES: 'reseller', MKT: 'marketing_manager',
    HR: 'hr_manager', BILLING: 'billing_manager', OPS: 'operations_manager',
    RD: 'regional_manager', PUB: 'public',
} as const;

const M = {
    ADM: 'ADMIN', OPS: 'OPERATIONS', FIN: 'FINANCE', GOV: 'GOVERNANCE', MKT: 'MARKETING',
    HR: 'HR', SEC: 'SECURITY', ERP: 'ERP', TELE: 'TELEHEALTH', PHARM: 'PHARMACY',
    AI: 'AI', AUTO: 'AUTOMATION', INTEROP: 'INTEROP', SOV: 'SOVEREIGN',
    LEADS: 'LEADS', SCHED: 'SCHEDULE', INV: 'INVOICES', ADM_MISSION: 'ADMISSION',
    FRAN: 'FRANCHISE',
} as const;

const A = {
    API: 'API_TRIGGER', NAV: 'UI_NAVIGATION', MODAL: 'OPEN_MODAL',
    SIG: 'API_SIGNATURE',
} as const;

const T = { P: 'primary', S: 'secondary', G: 'ghost', D: 'danger' } as const;

function btn(
    id: string, label: string, role: string, module: string,
    type: 'primary' | 'secondary' | 'ghost' | 'danger',
    action: string, description: string,
    opts?: { api?: string; routeKey?: string; routeParams?: string[] }
): ButtonDef {
    return {
        id, label, role, module, type, action, description,
        ...(opts?.api && { apiPath: opts.api }),
        ...(opts?.routeKey && { routeKey: opts.routeKey }),
        ...(opts?.routeParams && { routeParams: opts.routeParams }),
    };
}

// ── Operations Buttons (Admin-Ops, Marketing, Security, AI, ERP, Telehealth, Pharmacy, Reseller, Regional, Sovereign) ──

export const OPERATIONS_BUTTONS: ButtonDef[] = [
    // Admin Operations
    btn('btn-adm-admission-new',      'New Admission',             R.ADM, M.ADM_MISSION, T.P, A.MODAL, 'Starts the clinical admission intake.'),
    btn('btn-adm-automation-trigger', 'Launch Autopilot',          R.ADM, M.AUTO, T.P, A.API,   'Triggers clinical autopilot routines.', { api: ApiRegistry.PLATFORM.AI.AUTOPILOT_ENGAGE }),
    btn('btn-adm-leads-convert',      'Convert Lead',              R.ADM, M.LEADS,T.P, A.API,   'Converts a business lead to a customer.', { api: ApiRegistry.ADMIN.LEADS_CONVERT(':id'), routeParams: [':id'] }),
    btn('btn-adm-schedule-optimize',  'AI Shift Match',            R.ADM, M.SCHED,T.P, A.API,   'Runs AI matching for unassigned shifts.', { api: ApiRegistry.PLATFORM.AI.AI_OPTIMIZE }),
    btn('btn-adm-billing-finalize',   'Lock Master Ledger',        R.ADM, M.INV,  T.D, A.API,   'Finalizes global billing state.', { api: ApiRegistry.TENANCY.MANAGER.BILLING_FINALIZE }),
    btn('btn-adm-ops-optimize',       'Optimize Logistics',        R.ADM, M.OPS,  T.P, A.API,   'Triggers AI logistics optimization.', { api: ApiRegistry.ADMIN.OPERATIONS.LOGISTICS_HUB }),
    btn('btn-adm-region-new',         'Define New Region',         R.ADM, M.OPS,  T.S, A.MODAL, 'Creates a new operational geographic region.'),
    btn('btn-adm-fhir-export',        'Export FHIR Record',        R.ADM, M.INTEROP,T.P,A.API,   'Generates an HL7 FHIR R4 clinical JSON.', { api: ApiRegistry.PLATFORM.INTEROP.FHIR_EXPORT(':id'), routeParams: [':id'] }),
    // Marketing
    btn('btn-mkt-campaign-new',       'New Campaign',              R.MKT, M.MKT, T.P, A.MODAL, 'Launches the campaign creation wizard.'),
    btn('btn-mkt-crm-export',         'Export CRM Data',           R.MKT, M.MKT, T.S, A.API,   'Exports the current CRM lead pipeline.', { api: ApiRegistry.ADMIN.REPORTS }),
    btn('btn-hr-post-role',           'Post Core Role',            R.HR,  M.HR,  T.P, A.MODAL, 'Initializes a new job posting for recruitment.'),
    // Security
    btn('btn-sec-threat-scan',        'Scan for Threats',          R.ADM, M.SEC, T.D, A.API,   'Triggers a real-time platform threat detection sweep.', { api: ApiRegistry.PLATFORM.SECURITY.THREAT_DETECTION }),
    btn('btn-sec-session-flush',      'Flush Suspicious Sessions', R.ADM, M.SEC, T.S, A.API,   'Terminates all sessions flagged with anomalous behavior.', { api: ApiRegistry.PLATFORM.SECURITY.SESSIONS }),
    // AI
    btn('btn-ai-insights-refresh',    'Recalculate Insights',      R.ADM, M.AI,  T.S, A.API,   'Triggers a full AI analytics refresh.', { api: ApiRegistry.AI.INSIGHTS_REFRESH }),
    btn('btn-ai-autopilot-engage',    'Engage Auto-Pilot',         R.ADM, M.AUTO,T.P, A.API,   'Initializes autonomous shift matchmaking.', { api: ApiRegistry.AI.AUTOPILOT_ENGAGE }),
    // ERP
    btn('btn-erp-inventory-add',      'Register Stock Item',       R.ADM, M.ERP, T.P, A.MODAL, 'Adds new inventory unit to the systemic registry.'),
    btn('btn-erp-po-create',          'Generate Purchase Order',   R.OPS, M.ERP, T.P, A.MODAL, 'Initiates procurement request for external suppliers.'),
    // Telehealth
    btn('btn-telehealth-session-start','Start Virtual Visit',      R.RN,    M.TELE, T.P, A.NAV, 'Launches the real-time encrypted video consultation gateway.', { routeKey: 'ADMIN.TELEHEALTH.CENTER', api: ApiRegistry.PLATFORM.ADMIN.TELEHEALTH.CREATE_SESSION }),
    btn('btn-rpm-vitals-verify',      'Verify Remote Vitals',      R.COORD, M.TELE, T.S, A.API, 'Acknowledges and logs incoming remote patient monitoring data.', { api: ApiRegistry.PLATFORM.ADMIN.TELEHEALTH.VITAL_SIGN_PUSH }),
    // RCM
    btn('btn-rcm-claim-submit',       'Submit Insurance Claim',    R.BILLING,M.FIN,T.P, A.API,  'Transmits clinical documentation to insurance clearinghouses.', { api: ApiRegistry.PLATFORM.ADMIN.RCM.SUBMIT_CLAIM }),
    btn('btn-rcm-revenue-sync',       'Sync Revenue Ledger',       R.ADM,   M.FIN,T.S, A.API,  'Reconciles bank deposits with adjudicated insurance claims.', { api: ApiRegistry.PLATFORM.ADMIN.RCM.REVENUE_SYNC }),
    // Pharmacy
    btn('btn-pharmacy-order',         'Order Medication',           R.RN,    M.PHARM,T.P,A.MODAL,'Transmits e-prescription request to integrated pharmacy partner.', { api: ApiRegistry.PLATFORM.ADMIN.PHARMACY.ORDER_DRUGS }),
    btn('btn-pharmacy-mar-sync',      'Sync MAR Records',          R.COORD, M.PHARM,T.S,A.API,  'Synchronizes Medication Administration Records with the clinical ledger.', { api: ApiRegistry.PLATFORM.ADMIN.PHARMACY.MAR_SYNC }),
    // Reseller
    btn('btn-reseller-provision',     'Spawn Child Agency',         R.RES, M.FRAN, T.P, A.MODAL, 'Initializes a new white-label agency under the reseller.', { api: ApiRegistry.PLATFORM.ADMIN.RESELLER.PROVISION }),
    btn('btn-reseller-suspend',       'Suspend Franchise',         R.RES, M.FRAN, T.D, A.API,   'Temporarily revokes access for a child agency.', { api: ApiRegistry.PLATFORM.ADMIN.RESELLER.SUSPEND(':id'), routeParams: [':id'] }),
    // Regional Director
    btn('btn-rd-ops-stats',           'Refresh Regional Stats',    R.RD, M.OPS,  T.S, A.API,   'Triggers a recalculation of regional operational metrics.', { api: ApiRegistry.TENANCY.MANAGER.OPS_STATS }),
    btn('btn-rd-pl-export',           'Regional P&L Export',       R.RD, M.FIN,  T.S, A.API,   'Exports regional financial performance data.', { api: ApiRegistry.PLATFORM.ADMIN.REGIONAL.PL_EXPORT }),
    btn('btn-rd-audit-req',           'Strategic Audit Request',   R.RD, M.GOV,  T.P, A.API,   'Triggers a comprehensive strategic audit of the region.', { api: ApiRegistry.PLATFORM.ADMIN.REGIONAL.AUDIT_REQUEST }),
    // Sovereign / Auth
    btn('btn-wallet-did-verify',      'Authorize Secure Access',   R.CLIENT,M.SOV,T.P, A.API,   'Authenticates via Decentralized Identity (DID).', { api: ApiRegistry.PLATFORM.INTEROP.DID_VERIFY }),
    btn('btn-auth-osm-login',         'Sign in with OpenStreetMap',R.PUB, M.ADM,  T.S, A.API,   'Initializes secure identity verification via OpenStreetMap OAuth.', { api: '/v1/auth/osm' }),
];
