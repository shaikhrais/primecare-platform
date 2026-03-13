import type { DashboardEntry } from '../PageRegistry';

export const DashboardRegistry: DashboardEntry[] = [
    // ── Platform Dashboards ──
    { id: 'admin.dashboard', label: 'Admin Dashboard', route: '/platform/admin', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart', 'table'], icon: '⚙️' },
    { id: 'admin.summary', label: 'Registry Summary', route: '/platform/admin/summary-dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart'], icon: '📊' },
    { id: 'admin.finance', label: 'Finance Dashboard', route: '/platform/admin/finance/dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/financial/reports/daily-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '💰' },
    { id: 'admin.evv', label: 'EVV Dashboard', route: '/platform/admin/evv', owner: 'admin', statsEndpoints: ['/v1/admin/evv', '/v1/admin/evv/compliance-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '📍' },
    { id: 'admin.ai', label: 'AI Dashboard', route: '/platform/admin/ai', owner: 'admin', statsEndpoints: ['/v1/ai/insights'], widgets: ['kpi-card', 'chart'], icon: '🤖' },
    { id: 'admin.cron', label: 'Cron Dashboard', route: '/platform/admin/cron-dashboard', owner: 'admin', statsEndpoints: ['/v1/admin/cron/compliance-sweep'], widgets: ['kpi-card', 'table'], icon: '⏰' },
    { id: 'admin.security', label: 'Security Dashboard', route: '/platform/admin/security', owner: 'admin', statsEndpoints: ['/v1/security/threats'], widgets: ['kpi-card', 'chart', 'alert-panel'], icon: '🛡️' },
    { id: 'superuser.dashboard', label: 'Superuser Dashboard', route: '/platform', owner: 'superuser', statsEndpoints: ['/v1/superuser/health/summary'], widgets: ['kpi-card', 'chart'], icon: '👑' },
    { id: 'scrum-master.dashboard', label: 'Scrum Master Dashboard', route: '/platform/scrum-master', owner: 'scrum-master', statsEndpoints: ['/v1/scrum-master/stats'], widgets: ['kpi-card', 'table'], icon: '🔧' },
    // ── Tenancy Dashboards ──
    { id: 'manager.dashboard', label: 'Manager Dashboard', route: '/tenancy/manager', owner: 'manager', statsEndpoints: ['/v1/manager/dashboard/kpi', '/v1/manager/dashboard/today'], widgets: ['kpi-card', 'chart', 'table', 'calendar'], icon: '📊' },
    { id: 'staff.dashboard', label: 'Staff Dashboard', route: '/tenancy/staff', owner: 'staff', statsEndpoints: ['/v1/staff/dashboard/stats'], widgets: ['kpi-card', 'table'], icon: '👥' },
    { id: 'psw.dashboard', label: 'PSW Dashboard', route: '/tenancy/psw', owner: 'psw', statsEndpoints: ['/v1/psw/dashboard/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '🩺' },
    { id: 'rn.dashboard', label: 'RN Dashboard', route: '/tenancy/rn', owner: 'rn', statsEndpoints: ['/v1/rn/dashboard/stats'], widgets: ['kpi-card', 'table', 'chart'], icon: '💉' },
    { id: 'coordinator.dashboard', label: 'Coordinator Dashboard', route: '/tenancy/coordinator', owner: 'coordinator', statsEndpoints: ['/v1/coordinator/dashboard/stats'], widgets: ['kpi-card', 'map', 'table'], icon: '📍' },
    { id: 'client.dashboard', label: 'Client Dashboard', route: '/tenancy/client', owner: 'client', statsEndpoints: ['/v1/client/dashboard/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '👤' },
    { id: 'allied.dashboard', label: 'Allied Health Dashboard', route: '/tenancy/allied-health', owner: 'allied', statsEndpoints: [], widgets: ['kpi-card', 'table'], icon: '🏥' },
];
