import type { PageSections } from '../PageSectionRegistry';

export const TENANCY_SECTIONS: Record<string, PageSections> = {
    // ── D7: Manager Home ────────────────────────────────────────────────
    D7: {
        pageId: 'D7', label: 'Manager Home',
        sections: [
            { id: 'D7.header', label: 'Branch Header & Live Indicator', type: 'header', status: 'built', dataCy: 'page.title' },
            { id: 'D7.action-bar', label: 'Action Bar', type: 'action-bar', status: 'built', component: 'PageActionBar' },
            { id: 'D7.branch-stats', label: 'Branch KPI Cards', type: 'kpi-cards', status: 'built' },
            { id: 'D7.ops-feed', label: 'Operations Feed', type: 'feed', status: 'built' },
            { id: 'D7.staff-chart', label: 'Staff Performance Chart', type: 'chart', status: 'built' },
            { id: 'D7.compliance-bar', label: 'Compliance Quick View', type: 'stats', status: 'built' },
        ],
    },
    // ── D9: Branch P&L ───────────────────────────────────────────────────────
    D9: {
        pageId: 'D9', label: 'Branch P&L',
        sections: [
            { id: 'D9.header', label: 'Finance Header', type: 'header', status: 'built' },
            { id: 'D9.revenue-cards', label: 'Revenue KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D9.pl-chart', label: 'P&L Chart', type: 'chart', status: 'built' },
            { id: 'D9.payroll-table', label: 'Payroll Breakdown', type: 'table', status: 'built' },
        ],
    },
    // ── H12: Operations Hub ──────────────────────────────────────────────────
    H12: {
        pageId: 'H12', label: 'Operations Hub',
        sections: [
            { id: 'H12.header', label: 'Ops Header', type: 'header', status: 'built' },
            { id: 'H12.stats', label: 'Branch Health Stats', type: 'kpi-cards', status: 'built' },
            { id: 'H12.late-shifts', label: 'Late Shift Alerts', type: 'alert-panel', status: 'built' },
            { id: 'H12.attendance', label: 'Attendance Monitor', type: 'table', status: 'built' },
        ],
    },
    // ── D14: PSW Home ───────────────────────────────────────────────────
    D14: {
        pageId: 'D14', label: 'PSW Home',
        sections: [
            { id: 'D14.header', label: 'PSW Header & Live Indicator', type: 'header', status: 'built', component: 'AccessibilityControls', dataCy: 'page.title' },
            { id: 'D14.action-bar', label: 'Action Bar', type: 'action-bar', status: 'built', component: 'PageActionBar' },
            { id: 'D14.earnings', label: 'Earnings Projections', type: 'kpi-cards', status: 'built', component: 'EarningsProjections' },
            { id: 'D14.hours', label: 'Hours Logged Card', type: 'kpi-cards', status: 'built' },
            { id: 'D14.reliability', label: 'Reliability Streak', type: 'stats', status: 'built', component: 'ReliabilityStreak' },
            { id: 'D14.psw-stats', label: 'Performance Stats', type: 'chart', status: 'built', component: 'PswStats' },
            { id: 'D14.peer-kudos', label: 'Peer Kudos System', type: 'feed', status: 'built', component: 'PeerKudosSystem' },
            { id: 'D14.burnout', label: 'Burnout Predictor', type: 'alert-panel', status: 'built', component: 'BurnoutPredictor' },
            { id: 'D14.shifts', label: 'Shift List', type: 'list', status: 'built', component: 'ShiftList', apiEndpoint: '/v1/psw/schedule/visits' },
            { id: 'D14.compliance', label: 'Compliance Section', type: 'stats', status: 'built', component: 'ComplianceSection' },
            { id: 'D14.wellness', label: 'Wellness Pulse', type: 'custom', status: 'built', component: 'WellnessPulse' },
            { id: 'D14.id-badge', label: 'Digital ID Badge', type: 'modal', status: 'built', component: 'DigitalIdBadge' },
            { id: 'D14.chat', label: 'Direct Dispatch Chat', type: 'chat', status: 'built', component: 'DirectDispatchChat' },
            { id: 'D14.bg-settings', label: 'Background Settings Modal', type: 'modal', status: 'built', component: 'BackgroundSettingsModal' },
        ],
    },
    // ── L16: PSW Schedule ────────────────────────────────────────────────────
    L16: {
        pageId: 'L16', label: 'PSW Schedule',
        sections: [
            { id: 'L16.header', label: 'Schedule Header', type: 'header', status: 'built' },
            { id: 'L16.calendar', label: 'Week Calendar', type: 'calendar', status: 'built' },
            { id: 'L16.shift-cards', label: 'Shift Cards', type: 'list', status: 'built' },
            { id: 'L16.check-in', label: 'Check-In Action', type: 'action-bar', status: 'built' },
        ],
    },
    // ── D15: RN Home ────────────────────────────────────────────────────
    D15: {
        pageId: 'D15', label: 'RN Home',
        sections: [
            { id: 'D15.header', label: 'RN Header', type: 'header', status: 'built' },
            { id: 'D15.action-bar', label: 'Action Bar', type: 'action-bar', status: 'built' },
            { id: 'D15.clinical-stats', label: 'Clinical KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D15.audit-summary', label: 'Audit Summary', type: 'stats', status: 'built' },
            { id: 'D15.supervision', label: 'Supervision Overview', type: 'list', status: 'built' },
        ],
    },
    // ── D8: Client Home ─────────────────────────────────────────────────
    D8: {
        pageId: 'D8', label: 'Client Home',
        sections: [
            { id: 'D8.header', label: 'Client Header', type: 'header', status: 'built' },
            { id: 'D8.care-summary', label: 'Care Summary Cards', type: 'kpi-cards', status: 'built' },
            { id: 'D8.upcoming', label: 'Upcoming Visits', type: 'list', status: 'built' },
            { id: 'D8.care-team', label: 'Care Team Display', type: 'custom', status: 'built' },
            { id: 'D8.quick-actions', label: 'Client Quick Actions', type: 'action-bar', status: 'built' },
        ],
    },
    // ── H18: Coordinator Hub ─────────────────────────────────────────────────
    H18: {
        pageId: 'H18', label: 'Coordinator Hub',
        sections: [
            { id: 'H18.header', label: 'Dispatch Header', type: 'header', status: 'built' },
            { id: 'H18.action-bar', label: 'Action Bar', type: 'action-bar', status: 'built' },
            { id: 'H18.coverage-stats', label: 'Coverage KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'H18.shift-board', label: 'Shift Board', type: 'table', status: 'built' },
            { id: 'H18.sos-panel', label: 'SOS Alert Panel', type: 'alert-panel', status: 'built' },
            { id: 'H18.map', label: 'Dispatch Map', type: 'map', status: 'built' },
        ],
    },
    // ── D19: Staff Home ─────────────────────────────────────────────────
    D19: {
        pageId: 'D19', label: 'Staff Home',
        sections: [
            { id: 'D19.header', label: 'Staff Header', type: 'header', status: 'built' },
            { id: 'D19.task-stats', label: 'Task Stats', type: 'kpi-cards', status: 'built' },
            { id: 'D19.task-grid', label: 'Task Grid', type: 'table', status: 'built' },
            { id: 'D19.messages', label: 'Message Center', type: 'feed', status: 'built' },
        ],
    },
    // ── D18: Allied Health ───────────────────────────────────────────────────
    D18: {
        pageId: 'D18', label: 'Allied Health Home',
        sections: [
            { id: 'D18.header', label: 'Allied Header', type: 'header', status: 'built' },
            { id: 'D18.treatment-stats', label: 'Treatment KPIs', type: 'kpi-cards', status: 'built' },
            { id: 'D18.treatment-list', label: 'Treatment List', type: 'list', status: 'built' },
        ],
    },
};
