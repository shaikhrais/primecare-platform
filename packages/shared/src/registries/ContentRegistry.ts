export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare',
        TAGLINE: 'Compassionate Care, Professional Service',
    },
    AUTH: {
        LOGIN_TITLE: 'Sign in to your account',
        LOGIN_TITLE_CLIENT: 'Client Portal Login',
        LOGIN_TITLE_STAFF: 'Staff Portal Login',
        LOGIN_TITLE_PSW: 'Caregiver Portal Login',
        LOGIN_TITLE_RN: 'Registered Nurse Portal Login',
        BUTTON: 'Sign in',
        BUTTON_CLIENT: 'Sign In as Client',
        BUTTON_PSW: 'Sign In as Caregiver',
        BUTTON_RN: 'Sign In as RN',
        BUTTON_STAFF: 'Sign In as Staff',
        EMAIL_LABEL: 'Email address',
        PASSWORD_LABEL: 'Password',
        FORGOT_PASSWORD: 'Forgot password?',
        REGISTER_TITLE: 'Create your account',
        BUTTON_REGISTER: 'Sign up',
        SIGNUP_LINK: "Don't have an account? Sign up",
    },
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
        MESSAGES: {
            LOADING: 'Loading Client Dashboard...',
        }
    },
    PSW_DASHBOARD: {
        TITLE: 'My Work Schedule',
        SUBTITLE: 'Stay updated on your upcoming assigned care visits.',
        BUTTON_FULL_SCHEDULE: 'View Full Schedule',
        SECTION_SHIFTS: 'Shift Schedule',
        NO_SHIFTS: 'You have no shifts scheduled at this time.',
        MESSAGES: {
            LOADING: 'Loading Provider Dashboard...',
        }
    },
    RN_DASHBOARD: {
        TITLE: 'Clinical Care Management',
        SUBTITLE: 'Supervise care plans, review daily entries, and manage clinical outcomes.',
        QUICK_ACTIONS: 'Clinical Oversight',
        STATS: {
            PENDING_CARE_PLANS: 'Care Plans to Review',
            DAILY_REVIEWS: 'Daily Entries to Verify',
            SUPERVISED_PSWS: 'PSWs Under Supervision',
        },
        TASKS: {
            TITLE: 'Pending Clinical Tasks',
            EMPTY: 'No pending clinical tasks.',
            RESOLVE_BTN: 'Resolve Task',
            PATIENT_LABEL: 'Patient: ',
        },
        MESSAGES: {
            LOADING: 'Loading Clinical Dashboard...',
        }
    },
    PLATFORM_DASHBOARD: {
        TITLE: 'Platform Command Center',
        SUBTITLE: 'Fractal SaaS Network Overview',
        MESSAGES: {
            LOADING: 'Loading Global Stats...',
        },
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
    STAFF_DASHBOARD: {
        TITLE_BRANCH: 'Branch Coordination Hub',
        TITLE_NETWORK: 'Network Coordination Hub',
        SUBTITLE: 'Daily Schedule & Compliance',
        MESSAGES: {
            LOADING: 'Loading Staff Dashboard...',
        },
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
    USERS: {
        TITLE: 'Users & Healthcare Workers',
        APPROVE_BTN: 'Approve',
        ROLE: 'Role',
        STATUS: 'Status',
        INVITE_BTN: 'Invite User',
        ADD_BTN: 'Add New User',
        INVITE_PROMPT: 'Enter email to invite:',
        INVITE_SUCCESS: (email: string) => `Invitation sent to ${email}`,
        VERIFY_BTN: 'Verify Certs',
        EDIT_BTN: 'Edit',
        ID_VERIFICATION: 'ID Verification',
        ACTIONS: 'Actions',
        VERIFIED: 'Verified',
        PENDING: 'Pending Review',
        CLEAR_FILTERS: 'Clear All',
        ACTIVE_FILTERS: 'Active Filters:',
        MESSAGES: {
            LOADING: 'Retrieving secure user registry...',
            EMPTY: 'No users found in the registry.',
            ERROR_VERIFY: 'Failed to approve worker',
            ERROR_LOAD: 'Failed to load user list',
            SUCCESS_VERIFY: 'User extracted and verified successfully',
            ERROR_ACTION: 'Action failed',
        },
        MODAL: {
            INVITE_TITLE: 'Invite New User',
            DISCARD_TITLE: 'Discard Invite?',
            DISCARD_DESC: 'Are you sure you want to cancel this invitation?',
            DISCARD_BTN: 'Discard',
            STAY_BTN: 'Stay',
            SEND_BTN: 'Send Invite',
            SENDING: 'Sending...',
        },
        FORM: {
            TITLE_CREATE: 'Create New User',
            TITLE_EDIT: 'Edit User',
            SUBTITLE: 'Manage system access and profile details.',
            BTN_CREATE: 'Create User',
            BTN_UPDATE: 'Update User',
            BTN_CANCEL: 'Cancel',
            LOADING: 'Loading user data...',
            ERROR_LOAD: 'Failed to load user data',
            SUCCESS_CREATE: 'User created successfully',
            SUCCESS_UPDATE: 'User updated successfully',
            ERROR_ACTION: 'Action failed',
        }
    },
    INCIDENTS: {
        TITLE: 'Incident Reports',
        SUBTITLE: 'Document clinical or operational incidents for audit.',
        ADD_BTN: 'Report Incident',
        FORM: {
            TITLE: 'Report New Incident',
            TYPE_LABEL: 'Incident Type',
            SEVERITY_LABEL: 'Severity',
            DESC_LABEL: 'Description',
            SUBMIT_BTN: 'Submit Report',
            REPORTING: 'Reporting...',
            SUCCESS_MSG: 'Incident report submitted',
            ERROR_MSG: 'Submission failed',
        },
        RESOLVE: {
            BTN: 'Resolve',
            TITLE: 'Resolve Incident',
            NOTES_LABEL: 'Resolution Notes',
            NOTES_PLACEHOLDER: 'Describe the steps taken to resolve this incident...',
            RESOLVING_LOADING: 'Resolving...',
            DISCARD_TITLE: 'Discard Changes?',
            DISCARD_DESC: 'You have typed resolution notes. Are you sure you want to cancel?',
            SUCCESS: 'Incident resolved successfully',
            ERROR: 'Failed to resolve incident',
        },
        TABLE: {
            TYPE: 'Type',
            REPORTER: 'Reporter',
            STATUS: 'Status',
            DATE: 'Date',
            ACTIONS: 'Actions',
            LOADING: 'Loading incidents...',
        }
    },
    LEADS: {
        TITLE: 'Lead Inquiries',
        SUBTITLE: 'Track and manage potential client inquiries.',
        ADD_BTN: 'New Lead',
        SEARCH_PLACEHOLDER: 'Search leads...',
        ACTIONS: {
            EXPORT: 'Export CSV',
            REFRESH: 'Refresh',
            REFRESHING: 'Refreshing...',
            MARK_CONTACTED: 'Mark Contacted',
            CONVERT: 'Convert',
            CLOSE: 'Close',
        },
        FORM: {
            TITLE: 'New Lead Entry',
            SUBTITLE: 'Record an offline inquiry.',
            SOURCE_LABEL: 'Inquiry Source',
            NAME_LABEL: 'Lead Name',
            SUBMIT_BTN: 'Create Lead',
            SAVING: 'Saving...',
            SUCCESS_MSG: 'Lead created successfully',
            ERROR_MSG: 'Error creating lead',
            DISCARD_TITLE: 'Discard Lead?',
        },
        TABLE: {
            NAME: 'Name',
            CONTACT: 'Contact',
            INTEREST: 'Interest',
            STATUS: 'Status',
            DATE: 'Date',
            ACTIONS: 'Actions',
            NO_LEADS: 'No leads found matching your search.',
        },
        STATUS: {
            NEW: 'New',
            CONTACTED: 'Contacted',
            CONSULTATION: 'Consultation',
            CONVERTED: 'Converted',
            LOST: 'Lost',
        },
        MESSAGES: {
            LOADING: 'Loading leads repository...',
            EMPTY: 'No leads found.',
            ERROR: 'Failed to fetch leads',
            SUCCESS_UPDATE: 'Status updated successfully',
            ERROR_UPDATE: 'Failed to update status',
            SUCCESS_DELETE: 'Lead deleted successfully',
            ERROR_DELETE: 'Error deleting lead',
        }
    },
    SCHEDULE: {
        TITLE: 'Visit Schedule',
        SUBTITLE: 'Coordinate care visits and assign PSWs to client requests.',
        ACTIONS: {
            CREATE: '+ Create Visit Request',
            ASSIGN: 'Assign Caregiver',
            CONFIRM_ASSIGN: 'Confirm Assignment',
            CANCEL_VISIT: 'Cancel Visit',
            CLOSE: 'Close',
            EDIT: 'Edit Details',
        },
        MODAL: {
            SELECT_PSW: 'Select Verified PSW',
            CHOOSE_WORKER: '-- Choose a worker --',
            CONFIRM_DELETE: 'Are you sure you want to cancel this visit?',
        },
        MESSAGES: {
            SUCCESS_ASSIGN: 'PSW assigned successfully!',
            SUCCESS_CANCEL: 'Visit cancelled',
            ERROR_ASSIGN: 'Assignment failed',
            ERROR_DELETE: 'Failed to delete visit',
            ERROR_UPDATE: 'Status update failed',
            OFFERS_SENT: 'Offers sent successfully',
            OFFERS_FAILED: 'Failed to send offers',
            SURGE_SUCCESS: 'Surge pricing updated successfully',
            SURGE_ERROR: 'Failed to apply surge pricing',
            NETWORK_ERROR: 'Network error while applying surge',
        }
    },
    SERVICES: {
        TITLE: 'Services & Pricing',
        SUBTITLE: 'Manage the care packages and hourly rates offered to clients.',
        ADD_BTN: '+ Add New Service',
        TABLE: {
            NAME: 'Service Name',
            CATEGORY: 'Category',
            RATE: 'Hourly Rate',
            DESC: 'Description',
            ACTIONS: 'Actions',
            LOADING: 'Loading services...',
            EMPTY: 'No services configured.',
        },
        FORM: {
            TITLE_CREATE: 'Add New Service',
            TITLE_EDIT: 'Edit Service',
            NAME_LABEL: 'Service Name',
            RATE_LABEL: 'Hourly Rate ($)',
            CATEGORY_LABEL: 'Category',
            DESC_LABEL: 'Description',
            SAVE_BTN: 'Save Service',
            CANCEL_BTN: 'Cancel',
            DISCARD_TITLE: 'Discard Changes?',
            DISCARD_DESC: 'You have unsaved changes in this service. Are you sure you want to close?',
        },
        MESSAGES: {
            SUCCESS_CREATE: 'Service created successfully!',
            SUCCESS_UPDATE: 'Service updated successfully!',
            SUCCESS_DELETE: 'Service deleted successfully',
            ERROR_SAVE: 'Failed to save service',
            ERROR_DELETE: 'Failed to delete service',
            ERROR_LOAD: 'Failed to load services',
            CONFIRM_DELETE: 'Are you sure you want to delete this service?',
        },
        CATEGORIES: {
            SENIOR_CARE: 'Senior Care',
            FOOT_CARE: 'Foot Care',
            CONSULTING: 'Consulting',
            TRAINING: 'Training',
        }
    },
    CUSTOMERS: {
        TITLE: 'Customer Management',
        SUBTITLE: 'Manage active clients and oversee care admissions.',
        ADD_BTN: '+ Admit New Client',
        SEARCH_PLACEHOLDER: 'Search clients...',
        TABLE: {
            NAME: 'Full Name',
            EMAIL: 'Email',
            STATUS: 'Status',
            ACTIONS: 'Actions',
            EMPTY: 'No customers found in the registry.',
            ANONYMOUS: 'Anonymous Customer',
            VIEW_DETAILS: 'View Details',
        },
        FILTERS: {
            ACTIVE_FILTERS: 'Active Filters:',
            CLEAR_ALL: 'Clear All',
            STATUS_LABEL: 'Status: ',
        },
        MESSAGES: {
            LOADING: 'Loading customer registry...',
        }
    },
    INVOICES: {
        TITLE: 'Invoice Management',
        SUBTITLE: 'Generate and track billing across the network.',
        FORM: {
            CREATE_TITLE: 'Create New Invoice',
            DESC_PLACEHOLDER: 'Description of service',
            AMOUNT_PLACEHOLDER: 'Amount ($)',
            ADD_ITEM: '+ Add Line Item',
            SUBMIT_BTN: 'Generate & Send Invoice',
            CANCEL_BTN: 'Cancel',
            DISCARD_TITLE: 'Discard Invoice?',
            DISCARD_DESC: 'Are you sure you want to cancel this invoice? Unsaved changes will be lost.',
        },
        MESSAGES: {
            SUCCESS_GENERATE: 'Invoice generated and sent successfully',
            ERROR_GENERATE: 'Failed to generate invoice',
        }
    },
    REPORTS: {
        TITLE: 'Reports & Analytics',
        SUBTITLE: 'Visualize key performance indicators and operational metrics.',
        EXPORT_BTN: 'Export CSV',
        DATE_RANGES: {
            7: 'Last 7 Days',
            30: 'Last 30 Days',
            90: 'Last Quarter',
            YEAR: 'Year to Date',
        },
        TABS: {
            OVERVIEW: 'Overview',
            FINANCIAL: 'Financials',
            STAFF: 'Staff Utilization',
            CLIENTS: 'Client Growth',
        }
    },
    SETTINGS: {
        TITLE: 'System Settings',
        SUBTITLE: 'Configure global parameters and administrative preferences.',
        NOTIFICATIONS: {
            TITLE: 'General Notifications',
            EMAIL_ALERTS: 'Email Alerts for New Leads',
            EMAIL_DESC: 'Notify administrators when a new inquiry is submitted.',
        },
        SCHEDULING: {
            TITLE: 'Booking & Scheduling',
            AUTO_ASSIGN: 'Automatic PSW Assignment',
            AUTO_DESC: 'Experimental: Match best worker automatically for nursing visits.',
            GRACE_PERIOD: 'Late Check-in Grace Period',
            GRACE_DESC: 'Minutes allowed after scheduled start before alert is triggered.',
        },
        ACTIONS: {
            RESET: 'Reset to Defaults',
            SAVE: 'Save Settings',
            SUCCESS_SAVE: 'Settings saved successfully!',
        }
    },
    ROLES: {
        ADMIN: 'Master Franchise',
        STAFF: 'Staff Member',
        PSW: 'Personal Support Worker',
        RN: 'Registered Nurse',
        CLIENT: 'Client',
        COORDINATOR: 'Scheduling Coordinator',
        FINANCE: 'Finance Manager',
        HR: 'HR Manager',
        COMPLIANCE: 'Compliance Officer',
        CRM: 'Client Relationship Manager',
        TRAINING: 'Training Manager',
    },
    MENU: {
        DASHBOARD: 'Dashboard',
        USERS: 'Users & PSWs',
        SCHEDULE: 'Schedule',
        INCIDENTS: 'Incidents',
        TIMESHEETS: 'Timesheets',
        LEADS: 'Lead Inquiries',
        SERVICES: 'Services',
        AUDITS: 'Call Audits',
        CONTENT: 'Content',
        REPORTS: 'Reports',
        SETTINGS: 'Settings',
        SUPPORT: 'Support',
        DEVELOPER: 'Developer',
        INSIGHTS: 'Insights',
        CLINICAL_AI: 'Clinical AI',
        INTEROPERABILITY: 'Interoperability',
        AUTOMATION: 'Automation',
        GROWTH: 'Growth Strategy',
        KNOWLEDGE_BASE: 'Knowledge Base',
        RESELLER: 'Reseller Hub',
        MARKETPLACE: 'Marketplace',
        PRIVATE_MARKET: 'Private Market',
        IDENTITY: 'My Identity',
        TRAINING: 'System Training',
        DEV_AUDIT: 'Developer Audit',
        CLIENT_HUB: 'My Care Hub',
        CLIENT_BOOKINGS: 'My Bookings',
        CLIENT_BILLING: 'Billing',
        PROFILE: 'Account Profile',
        STAFF_HUB: 'Staff Hub',
        CUSTOMERS: 'Customer Mgmt',
        TICKETS: 'Tickets',
        WORK_SCHEDULE: 'Work Schedule',
        OPEN_SHIFTS: 'Open Shifts',
        MY_SHIFTS: 'My Shifts',
        MY_EARNINGS: 'My Earnings',
        MY_CREDENTIALS: 'My Credentials',
        HELP_DESK: 'Help Desk',
        CLINICAL_DASHBOARD: 'Clinical Dashboard',
        CLINIENT_ADMISSION: 'Clients admission',
        DAILY_ENTRY: 'Daily Entry',
        EVALUATIONS: 'Evaluations',
        SERVICE_REVIEW: 'Service Review',
        ONBOARDING: 'Onboarding',
        COMPLIANCE: 'Compliance',
        INQUIRIES: 'Inquiries',
        SATISFACTION: 'Satisfaction',
        MODULES: 'Modules',
        SKILLS: 'Staff Skills',
        CARE_PLANS: 'Care Plans',
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
        PERSPECTIVES: ['Operations', 'Clinical', 'Marketing', 'Recruiting', 'Finance'],
        MESSAGES: {
            LOADING: 'Loading Dashboard...',
        }
    },
    DAILY_ENTRY: {
        TITLE: 'Daily Care Entry',
        LEFT_PANEL_TITLE: 'Select Context',
        CLIENT_LABEL: 'Client',
        CLIENT_PLACEHOLDER: 'Select Client...',
        TIP_TITLE: '💡 Tip',
        TIP_CONTENT: 'Auto-save is enabled for drafts. Submitting requires a signature.',
        ADL_TITLE: 'ADL Checklist',
        VITALS_TITLE: 'Vitals & Wellness',
        VITALS: {
            BP: 'BP',
            PULSE: 'Pulse',
            TEMP: 'Temp',
            MOOD_LABEL: 'Client Mood (1-5)',
        },
        NOTES_TITLE: 'Notes & Signature',
        NOTES_PLACEHOLDER: 'Daily progress notes, observations, or incidents...',
        SIGNATURE_LABEL: 'Digital Signature',
        SIGNATURE_PLACEHOLDER: 'Type full name to sign',
        SAVE_DRAFT: 'Save Draft',
        SUBMIT: 'Submit Entry',
        SUBMITTING: 'Submitting...',
        GUARD: {
            TITLE: 'Unsaved Changes',
            DESC: 'You have unsaved changes. Navigating away will discard them. Would you like to stay and save?',
            LEAVE: 'Leave',
            STAY: 'Stay',
        },
        MESSAGES: {
            SELECT_CLIENT: 'Please select a client',
            SIGNATURE_REQUIRED: 'Signature required for submission',
            SUCCESS_DRAFT: 'Draft saved!',
            SUCCESS_SUBMIT: 'Daily entry submitted successfully!',
            ERROR_SAVE: 'Failed to save entry',
            ERROR_SERVER: 'Error communicating with server',
        }
    },
    LAYOUT: {
        LOGOUT: 'Sign Out',
        PROFILE_TITLE: 'Account Profile',
        PERSPECTIVE: 'Perspective',
        IMPERSONATING: 'Impersonating profile',
        SWITCH_PERSPECTIVE: 'Choose Perspective',
        SEARCH_USERS: 'Search system users...',
        ONLINE_STATUS: 'STATUS: ONLINE',
        FULLSCREEN_ENTER: 'Enter Fullscreen',
        FULLSCREEN_EXIT: 'Exit Fullscreen',
        MOBILE_MENU: 'Toggle Menu',
        SEARCH_LABEL: 'Search Registry',
        LOGGED_IN_AS: 'Active Session: ',
        PERSPECTIVE_MODAL: {
            TITLE_MAIN: 'Umbrella Perspective',
            TITLE_IMPERSONATE: 'User Impersonation Tool',
            SUBTITLE_MAIN: 'Switch between platform umbrellas or impersonate users',
            SUBTITLE_IMPERSONATE: 'Viewing system as another user',
            SECTION_ROLE: 'SWITCH UMBRELLA',
            SECTION_IMPERSONATE: 'SEARCH SYSTEM USERS',
            EXIT_IMPERSONATE: 'EXIT IMPERSONATION',
            SEARCH_PLACEHOLDER: 'Search by name, email or UID...',
            IMPERSONATE_ACTION: 'IMPERSONATE →',
            GROUPS: {
                ADMIN: 'Administration',
                STAFF: 'Staff Operations',
                MANAGEMENT: 'Management',
                HEALTHCARE: 'Healthcare Workers',
            }
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
    MODALS: {
        CREATE_VISIT: {
            TITLE_CREATE: 'Create New Shift Request',
            TITLE_EDIT: 'Edit Shift Request',
            SUBMIT_CREATE: 'Create Shift',
            SUBMIT_SAVE: 'Save Changes',
            CANCEL: 'Cancel',
            PROCESSING: 'Processing...',
            SUCCESS_CREATE: 'Shift created successfully!',
            SUCCESS_UPDATE: 'Shift updated successfully!',
            ERROR_CREATE: 'Failed to create shift',
            ERROR_UPDATE: 'Failed to update shift',
        },
        CONFIRM_DELETE: {
            TITLE: 'Confirm Deletion',
            DESC: 'Are you sure you want to delete this item? This action cannot be undone.',
            CONFIRM: 'Delete',
            CANCEL: 'Cancel',
        }
    },
    EARNINGS: {
        TITLE: 'Earnings Center',
        SUBTITLE: 'Enterprise-grade financial oversight and payout management',
        STATS: {
            REVENUE: 'Total Revenue',
            PAYROLL: 'Total Payroll',
            PROFIT: 'Net Profit',
            PENDING: 'Payouts Pending',
        },
        TABS: {
            OVERVIEW: 'Overview',
            INVOICES: 'Invoices',
            PAYOUTS: 'Payouts',
            REPORTS: 'Reports',
        },
        ACTIONS: {
            EXPORT: 'Export Report',
            DATE_RANGE: 'Date Range',
            FILTER_ACTIVE: 'Filter Active',
        },
        INVOICE_ID: 'Invoice ID',
        CLIENT: 'Client',
        PSW: 'PSW',
        REVENUE: 'Revenue',
        PAYROLL: 'Payroll',
        PROFIT: 'Profit',
    },
    ADMISSION: {
        TITLE: 'Client Admission',
        SUBTITLE: 'Register a new client and configure their care requirements.',
        FORM: {
            FULL_NAME: 'Full Name',
            EMAIL: 'Email Address',
            PHONE: 'Phone Number',
            ADDRESS: 'Residential Address',
            EMERGENCY: 'Emergency Contact Name & Phone',
            NOTES: 'Medical Notes / Primary Concern',
            SUBMIT: 'Complete Admission',
            PROCESSING: 'Processing...',
            CANCEL: 'Cancel',
            DISCARD_TITLE: 'Unsaved Changes',
            DISCARD_DESC: 'You have unsaved admission data. Navigating away will discard it.',
        },
        MESSAGES: {
            SUCCESS: 'Client admitted successfully!',
            ERROR: 'Failed to admit client',
            ERROR_SUBMISSION: 'Error during admission',
        }
    },
    ONBOARDING: {
        TITLE: 'PSW Professional Onboarding',
        SUBTITLE: 'Register a new Personal Support Worker and verify credentials.',
        FORM: {
            FULL_NAME: 'Full Name',
            EMAIL: 'Email Address',
            PHONE: 'Phone Number',
            ADDRESS: 'Home Address',
            SIN: 'SIN (Security Encrypted)',
            BACKGROUND_CHECK: 'Background Check Status',
            CERTIFICATIONS: 'Certifications',
            SUBMIT: 'Complete Onboarding',
            PROCESSING: 'Registering...',
            CANCEL: 'Cancel',
            DISCARD_TITLE: 'Unsaved Changes',
            DISCARD_DESC: 'You have unsaved onboarding data. Navigating away will discard it.',
            STATUS_OPTIONS: {
                PENDING: 'Pending',
                CLEARED: 'Cleared',
                FLAGGED: 'Flagged'
            }
        },
        MESSAGES: {
            SUCCESS: 'PSW onboarded successfully!',
            ERROR: 'Failed to onboard PSW',
            ERROR_SUBMISSION: 'Error during onboarding',
        }
    },
    INSIGHTS: {
        TITLE: 'PrimeCare AI Insights',
        SUBTITLE: 'Predictive models and clinical intelligence for your agency.',
        CARDS: {
            BURNOUT: {
                LABEL: 'Staff Burnout Risk',
                DESC: 'PSWs exceed recommended overtime hours.'
            },
            COMPLIANCE: {
                LABEL: 'Compliance Probability',
                DESC: 'Based on automated documentation audits.'
            },
            DEMAND: {
                LABEL: 'Shift Demand Forecast',
                DESC: 'Expected increase in weekend shift requests.'
            }
        },
        CHARTS: {
            RISK_PERFORMANCE: 'Risk vs. Performance (Weekly Prediction)',
        },
        TIPS: {
            TITLE: 'AI-Generated Care Tips',
            DOC_GAP: {
                TITLE: 'Documentation Gap',
                DESC: 'Client has missing daily notes. Risk: Moderate.'
            },
            STAFF_OPT: {
                TITLE: 'Staff Optimization',
                DESC: 'PSWs in specific regions are under-utilized.'
            }
        }
    },
    CLINICAL_ASSISTANT: {
        TITLE: 'AI Clinical Assistant',
        SUBTITLE: 'Transform assessment notes into detailed care plans in seconds.',
        INPUT_LABEL: 'Input Assessment Notes',
        INPUT_PLACEHOLDER: 'e.g. Client shows signs of fatigue during transfers...',
        GENERATE_BTN: '🪄 Generate Care Plan',
        GENERATING: 'Generating Plan...',
        DRAFT_TITLE: 'Generated Plan Draft',
        DRAFT_EMPTY: 'Your AI-generated plan will appear here.',
        ANALYZING: 'Analysing clinical data...',
        APPROVE_BTN: 'Approve & Save',
        EDIT_BTN: 'Edit Draft'
    },
    LOCATIONS: {
        TITLE: 'Facility & Location Manager',
        SUBTITLE: 'Configure care facilities, clinics, and regional operating hubs.',
        FORM: {
            NAME: 'Facility Name',
            MANAGER: 'Facility Manager',
            MANAGER_SELECT: 'Select Manager...',
            CAPACITY: 'Max Patient Capacity',
            ADDRESS: 'Full Address',
            SAVE_BTN: 'Save Location',
            SAVING: 'Saving...',
            CANCEL: 'Cancel',
            DISCARD_TITLE: 'Unsaved Location',
            DISCARD_DESC: 'Location details are not saved. Discard them?',
        },
        MESSAGES: {
            SUCCESS: 'Care location saved!',
            ERROR: 'Failed to save location',
            ERROR_SUBMISSION: 'Error during submission',
        }
    },
    MARKETPLACE: {
        TITLE: 'Marketplace',
        SUBTITLE: 'Discover services and resources from the PrimeCare network.',
        INQUIRE_BTN: 'Inquire Now',
        OFFER_TITLE: 'Have something to offer?',
        OFFER_DESC: 'List your surplus staff or consulting services.',
        CREATE_BTN: 'Create Listing',
        PRICE_UNIT: '/hr'
    },
    COMMON: {
        LOAD_MORE: 'Load More',
        RETRY: 'Retry',
        SEARCH_PLACEHOLDER: 'Search...',
        NO_RESULTS: 'No results found.',
        SAVE: 'Save',
        CLOSE: 'Close',
        BACK: 'Back',
        EDIT: 'Edit',
        DELETE: 'Delete',
        NETWORK_ERROR: 'Network error',
        PROCESSING: 'Processing...',
    },
    SETUP_WIZARD: {
        TITLE: 'Business Setup Wizard',
        SUBTITLE: 'Complete these 3 steps to launch your care business.',
        STEPS: {
            SERVICES: 'Define Services',
            STAFF: 'Onboard Staff',
            CLIENTS: 'Admit Clients',
            FINISH: 'Ready to Go!'
        },
        HEADERS: {
            STEP_1: 'Step 1: Define Your Care Services',
            STEP_2: 'Step 2: Onboard Your First Healthcare Worker',
            STEP_3: 'Step 3: Admit Your First Client',
        },
        BUTTONS: {
            NEXT: 'Next Step',
            BACK: 'Back',
            FINISH: 'Launch My Business',
            SKIP: 'Skip for now'
        },
        SUCCESS: {
            TITLE: 'Congratulations!',
            MESSAGE: 'Your business setup is complete. You can now start scheduling visits.'
        }
    },
    WIZARD_HUB: {
        TITLE: 'Operational Wizard Hub',
        SUBTITLE: 'Streamline your daily administrative workflows.',
        STAFF: {
            TITLE: 'Staff Compliance',
            DESC: 'Verify credentials and complete HR onboarding.',
            ACTION: 'Start Onboarding'
        },
        CLIENT: {
            TITLE: 'Care Planning',
            DESC: 'Build digital care plans and medical protocols.',
            ACTION: 'Create Care Plan'
        },
        FINANCE: {
            TITLE: 'Revenue Setup',
            DESC: 'Configure billing cycles and service rates.',
            ACTION: 'Manage Revenue'
        },
        STRATEGY: {
            TITLE: 'Business Strategy',
            DESC: 'Define margins, tax IDs, and brand identity.',
            ACTION: 'Setup Strategy'
        }
    },
    STRATEGY_WIZARD: {
        TITLE: 'Business Strategy Wizard',
        SUBTITLE: 'Define your core business parameters and margins.',
        STEPS: {
            BRANDING: 'Branding & Identity',
            COMPLIANCE: 'Tax & Legal Compliance',
            MARGIN: 'Profit Margin Strategy',
        },
        BRANDING: {
            EMAIL_LABEL: 'Public Support Email',
            EMAIL_PLACEHOLDER: 'support@yourcare.com',
            LOGO_UPLOAD: 'Upload Business Logo',
            LOGO_UPLOADING: 'Uploading...',
            LOGO_CHANGE: 'Change Logo',
            LOGO_HINT: 'PNG or SVG, Max 2MB',
            LOGO_ERROR_SIZE: 'Logo must be smaller than 2MB',
        },
        COMPLIANCE: {
            BN_LABEL: 'Business Registration Number (BN)',
            BN_PLACEHOLDER: 'e.g. 12345 6789 RT0001',
            TAX_LABEL: 'Automatically apply HST/GST to invoices',
            TAX_DESC: 'Based on your primary business location settings.',
        },
        MARGIN: {
            DESC: 'Set your target gross margin. This helps calculate what you pay providers versus what you charge clients.',
            LABEL: 'TARGET MARGIN',
            LOW: 'Lean (10%)',
            MID: 'Industry Standard (30%)',
            HIGH: 'Premium (60%)',
        },
        BUTTONS: {
            SAVE_CONTINUE: 'Save & Continue',
            COMPLETE: 'Complete Setup',
            BACK: 'Back',
            CANCEL: 'Cancel',
            PROCESSING: 'Processing...',
        },
        MESSAGES: {
            SUCCESS_LOGO: 'Logo uploaded successfully!',
            ERROR_LOGO: 'Failed to upload logo',
            SUCCESS_SAVE: 'Business Strategy saved!',
            ERROR_SAVE: 'Failed to save settings',
            ERROR_SERVER: 'Error connecting to server',
        }
    },
    BUSINESS_STATUS: {
        TITLE: 'Business Command Center',
        SUBTITLE: 'Monitor your setup progress and perform rapid data entry.',
        INITIALIZING: 'Initializing Command Center...',
        FOOTER: {
            TITLE: 'Need to add something specific?',
            VIEW_STAFF: '→ View All Staff',
            MANAGE_LEADS: '→ Manage Leads',
            DISPATCH_SHIFTS: '→ Dispatch Shifts',
        },
        DOMAINS: {
            STRATEGY: 'Business Model',
            SERVICES: 'Care Services',
            STAFF: 'Provider Network',
            CLIENTS: 'Client Roster',
            FINANCE: 'Financial Ops'
        }
    },
    HEALTH_ALERTS: {
        TITLE: 'Business Health Monitor',
        COMPLIANCE: {
            LABEL: 'Compliance Risk',
            DESC: 'Staff with missing or expired documents'
        },
        COVERAGE: {
            LABEL: 'Coverage Gap',
            DESC: 'Unassigned visits in the next 7 days'
        },
        PIPELINE: {
            LABEL: 'Pipeline Stagnation',
            DESC: 'Leads not contacted in 3+ days'
        }
    },
    STAFF_WIZARD: {
        TITLE: 'Staff Registry & Compliance',
        SUBTITLE: 'Onboard new care providers and verify clinical credentials.',
        STEPS: ['Profile', 'Compliance', 'Documents'],
        FORM: {
            NAME_LABEL: 'Full Legal Name',
            NAME_PLACEHOLDER: 'e.g. John Doe',
            EMAIL_LABEL: 'Professional Email',
            EMAIL_PLACEHOLDER: 'john@example.com',
            ROLE_LABEL: 'Professional Role',
            SIN_LABEL: 'Tax ID / SIN',
            SIN_PLACEHOLDER: '000-000-000',
            DOCS_TITLE: 'Required Credentials',
            VSS_LABEL: 'Vulnerable Sector Screen (VSS)',
            LICENSE_LABEL: 'Clinical License / Certificate',
            UPLOAD_BTN: 'Upload Document',
            SUBMIT_BTN: 'Register Provider',
            SUBMITTING: 'Registering...',
            SUCCESS: 'Provider registered successfully'
        }
    },
    CARE_WIZARD: {
        TITLE: 'Client Admission & Intake',
        SUBTITLE: 'Standardized care planning and intake flow.',
        STEPS: ['Demographics', 'Clinical Profile', 'Baseline ADLs'],
        FORM: {
            NAME_LABEL: 'Full Legal Name',
            NAME_PLACEHOLDER: 'e.g. Sarah Jenkins',
            EMAIL_LABEL: 'Email (Portal Access)',
            EMAIL_PLACEHOLDER: 'sarah@example.com',
            ADDR_LABEL: 'Service Address',
            ADDR_PLACEHOLDER: '123 Care Street, Suite 4B...',
            MEDICAL_TITLE: 'Clinical Profile & Allergies',
            MEDICAL_LABEL: 'Medical History & Known Conditions',
            MEDICAL_PLACEHOLDER: 'Detail chronic conditions, allergies, or physical limitations...',
            ADL_TITLE: 'Baseline ADLs (Assistance Levels)',
            SUBMIT_BTN: 'Finalize Care Plan',
            NEXT_BTN: 'Next Step',
            BACK_BTN: 'Back',
            ADMIT_BTN: 'Admit Client',
            ADMITTING: 'Admitting...'
        }
    },
    REVENUE_WIZARD: {
        TITLE: 'Revenue & Billing Configuration',
        SUBTITLE: 'Configure your rates and billing automation.',
        ECONOMICS_TITLE: 'Service Economics',
        RATE_LABEL: 'Base Hourly Rate (Client Charge)',
        CYCLE_LABEL: 'Billing Frequency',
        TAX_TITLE: 'Automated Tax Calculation',
        TAX_DESC: 'Automatically apply HST/GST to all invoices.',
        SUBMIT_BTN: 'Finalize Finance Setup',
        SAVING: 'Saving...',
        SUCCESS: 'Financial settings updated'
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
            READY: 'Ready',
            TESTING: '⌛ Testing...',
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
            SECURITY_ROLES: 'Security Roles',
            WORKFLOW_PATHWAY: 'Workflow pathway',
            STEPS: {
                ADMIN: ['Dashboard Overlay', 'User Management', 'Global Schedule', 'Earnings Center', 'System Settings', 'Developer Audit Hub'],
                MANAGER: ['Operations Dashboard', 'Shift Coordination', 'Clinical Reviews', 'Payroll Verification', 'Regional Analytics'],
                STAFF: ['Staff Hub', 'Lead Inquiries', 'Customer Roster', 'Incident Logging', 'Compliance Monitoring'],
                PSW: ['My Schedule', 'Open Market', 'Visit Check-in/out', 'Payout Requests', 'Compliance Ledger'],
                CLIENT: ['Care Hub', 'New Request', 'Assigned Team', 'Digital Invoices', 'Feedback Gateway'],
            }
        },
        MONITORING: {
            TITLE: 'System Health Monitor',
            SUBTITLE: 'Real-time operational status and infrastructure telemetry',
            API_CLUSTER: 'API Cluster',
            UPTIME_DESC: 'Uptime 24h • Average Latency 42ms',
            DB_TELEMETRY: 'Complex P99 • 8.4GB Cache usage',
            LOGS_TITLE: 'Live Logs Stream',
            HEARTBEAT: 'Heartbeat check: OK.',
        },
        ENV_AUDIT: {
            TITLE: 'Environment Audit',
            SUBTITLE: 'Sanitized system configuration and environment mapping',
            SECURITY_NOTE: 'Sensitive keys like DATABASE_URL, JWT_SECRET, and API_KEYS are never exposed in the UI. Only configuration flags and public-facing service URLs are visible here for technical auditing.',
        },
        REGISTRY_CHECK: {
            TITLE: 'Registry Integrity Monitor',
            SUBTITLE: 'Cross-referencing shared registries for consistency',
        },
        DATABASE_SCHEMA: {
            TITLE: 'Database Schema Audit',
            SUBTITLE: 'Prisma model overview and relationship mapping',
            MODEL_NAME: 'Model Name',
            CORE_FIELDS: 'Core Fields',
            RELATIONS: 'Relations',
            SYNC_STATUS: 'Sync Status',
            INSIGHT: 'The current schema follows a Multi-Tenant Shared Database pattern. Data isolation is enforced at the application level via tenantId scoping in the api-worker middleware. All structural changes must be verified against the Prisma Migration Logs available in the Environment Audit section.',
        },
        INTEGRITY: {
            TOTAL_ROUTES: 'Total Route Definitions',
            API_MAPPINGS: 'API Endpoint Mappings',
            TRANSLATION_OVERLAP: 'Translation Keys Overlap',
            BROKEN_LINKS: 'Broken Internal Links',
        },
        ANOMALIES: {
            TITLE: 'Detected Anomalies',
            SEVERITY: 'Severity',
            COMPONENT: 'Component',
            OBSERVATION: 'Observation',
            TECHNICAL_SUGGESTION: 'Technical Suggestion',
        }
    },
    SHARED: {
        VARIABLE_KEY: 'Variable Key',
        CURRENT_VALUE: 'Current Value',
        SECURITY_LEVEL: 'Security Level',
        STATUS: 'Status',
        ARCHITECTURE_INSIGHT: 'Architecture Insight',
        SECURITY_NOTE: 'Security Note',
        HEALTHY: 'Healthy',
        VERIFIED: 'Verified',
        ACCESSIBLE: 'Accessible',
        MATCH: 'Match',
        SECURE: 'Secure',
        PUBLIC: 'Public',
        SYSTEM: 'System',
        SENSITIVE: 'Sensitive',
        LOW: 'Low',
        MEDIUM: 'Medium',
        HIGH: 'High',
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
