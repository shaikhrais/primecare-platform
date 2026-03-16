import type { PageSections } from '../PageSectionRegistry';

export const ADMIN_SECTIONS: Record<string, PageSections> = {
    // ── D1: Admin Dashboard ──────────────────────────────────────────────────
    D1: {
        pageId: 'D1', label: 'Admin Dashboard',
        sections: [
            { id: 'D1.header', label: 'Page Header & Live Indicator', type: 'header', status: 'built', component: 'PageHeader', dataCy: 'page.title' },
            { id: 'D1.action-bar', label: 'Action Bar', type: 'action-bar', status: 'built', component: 'PageActionBar', dataCy: 'action-bar' },
            { id: 'D1.setup-banner', label: 'Business Model Score Banner', type: 'alert-panel', status: 'built', component: 'SetupBanner' },
            { id: 'D1.stats', label: 'Dashboard Statistics Cards', type: 'kpi-cards', status: 'built', component: 'DashboardStats', apiEndpoint: '/v1/admin/stats' },
            { id: 'D1.health-alerts', label: 'Health Alert Monitor', type: 'alert-panel', status: 'built', component: 'HealthAlerts' },
            { id: 'D1.charts', label: 'Interactive Charts', type: 'chart', status: 'built', component: 'DashboardCharts' },
            { id: 'D1.bi', label: 'Business Intelligence', type: 'custom', status: 'built', component: 'BusinessIntelligenceSection' },
            { id: 'D1.quick-actions', label: 'Quick Actions Grid', type: 'action-bar', status: 'built', component: 'QuickActions' },
            { id: 'D1.ops-status', label: 'Operational Status', type: 'stats', status: 'built', component: 'OperationalStatus' },
            { id: 'D1.create-visit', label: 'Create Visit Modal', type: 'modal', status: 'built', component: 'CreateVisitModal' },
            { id: 'D1.live-feed', label: 'Live Feed Indicator', type: 'custom', status: 'built', component: 'LiveFeedIndicator' },
        ],
    },
    // ── D2: Registry Summary ─────────────────────────────────────────────────
    D2: {
        pageId: 'D2', label: 'Registry Summary',
        sections: [
            { id: 'D2.header', label: 'Page Header', type: 'header', status: 'built', dataCy: 'page.title' },
            { id: 'D2.registry-stats', label: 'Registry Count Cards', type: 'kpi-cards', status: 'built' },
            { id: 'D2.page-type-breakdown', label: 'Page Type Breakdown', type: 'chart', status: 'built' },
            { id: 'D2.master-table', label: 'Master Page Table', type: 'table', status: 'built' },
        ],
    },
    // ── D3: Accounting Dashboard ─────────────────────────────────────────────
    D3: {
        pageId: 'D3', label: 'Accounting Dashboard',
        sections: [
            { id: 'D3.header', label: 'Finance Header', type: 'header', status: 'built' },
            { id: 'D3.ledger-summary', label: 'Ledger Summary KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D3.pl-chart', label: 'P&L Chart', type: 'chart', status: 'built' },
            { id: 'D3.journal-table', label: 'Journal Entries Table', type: 'table', status: 'built' },
            { id: 'D3.balance-sheet', label: 'Balance Sheet', type: 'chart', status: 'built' },
            { id: 'D3.cash-flow', label: 'Cash Flow Forecast', type: 'chart', status: 'built' },
        ],
    },
    // ── D5: AI Dashboard ─────────────────────────────────────────────────────
    D5: {
        pageId: 'D5', label: 'AI Dashboard',
        sections: [
            { id: 'D5.header', label: 'AI Header', type: 'header', status: 'built' },
            { id: 'D5.model-stats', label: 'Model Performance KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D5.inference-chart', label: 'Inference Volume Chart', type: 'chart', status: 'built' },
            { id: 'D5.nav-cards', label: 'AI Module Navigation Cards', type: 'custom', status: 'built' },
        ],
    },
    // ── D6: Cron Dashboard ───────────────────────────────────────────────────
    D6: {
        pageId: 'D6', label: 'Cron Dashboard',
        sections: [
            { id: 'D6.header', label: 'Cron Header', type: 'header', status: 'built' },
            { id: 'D6.job-stats', label: 'Job Status KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D6.job-list', label: 'Cron Job List', type: 'table', status: 'built' },
            { id: 'D6.run-history', label: 'Run History Chart', type: 'chart', status: 'built' },
        ],
    },
    // ── Admin Lists ──────────────────────────────────────────────────────────
    L1: {
        pageId: 'L1', label: 'Schedule',
        sections: [
            { id: 'L1.header', label: 'Schedule Header', type: 'header', status: 'built' },
            { id: 'L1.calendar', label: 'Schedule Calendar', type: 'calendar', status: 'built' },
            { id: 'L1.shift-list', label: 'Shift List Table', type: 'table', status: 'built' },
            { id: 'L1.filters', label: 'Filter Panel', type: 'action-bar', status: 'built' },
        ],
    },
    L2: {
        pageId: 'L2', label: 'Incident List',
        sections: [
            { id: 'L2.header', label: 'Incident Header', type: 'header', status: 'built' },
            { id: 'L2.table', label: 'Incident Table', type: 'table', status: 'built' },
            { id: 'L2.filters', label: 'Severity Filters', type: 'action-bar', status: 'built' },
        ],
    },
    L3: {
        pageId: 'L3', label: 'Lead List',
        sections: [
            { id: 'L3.header', label: 'Lead Header', type: 'header', status: 'built' },
            { id: 'L3.pipeline', label: 'Pipeline Summary', type: 'kpi-cards', status: 'built' },
            { id: 'L3.table', label: 'Lead Table', type: 'table', status: 'built' },
        ],
    },
    L4: {
        pageId: 'L4', label: 'Timesheets',
        sections: [
            { id: 'L4.header', label: 'Timesheet Header', type: 'header', status: 'built' },
            { id: 'L4.stats', label: 'Approval Stats', type: 'kpi-cards', status: 'built' },
            { id: 'L4.table', label: 'Timesheet Table', type: 'table', status: 'built' },
            { id: 'L4.detail-modal', label: 'Timesheet Detail Modal', type: 'modal', status: 'built', component: 'TimesheetDetailModal' },
        ],
    },
    // ── Admin Hubs ───────────────────────────────────────────────────────────
    H1: {
        pageId: 'H1', label: 'Telehealth Center',
        sections: [
            { id: 'H1.header', label: 'Telehealth Header', type: 'header', status: 'built' },
            { id: 'H1.session-stats', label: 'Session KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H1.active-sessions', label: 'Active Sessions', type: 'list', status: 'built' },
            { id: 'H1.alerts', label: 'RPM Alerts', type: 'alert-panel', status: 'built' },
        ],
    },
    H2: {
        pageId: 'H2', label: 'Pharmacy Hub',
        sections: [
            { id: 'H2.header', label: 'Pharmacy Header', type: 'header', status: 'built' },
            { id: 'H2.mar-summary', label: 'MAR Summary', type: 'kpi-cards', status: 'built' },
            { id: 'H2.prescriptions', label: 'Active Prescriptions', type: 'table', status: 'built' },
        ],
    },
    // ── Admin Tools & Security ───────────────────────────────────────────────
    T10: {
        pageId: 'T10', label: 'Security Governance',
        sections: [
            { id: 'T10.header', label: 'Security Header', type: 'header', status: 'built' },
            { id: 'T10.threat-stats', label: 'Threat Summary KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'T10.nav-cards', label: 'Security Module Nav', type: 'custom', status: 'built' },
            { id: 'T10.activity-feed', label: 'Security Activity Feed', type: 'feed', status: 'built' },
        ],
    },
    // ── Admin Forms ──────────────────────────────────────────────────────────
    F6: {
        pageId: 'F6', label: 'Client Admission',
        sections: [
            { id: 'F6.header', label: 'Admission Header', type: 'header', status: 'built' },
            { id: 'F6.form', label: 'Admission Form', type: 'form', status: 'built' },
            { id: 'F6.documents', label: 'Document Upload', type: 'custom', status: 'built' },
        ],
    },
    // ── Registries ───────────────────────────────────────────────────────────
    G1: {
        pageId: 'G1', label: 'Form Registry',
        sections: [
            { id: 'G1.header', label: 'Registry Header', type: 'header', status: 'built' },
            { id: 'G1.stats', label: 'Form Count Stats', type: 'kpi-cards', status: 'built' },
            { id: 'G1.table', label: 'Form Registry Table', type: 'table', status: 'built' },
        ],
    },
    G2: {
        pageId: 'G2', label: 'Page Registry',
        sections: [
            { id: 'G2.header', label: 'Registry Header', type: 'header', status: 'built' },
            { id: 'G2.stats', label: 'Page Count Stats', type: 'kpi-cards', status: 'built' },
            { id: 'G2.table', label: 'Page Registry Table', type: 'table', status: 'built' },
            { id: 'G2.type-chart', label: 'Page Type Distribution', type: 'chart', status: 'built' },
        ],
    },
};
