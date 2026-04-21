import { FormEntry } from '../01_I_form_registry';

/**
 * Finance-Specific Form Definitions
 */
export const FINANCE_FORMS: FormEntry[] = [
    {
        id: 'ledger_entry_create',
        label: 'New Ledger Entry',
        category: 'finance',
        fields: [
            { name: 'date', type: 'date', label: 'Transaction Date', required: true },
            { name: 'account_id', type: 'select', label: 'Account', required: true },
            { name: 'amount', type: 'number', label: 'Amount', required: true },
            { name: 'type', type: 'select', label: 'Entry Type', required: true },
            { name: 'description', type: 'text', label: 'Description', required: false }
        ]
    },
    {
        id: 'tax_report_generate',
        label: 'Generate Tax Report',
        category: 'finance',
        fields: [
            { name: 'period_start', type: 'date', label: 'Start Date', required: true },
            { name: 'period_end', type: 'date', label: 'End Date', required: true },
            { name: 'tax_type', type: 'select', label: 'Tax Type', required: true }
        ]
    },
    {
        id: 'reconciliation_run',
        label: 'Run Bank Reconciliation',
        category: 'finance',
        fields: [
            { name: 'bank_account', type: 'select', label: 'Bank Account', required: true },
            { name: 'statement_date', type: 'date', label: 'Statement Date', required: true },
            { name: 'closing_balance', type: 'number', label: 'Closing Balance', required: true }
        ]
    },
    {
        id: 'financeDirectorDashboard',
        label: 'Finance Director Oversight',
        category: 'dashboard',
        fields: []
    }
];
