import type { PageSections } from '../page_section_registry';

export const PREMIUM_SECTIONS: Record<string, PageSections> = {
    // ── H25: Gamification Hub ────────────────────────────────────────────────
    H25: {
        pageId: 'H25', label: 'Gamification Hub',
        sections: [
            { id: 'H25.header', label: 'Hub Header', type: 'header', status: 'built', dataCy: 'page.title' },
            { id: 'H25.stats', label: 'Engagement KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H25.tabs', label: 'Tab Navigation (Leaderboard, Badges, Challenges, Rewards)', type: 'tabs', status: 'built' },
        ],
    },
    // ── H26: IoT Monitoring ──────────────────────────────────────────────────
    H26: {
        pageId: 'H26', label: 'IoT Monitoring',
        sections: [
            { id: 'H26.header', label: 'IoT Header', type: 'header', status: 'built' },
            { id: 'H26.device-stats', label: 'Device Status KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H26.device-table', label: 'Device Registry Table', type: 'table', status: 'built' },
            { id: 'H26.alert-panel', label: 'IoT Alert Panel', type: 'alert-panel', status: 'built' },
        ],
    },
    // ── H27: Document Signing Center ─────────────────────────────────────────
    H27: {
        pageId: 'H27', label: 'Document Signing Center',
        sections: [
            { id: 'H27.header', label: 'Signing Header', type: 'header', status: 'built' },
            { id: 'H27.stats', label: 'Signature KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H27.pending-list', label: 'Documents Table', type: 'table', status: 'built' },
            { id: 'H27.completed', label: 'Template Grid', type: 'custom', status: 'built' },
        ],
    },
    // ── H28: SMS Hub ─────────────────────────────────────────────────────────
    H28: {
        pageId: 'H28', label: 'SMS Hub',
        sections: [
            { id: 'H28.header', label: 'SMS Header', type: 'header', status: 'built' },
            { id: 'H28.stats', label: 'Message Volume KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H28.campaign-list', label: 'Campaigns / Templates Tabs', type: 'tabs', status: 'built' },
        ],
    },
    // ── H29: Training Academy ────────────────────────────────────────────────
    H29: {
        pageId: 'H29', label: 'Training Academy',
        sections: [
            { id: 'H29.header', label: 'Academy Header', type: 'header', status: 'built' },
            { id: 'H29.stats', label: 'Training KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H29.module-grid', label: 'Courses / Certifications Tabs', type: 'tabs', status: 'built' },
        ],
    },
    // ── L23: Performance Reviews ─────────────────────────────────────────────
    L23: {
        pageId: 'L23', label: 'Performance Reviews',
        sections: [
            { id: 'L23.header', label: 'Reviews Header', type: 'header', status: 'built' },
            { id: 'L23.stats', label: 'Review Cycle KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'L23.review-table', label: 'Staff Reviews Table', type: 'table', status: 'built' },
        ],
    },
    // ── G3: PSW User Guide ───────────────────────────────────────────────────
    G3: {
        pageId: 'G3', label: 'PSW User Guide',
        sections: [
            { id: 'G3.header', label: 'Guide Header', type: 'header', status: 'built' },
            { id: 'G3.toc', label: 'Table of Contents', type: 'custom', status: 'built' },
            { id: 'G3.getting-started', label: 'Getting Started', type: 'custom', status: 'built' },
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
            { id: 'D20.ai-stats', label: 'AI Performance KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D20.recommendations', label: 'Recommendations / Models / Insights Tabs', type: 'tabs', status: 'built' },
        ],
    },
    // ── S8: Multi-Currency Settings ──────────────────────────────────────────
    S8: {
        pageId: 'S8', label: 'Multi-Currency Settings',
        sections: [
            { id: 'S8.header', label: 'Settings Header', type: 'header', status: 'built' },
            { id: 'S8.stats', label: 'Currency KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'S8.rate-table', label: 'Exchange Rate Table', type: 'table', status: 'built' },
            { id: 'S8.fx-history', label: 'FX Transaction History', type: 'table', status: 'built' },
        ],
    },
    // ── L24: Audit Trail Viewer ──────────────────────────────────────────────
    L24: {
        pageId: 'L24', label: 'Audit Trail Viewer',
        sections: [
            { id: 'L24.header', label: 'Audit Header', type: 'header', status: 'built' },
            { id: 'L24.stats', label: 'Audit Event KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'L24.audit-table', label: 'Audit Event Table', type: 'table', status: 'built' },
        ],
    },
    // ── H30: Franchise Management ────────────────────────────────────────────
    H30: {
        pageId: 'H30', label: 'Franchise Management',
        sections: [
            { id: 'H30.header', label: 'Franchise Header', type: 'header', status: 'built' },
            { id: 'H30.overview-stats', label: 'Network KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H30.location-table', label: 'Locations / Expansion Tabs', type: 'tabs', status: 'built' },
        ],
    },
    // ── L25: Supply Chain Management ─────────────────────────────────────────
    L25: {
        pageId: 'L25', label: 'Supply Chain Management',
        sections: [
            { id: 'L25.header', label: 'Supply Chain Header', type: 'header', status: 'built' },
            { id: 'L25.chain-stats', label: 'Inventory & PO KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'L25.inventory-table', label: 'Inventory / Suppliers / Orders Tabs', type: 'tabs', status: 'built' },
        ],
    },
};
