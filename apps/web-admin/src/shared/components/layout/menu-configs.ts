import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export interface MenuItem {
    label: string;
    path: string;
    icon: string;
}

import { knowledgeBaseMenus } from './kb-menu-configs';

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
    { label: ContentRegistry.MENU.SETTINGS, path: RouteRegistry.ADMIN.SETTINGS, icon: '⚙️' },
    { label: ContentRegistry.MENU.INSIGHTS, path: RouteRegistry.ADMIN.AI_INSIGHTS, icon: '🧠' },
    { label: ContentRegistry.MENU.CLINICAL_AI, path: RouteRegistry.ADMIN.CLINICAL_ASSISTANT, icon: '🩺' },
    { label: ContentRegistry.MENU.INTEROPERABILITY, path: RouteRegistry.ADMIN.INTEROP, icon: '🔗' },
    { label: ContentRegistry.MENU.AUTOMATION, path: RouteRegistry.ADMIN.AUTOPILOT, icon: '🤖' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.ADMIN.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.PRIVATE_MARKET, path: RouteRegistry.ADMIN.PRIVATE_MARKETPLACE, icon: '🏪' },
    { label: ContentRegistry.MENU.IDENTITY, path: RouteRegistry.ADMIN.SOVEREIGN, icon: '🆔' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },

    // Explicit Role-Based Knowledge Base Routes
    ...knowledgeBaseMenus,

    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
];

export const platformMenu: MenuItem[] = [
    { label: 'Platform Stats', path: RouteRegistry.SUPERUSER.DASHBOARD, icon: '📊' },
    { label: 'Risk Surveillance', path: RouteRegistry.SUPERUSER.RISK_SURVEILLANCE, icon: '🛡️' },
    { label: 'Audit Logs', path: RouteRegistry.SUPERUSER.AUDIT_LOGS, icon: '📜' },
    { label: 'SLA Monitoring', path: RouteRegistry.SUPERUSER.SLA, icon: '🌐' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const scrumMasterMenu: MenuItem[] = [
    { label: 'Dash', path: RouteRegistry.SCRUM_MASTER.DASHBOARD, icon: '🚀' },
    { label: ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE, path: RouteRegistry.SCRUM_MASTER.API_ENDPOINTS, icon: '🔌' },
    { label: ContentRegistry.SCRUM_MASTER.PAGES.TITLE, path: RouteRegistry.SCRUM_MASTER.PAGES, icon: '📄' },
    { label: ContentRegistry.SCRUM_MASTER.COMPONENTS.TITLE, path: RouteRegistry.SCRUM_MASTER.COMPONENTS, icon: '🧩' },
    { label: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE, path: RouteRegistry.SCRUM_MASTER.ROLE_FLOWS, icon: '🔄' },
    { label: ContentRegistry.SCRUM_MASTER.MONITORING.TITLE, path: RouteRegistry.SCRUM_MASTER.MONITORING, icon: '💓' },
    { label: ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.TITLE, path: RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA, icon: '🗄️' },
    { label: ContentRegistry.SCRUM_MASTER.THEME_CENTER.TITLE, path: RouteRegistry.SCRUM_MASTER.THEME_CENTER, icon: '🎨' },
    { label: ContentRegistry.SCRUM_MASTER.PERFORMANCE.TITLE, path: RouteRegistry.SCRUM_MASTER.PERFORMANCE, icon: '⚡' },
    { label: ContentRegistry.SCRUM_MASTER.BUILD_HEALTH.TITLE, path: RouteRegistry.SCRUM_MASTER.BUILD_HEALTH, icon: '🏗️' },
    { label: ContentRegistry.SCRUM_MASTER.SECURITY_SCANS.TITLE, path: RouteRegistry.SCRUM_MASTER.SECURITY_SCANS, icon: '🛡️' },
    { label: ContentRegistry.SCRUM_MASTER.LOCALIZATION.TITLE, path: RouteRegistry.SCRUM_MASTER.LOCALIZATION, icon: '🌍' },
    { label: 'Dev', path: RouteRegistry.SCRUM_MASTER.DEVELOPER, icon: '💻' },
    { label: 'Dev KB', path: RouteRegistry.SCRUM_MASTER.DEV_KB, icon: '🛠️' },
    { label: ContentRegistry.SCRUM_MASTER.ENV_AUDIT.TITLE, path: RouteRegistry.SCRUM_MASTER.ENV_AUDIT, icon: '🌐' },
    { label: ContentRegistry.SCRUM_MASTER.REGISTRY_CHECK.TITLE, path: RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK, icon: '📋' },
];

export const clientMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLIENT_HUB, path: RouteRegistry.CLIENT.DASHBOARD, icon: '🏠' },
    { label: ContentRegistry.MENU.CLIENT_BOOKINGS, path: RouteRegistry.CLIENT.BOOKINGS, icon: '📅' },
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-client`, icon: '🎭' },
    { label: ContentRegistry.MENU.SUPPORT, path: RouteRegistry.SUPPORT, icon: '💬' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
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
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const pswMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.WORK_SCHEDULE, path: RouteRegistry.PSW.DASHBOARD, icon: '🗓️' },
    { label: ContentRegistry.MENU.OPEN_SHIFTS, path: RouteRegistry.PSW.OPEN_SHIFTS, icon: '✨' },
    { label: ContentRegistry.MENU.MY_SHIFTS, path: RouteRegistry.PSW.SCHEDULE, icon: '⌚' },
    { label: ContentRegistry.MENU.MY_EARNINGS, path: RouteRegistry.PSW.EARNINGS, icon: '💰' },
    { label: ContentRegistry.MENU.MY_CREDENTIALS, path: RouteRegistry.PROFILE, icon: '📜' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-psw`, icon: '🎭' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.HELP_DESK, path: RouteRegistry.SUPPORT, icon: '❓' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const rnMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.CLINICAL_DASHBOARD, path: RouteRegistry.RN.DASHBOARD, icon: '🩺' },
    { label: ContentRegistry.MENU.CLINIENT_ADMISSION, path: RouteRegistry.ADMIN.ADMISSION, icon: '📝' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '🚨' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-rn`, icon: '🎭' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const managerMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.DAILY_ENTRY, path: RouteRegistry.MANAGER.DAILY_ENTRY, icon: '📝' },
    { label: ContentRegistry.MENU.EVALUATIONS, path: RouteRegistry.MANAGER.EVALUATIONS, icon: '📋' },
    { label: ContentRegistry.MENU.SERVICE_REVIEW, path: RouteRegistry.MANAGER.SERVICE_REVIEW, icon: '⭐' },
    { label: ContentRegistry.MENU.PROFILE, path: RouteRegistry.PROFILE, icon: '👤' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-manager`, icon: '🎭' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const coordinatorMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.COORDINATOR.DASHBOARD, icon: '📊' },
    { label: ContentRegistry.MENU.SCHEDULE, path: RouteRegistry.ADMIN.SCHEDULE, icon: '📅' },
    { label: ContentRegistry.MENU.CUSTOMERS, path: RouteRegistry.STAFF.CUSTOMERS, icon: '👥' },
    { label: ContentRegistry.MENU.USERS, path: RouteRegistry.ADMIN.USERS, icon: '👨‍⚕️' },
    { label: ContentRegistry.MENU.INCIDENTS, path: RouteRegistry.ADMIN.INCIDENTS, icon: '⚠️' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-coordinator`, icon: '🎭' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export const financeMenu: MenuItem[] = [
    { label: ContentRegistry.MENU.DASHBOARD, path: RouteRegistry.MANAGER.TRAINING, icon: '💰' }, // Using training as placeholder if finance specific missing
    { label: ContentRegistry.MENU.CLIENT_BILLING, path: RouteRegistry.CLIENT.BILLING, icon: '💳' },
    { label: ContentRegistry.MENU.TIMESHEETS, path: RouteRegistry.ADMIN.TIMESHEETS, icon: '💸' },
    { label: ContentRegistry.MENU.REPORTS, path: RouteRegistry.ADMIN.REPORTS, icon: '📈' },
    { label: 'My Role Playbook', path: `${RouteRegistry.KNOWLEDGE_BASE}/role-finance`, icon: '🎭' },
    { label: ContentRegistry.MENU.KNOWLEDGE_BASE, path: RouteRegistry.KNOWLEDGE_BASE, icon: '📚' },
    { label: ContentRegistry.MENU.TRAINING, path: RouteRegistry.LEARN, icon: '🎓' },
];

export { getManagerRoleMenu } from './manager-role-menus';
