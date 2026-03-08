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
            REGIONS: 'Region Mapping'
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
            DASHBOARD: 'Branch Dashboard',
            AGENCY_HUB: 'Agency Operations Hub',
            FINANCIALS: 'Branch Financials',
            TEAM: 'Branch Team'
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
            MY_AVAILABILITY: 'My Availability'
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
    SCRUM_MASTER: {
        API_HUB: {
            TITLE: 'API Integrity Hub',
            SUBTITLE: 'Endpoint registry',
            TEST_BTN: 'Test Protocol',
            READY: 'Registry Ready',
            TESTING: '⌛ Analysis...',
        },
        MONITORING: {
            TITLE: 'System Health',
            SUBTITLE: 'Real-time platform vitals and operational telemetry.',
            API_CLUSTER: 'Worker API Cluster',
            UPTIME_DESC: 'Continuous operational uptime per role basis.',
            DB_TELEMETRY: 'Database Query Latency',
            LOGS_TITLE: 'Live System Logs',
            HEARTBEAT: 'System heartbeat pulse detected.',
        },
        ENV_AUDIT: { TITLE: 'Environment Audit' },
        REGISTRY_CHECK: { TITLE: 'Registry Integrity' },
        SCHEMA: { TITLE: 'Schema Audit' },
        BUILDS: { TITLE: 'Build Surveillance' },
        SCANS: { TITLE: 'Vulnerability Scans' },
        LOCALIZATION: {
            TITLE: 'Localization Audit',
            SUBTITLE: 'I18n coverage and registry shadowing report.',
        },
        PERFORMANCE: {
            TITLE: 'Node Performance',
            SUBTITLE: 'Real-time node and worker performance metrics.',
        },
        THEME_LAB: { TITLE: 'Theme Studio' },
        SECURITY_SCANS: {
            TITLE: 'Security Scans',
            SUBTITLE: 'Vulnerability and dependency lattice surveillance.',
        },
        BUILD_HEALTH: {
            TITLE: 'Build Health',
            SUBTITLE: 'Live CI/CD and production bundle status.',
        },
        MONITORING_STATS: { TITLE: 'Monitoring Stats' },
        DATABASE_SCHEMA: { TITLE: 'Database Schema' },
        INTEGRITY: { TITLE: 'System Integrity' },
        COMPONENTS: { TITLE: 'UI Comp' },
        PAGES: {
            TITLE: 'Pages',
            SUBTITLE: 'Fractal tiering and route validation.',
        },
        API_ENDPOINTS: {
            TITLE: 'APIs',
            SUBTITLE: 'Endpoint health and latency tracking.',
        },
        DASHBOARD: {
            TITLE: 'Scrum Master Dashboard',
            SUBTITLE: 'Engineering oversight and platform integrity metrics.',
        },
        DEV_KB: {
            TITLE: 'Developer Knowledge Base',
            SUBTITLE: 'Documentation for technical architecture and engineering patterns.',
            SEARCH_PLACEHOLDER: 'Search architecture docs...',
        },
        ANALYTICS: {
            TITLE: 'System Health Telemetry',
            LATENCY: 'API Latency (v1)',
            ERRORS: 'Error Distribution',
            AVAILABILITY: 'System Availability',
            COMPLIANCE: 'Registry Compliance',
            X_AXIS: 'Time',
            Y_AXIS: 'ms',
        },
        ALERTS: {
            TITLE: 'Active System Alerts',
            CRITICAL: 'Critical Environment Failure',
            WARNING: 'Sync Latency High',
            INFO: 'Daily Compliance Job Pending',
            RESOLVE: 'Resolve',
        },
        ROADMAP: {
            TITLE: 'Product Roadmap & Enhancements',
            PHASE_1: 'Phase 14: Health Analytics',
            PHASE_2: 'Phase 15: AI-Driven Self-Healing',
            PHASE_3: 'Phase 16: Multi-Cloud Replication',
            STATUS_PLANNED: 'Planned',
            STATUS_IN_PROGRESS: 'In Progress',
            STATUS_COMPLETED: 'Completed',
        },
        COPILOT: {
            TITLE: 'Scrum Master AI Copilot',
            SUBTITLE: 'Predictive analytics and autonomous health management',
            SUGGESTION_1: 'Optimize API caching for /v1/admission',
            SUGGESTION_2: 'Unusual latency spike detected in US-EAST cluster',
            SUGGESTION_3: 'Schema drift detected in Earnings module',
        },
        ROLE_FLOWS: {
            TITLE: 'Flows',
            SUBTITLE: 'User journeys',
            SECURITY_ROLES: 'Security Roles',
            WORKFLOW_PATHWAY: 'Workflow pathway',
            STEPS: {
                ADMIN: ['Dashboard Overlay', 'User Management', 'Global Schedule', 'Earnings Center', 'System Settings', 'Developer Audit Hub'],
                SCRUM_MASTER: ['Technical Dashboard', 'API Registry Audit', 'Blueprint Gap Analysis', 'Performance Sweep', 'Security Surveillance', 'Theme Customization'],
                MANAGER: ['Operations Dashboard', 'Shift Coordination', 'Clinical Reviews', 'Payroll Verification', 'Regional Analytics'],
                MARKETING_MANAGER: ['Growth Pipeline', 'CRM Management', 'Lead Conversion', 'Campaign Performance'],
                HR_MANAGER: ['Talent Pipeline', 'Recruitment Funnel', 'Onboarding Tracking', 'Compliance Audits'],
                FINANCE_MANAGER: ['Revenue Intelligence', 'Expense Audits', 'Payroll Reconciliation', 'Tax Compliance'],
                REGIONAL_MANAGER: ['Regional P&L', 'Branch Benchmarking', 'Operational Overhead', 'Growth Strategy'],
                CLINICAL_MANAGER: ['Clinical Audit', 'Medication Safety', 'QA Compliance', 'Incident Oversight'],
                COORDINATOR: ['Live Dispatch Map', 'SOS Queue', 'Coverage Alerts', 'Emergency Check-in'],
                RECRUITING_MANAGER: ['Job Postings', 'Candidate Screening', 'Interview Roster', 'Offer Management'],
                STAFF: ['Staff Hub', 'Lead Inquiries', 'Customer Roster', 'Incident Logging', 'Compliance Monitoring'],
                RN: ['Clinical Dashboard', 'Care Plan Manager', 'Daily Entry Audit', 'Supervision Hub'],
                PSW: ['My Schedule', 'Open Market', 'Visit Check-in/out', 'Payout Requests', 'Compliance Ledger'],
                CLIENT: ['Care Hub', 'New Request', 'Assigned Team', 'Digital Invoices', 'Feedback Gateway'],
            }
        },
    },
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
