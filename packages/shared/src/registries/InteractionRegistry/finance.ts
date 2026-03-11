import { RouteRegistry } from '../../apps/web-admin/RouteRegistry';
import { ApiRegistry } from '../ApiRegistry';
import { InteractionDef } from './types';

export const FINANCE_DOMAINS = {
    FINANCE: {
        HUB: {
            PL_EXPORT: {
                id: 'fin-pl-export',
                label: 'P&L Export',
                type: 'button',
                module: 'FINANCE',
                purpose: 'Export regional profit and loss data for external analysis.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.FINANCE
            },
            AUDIT_REQUEST: {
                id: 'fin-audit-req',
                label: 'Audit Request',
                type: 'button',
                module: 'FINANCE',
                purpose: 'Initiate a formal financial audit for the current branch.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.FINANCE
            }
        }
    },
    FINANCE_DIRECTOR: {
        DASHBOARD: {
            REFRESH: {
                id: 'fd-dashboard-refresh',
                label: 'Refresh Ledger',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Trigger a real-time ledger synchronization and P&L recalculation.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT
            },
            GENERATE_AUDIT: {
                id: 'fd-generate-audit',
                label: 'Generate Audit',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Produce a GAAP-compliant forensic audit trail of all ledger entries.',
                permission: 'FINANCIAL_ADMIN'
            },
            RECONCILE: {
                id: 'fd-reconcile-action',
                label: 'Reconcile Now',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Execute the fuzzy matching engine to reconcile bank transactions with ledger entries.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.RECONCILE
            },
            AUTO_RECONCILE: {
                id: 'fd-auto-reconcile-action',
                label: 'Auto-Match Transactions',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Trigger the fuzzy matching engine to automatically link bank feeds with ledger entries.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.AUTO_RECONCILE
            },
            VIEW_FORECAST: {
                id: 'fd-view-forecast',
                label: 'View Cash Projections',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Access predictive analytics for liquidity and runway monitoring.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.FORECAST
            },
            VIEW_TAX_HUB: {
                id: 'fd-view-tax-hub',
                label: 'Tax Compliance Hub',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Manage HST/GST filings and remittances.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.TAX_FILING
            },
            RECORD_TAX_REMITTANCE: {
                id: 'fd-record-tax-remittance',
                label: 'Record Tax Remittance',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Record a tax payment to the revenue agency in the ledger.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.TAX_REMITTANCE
            }
        }
    }
};
