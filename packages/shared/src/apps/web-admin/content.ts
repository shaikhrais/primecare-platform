import { ContentRegistry as MasterContentRegistry } from '../../registries/ContentRegistry';

/**
 * Web Admin Specific Content Overrides
 * This registry inherits from the Master ContentRegistry and applies portal-specific branding.
 */
export const ContentRegistry = {
    ...MasterContentRegistry,
    APP: {
        ...MasterContentRegistry.APP,
        NAME: 'PrimeCare Admin',
        TAGLINE: 'Platform Management Portal',
    },
    AUTH: {
        ...MasterContentRegistry.AUTH,
        LOGIN_TITLE: 'Admin Login',
        LOGIN_TITLE_PSW: 'Caregiver Login',
        LOGIN_TITLE_CLIENT: 'Family Portal Login',
        BUTTON: 'Login to Dashboard',
        BUTTON_PSW: 'Sign In as Caregiver',
        BUTTON_CLIENT: 'Sign In to Family Hub',
    },
    DASHBOARD: {
        TITLE: 'Overview',
        STATS: {
            USERS: 'Total Users',
            PSWS: 'Pending PSWs',
            VISITS: 'Unassigned Visits',
        },
    },
    MENU: {
        ...MasterContentRegistry.MENU,
        DASHBOARD: 'Dashboard',
        USERS: 'Users',
        SCHEDULE: 'Schedule',
        INCIDENTS: 'Incidents',
        TIMESHEETS: 'Timesheets',
        LEADS: 'Inquiries',
        SERVICES: 'Services',
        AUDITS: 'Audits',
        CONTENT: 'Content',
        SETTINGS: 'Settings',
        DEVELOPER: 'Developer',
        THEME: 'Theme Center',
    },
    USERS: {
        ...MasterContentRegistry.USERS,
        TITLE: 'User Management',
    },
    SCHEDULE: {
        ...MasterContentRegistry.SCHEDULE,
        TITLE: 'Shift Scheduling',
        SUBTITLE: 'Manage client visits and caregiver assignments',
    },
    // Scrum Master section is inherited from Master but we ensure THEME_CENTER is present
    SCRUM_MASTER: {
        ...MasterContentRegistry.SCRUM_MASTER,
        THEME_CENTER: {
            TITLE: 'Theme Core Center',
            SUBTITLE: 'Live platform style management and CSS variable audit',
        },
        ROLE_FLOWS: {
            ...MasterContentRegistry.SCRUM_MASTER.ROLE_FLOWS,
            STEPS: {
                ...MasterContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS
            }
        }
    }
} as const;
