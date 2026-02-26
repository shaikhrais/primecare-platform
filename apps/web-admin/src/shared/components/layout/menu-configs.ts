import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;

export interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

export const adminMenu: MenuItem[] = [
    { label: 'Dashboard', path: RouteRegistry.DASHBOARD, icon: '📊' },
    { label: 'Users & PSWs', path: RouteRegistry.USERS, icon: '👥' },
    { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: 'Incidents', path: RouteRegistry.INCIDENTS, icon: '🚨' },
    { label: 'Timesheets', path: RouteRegistry.TIMESHEETS, icon: '⏰' },
    { label: 'Lead Inquiries', path: RouteRegistry.LEADS, icon: '📥' },
    { label: 'Services', path: RouteRegistry.SERVICES, icon: '💰' },
    { label: 'Call Audits', path: RouteRegistry.AUDITS, icon: '🎙️' },
    { label: 'Content', path: RouteRegistry.CONTENT, icon: '📝' },
    { label: 'Reports', path: '/admin/reports', icon: '📈' },
    { label: 'Settings', path: RouteRegistry.SETTINGS, icon: '⚙️' },
    { label: 'Support', path: RouteRegistry.SUPPORT, icon: '💬' },
];

export const clientMenu: MenuItem[] = [
    { label: 'My Care Hub', path: '/client/dashboard', icon: '🏠' },
    { label: 'My Bookings', path: '/client/bookings', icon: '📅' },
    { label: 'Billing', path: '/client/billing', icon: '💳' },
    { label: 'Account Profile', path: '/profile', icon: '👤' },
    { label: 'Support', path: '/support', icon: '💬' },
];

export const staffMenu: MenuItem[] = [
    { label: 'Staff Hub', path: '/staff/dashboard', icon: '🏢' },
    { label: 'Leads', path: RouteRegistry.LEADS, icon: '📥' },
    { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: 'Users', path: RouteRegistry.USERS, icon: '👥' },
    { label: 'Customer Mgmt', path: '/staff/customers', icon: '👤' },
    { label: 'Tickets', path: '/support', icon: '🎫' },
    { label: 'My Profile', path: '/profile', icon: '👤' },
];

export const pswMenu: MenuItem[] = [
    { label: 'Work Schedule', path: '/psw/dashboard', icon: '🗓️' },
    { label: 'Open Shifts', path: '/psw/open-shifts', icon: '✨' },
    { label: 'My Shifts', path: '/psw/schedule', icon: '⌚' },
    { label: 'My Earnings', path: '/psw/earnings', icon: '💰' },
    { label: 'My Credentials', path: '/psw/profile', icon: '📜' },
    { label: 'Help Desk', path: '/support', icon: '❓' },
];

export const rnMenu: MenuItem[] = [
    { label: 'Clinical Dashboard', path: '/rn/dashboard', icon: '🩺' },
    { label: 'Clients admission', path: '/admin/clients/admission', icon: '📝' },
    { label: 'Incident List', path: RouteRegistry.INCIDENTS, icon: '🚨' },
    { label: 'Profile', path: '/profile', icon: '👤' },
];

export const managerMenu: MenuItem[] = [
    { label: 'Dashboard', path: '/manager/dashboard', icon: '📊' },
    { label: 'Daily Entry', path: '/manager/daily-entry', icon: '📝' },
    { label: 'Evaluations', path: '/manager/evaluations', icon: '📋' },
    { label: 'Service Review', path: '/manager/service-review', icon: '⭐' },
    { label: 'Profile', path: '/profile', icon: '👤' },
];

export const coordinatorMenu: MenuItem[] = [
    { label: 'Dashboard', path: '/coordinator/dashboard', icon: '📊' },
    { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
    { label: 'Clients', path: '/customers', icon: '👥' },
    { label: 'Staff', path: RouteRegistry.USERS, icon: '👨‍⚕️' },
    { label: 'Incidents', path: RouteRegistry.INCIDENTS, icon: '⚠️' },
];

export const financeMenu: MenuItem[] = [
    { label: 'Dashboard', path: '/finance/dashboard', icon: '💰' },
    { label: 'Billing', path: '/billing', icon: '💳' },
    { label: 'Payroll', path: '/payroll', icon: '💸' },
    { label: 'Reports', path: '/reports', icon: '📈' },
];

export const getManagerRoleMenu = (role: string): MenuItem[] => {
    const commonDashboard = { label: 'Dashboard', path: '/manager/dashboard', icon: '📊' };

    switch (role) {
        case 'coordinator':
            return [
                commonDashboard,
                { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
                { label: 'Clients', path: '/customers', icon: '👥' },
                { label: 'Staff', path: '/users', icon: '👨‍⚕️' },
            ];
        case 'finance':
            return [
                commonDashboard,
                { label: 'Billing', path: '/invoices', icon: '💰' },
                { label: 'Payroll', path: '/timesheets', icon: '💸' },
                { label: 'Reports', path: '/reports', icon: '📈' },
                { label: 'Earnings', path: '/earnings', icon: '💵' },
            ];
        case 'hr':
            return [
                commonDashboard,
                { label: 'Staff', path: '/users', icon: '👨‍⚕️' },
                { label: 'Onboarding', path: '/onboarding', icon: '📋' },
                { label: 'Training', path: '/training', icon: '🎓' },
                { label: 'Compliance', path: '/compliance', icon: '✅' },
            ];
        case 'compliance':
            return [
                commonDashboard,
                { label: 'Audits', path: '/audits', icon: '🔍' },
                { label: 'Incidents', path: '/incidents', icon: '⚠️' },
                { label: 'Reports', path: '/reports', icon: '📈' },
            ];
        case 'crm':
            return [
                commonDashboard,
                { label: 'Clients', path: '/customers', icon: '👥' },
                { label: 'Inquiries', path: '/leads', icon: '📞' },
                { label: 'Satisfaction', path: '/surveys', icon: '😊' },
            ];
        case 'training':
            return [
                commonDashboard,
                { label: 'Modules', path: '/training/modules', icon: '📚' },
                { label: 'Staff Skills', path: '/users', icon: '👨‍⚕️' },
            ];
        case 'rn':
            return [
                commonDashboard,
                { label: 'Care Plans', path: '/care-plans', icon: '📋' },
                { label: 'Clients', path: '/customers', icon: '👥' },
                { label: 'Daily Entries', path: '/manager/daily-entry', icon: '📝' },
            ];
        default:
            return [
                commonDashboard,
                { label: 'Daily Entry', path: '/manager/daily-entry', icon: '📝' },
                { label: 'Clients', path: '/customers', icon: '👥' },
                { label: 'Staff', path: '/users', icon: '👨‍⚕️' },
                { label: 'Schedule', path: RouteRegistry.SCHEDULE, icon: '📅' },
                { label: 'Incidents', path: '/incidents', icon: '⚠️' },
                { label: 'Reports', path: '/reports', icon: '📈' },
            ];
    }
};
