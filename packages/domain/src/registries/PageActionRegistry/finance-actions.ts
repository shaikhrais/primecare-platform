import type { PageActions } from '../01_I_page_action_registry';

/**
 * Finance-Specific Page Action Mappings
 * Maps page IDs to allowed financial orchestration buttons.
 */
export const FINANCE_ACTIONS: Record<string, PageActions> = {
    'financeDirectorDashboard': {
        primary: 'BTN_SEAL_LEDGER',
        actions: [
            'BTN_VOID_TRANSACTION',
            'BTN_EXPORT_TAX_REPORT'
        ]
    }
};
