import { MenuItem } from './menu-configs';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export const getManagerRoleMenu = (role: string): MenuItem[] => {
    const commonDashboard = { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' };

    switch (role) {
        case 'coordinator':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
            ];
        case 'finance':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💰' },
                { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.ADMIN.TIMESHEETS, icon: '💸' },
                { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.ADMIN.REPORTS, icon: '📈' },
                { label: ContentRegistry.ROLES.FINANCE, path: RouteRegistry.ADMIN.EARNINGS, icon: '💵' },
            ];
        case 'hr':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
                { label: ContentRegistry.MENU.ONBOARDING, path: RouteRegistry.ADMIN.ONBOARDING, icon: '📋' },
                { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.MANAGER.TRAINING, icon: '🎓' },
                { label: ContentRegistry.MENU.COMPLIANCE, path: RouteRegistry.MANAGER.TRAINING, icon: '✅' },
            ];
        case 'compliance':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.AUDITS, path: RouteRegistry.ADMIN.AUDITS, icon: '🔍' },
                { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '⚠️' },
                { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.ADMIN.REPORTS, icon: '📈' },
            ];
        case 'crm':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.INQUIRIES, path: RouteRegistry.ADMIN.LEADS, icon: '📞' },
                { label: ContentRegistry.MENU.SATISFACTION, path: RouteRegistry.PLAN.MANAGER.SURVEYS, icon: '😊' },
            ];
        case 'training':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.MODULES, path: RouteRegistry.PLAN.MANAGER.TRAINING_MODULES, icon: '📚' },
                { label: ContentRegistry.MENU.SKILLS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
            ];
        case 'rn':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CARE_PLANS, path: RouteRegistry.PLAN.CARE_PLANS, icon: '📋' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
            ];
        default:
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
                { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
                { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '⚠️' },
                { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.ADMIN.REPORTS, icon: '📈' },
            ];
    }
};
