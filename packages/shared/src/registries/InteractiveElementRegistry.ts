import { RouteRegistry } from '../apps/web-admin/RouteRegistry';

export type InteractiveCategory = 'button' | 'link' | 'action' | 'navigation';

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
 * response_bot_registry: Centralized operational store for all interactive touchpoints.
 * This powers the programmatic integrity sweep for 100% platform coverage.
 */
export const InteractiveElementRegistry: InteractiveElement[] = [
    // --- ADMIN MODULE ---
    { id: 'admin-user-create', category: 'action', label: 'Invite User', path: '/v1/admin/users', role: 'admin', module: 'ADMIN', checkType: 'API' },
    { id: 'admin-search-global', category: 'action', label: 'Deep Search', path: '/v1/admin/search', role: 'admin', module: 'ADMIN', checkType: 'API' },

    // --- COORDINATOR MODULE ---
    { id: 'coord-dispatch-sos', category: 'action', label: 'SOS Respond', path: '/v1/manager/coordinator/sos-dispatch', role: 'coordinator', module: 'OPERATIONS', checkType: 'API' },
    { id: 'coord-coverage-alert', category: 'navigation', label: 'View Coverage', path: RouteRegistry.MANAGER.COORDINATOR, role: 'coordinator', module: 'OPERATIONS', checkType: 'ROUTE' },

    // --- RN CLINICAL ---
    { id: 'rn-care-plan-save', category: 'submit', label: 'Save Care Plan', path: '/v1/rn/clinical/care-plans', role: 'rn', module: 'CLINICAL', checkType: 'API' } as any,
    { id: 'rn-audit-verify', category: 'action', label: 'Verify Entry', path: '/v1/rn/clinical/audit/entries/verify', role: 'rn', module: 'CLINICAL', checkType: 'API' },

    // --- MARKETING ---
    { id: 'mkt-campaign-start', category: 'action', label: 'New Campaign', path: RouteRegistry.MANAGER.MARKETING, role: 'marketing_manager', module: 'MARKETING', checkType: 'ROUTE' },

    // --- HR & RECRUITMENT ---
    { id: 'hr-candidate-offer', category: 'action', label: 'Send Offer', path: RouteRegistry.MANAGER.RECRUITING, role: 'recruiting_manager', module: 'HR', checkType: 'ROUTE' },

    // --- FINANCE ---
    { id: 'fin-pl-drilldown', category: 'navigation', label: 'Branch P&L', path: RouteRegistry.MANAGER.FINANCE, role: 'finance_manager', module: 'FINANCE', checkType: 'ROUTE' }
];
