import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

export const adminMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.ADMIN.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👥' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '🚨' },
    { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.ADMIN.TIMESHEETS, icon: '⏰' },
    { label: ContentRegistry.MENU.LEADS, path: RouteRegistry.ADMIN.LEADS, icon: '📥' },
    { label: ContentRegistry.MENU.SERVICES, path: RouteRegistry.ADMIN.SERVICES, icon: '💰' },
    { label: ContentRegistry.MENU.AUDITS, path: RouteRegistry.ADMIN.AUDITS, icon: '🎙️' },
    { label: ContentRegistry.MENU.CONTENT, path: RouteRegistry.ADMIN.CONTENT, icon: '📝' },
    { label: ContentRegistry.MENU.SETTINGS, path: RouteRegistry.ADMIN.SETTINGS, icon: '⚙️' },
    { label: 'Developer', path: RouteRegistry.ADMIN.DEVELOPER, icon: '💻' },
    { label: 'Insights', path: RouteRegistry.ADMIN.AI_INSIGHTS, icon: '🧠' },
    { label: 'Clinical AI', path: RouteRegistry.ADMIN.CLINICAL_ASSISTANT, icon: '🩺' },
    { label: 'Interoperability', path: RouteRegistry.ADMIN.INTEROP, icon: '🔗' },
    { label: 'Automation', path: RouteRegistry.ADMIN.AUTOPILOT, icon: '🤖' },
    { label: 'Growth Strategy', path: RouteRegistry.ADMIN.GROWTH_STRATEGY, icon: '📈' },
    { label: 'Knowledge Base', path: RouteRegistry.ADMIN.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'Reseller Hub', path: RouteRegistry.ADMIN.RESELLER, icon: '🏢' },
    { label: 'Private Market', path: RouteRegistry.ADMIN.PRIVATE_MARKETPLACE, icon: '🏪' },
    { label: 'My Identity', path: RouteRegistry.ADMIN.SOVEREIGN, icon: '🆔' },
    { label: 'Public Marketplace', path: RouteRegistry.ADMIN.MARKETPLACE, icon: '🌐' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
    { label: 'Developer Audit', path: RouteRegistry.ADMIN.DEV_KB, icon: '🛠️' },

    // Explicit Role-Based Knowledge Base Routes
    { label: 'KB: Super Admin', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-super-admin`, icon: '🎭' },
    { label: 'KB: Admin', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-admin`, icon: '🎭' },
    { label: 'KB: Regional Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-regional-manager`, icon: '🎭' },
    { label: 'KB: Operations', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-operations-manager`, icon: '🎭' },
    { label: 'KB: HR Manager', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-hr-manager`, icon: '🎭' },
    { label: 'KB: Clinical Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-clinical-manager`, icon: '🎭' },
    { label: 'KB: Finance Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-finance-manager`, icon: '🎭' },
    { label: 'KB: Marketing', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-marketing-manager`, icon: '🎭' },
    { label: 'KB: Recruiting', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-recruiting-manager`, icon: '🎭' },
    { label: 'KB: General Mgr', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-manager`, icon: '🎭' },
    { label: 'KB: Coordinator', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-coordinator`, icon: '🎭' },
    { label: 'KB: Staff', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-staff`, icon: '🎭' },
    { label: 'KB: Finance Clerk', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-finance`, icon: '🎭' },
    { label: 'KB: Client', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-client`, icon: '🎭' },
    { label: 'KB: RN', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rn`, icon: '🎭' },
    { label: 'KB: PSW', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-psw`, icon: '🎭' },
    { label: 'KB: RMT', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rmt`, icon: '🎭' },
    { label: 'KB: RPT', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rpt`, icon: '🎭' },
    { label: 'KB: RCH', path: `${RouteRegistry.ADMIN.KNOWLEDGE_BASE}/role-rch`, icon: '🎭' },

    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
];

export const platformMenu: MenuItem[] = [
    { label: 'Platform Stats', path: RouteRegistry.SUPERUSER.DASHBOARD, icon: '📊' },
    { label: 'Risk Surveillance', path: RouteRegistry.SUPERUSER.RISK_SURVEILLANCE, icon: '🛡️' },
    { label: 'Audit Logs', path: RouteRegistry.SUPERUSER.AUDIT_LOGS, icon: '📜' },
    { label: 'SLA Monitoring', path: RouteRegistry.SUPERUSER.SLA, icon: '🌐' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
    { label: 'Developer Audit', path: RouteRegistry.ADMIN.DEV_KB, icon: '🛠️' },
];

export const scrumMasterMenu: MenuItem[] = [
    { label: 'SM Dashboard', path: RouteRegistry.SCRUM_MASTER.DASHBOARD, icon: '🚀' },
    { label: 'API Endpoints', path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, icon: '🔌' },
    { label: 'Pages Audit', path: RouteRegistry.SCRUM_MASTER.PAGES, icon: '📄' },
    { label: 'Components', path: RouteRegistry.SCRUM_MASTER.COMPONENTS, icon: '🧩' },
    { label: 'Role Flows', path: RouteRegistry.SCRUM_MASTER.ROLE_FLOWS, icon: '🔄' },
    { label: 'System Health', path: RouteRegistry.SCRUM_MASTER.MONITORING, icon: '💓' },
    { label: 'Env Audit', path: RouteRegistry.SCRUM_MASTER.ENV_AUDIT, icon: '🌐' },
    { label: 'Registry Check', path: RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK, icon: '📋' },
    { label: 'DB Schema', path: RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA, icon: '🗄️' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const clientMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLIENT_HUB, path: RouteRegistry.CLIENT.DASHBOARD, icon: '🏠' },
    { label: ContentRegistry.MENU.CLIENT_BOOKINGS, path: RouteRegistry.CLIENT.BOOKINGS, icon: '📅' },
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-client`, icon: '🎭' },
    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const staffMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.STAFF_HUB, path: RouteRegistry.STAFF.DASHBOARD, icon: '🏢' },
    { label: ContentRegistry.MENU.LEADS, path: RouteRegistry.ADMIN.LEADS, icon: '📥' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👥' },
    { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👤' },
    { label: ContentRegistry.MENU.TICKETS, path: RouteRegistry.SUPPORT, icon: '🎫' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-staff`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const pswMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.WORK_SCHEDULE, path: RouteRegistry.PSW.DASHBOARD, icon: '🗓️' },
    { label: ContentRegistry.MENU.OPEN_SHIFTS, path: RouteRegistry.PSW.OPEN_SHIFTS, icon: '✨' },
    { label: ContentRegistry.MENU.MY_SHIFTS, path: RouteRegistry.PSW.SCHEDULE, icon: '⌚' },
    { label: ContentRegistry.MENU.MY_EARNINGS, path: RouteRegistry.PSW.EARNINGS, icon: '💰' },
    { label: ContentRegistry.MENU.MY_CREDENTIALS, path: RouteRegistry.PROFILE, icon: '📜' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-psw`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.HELP_DESK, path: RouteRegistry.SUPPORT, icon: '❓' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const rnMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLINICAL_DASHBOARD, path: RouteRegistry.RN.DASHBOARD, icon: '🩺' },
    { label: ContentRegistry.MENU.CLINIENT_ADMISSION, path: RouteRegistry.ADMIN.ADMISSION, icon: '📝' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '🚨' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-rn`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const managerMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
    { label: ContentRegistry.MENU.EVALUATIONS, path: RouteRegistry.MANAGER.EVALUATIONS, icon: '📋' },
    { label: ContentRegistry.MENU.SERVICE_REVIEW, path: RouteRegistry.MANAGER.SERVICE_REVIEW, icon: '⭐' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-manager`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const coordinatorMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.COORDINATOR, icon: '📊' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '⚠️' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-coordinator`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

export const financeMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.TRAINING, icon: '💰' }, // Using training as placeholder if finance specific missing
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.ADMIN.TIMESHEETS, icon: '💸' },
    { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.ADMIN.REPORTS, icon: '📈' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-finance`, icon: '🎭' },
    { label: 'Knowledge Base', path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: 'System Training', path: RouteRegistry.LEARN, icon: '🎓' },
];

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
