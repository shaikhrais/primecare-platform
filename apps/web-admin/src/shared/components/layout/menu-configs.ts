import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

export const adminMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👥' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.INCIDENTS, icon: '🚨' },
    { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.TIMESHEETS, icon: '⏰' },
    { label: ContentRegistry.MENU.LEADS, path: RouteRegistry.LEADS, icon: '📥' },
    { label: ContentRegistry.MENU.SERVICES, path: RouteRegistry.SERVICES, icon: '💰' },
    { label: ContentRegistry.MENU.AUDITS, path: RouteRegistry.AUDITS, icon: '🎙️' },
    { label: ContentRegistry.MENU.CONTENT, path: RouteRegistry.CONTENT, icon: '📝' },
    { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.REPORTS, icon: '📈' },
    { label: ContentRegistry.MENU.SETTINGS, path: RouteRegistry.SETTINGS, icon: '⚙️' },
    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
];

export const clientMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLIENT_HUB, path: RouteRegistry.CLIENT.DASHBOARD, icon: '🏠' },
    { label: ContentRegistry.MENU.CLIENT_BOOKINGS, path: RouteRegistry.CLIENT.BOOKINGS, icon: '📅' },
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
];

export const staffMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.STAFF_HUB, path: RouteRegistry.STAFF.DASHBOARD, icon: '🏢' },
    { label: ContentRegistry.MENU.LEADS, path: RouteRegistry.LEADS, icon: '📥' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👥' },
    { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👤' },
    { label: ContentRegistry.MENU.TICKETS, path: RouteRegistry.SUPPORT, icon: '🎫' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
];

export const pswMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.WORK_SCHEDULE, path: RouteRegistry.PSW.DASHBOARD, icon: '🗓️' },
    { label: ContentRegistry.MENU.OPEN_SHIFTS, path: RouteRegistry.PSW.OPEN_SHIFTS, icon: '✨' },
    { label: ContentRegistry.MENU.MY_SHIFTS, path: RouteRegistry.PSW.SCHEDULE, icon: '⌚' },
    { label: ContentRegistry.MENU.MY_EARNINGS, path: RouteRegistry.PSW.EARNINGS, icon: '💰' },
    { label: ContentRegistry.MENU.MY_CREDENTIALS, path: RouteRegistry.PSW.PROFILE, icon: '📜' },
    { label: ContentRegistry.MENU.HELP_DESK, path: RouteRegistry.SUPPORT, icon: '❓' },
];

export const rnMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLINICAL_DASHBOARD, path: RouteRegistry.RN.DASHBOARD, icon: '🩺' },
    { label: ContentRegistry.MENU.CLINIENT_ADMISSION, path: RouteRegistry.ADMISSION, icon: '📝' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.INCIDENTS, icon: '🚨' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
];

export const managerMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
    { label: ContentRegistry.MENU.EVALUATIONS, path: RouteRegistry.MANAGER.EVALUATIONS, icon: '📋' },
    { label: ContentRegistry.MENU.SERVICE_REVIEW, path: RouteRegistry.MANAGER.SERVICE_REVIEW, icon: '⭐' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
];

export const coordinatorMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.COORDINATOR, icon: '📊' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👨‍⚕️' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.INCIDENTS, icon: '⚠️' },
];

export const financeMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.TRAINING, icon: '💰' }, // Using training as placeholder if finance specific missing
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.TIMESHEETS, icon: '💸' },
    { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.REPORTS, icon: '📈' },
];

export const getManagerRoleMenu = (role: string): MenuItem[] => {
    const commonDashboard = { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' };

    switch (role) {
        case 'coordinator':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.SCHEDULE, icon: '📅' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👨‍⚕️' },
            ];
        case 'finance':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💰' },
                { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.TIMESHEETS, icon: '💸' },
                { label: ContentRegistry.MENU.REPORTS, path: '/reports', icon: '📈' },
                { label: ContentRegistry.ROLES.FINANCE, path: '/earnings', icon: '💵' },
            ];
        case 'hr':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👨‍⚕️' },
                { label: ContentRegistry.MENU.ONBOARDING, path: RouteRegistry.ONBOARDING, icon: '📋' },
                { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.MANAGER.TRAINING, icon: '🎓' },
                { label: ContentRegistry.MENU.COMPLIANCE, path: RouteRegistry.MANAGER.TRAINING, icon: '✅' },
            ];
        case 'compliance':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.AUDITS, path: RouteRegistry.AUDITS, icon: '🔍' },
                { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.INCIDENTS, icon: '⚠️' },
                { label: ContentRegistry.MENU.REPORTS, path: '/reports', icon: '📈' },
            ];
        case 'crm':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.INQUIRIES, path: RouteRegistry.LEADS, icon: '📞' },
                { label: ContentRegistry.MENU.SATISFACTION, path: '/surveys', icon: '😊' },
            ];
        case 'training':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.MODULES, path: '/training/modules', icon: '📚' },
                { label: ContentRegistry.MENU.SKILLS, path: RouteRegistry.USERS, icon: '👨‍⚕️' },
            ];
        case 'rn':
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.CARE_PLANS, path: '/care-plans', icon: '📋' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
            ];
        default:
            return [
                commonDashboard,
                { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
                { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
                { label: ContentRegistry.MENU.USERS, path: RouteRegistry.USERS, icon: '👨‍⚕️' },
                { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.SCHEDULE, icon: '📅' },
                { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.INCIDENTS, icon: '⚠️' },
                { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.REPORTS, icon: '📈' },
            ];
    }
};
