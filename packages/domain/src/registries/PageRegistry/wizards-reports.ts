import type { WizardEntry, ReportEntry } from '../01_I_page_registry';

export const WizardRegistry: WizardEntry[] = [
    { id: 'admin.setup-wizard', label: 'Business Setup Wizard', route: '/platform/admin/setup-wizard', owner: 'admin', steps: ['Business Info', 'Services', 'Users', 'Settings'] },
    { id: 'admin.staff-onboarding', label: 'Staff Onboarding Wizard', route: '/platform/admin/wizards/staff-onboarding', owner: 'admin', steps: ['Personal Info', 'Role', 'Certifications', 'Review'], formRegistryId: 'admin.wizard.staff-onboarding' },
    { id: 'admin.care-plan', label: 'Care Plan Wizard', route: '/platform/admin/wizards/care-plan', owner: 'admin', steps: ['Client', 'Service', 'Goals', 'Schedule'], formRegistryId: 'admin.wizard.care-plan' },
    { id: 'admin.revenue', label: 'Revenue Wizard', route: '/platform/admin/wizards/revenue', owner: 'admin', steps: ['Sources', 'Projections', 'Review'] },
    { id: 'admin.business-model', label: 'Business Model Wizard', route: '/platform/admin/wizards/business-strategy', owner: 'admin', steps: ['Strategy', 'Markets', 'Pricing', 'Review'] },
];

export const ReportRegistry: ReportEntry[] = [
    { id: 'admin.reports', label: 'Report Center', route: '/platform/admin/reports', owner: 'admin', fetchEndpoint: '/v1/admin/reports/export', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.report-export', label: 'Export Page', route: '/platform/admin/reports/export', owner: 'admin', fetchEndpoint: '/v1/admin/reports/export', exportFormats: ['pdf', 'csv', 'xlsx'] },
    { id: 'admin.trading', label: 'Trading Account', route: '/platform/admin/finance/trading', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/trading-account', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.profit-loss', label: 'Profit & Loss', route: '/platform/admin/finance/p-and-l', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/p-and-l', exportFormats: ['pdf', 'xlsx'] },
    { id: 'admin.balance-sheet', label: 'Balance Sheet', route: '/platform/admin/finance/balance-sheet', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reports/balance-sheet', exportFormats: ['pdf', 'xlsx'] },
    { id: 'admin.reconciliation', label: 'Financial Reconciliation', route: '/platform/admin/finance/reconciliation', owner: 'admin', fetchEndpoint: '/v1/admin/financial/reconcile', exportFormats: ['csv'] },
    { id: 'admin.evv-export', label: 'EVV Export', route: '/platform/admin/evv/export', owner: 'admin', fetchEndpoint: '/v1/admin/evv/export', exportFormats: ['csv', 'xlsx'] },
    { id: 'admin.audit-download', label: 'Audit Download', route: '/platform/admin/audit-export', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/download', exportFormats: ['pdf', 'csv'] },
    { id: 'admin.compliance-export', label: 'Compliance Export', route: '/platform/admin/audit-export/compliance', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/compliance-home', exportFormats: ['pdf'] },
    { id: 'admin.regulatory', label: 'Regulatory Report', route: '/platform/admin/audit-export/regulatory', owner: 'admin', fetchEndpoint: '/v1/admin/audit-export/regulatory-report', exportFormats: ['pdf'] },
    { id: 'admin.referral-analytics', label: 'Referral Analytics', route: '/platform/admin/referrals/analytics', owner: 'admin', fetchEndpoint: '/v1/admin/referrals/analytics', exportFormats: ['csv'] },
    { id: 'admin.claims-era', label: 'Claims ERA', route: '/platform/admin/claims/era', owner: 'admin', fetchEndpoint: '/v1/admin/claims/era', exportFormats: ['csv'] },
];
