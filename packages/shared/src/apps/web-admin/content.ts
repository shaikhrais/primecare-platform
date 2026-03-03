export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare Admin',
        TAGLINE: 'Platform Management Portal',
    },
    AUTH: {
        LOGIN_TITLE: 'Admin Login',
        LOGIN_TITLE_PSW: 'Caregiver Login',
        LOGIN_TITLE_CLIENT: 'Family Portal Login',
        EMAIL_LABEL: 'Email Address',
        PASSWORD_LABEL: 'Password',
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
    USERS: {
        TITLE: 'User Management',
        APPROVE_BTN: 'Approve',
        ROLE: 'Role',
        STATUS: 'Status',
    },
    SCHEDULE: {
        TITLE: 'Shift Scheduling',
        SUBTITLE: 'Manage client visits and caregiver assignments',
        ACTIONS: {
            CREATE: '+ Create Visit Request',
            ASSIGN: 'Assign Caregiver',
            CONFIRM_ASSIGN: 'Confirm Assignment',
            CANCEL_VISIT: 'Cancel Visit',
            CLOSE: 'Close',
            EDIT: 'Edit Visit'
        },
        MODAL: {
            SELECT_PSW: 'Select Caregiver',
            CHOOSE_WORKER: 'Choose a worker...',
            CONFIRM_DELETE: 'Are you sure you want to cancel this visit?'
        },
        MESSAGES: {
            SUCCESS_ASSIGN: 'Shift assigned successfully',
            ERROR_ASSIGN: 'Failed to assign shift',
            SUCCESS_CANCEL: 'Visit cancelled successfully',
            ERROR_DELETE: 'Failed to cancel visit',
            ERROR_UPDATE: 'Failed to update status'
        }
    },
    SCRUM_MASTER: {
        DASHBOARD: {
            TITLE: 'Scrum Master Dashboard',
            SUBTITLE: 'Technical system audit and testing center',
        },
        API_ENDPOINTS: {
            TITLE: 'API Endpoints Registry',
            SUBTITLE: 'Monitor and test system-wide endpoints',
            TEST_BTN: 'Test Endpoint',
        },
        PAGES: {
            TITLE: 'System Pages Audit',
            SUBTITLE: 'Physical components and route mapping',
        },
        COMPONENTS: {
            TITLE: 'UI Components Library',
            SUBTITLE: 'Shared components and design tokens',
        },
        ROLE_FLOWS: {
            TITLE: 'Role Navigation Flows',
            SUBTITLE: 'Audit user journeys and permissions',
        },
        MONITORING: {
            TITLE: 'System Health Monitor',
            SUBTITLE: 'Real-time operational status and infrastructure telemetry',
        },
        ENV_AUDIT: {
            TITLE: 'Environment Audit',
            SUBTITLE: 'Sanitized system configuration and environment mapping',
        },
        REGISTRY_CHECK: {
            TITLE: 'Registry Integrity Monitor',
            SUBTITLE: 'Cross-referencing shared registries for consistency',
        },
        DATABASE_SCHEMA: {
            TITLE: 'Database Schema Audit',
            SUBTITLE: 'Prisma model overview and relationship mapping',
        },
    },
    LEARN: {
        TITLE: 'System Training Hub',
        SUBTITLE: 'Learn how to effectively use the PrimeCare platform',
        WHAT_YOU_CAN_DO: 'What You Can Do',
        PRO_TIPS: 'Pro Tips & Efficient Workflows',
    },
    DEV_KB: {
        TITLE: 'Developer Knowledge Base',
        SUBTITLE: 'Technical documentation and system architecture audit',
    },
    AUDIT: {
        TABS: {
            ROUTES: 'System Routes',
            COMPONENTS: 'Core Components',
        },
        TABLE: {
            ROUTE_NAME: 'Route Name',
            PATH: 'Browser Path',
            REFERENCE: 'Registry Reference',
            MODULE: 'Module',
            COMPONENT_NAME: 'Component Name',
            LAYER: 'Architecture Layer',
        }
    },
    ROLE_LABELS: {
        ADMIN: 'Master Franchise',
        MANAGER: 'Agency Operator',
        STAFF: 'Staff Member',
        PSW: 'Caregiver (PSW)',
        CLIENT: 'Client / Family',
    }
} as const;
