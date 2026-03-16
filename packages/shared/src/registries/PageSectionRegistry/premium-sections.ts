import type { PageSections } from '../PageSectionRegistry';

export const PREMIUM_SECTIONS: Record<string, PageSections> = {
    // ── H25: Gamification Hub ────────────────────────────────────────────────
    H25: {
        pageId: 'H25', label: 'Gamification Hub',
        sections: [
            { id: 'H25.header', label: 'Hub Header', type: 'header', status: 'built', dataCy: 'page.title' },
            { id: 'H25.stats', label: 'Engagement KPIs (Active PSWs, Avg Score, Badges, Challenges, Retention)', type: 'kpi-cards', status: 'mocked', description: 'Hardcoded mock stats' },
            { id: 'H25.tabs', label: 'Tab Navigation (Leaderboard, Badges, Challenges, Rewards)', type: 'tabs', status: 'built' },
            { id: 'H25.leaderboard', label: 'PSW Leaderboard Table', type: 'table', status: 'mocked', description: '8 mock entries, not API-connected' },
            { id: 'H25.badges', label: 'Badge Grid (8 badges)', type: 'custom', status: 'mocked', description: 'Static badge definitions' },
            { id: 'H25.challenges', label: 'Active Challenges with Progress Bars', type: 'list', status: 'mocked', description: '3 mock challenges' },
            { id: 'H25.rewards', label: 'Reward Redemption Catalog', type: 'custom', status: 'mocked', description: '6 mock rewards' },
        ],
    },
    // ── H26: IoT Monitoring ──────────────────────────────────────────────────
    H26: {
        pageId: 'H26', label: 'IoT Monitoring',
        sections: [
            { id: 'H26.header', label: 'IoT Header', type: 'header', status: 'built' },
            { id: 'H26.device-stats', label: 'Device Status KPIs', type: 'kpi-cards', status: 'mocked' },
            { id: 'H26.event-feed', label: 'Real-time Event Feed', type: 'feed', status: 'mocked', apiEndpoint: '/v1/manager/iot/events' },
            { id: 'H26.device-table', label: 'Device Registry Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/manager/iot/devices' },
            { id: 'H26.alert-panel', label: 'IoT Alert Panel', type: 'alert-panel', status: 'mocked', apiEndpoint: '/v1/manager/iot/alerts' },
        ],
    },
    // ── H27: Document Signing Center ─────────────────────────────────────────
    H27: {
        pageId: 'H27', label: 'Document Signing Center',
        sections: [
            { id: 'H27.header', label: 'Signing Header', type: 'header', status: 'built' },
            { id: 'H27.stats', label: 'Signature KPIs (Pending, Completed, Expired)', type: 'kpi-cards', status: 'mocked' },
            { id: 'H27.pending-list', label: 'Pending Signatures List', type: 'list', status: 'mocked', apiEndpoint: '/v1/manager/documents/signing/requests' },
            { id: 'H27.completed', label: 'Completed Documents Table', type: 'table', status: 'mocked' },
            { id: 'H27.upload', label: 'Document Upload Zone', type: 'form', status: 'mocked' },
        ],
    },
    // ── H28: SMS Hub ─────────────────────────────────────────────────────────
    H28: {
        pageId: 'H28', label: 'SMS Hub',
        sections: [
            { id: 'H28.header', label: 'SMS Header', type: 'header', status: 'built' },
            { id: 'H28.stats', label: 'Message Volume KPIs', type: 'kpi-cards', status: 'mocked' },
            { id: 'H28.campaign-list', label: 'Campaign List', type: 'list', status: 'mocked', apiEndpoint: '/v1/manager/communications/sms/campaigns' },
            { id: 'H28.compose', label: 'Compose SMS Form', type: 'form', status: 'mocked' },
            { id: 'H28.logs', label: 'Communication Logs Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/manager/communications/sms/logs' },
        ],
    },
    // ── H29: Training Academy ────────────────────────────────────────────────
    H29: {
        pageId: 'H29', label: 'Training Academy',
        sections: [
            { id: 'H29.header', label: 'Academy Header', type: 'header', status: 'built' },
            { id: 'H29.stats', label: 'Training KPIs (Enrolled, Completed, Compliance)', type: 'kpi-cards', status: 'mocked' },
            { id: 'H29.module-grid', label: 'Training Module Grid', type: 'custom', status: 'mocked', apiEndpoint: '/v1/manager/training/academy/modules' },
            { id: 'H29.progress', label: 'Staff Progress Tracker', type: 'table', status: 'mocked', apiEndpoint: '/v1/manager/training/academy/progress' },
            { id: 'H29.certifications', label: 'Certification Status', type: 'list', status: 'mocked' },
        ],
    },
    // ── L23: Performance Reviews ─────────────────────────────────────────────
    L23: {
        pageId: 'L23', label: 'Performance Reviews',
        sections: [
            { id: 'L23.header', label: 'Reviews Header', type: 'header', status: 'built' },
            { id: 'L23.stats', label: 'Review Cycle KPIs', type: 'kpi-cards', status: 'mocked' },
            { id: 'L23.review-table', label: 'Staff Reviews Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/manager/hr/performance-reviews' },
            { id: 'L23.goal-tracker', label: 'Goal & KPI Tracker', type: 'chart', status: 'mocked' },
            { id: 'L23.review-form', label: 'Review Entry Form', type: 'form', status: 'planned' },
        ],
    },
    // ── G3: PSW User Guide ───────────────────────────────────────────────────
    G3: {
        pageId: 'G3', label: 'PSW User Guide',
        sections: [
            { id: 'G3.header', label: 'Guide Header', type: 'header', status: 'built' },
            { id: 'G3.toc', label: 'Table of Contents', type: 'custom', status: 'built' },
            { id: 'G3.getting-started', label: 'Getting Started Section', type: 'custom', status: 'built' },
            { id: 'G3.daily-workflow', label: 'Daily Workflow Guide', type: 'custom', status: 'built' },
            { id: 'G3.features', label: 'Feature Walkthroughs', type: 'custom', status: 'built' },
            { id: 'G3.screenshots', label: 'Screenshot Gallery', type: 'custom', status: 'built' },
            { id: 'G3.faq', label: 'FAQ Section', type: 'custom', status: 'built' },
        ],
    },
    // ── D20: AI Command Center ───────────────────────────────────────────────
    D20: {
        pageId: 'D20', label: 'AI Command Center',
        sections: [
            { id: 'D20.header', label: 'Command Header', type: 'header', status: 'built' },
            { id: 'D20.model-stats', label: 'Model Performance KPIs', type: 'kpi-cards', status: 'mocked', apiEndpoint: '/v1/admin/ai-command' },
            { id: 'D20.model-table', label: 'Active Models Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/admin/ai-command/models' },
            { id: 'D20.inference-chart', label: 'Inference Volume Chart', type: 'chart', status: 'mocked' },
            { id: 'D20.config', label: 'Model Configuration Panel', type: 'form', status: 'planned', apiEndpoint: '/v1/admin/ai-command/config' },
        ],
    },
    // ── S8: Multi-Currency Settings ──────────────────────────────────────────
    S8: {
        pageId: 'S8', label: 'Multi-Currency Settings',
        sections: [
            { id: 'S8.header', label: 'Settings Header', type: 'header', status: 'built' },
            { id: 'S8.base-currency', label: 'Base Currency Selector', type: 'form', status: 'mocked' },
            { id: 'S8.exchange-rates', label: 'Exchange Rate Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/admin/finance/multi-currency/rates' },
            { id: 'S8.conversion-log', label: 'Conversion History Log', type: 'list', status: 'planned' },
        ],
    },
    // ── L24: Audit Trail Viewer ──────────────────────────────────────────────
    L24: {
        pageId: 'L24', label: 'Audit Trail Viewer',
        sections: [
            { id: 'L24.header', label: 'Audit Header', type: 'header', status: 'built' },
            { id: 'L24.filters', label: 'Advanced Filter Bar', type: 'action-bar', status: 'mocked' },
            { id: 'L24.trail-table', label: 'Audit Event Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/admin/audit-trail' },
            { id: 'L24.detail-panel', label: 'Event Detail Panel', type: 'custom', status: 'mocked' },
            { id: 'L24.export', label: 'Export Controls', type: 'action-bar', status: 'mocked' },
        ],
    },
    // ── H30: Franchise Management ────────────────────────────────────────────
    H30: {
        pageId: 'H30', label: 'Franchise Management',
        sections: [
            { id: 'H30.header', label: 'Franchise Header', type: 'header', status: 'built' },
            { id: 'H30.network-stats', label: 'Network KPIs (Franchises, Revenue, Growth)', type: 'kpi-cards', status: 'mocked', apiEndpoint: '/v1/admin/franchise' },
            { id: 'H30.franchise-table', label: 'Franchise Directory Table', type: 'table', status: 'mocked', apiEndpoint: '/v1/admin/franchise' },
            { id: 'H30.performance', label: 'Performance Comparison Chart', type: 'chart', status: 'mocked', apiEndpoint: '/v1/admin/franchise/performance' },
            { id: 'H30.create-form', label: 'New Franchise Form', type: 'form', status: 'planned' },
        ],
    },
    // ── L25: Supply Chain Management ─────────────────────────────────────────
    L25: {
        pageId: 'L25', label: 'Supply Chain Management',
        sections: [
            { id: 'L25.header', label: 'Supply Chain Header', type: 'header', status: 'built' },
            { id: 'L25.stats', label: 'Inventory & PO KPIs', type: 'kpi-cards', status: 'mocked' },
            { id: 'L25.vendor-table', label: 'Vendor Directory', type: 'table', status: 'mocked', apiEndpoint: '/v1/admin/supply-chain/vendors' },
            { id: 'L25.po-list', label: 'Purchase Order List', type: 'list', status: 'mocked', apiEndpoint: '/v1/admin/supply-chain/purchase-orders' },
            { id: 'L25.inventory', label: 'Inventory Levels', type: 'chart', status: 'mocked' },
        ],
    },
};
