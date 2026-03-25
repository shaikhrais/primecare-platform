import { scrumMasterContent } from './scrum-master';

export const navContent = {
    LINKS: {
        ADMIN: {
            AUDITS: 'Security Audits',
            USERS: 'User Management',
            SCHEDULE: 'Global Schedule',
            INCIDENTS: 'Global Incidents',
            TIMESHEETS: 'Payroll Timesheets',
            LEADS: 'Growth Pipeline',
            SERVICES: 'Service Catalog',
            SETTINGS: 'Global Settings',
            CONTENT: 'Content Manager',
            ADMISSION: 'Admission Center',
            REPORTS: 'Report Center',
            SETUP_WIZARD: 'Setup Wizard',
            SEARCH: 'Global Search',
            CUSTOMERS: 'Customer CRM',
            EARNINGS: 'Earnings Ledger',
            INTEROP: 'Electronic Health Link',
            LOCATIONS: 'Branch Mapping',
            LOGISTICS: 'Logistics Hub',
            REGIONS: 'Region Mapping',
            AI_COMMAND: 'AI Command Center',
            MULTI_CURRENCY: 'Multi-Currency Settings',
            AUDIT_TRAIL: 'Audit Trail Viewer',
            FRANCHISE: 'Franchise Management',
            SUPPLY_CHAIN: 'Supply Chain Management'
        },
        SCRUM_MASTER: {
            API_HUB: 'API Integrity Hub',
            MONITORING: 'System Health',
            ENV_AUDIT: 'Environment Audit',
            REGISTRY: 'Registry Integrity',
            SCHEMA: 'Schema Audit',
            BUILDS: 'Build Surveillance',
            SCANS: 'Vulnerability Scans',
            LOCALIZATION: 'Localization Audit',
            AUTO_FIX: 'Auto-Repair Engine',
            IMPERSONATE: 'Role Shadowing',
            RESPONSE_BOT: 'Response Bot AI',
            PERFORMANCE: 'Node Performance',
            THEME_LAB: 'Theme Studio'
        },
        MANAGER: {
            PL: 'Branch Profit & Loss',
            OPS_TRIAGE: 'Operations Triage',
            COMPLIANCE: 'Compliance Monitor',
            HOME: 'Branch Home',
            AGENCY_HUB: 'Agency Operations Hub',
            FINANCIALS: 'Branch Financials',
            TEAM: 'Branch Team',
            GAMIFICATION: 'Gamification Hub',
            IOT_MONITORING: 'IoT Monitoring',
            DOCUMENT_SIGNING: 'Document Signing Center',
            SMS_HUB: 'SMS Command Center',
            PERFORMANCE_REVIEWS: 'Staff Performance Reviews',
            TRAINING_ACADEMY: 'Training Academy'
        },
        COORDINATOR: {
            HUB: 'Dispatch Center',
            SOS: 'SOS Center',
            MAP: 'Dispatcher Map',
            WAITLIST: 'Inflow Waitlist',
            SOS_HUB: 'SOS Dispatch Hub',
            MASTER_SCHEDULE: 'Master Schedule'
        },
        PSW: {
            OFFERS: 'Shift Marketplace',
            HANDOVER: 'Shift Handover',
            AVAILABILITY: 'Availability Overrides',
            EARNINGS: 'Earnings & Payouts',
            LIVE_VISIT: 'Live Visit Center',
            MY_AVAILABILITY: 'My Availability',
            GUIDE: 'PSW User Guide'
        },
        RN: {
            SUPERVISION: 'Supervision Hub',
            OPS_VERIFY: 'Professional Sign-off',
            CARE_PLANS: 'Care Plan Management',
            ASSESSMENTS: 'Clinical Intake',
            PHARMACY: 'Pharmacy Hub'
        },
        CLIENT: {
            SUPPORT: 'Nursing Chat',
            TEAM: 'My Care Team',
            BILLING: 'Billing & Invoices'
        },
        REGIONAL: {
            INTELLIGENCE: 'Regional Intelligence',
            FINANCE: 'Regional Finance Hub'
        },
        SHARED: {
            STOCK: 'Stock & Inventory',
            PROCUREMENT: 'Procurement Hub',
            TELEHEALTH: 'Telehealth Center',
            REMOTE_ALERTS: 'Remote Alerts',
            CLAIMS: 'Claims Command Center',
            REVENUE: 'Revenue Analytics',
            MAR: 'Digital MAR'
        }
    },
    SCRUM_MASTER: scrumMasterContent,
    PROFILE: {
        TITLE: 'Account Profile',
        SUBTITLE: 'Manage your personal information and preferences.',
        FULL_NAME: 'Full Name',
        BIO: 'Professional Bio',
        ADDRESS: 'Address',
        CITY: 'City',
        EMAIL_LABEL: 'Email (Unchangeable)',
        PHONE_LABEL: 'Phone',
        SECURITY: {
            TITLE: 'Location Verification',
            SYNCED: '📍 Coordinate Synced',
            PENDING: '⏳ Pending Sync',
            FOOTER: (role: string) => 'we use this for coordinate verification and secure ' + (role === 'psw' ? 'check-ins' : 'visit security') + '.',
        },
        GUARD: {
            TITLE: 'Unsaved Changes',
            MESSAGE: 'You have unsaved changes. Navigating away will discard them. Would you like to stay and save?',
            LEAVE: 'Leave',
            STAY: 'Stay',
        },
        MESSAGES: {
            FETCH_ERROR: 'Failed to load profile data',
            SAVE_SUCCESS: 'Profile updated successfully!',
            SAVE_ERROR: 'Failed to update profile',
            LOADING: 'Loading profile...',
            SAVING: 'Saving...',
            SAVE_BTN: 'Save Changes',
        }
    },
    ROLE_HELP: {
        TITLE: '💡 Umbrella Role System',
        ADMIN: {
            TITLE: 'Core Administration',
            LABEL: 'Master Franchise',
            INFO: 'Full system access. Manage global settings, billing architecture, and system roles.'
        },
        STAFF: {
            TITLE: 'Operations Umbrella',
            LABEL: 'Staff / HR / Finance',
            INFO: 'Manage day-to-day coordination: scheduling visits, payroll processing, and compliance monitoring.'
        },
        MANAGER: {
            TITLE: 'Management Umbrella',
            LABEL: 'Child Agency Operators',
            INFO: 'Strategic oversight: access to operational analytics, service audits, and department-level reporting.'
        },
        PROVIDER: {
            TITLE: 'Healthcare Workers',
            LABEL: 'Service Providers (PSW / RN)',
            INFO: 'Field operations: Direct care delivery, shift scheduling, and clinical documentation.'
        },
        CLIENT: {
            TITLE: 'Clients & Guardians',
            LABEL: 'Client / Family Profile',
            INFO: 'Service recipients: Manage family care requests, view assigned visits, and handle private billing.'
        },
        TIP_LABEL: 'Tip:',
        TIP_CONTENT: 'Users can possess multiple roles across umbrellas to aggregate permissions and access.'
    },
} as const;
