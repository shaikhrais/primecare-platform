import type { HomeEntry } from '../01_I_page_registry';

export const HomeRegistry: HomeEntry[] = [
    // ── Platform Homes ──
    { id: 'admin.home', label: 'Admin Home', route: '/platform/admin', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart', 'table'], icon: '⚙️' },
    { id: 'admin.summary', label: 'Registry Summary', route: '/platform/admin/summary-home', owner: 'admin', statsEndpoints: ['/v1/admin/stats'], widgets: ['kpi-card', 'chart'], icon: '📊' },
    { id: 'admin.finance', label: 'Finance Home', route: '/platform/admin/finance/home', owner: 'admin', statsEndpoints: ['/v1/admin/financial/reports/daily-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '💰' },
    { id: 'admin.evv', label: 'EVV Home', route: '/platform/admin/evv', owner: 'admin', statsEndpoints: ['/v1/admin/evv', '/v1/admin/evv/compliance-summary'], widgets: ['kpi-card', 'chart', 'table'], icon: '📍' },
    { id: 'admin.ai', label: 'AI Home', route: '/platform/admin/ai', owner: 'admin', statsEndpoints: ['/v1/ai/insights'], widgets: ['kpi-card', 'chart'], icon: '🤖' },
    { id: 'admin.cron', label: 'Cron Home', route: '/platform/admin/cron-home', owner: 'admin', statsEndpoints: ['/v1/admin/cron/compliance-sweep'], widgets: ['kpi-card', 'table'], icon: '⏰' },
    { id: 'admin.security', label: 'Security Home', route: '/platform/admin/security', owner: 'admin', statsEndpoints: ['/v1/security/threats'], widgets: ['kpi-card', 'chart', 'alert-panel'], icon: '🛡️' },
    { id: 'superuser.home', label: 'Superuser Home', route: '/platform', owner: 'superuser', statsEndpoints: ['/v1/superuser/health/summary'], widgets: ['kpi-card', 'chart'], icon: '👑' },
    { id: 'scrum-master.home', label: 'Scrum Master Home', route: '/platform/scrum-master', owner: 'scrum-master', statsEndpoints: ['/v1/scrum-master/stats'], widgets: ['kpi-card', 'table'], icon: '🔧' },
    // ── Tenancy Homes ──
    { id: 'manager.home', label: 'Manager Home', route: '/tenancy/manager', owner: 'manager', statsEndpoints: ['/v1/manager/home/kpi', '/v1/manager/home/today'], widgets: ['kpi-card', 'chart', 'table', 'calendar'], icon: '📊' },
    { id: 'staff.home', label: 'Staff Home', route: '/tenancy/staff', owner: 'staff', statsEndpoints: ['/v1/staff/home/stats'], widgets: ['kpi-card', 'table'], icon: '👥' },
    { id: 'psw.home', label: 'PSW Home', route: '/tenancy/psw', owner: 'psw', statsEndpoints: ['/v1/psw/home/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '🩺' },
    { id: 'rn.home', label: 'RN Home', route: '/tenancy/rn', owner: 'rn', statsEndpoints: ['/v1/rn/home/stats'], widgets: ['kpi-card', 'table', 'chart'], icon: '💉' },
    { id: 'coordinator.home', label: 'Coordinator Home', route: '/tenancy/coordinator', owner: 'coordinator', statsEndpoints: ['/v1/coordinator/home/stats'], widgets: ['kpi-card', 'map', 'table'], icon: '📍' },
    { id: 'client.home', label: 'Client Home', route: '/tenancy/client', owner: 'client', statsEndpoints: ['/v1/client/home/stats'], widgets: ['kpi-card', 'calendar', 'feed'], icon: '👤' },
    { id: 'allied.home', label: 'Allied Health Home', route: '/platform/allied-health', owner: 'allied', statsEndpoints: [], widgets: ['kpi-card', 'table'], icon: '🏥' },
    { id: 'training-director.home', label: 'Training Director Home', route: '/platform/admin/training/home', owner: 'admin', statsEndpoints: ['/v1/admin/training/stats/compliance-overview', '/v1/admin/training/stats/expiring-certs'], widgets: ['kpi-card', 'chart', 'table'], icon: '🎓' },
];
