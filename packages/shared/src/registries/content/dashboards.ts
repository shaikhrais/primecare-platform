import { dashboardsFinanceContent } from './dashboards-finance';

export const dashboardsContent = {
    ADMIN_DASHBOARD: {
        STATS: {
            TOTAL_USERS: 'Total Users',
            NEW_INQUIRIES: 'New Inquiries',
            PENDING_VISITS: 'Pending Visits',
            TOTAL_VISITS: 'Total Care Visits',
        },
        TITLES: {
            WELCOME: 'Welcome back, Master Franchise',
            SUBTITLE: "Here is what's happening today across your network.",
            QUICK_ACTIONS: 'Quick Actions',
            OPERATIONAL_STATUS: 'Operational Status',
            ANALYTICS: 'Performance Analytics',
        },
        SETUP_BANNER: {
            TITLE: '🚀 Business Ready?',
            SUBTITLE: 'Check your command center and complete your setup.',
            ACTION: 'Review Business Status',
            TRAINING: '🎓 System Training',
            SCORE_LABEL: 'Business Model Score',
            STRATEGY_LINK: 'Business Strategy',
            STRATEGY_DESC: 'to reach 100%.',
        },
        ACTIONS: {
            VIEW_DETAILS: 'Click to view details →',
            CHECK_CERTS: 'Check certifications',
            VIEW_SCHEDULE: 'View Schedule',
            MANAGE_ASSIGNMENTS: 'Manage assignments',
            REVIEW_LEADS: 'Review Leads',
            RESPOND_INQUIRIES: 'Respond to inquiries',
            SYSTEM_CONFIG: 'System Config',
            APP_ADJUSTS: 'App adjustments',
            POST_SHIFT: '+ Post New Shift',
            POST_SHIFT_DESC: 'Direct or open posting',
            POST_SUCCESS: 'Shift posted successfully!',
            FIX: 'Fix',
            VIEW: 'View',
            ACTION: 'Action',
        },
        STATUS: {
            API: 'Worker API Status',
            CLIENT_APP: 'Mobile Client App',
            PSW_APP: 'Mobile PSW App',
            HEALTHY: '● Healthy',
            ONLINE: (v: string) => `● v${v} Online`,
        }
    },
    CLIENT_DASHBOARD: {
        TITLE: 'My Care Hub',
        SUBTITLE: 'Welcome back to your family care portal.',
        BUTTON_REQUEST: 'Request New Care',
        MODAL_TITLE: 'Request New Care',
        MODAL_SUBTITLE: 'Please select your care type and preferred time.',
        MESSAGES: { LOADING: 'Loading Client Dashboard...' },
        FAMILY_HUB: {
            TITLE: 'Family Care Hub',
            SUBTITLE: 'Oversight, notifications, and care team engagement.',
            FEED_TITLE: 'Care Timeline',
            TEAM_TITLE: 'Your Care Team',
            BILLING_TITLE: 'Recent Invoices',
            PULSE_TITLE: 'Care Pulse (Direct Feedback)',
        },
        FEEDBACK_LOOP: {
            TITLE: 'Care Feedback Loop',
            SUBTITLE: 'Help us improve by rating your recent care visits.',
            SUCCESS_MSG: 'Thank you for your feedback! It helps us maintain premium care standards.',
        }
    },
    PSW_DASHBOARD: {
        TITLE: 'Caregiver Command Center',
        SUBTITLE: 'Manage your active visits, earnings, and professional profile.',
        BUTTON_FULL_SCHEDULE: 'View Full Schedule',
        SECTION_SHIFTS: 'Active Care Timeline',
        NO_SHIFTS: 'Your timeline is currently clear. Expect new assignments soon.',
        STATS: {
            NEXT_VISIT: 'Next Visit In',
            WEEKLY_HOURS: 'Weekly Hours',
            PENDING_PAYOUT: 'Pending Payout',
        },
        MESSAGES: { LOADING: 'Synchronizing Command Center...' }
    },
    RN_DASHBOARD: {
        TITLE: 'Clinical Dashboard',
        SUBTITLE: 'Branch-wide clinical overview and task triage.',
        MESSAGES: { LOADING: 'Synchronizing Clinical Center...' },
        STATS: {
            PENDING_CARE_PLANS: 'Pending Care Plans',
            DAILY_REVIEWS: 'Daily Audits Needed',
            SUPERVISED_PSWS: 'Supervised PSWs',
        },
        TASKS: {
            TITLE: 'Clinical Task Triage',
            EMPTY: 'No urgent clinical tasks identified.',
            PATIENT_LABEL: 'Patient: ',
            RESOLVE_BTN: 'Resolve',
        }
    },
    STAFF_DASHBOARD: {
        TITLE_BRANCH: 'Branch Coordination Hub',
        TITLE_NETWORK: 'Network Coordination Hub',
        SUBTITLE: 'Daily Schedule & Compliance',
        MESSAGES: { LOADING: 'Loading Staff Dashboard...' },
        STATS: {
            URGENT_NEEDS: 'Urgent Scheduling Needs',
            URGENT_DESC: 'Shifts requiring immediate assignment',
            ACTIVE_CAREGIVERS: 'Active Caregivers',
            ACTIVE_DESC: 'PSWs and RNs fully compliant',
            MISSING_TIMESHEETS: 'Missing Timesheets',
            MISSING_DESC: 'Awaiting provider submission',
        },
        PRIORITIES: {
            TITLE: "Today's Operational Priorities",
            COMPLIANCE_TITLE: 'Review Compliance Expirations',
            COMPLIANCE_DESC: 'Caregivers have CPR certs expiring this week.',
            COMPLIANCE_BTN: 'Review',
            TIMESHEETS_TITLE: 'Approve Pending Timesheets',
            TIMESHEETS_DESC: 'shifts from yesterday require manager sign-off.',
            TIMESHEETS_BTN: 'Timesheets',
            FEEDBACK_TITLE: 'Client Feedback Follow-ups',
            FEEDBACK_DESC: 'families requested scheduling adjustments.',
            FEEDBACK_BTN: 'Support',
        }
    },
    MANAGER_DASHBOARD: {
        TITLE: 'Branch Dashboard',
        SUBTITLE: 'Local agency operational overview',
        QUICK_ACTIONS: 'Quick Actions',
        ANALYTICS: 'Performance Analytics',
        KPI: {
            TODAY_SHIFTS: "Today's Shifts",
            ACTIVE_CLIENTS: 'Active Clients',
            STAFF_ON_DUTY: 'Staff On Duty',
            OPEN_INCIDENTS: 'Open Incidents',
        },
        ACTIONS: {
            DAILY_CARE: 'Daily Care Entry',
            STAFF_EVAL: 'Staff Evaluations',
            SERVICE_REVIEW: 'Service Reviews',
            LOG_INCIDENT: 'Log Incident',
            VIEW_CLIENTS: 'View Clients',
        },
        PERSPECTIVES: ['Operations', 'Clinical', 'Marketing', 'Recruiting', 'Finance'] as const,
        MESSAGES: { LOADING: 'Loading Dashboard...' }
    },
    PLATFORM_DASHBOARD: {
        TITLE: 'Platform Command Center',
        SUBTITLE: 'Fractal SaaS Network Overview',
        MESSAGES: { LOADING: 'Loading Global Stats...' },
        STATS: {
            MASTER_AGENCIES: 'Master Franchises (Roots)',
            NETWORK_USERS: 'Total Network Users',
            PLATFORM_VISITS: 'Total Platform Visits',
        },
        HEALTH: {
            TITLE: 'Platform Health',
            DESC: 'All routing and payment systems operational across the entire franchise network.',
        },
        RISK: {
            TITLE: 'Risk Surveillance',
            DESC: 'No critical compliance threats detected across Master or Sub-Agencies.',
        }
    },
    SUMMARY_DASHBOARD: {
        TITLE: 'Registry Intelligence Dashboard',
        SUBTITLE: 'Real-time platform summaries, KPIs, and registry-driven insights.',
        HEADER: { CONTEXT: 'Context', LAST_UPDATED: 'Last Synchronized', SYNC_NOW: 'Sync Orbit' },
        CARDS: {
            KPI: 'Performance KPI',
            TREND: 'Registry Trend',
            REGISTRY_HUB: {
                TITLE: 'Registry Intelligence Hub',
                SUBTITLE: 'Consolidated platform KPIs, stats, and registry-driven insights.',
            }
        },
        MESSAGES: { EMPTY: 'No summary contexts registered.', SYNCING: 'Calibrating registry nodes...' }
    },
    COORDINATOR_HUB: {
        TITLE: 'Logistics Control Center',
        SUBTITLE: 'Live Dispatch, SOS Monitoring, and Waitlist Synchronization.',
        MAP_TITLE: 'Live Dispatch Map',
        GRID_TITLE: 'Scheduling Grid',
        SOS_TITLE: 'SOS Emergency Response',
        WAITLIST_TITLE: 'Waitlist Manager',
        STATS: {
            LIVE_PSW: 'PSWs on Duty',
            SOS_ACTIVE: 'Active SOS Alerts',
            PENDING_MATCHES: 'Open Shifts',
            WAITLIST_COUNT: 'Waitlisted Clients',
        },
        ACTIONS: { ACKNOWLEDGE_SOS: 'Acknowledge SOS', OVERRIDE_MATCH: 'Override Match', SYNC_WAITLIST: 'Sync Priorities' },
        SUCCESS: { SOS_ACK: 'SOS alert acknowledged.', MATCH_OVERRIDDEN: 'PSW manual assignment confirmed.', WAITLIST_SYNCED: 'Waitlist priorities updated.' }
    },
    ...dashboardsFinanceContent,
} as const;
