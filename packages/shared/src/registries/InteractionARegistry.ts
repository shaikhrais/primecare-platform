import { ApiRegistry } from './ApiRegistry';

export interface InteractionADef {
    id: string;
    label: string;
    role: string;
    module: string;
    trigger: 'click' | 'hover' | 'submit';
    consequence: string; // e.g., 'openModal', 'apiTrigger', 'routeChange'
    description: string;
    target?: string;
}

export const InteractionARegistry: InteractionADef[] = [
    { id: 'ia-sm-registry-repair', label: 'Auto-Repair Registry', role: 'scrum_master', module: 'SCRUM_MASTER', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Autonomous attempt to resolve broken registry mappings.' },
    { id: 'ia-hr-bulk-notify', label: 'Compliance Notifications', role: 'hr_manager', module: 'HR', trigger: 'click', consequence: 'openModal', description: 'Open bulk notification composer for certification renewals.' },
    { id: 'ia-adm-provision-flow', label: 'Enterprise Provisioning', role: 'admin', module: 'SETUP', trigger: 'click', consequence: 'openModal', description: 'Multi-step wizard for new enterprise on-boarding.' },
    { id: 'ia-sm-recovery-full', label: 'Disaster Recovery', role: 'scrum_master', module: 'GOVERNANCE', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.AUTO_FIX, description: 'Emergency restoration of platform registry state.' },
    { id: 'ia-ops-dispatch-predictive', label: 'Launch Predictive Router', role: 'admin', module: 'OPERATIONS', trigger: 'click', consequence: 'openModal', description: 'Triggers AI-driven fleet dispatch and route optimization.' },
    { id: 'ia-adm-search-reindex', label: 'Commit Global Index', role: 'admin', module: 'ADMIN', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.SEARCH, description: 'Autonomous systemic audit of search relevance and indexing.' },
    { id: 'ia-sm-response-bot-audit', label: 'Execute Full Registry Sweep', role: 'scrum_master', module: 'GOVERNANCE', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.RESPONSE_BOT_SCAN, description: 'Automated Response Bot diagnostic of all system touchpoints.' },
    { id: 'ia-sm-audit-flush', label: 'Execute Retention Purge', role: 'scrum_master', module: 'GOVERNANCE', trigger: 'click', consequence: 'apiTrigger', description: 'Systemic forensic log rotation based on regulatory compliance windows.' },
    { id: 'ia-erp-stock-sync', label: 'Sync Global Stock', role: 'admin', module: 'ERP', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.ERP.STOCK_SYNC, description: 'Triggers a systemic synchronization of inventory levels across all branches.' },
    { id: 'ia-rpm-vitals-broadcast', label: 'Broadcast Vitals Heartbeat', role: 'system', module: 'TELEHEALTH', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.TELEHEALTH.VITAL_SIGN_PUSH, description: 'Simulates a real-time data push from integrated patient wearable devices.' },
    { id: 'ia-rcm-claim-batch', label: 'Execute Batch Adjudication', role: 'admin', module: 'FINANCE', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.RCM.REVENUE_SYNC, description: 'Autonomous systemic audit of all pending claims against insurance payment cycles.' },
    { id: 'ia-pharmacy-mar-audit', label: 'Audit MAR Compliance', role: 'clinical_manager', module: 'PHARMACY', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.PHARMACY.MAR_SYNC, description: 'Triggers a systemic audit of medication administration compliance for the current shift.' },
    { id: 'ia-rn-assess-submit', label: 'Submit Clinical Assessment', role: 'rn', module: 'CLINICAL', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.CLINICAL_ASSESS, description: 'Commits a formal clinical assessment to the client record.' },
    { id: 'ia-rn-careplan-save', label: 'Save Care Plan Review', role: 'rn', module: 'CLINICAL', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.CARE_PLAN_REVIEW('target'), description: 'Updates the clinical interventions and goals for a client care plan.' },
    { id: 'ia-rn-supervision-log', label: 'Commit Supervision Log', role: 'rn', module: 'CLINICAL', trigger: 'submit', consequence: 'apiTrigger', target: ApiRegistry.TENANCY.RN.RN_SUPERVISION, description: 'Records a formal supervision log for a field PSW.' }
];
