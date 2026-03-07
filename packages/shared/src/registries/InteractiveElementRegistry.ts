import { RouteRegistry } from '../apps/web-admin/RouteRegistry';
import { ContentRegistry } from './ContentRegistry';

export type InteractiveCategory = 'button' | 'link' | 'submit' | 'tab' | 'navigation' | 'action';

export interface InteractiveElement {
    id: string;
    category: InteractiveCategory;
    label: string;
    path: string;
    role: string;
    module: string;
    checkType: 'ROUTE' | 'API' | 'EXTERNAL';
    expectedStatus?: number;
}

/**
 * InteractiveElementRegistry: Centralized operational store for all primary platform touchpoints.
 * Powers the "Response Bot" programmatic integrity sweep.
 */
export const InteractiveElementRegistry: InteractiveElement[] = [
    // --- GOVERNANCE (ADMIN & SCRUM MASTER) ---
    { id: 'admin-user-invite', category: 'action', label: 'Invite User', path: '/v1/admin/users', role: 'admin', module: 'ADMIN', checkType: 'API' },
    { id: 'admin-settings-biz', category: 'navigation', label: ContentRegistry.BUSINESS_STATUS.DOMAINS.STRATEGY, path: RouteRegistry.ADMIN.SETTINGS, role: 'admin', module: 'ADMIN', checkType: 'ROUTE' },
    { id: 'sm-auto-fix', category: 'action', label: 'Start Auto-Fix', path: '/v1/admin/scrum/auto-fix', role: 'scrum_master', module: 'SCRUM_MASTER', checkType: 'API' },
    { id: 'sm-registry-sweep', category: 'action', label: 'Registry Sweep', path: '/v1/admin/scrum/env-audit', role: 'scrum_master', module: 'SCRUM_MASTER', checkType: 'API' },

    // --- OPERATIONS (MANAGER & COORDINATOR) ---
    { id: 'mgr-perf-rank', category: 'navigation', label: 'Performance Ranker', path: RouteRegistry.MANAGER.PERFORMANCE, role: 'manager', module: 'MANAGER', checkType: 'ROUTE' },
    { id: 'mgr-payroll-audit', category: 'action', label: 'Audit Payroll', path: '/v1/manager/finance/payroll-audit', role: 'manager', module: 'MANAGER', checkType: 'API' },
    { id: 'coord-sos-dispatch', category: 'action', label: 'SOS Dispatch', path: '/v1/manager/coordinator/sos-dispatch', role: 'coordinator', module: 'OPERATIONS', checkType: 'API' },
    { id: 'coord-live-pulse', category: 'navigation', label: 'Live Monitoring', path: RouteRegistry.COORDINATOR.DASHBOARD, role: 'coordinator', module: 'OPERATIONS', checkType: 'ROUTE' },

    // --- CLINICAL (RN & PSW) ---
    { id: 'rn-care-plan-rev', category: 'action', label: 'Review Care Plan', path: '/v1/rn/clinical/care-plans/review', role: 'rn', module: 'CLINICAL', checkType: 'API' },
    { id: 'rn-entry-verify', category: 'action', label: 'Verify Entry', path: '/v1/rn/clinical/audit/entries/verify', role: 'rn', module: 'CLINICAL', checkType: 'API' },
    { id: 'psw-check-in', category: 'action', label: 'Check-in', path: '/v1/psw/schedule/visits/check-in', role: 'psw', module: 'CARE_DELIVERY', checkType: 'API' },
    { id: 'psw-earnings-req', category: 'action', label: 'Req Payout', path: '/v1/psw/schedule/payouts/request', role: 'psw', module: 'CARE_DELIVERY', checkType: 'API' },

    // --- STAFF (BRANCH OPS) ---
    { id: 'staff-task-create', category: 'action', label: 'New Task', path: '/v1/staff/tasks/grid', role: 'staff', module: 'STAFF', checkType: 'API' },
    { id: 'staff-incident-log', category: 'action', label: 'Log Incident', path: '/v1/staff/ops/incidents/submit', role: 'staff', module: 'STAFF', checkType: 'API' },

    // --- CLIENT (ENGAGEMENT) ---
    { id: 'client-book-req', category: 'action', label: 'Request Booking', path: '/v1/client/bookings', role: 'client', module: 'CLIENT', checkType: 'API' },
    { id: 'client-nursing-chat', category: 'navigation', label: 'Nursing Chat', path: RouteRegistry.CLIENT.SUPPORT, role: 'client', module: 'CLIENT', checkType: 'ROUTE' },

    // --- SPECIALIZED MANAGEMENT ---
    { id: 'mkt-campaign-launch', category: 'action', label: 'Launch Campaign', path: '/v1/admin/marketing/campaigns', role: 'marketing_manager', module: 'MARKETING', checkType: 'API' },
    { id: 'hr-recruitment-post', category: 'action', label: 'Post Job', path: RouteRegistry.MANAGER.RECRUITING, role: 'recruiting_manager', module: 'HR', checkType: 'ROUTE' },
    { id: 'fin-regional-pl', category: 'navigation', label: 'Regional P&L', path: RouteRegistry.MANAGER.FINANCE, role: 'finance_manager', module: 'FINANCE', checkType: 'ROUTE' },
    { id: 'qa-safety-sweep', category: 'action', label: 'QA Sweep', path: RouteRegistry.MANAGER.CLINICAL, role: 'clinical_manager', module: 'QA', checkType: 'ROUTE' }
];
