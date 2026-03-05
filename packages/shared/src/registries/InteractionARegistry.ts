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
    { id: 'ia-sm-response-bot-audit', label: 'Execute Full Registry Sweep', role: 'scrum_master', module: 'GOVERNANCE', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.SCRUM_MASTER.RESPONSE_BOT_SCAN, description: 'Automated Response Bot diagnostic of all system touchpoints.' },
    { id: 'ia-erp-stock-sync', label: 'Sync Global Stock', role: 'admin', module: 'ERP', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.ERP.STOCK_SYNC, description: 'Triggers a systemic synchronization of inventory levels across all branches.' },
    { id: 'ia-rpm-vitals-broadcast', label: 'Broadcast Vitals Heartbeat', role: 'system', module: 'TELEHEALTH', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.TELEHEALTH.VITAL_SIGN_PUSH, description: 'Simulates a real-time data push from integrated patient wearable devices.' },
    { id: 'ia-rcm-claim-batch', label: 'Execute Batch Adjudication', role: 'admin', module: 'FINANCE', trigger: 'click', consequence: 'apiTrigger', target: ApiRegistry.ADMIN.RCM.REVENUE_SYNC, description: 'Autonomous systemic audit of all pending claims against insurance payment cycles.' }
];
