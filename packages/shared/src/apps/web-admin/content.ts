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
        THEME: 'Theme Center',
        RESELLER: 'Reseller Hub',
        ERP: 'Supply Chain Hub',
        TELEHEALTH: 'Telehealth Center',
        RCM: 'Claims Hub',
        PHARMACY: 'Pharmacy Hub',
        FORENSIC_TRAILS: 'Forensic Trails',
        CORS_SETTINGS: 'CORS Settings',
        INTEGRITY_SCAN: 'Integrity Check',
        FINANCIAL_LEDGER: 'Financial Ledger',
    },
    PHARMACY: {
        TITLE: 'Pharmacy & Medication Hub',
        SUBTITLE: 'E-prescribing, MAR tracking, and pharmacy integration.',
        LIST_TITLE: 'Active Medication Records',
        STATS: {
            ACTIVE: 'Active Prescriptions',
            PENDING: 'Pending Renewals',
            COMPLIANCE: 'MAR Compliance',
            ALERTS: 'Critical Alerts',
        }
    },
    RCM: {
        TITLE: 'Revenue Cycle Management (RCM)',
        SUBTITLE: 'Manage insurance claims, adjudications, and financial health.',
        LEDGER_TITLE: 'Claims Management Ledger',
        STATS: {
            REVENUE: 'Total Revenue (MTD)',
            PENDING: 'Pending Claims',
            DENIED: 'Denied Claims',
            CLEAN_RATE: 'Clean Claim Rate',
        }
    },
    TELEHEALTH: {
        TITLE: 'Telehealth & RPM Center',
        SUBTITLE: 'Encrypted video consultations and live remote patient monitoring.',
        SESSIONS_TITLE: 'Active Consultations',
        STATS: {
            GATEWAY: 'Gateway Status',
            ALERTS: 'Critical Alerts',
        }
    },
    ERP: {
        TITLE: 'ERP & Supply Chain Hub',
        SUBTITLE: 'Manage medical inventory, suppliers, and procurement lifecycles.',
        LEDGER_TITLE: 'Systemic Inventory Ledger',
        STATS: {
            SKU_COUNT: 'Total SKU Count',
            LOW_STOCK: 'Low Stock Alerts',
            OPEN_POS: 'Open POs',
            LATENCY: 'Procurement Latency',
        }
    },
    OPERATIONS: {
        TITLE: 'Live Operations Center',
        SUBTITLE: 'Real-time visibility into field operations, fleet tracking, and visit management.',
        MENU: 'Operations Center',
    },
    RESELLER: {
        TITLE: 'White-Label Reseller Hub',
        SUBTITLE: 'Spawn and manage your child agencies in the Fractal SaaS network.',
        PROVISION_TITLE: 'Provision New Agency',
        STATS: {
            REVENUE: 'Total Portfolio MRR',
            SUCCESS: 'Franchise Success Rate',
            CAPACITY: 'Provisioning Capacity',
        }
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
