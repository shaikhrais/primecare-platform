export const opsAdminContent = {
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
} as const;
