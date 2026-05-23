// Governance - Category: service | Purpose: Specialized Financial & Ledger Buttons for the PrimeCare Platform. These buttons trigger core financial actions via t...
import type { ButtonDef } from '../button_registry';

/**
 * Specialized Financial & Ledger Buttons for the PrimeCare Platform.
 * These buttons trigger core financial actions via the Finance Director dashboard.
 */
export const FINANCE_BUTTONS: ButtonDef[] = [
    {
        id: 'BTN_VOID_TRANSACTION',
        label: 'Void Transaction',
        role: 'finance_director',
        module: 'FINANCE',
        type: 'danger',
        action: 'VOID',
        description: 'Reverses the selected transaction and creates an offsetting ledger entry.',
        apiPath: '/v1/finance/void',
    },
    {
        id: 'BTN_SEAL_LEDGER',
        label: 'Seal Period',
        role: 'finance_director',
        module: 'FINANCE',
        type: 'primary',
        action: 'SEAL',
        description: 'Locks all transactions in the current period to prevent further modification.',
        apiPath: '/v1/finance/seal',
    },
    {
        id: 'BTN_EXPORT_TAX_REPORT',
        label: 'Export Tax Report',
        role: 'finance_director',
        module: 'FINANCE',
        type: 'secondary',
        action: 'EXPORT',
        description: 'Generates a detailed HST/GST filing report for the selected period.',
        apiPath: '/v1/finance/tax/report',
    }
];
