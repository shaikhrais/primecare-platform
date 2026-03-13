// ──────────────────────────────────────────────────────────────────────────────
// FormRegistry — Centralized catalogue of every forms across the platform.
// Each entry declares its route, API endpoints, required fields, dependent
// entities (inline creators), and the data-cy attribute prefix used in tests.
// ──────────────────────────────────────────────────────────────────────────────

// ── Types ────────────────────────────────────────────────────────────────────

export interface FormField {
    name: string;
    label: string;
    type: 'text' | 'email' | 'password' | 'select' | 'textarea' | 'date' |
          'number' | 'checkbox' | 'tel' | 'file' | 'datetime-local' | 'time' | 'hidden';
    required: boolean;
    /** API endpoint to dynamically load <select> options */
    fetchOptionsFrom?: string;
    placeholder?: string;
    defaultValue?: string;
}

export interface FormDependency {
    /** The select/dropdown field that depends on this record */
    field: string;
    /** Semantic entity type (e.g. 'serviceType', 'client', 'psw') */
    entityType: string;
    /** API endpoint to create a new dependent record inline */
    inlineCreateEndpoint: string;
    /** API endpoint to refresh dropdown options after inline creation */
    fetchEndpoint: string;
    /** Human label for the inline creator button */
    inlineCreateLabel: string;
}

export interface FormEntry {
    /** Unique form identifier (dot-namespace, e.g. 'auth.login') */
    id: string;
    /** Human-readable form title */
    label: string;
    /** Frontend route where the form lives */
    route: string;
    /** POST/PUT endpoint for form submission */
    apiEndpoint: string;
    /** GET endpoint for editing / pre-fill */
    fetchEndpoint?: string;
    method: 'POST' | 'PUT' | 'PATCH';
    /** data-cy attribute prefix used for testing hooks */
    dataCyPrefix: string;
    /** Ordered list of form fields */
    fields: FormField[];
    /** Dependencies that need inline creation components */
    dependencies?: FormDependency[];
    /** Category grouping for UI discovery */
    category: 'auth' | 'admin' | 'admin-wizard' | 'client' | 'psw' | 'manager' |
              'rn' | 'shared' | 'marketing' | 'platform' | 'dam' | 'coordinator';
}

// ── AUTH FORMS ────────────────────────────────────────────────────────────────

const AUTH_FORMS: FormEntry[] = [
    {
        id: 'auth.login',
        label: 'Login',
        route: '/login',
        apiEndpoint: '/v1/auth/login',
        method: 'POST',
        dataCyPrefix: 'login',
        category: 'auth',
        fields: [
            { name: 'email', label: 'Email', type: 'email', required: true, placeholder: 'admin@company.com' },
            { name: 'password', label: 'Password', type: 'password', required: true, placeholder: '••••••••' },
        ],
    },
    {
        id: 'auth.register',
        label: 'Register',
        route: '/register',
        apiEndpoint: '/v1/auth/register',
        method: 'POST',
        dataCyPrefix: 'register',
        category: 'auth',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email Address', type: 'email', required: true },
            { name: 'password', label: 'Password', type: 'password', required: true },
            { name: 'confirmPassword', label: 'Confirm Password', type: 'password', required: true },
        ],
    },
    {
        id: 'auth.forgot-password',
        label: 'Forgot Password',
        route: '/forgot-password',
        apiEndpoint: '/v1/auth/forgot-password',
        method: 'POST',
        dataCyPrefix: 'forgot-password',
        category: 'auth',
        fields: [
            { name: 'email', label: 'Email Address', type: 'email', required: true },
        ],
    },
    {
        id: 'auth.reset-password',
        label: 'Reset Password',
        route: '/reset-password',
        apiEndpoint: '/v1/auth/reset-password',
        method: 'POST',
        dataCyPrefix: 'reset-password',
        category: 'auth',
        fields: [
            { name: 'token', label: 'Reset Token', type: 'hidden', required: true },
            { name: 'password', label: 'New Password', type: 'password', required: true },
            { name: 'confirmPassword', label: 'Confirm Password', type: 'password', required: true },
        ],
    },
    {
        id: 'auth.onboard-business',
        label: 'Onboard Business',
        route: '/onboard-business',
        apiEndpoint: '/v1/auth/onboard-business',
        method: 'POST',
        dataCyPrefix: 'onboard-business',
        category: 'auth',
        fields: [
            { name: 'businessName', label: 'Business Name', type: 'text', required: true },
            { name: 'ownerName', label: 'Owner Full Name', type: 'text', required: true },
            { name: 'email', label: 'Business Email', type: 'email', required: true },
            { name: 'phone', label: 'Phone Number', type: 'tel', required: true },
            { name: 'password', label: 'Admin Password', type: 'password', required: true },
            { name: 'industry', label: 'Industry', type: 'select', required: true },
        ],
    },
];

// ── ADMIN FORMS ──────────────────────────────────────────────────────────────

const ADMIN_FORMS: FormEntry[] = [
    {
        id: 'admin.user-invite',
        label: 'Invite User',
        route: '/platform/admin/users',
        apiEndpoint: '/v1/admin/users',
        method: 'POST',
        dataCyPrefix: 'user-invite',
        category: 'admin',
        fields: [
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'role', label: 'Role', type: 'select', required: true },
            { name: 'phone', label: 'Phone', type: 'tel', required: false },
        ],
    },
    {
        id: 'admin.user-entry',
        label: 'Create / Edit User',
        route: '/platform/admin/users/new',
        apiEndpoint: '/v1/admin/users',
        fetchEndpoint: '/v1/admin/users',
        method: 'POST',
        dataCyPrefix: 'user-entry',
        category: 'admin',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'password', label: 'Temporary Password', type: 'password', required: true },
            { name: 'role', label: 'Role', type: 'select', required: true },
            { name: 'phone', label: 'Phone Number', type: 'tel', required: false },
            { name: 'address', label: 'Address', type: 'text', required: false },
        ],
    },
    {
        id: 'admin.service-modal',
        label: 'Create / Edit Service',
        route: '/platform/admin/services',
        apiEndpoint: '/v1/admin/services',
        fetchEndpoint: '/v1/admin/services',
        method: 'POST',
        dataCyPrefix: 'service',
        category: 'admin',
        fields: [
            { name: 'name', label: 'Service Name', type: 'text', required: true },
            { name: 'description', label: 'Description', type: 'textarea', required: false },
            { name: 'rate', label: 'Hourly Rate ($)', type: 'number', required: true },
            { name: 'category', label: 'Category', type: 'select', required: true },
            { name: 'isActive', label: 'Active', type: 'checkbox', required: false },
        ],
    },
    {
        id: 'admin.lead-entry',
        label: 'Create / Edit Lead',
        route: '/platform/admin/leads/new',
        apiEndpoint: '/v1/admin/leads',
        fetchEndpoint: '/v1/admin/leads',
        method: 'POST',
        dataCyPrefix: 'lead',
        category: 'admin',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'phone', label: 'Phone', type: 'tel', required: true },
            { name: 'source', label: 'Lead Source', type: 'select', required: true },
            { name: 'notes', label: 'Notes', type: 'textarea', required: false },
            { name: 'serviceInterest', label: 'Service Interest', type: 'select', required: false, fetchOptionsFrom: '/v1/admin/services' },
        ],
        dependencies: [
            {
                field: 'serviceInterest',
                entityType: 'serviceType',
                inlineCreateEndpoint: '/v1/admin/services',
                fetchEndpoint: '/v1/admin/services',
                inlineCreateLabel: '+ New Service Type',
            },
        ],
    },
    {
        id: 'admin.incident-entry',
        label: 'Create / Edit Incident',
        route: '/platform/admin/incidents/new',
        apiEndpoint: '/v1/admin/incidents',
        fetchEndpoint: '/v1/admin/incidents',
        method: 'POST',
        dataCyPrefix: 'incident',
        category: 'admin',
        fields: [
            { name: 'title', label: 'Incident Title', type: 'text', required: true },
            { name: 'clientId', label: 'Client', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/clients' },
            { name: 'pswId', label: 'PSW Involved', type: 'select', required: false, fetchOptionsFrom: '/v1/admin/users?role=psw' },
            { name: 'severity', label: 'Severity', type: 'select', required: true },
            { name: 'description', label: 'Description', type: 'textarea', required: true },
            { name: 'dateOccurred', label: 'Date Occurred', type: 'date', required: true },
        ],
        dependencies: [
            {
                field: 'clientId',
                entityType: 'client',
                inlineCreateEndpoint: '/v1/admin/clients',
                fetchEndpoint: '/v1/admin/clients',
                inlineCreateLabel: '+ New Client',
            },
            {
                field: 'pswId',
                entityType: 'psw',
                inlineCreateEndpoint: '/v1/admin/users',
                fetchEndpoint: '/v1/admin/users?role=psw',
                inlineCreateLabel: '+ New PSW',
            },
        ],
    },
    {
        id: 'admin.admission',
        label: 'Client Admission',
        route: '/platform/admin/admission',
        apiEndpoint: '/v1/admin/clients',
        method: 'POST',
        dataCyPrefix: 'admission',
        category: 'admin',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'phone', label: 'Phone', type: 'tel', required: true },
            { name: 'dateOfBirth', label: 'Date of Birth', type: 'date', required: true },
            { name: 'address', label: 'Address', type: 'text', required: true },
            { name: 'serviceTypeId', label: 'Service Type', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/services' },
            { name: 'assignedPswId', label: 'Assigned PSW', type: 'select', required: false, fetchOptionsFrom: '/v1/admin/users?role=psw' },
            { name: 'emergencyContact', label: 'Emergency Contact', type: 'text', required: true },
            { name: 'notes', label: 'Admission Notes', type: 'textarea', required: false },
        ],
        dependencies: [
            {
                field: 'serviceTypeId',
                entityType: 'serviceType',
                inlineCreateEndpoint: '/v1/admin/services',
                fetchEndpoint: '/v1/admin/services',
                inlineCreateLabel: '+ New Service Type',
            },
            {
                field: 'assignedPswId',
                entityType: 'psw',
                inlineCreateEndpoint: '/v1/admin/users',
                fetchEndpoint: '/v1/admin/users?role=psw',
                inlineCreateLabel: '+ New PSW',
            },
        ],
    },
    {
        id: 'admin.onboarding',
        label: 'Staff Onboarding',
        route: '/platform/admin/onboarding',
        apiEndpoint: '/v1/admin/users',
        method: 'POST',
        dataCyPrefix: 'onboarding',
        category: 'admin',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'role', label: 'Role', type: 'select', required: true },
            { name: 'startDate', label: 'Start Date', type: 'date', required: true },
            { name: 'credentials', label: 'Credentials / Certifications', type: 'textarea', required: false },
        ],
    },
    {
        id: 'admin.locations',
        label: 'Create / Edit Location',
        route: '/platform/admin/locations',
        apiEndpoint: '/v1/admin/locations',
        fetchEndpoint: '/v1/admin/locations',
        method: 'POST',
        dataCyPrefix: 'location',
        category: 'admin',
        fields: [
            { name: 'name', label: 'Location Name', type: 'text', required: true },
            { name: 'address', label: 'Address', type: 'text', required: true },
            { name: 'city', label: 'City', type: 'text', required: true },
            { name: 'province', label: 'Province / State', type: 'text', required: true },
            { name: 'postalCode', label: 'Postal Code', type: 'text', required: true },
            { name: 'managerId', label: 'Branch Manager', type: 'select', required: false, fetchOptionsFrom: '/v1/admin/users' },
            { name: 'phone', label: 'Phone', type: 'tel', required: false },
        ],
    },
    {
        id: 'admin.timesheet-adjust',
        label: 'Timesheet Adjustment',
        route: '/platform/admin/timesheets/adjust',
        apiEndpoint: '/v1/admin/timesheets',
        method: 'PUT',
        dataCyPrefix: 'timesheet',
        category: 'admin',
        fields: [
            { name: 'pswId', label: 'PSW', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/users?role=psw' },
            { name: 'visitDate', label: 'Visit Date', type: 'date', required: true },
            { name: 'checkIn', label: 'Check-in Time', type: 'time', required: true },
            { name: 'checkOut', label: 'Check-out Time', type: 'time', required: true },
            { name: 'reason', label: 'Adjustment Reason', type: 'textarea', required: true },
        ],
    },
    {
        id: 'admin.reseller-provision',
        label: 'Provision New Agency',
        route: '/platform/admin/reseller',
        apiEndpoint: '/v1/admin/reseller/provision',
        method: 'POST',
        dataCyPrefix: 'reseller',
        category: 'admin',
        fields: [
            { name: 'name', label: 'Agency Name', type: 'text', required: true },
            { name: 'slug', label: 'Routing Slug', type: 'text', required: true },
            { name: 'adminEmail', label: 'Admin Login Email', type: 'email', required: true },
            { name: 'adminPassword', label: 'Temporary Password', type: 'password', required: true },
        ],
    },
    {
        id: 'admin.incident-resolution',
        label: 'Incident Resolution',
        route: '/platform/admin/incidents',
        apiEndpoint: '/v1/admin/incidents',
        method: 'PUT',
        dataCyPrefix: 'incident-resolution',
        category: 'admin',
        fields: [
            { name: 'resolution', label: 'Resolution Summary', type: 'textarea', required: true },
            { name: 'rootCause', label: 'Root Cause', type: 'select', required: true },
            { name: 'followUpDate', label: 'Follow-up Date', type: 'date', required: false },
        ],
    },
];

// ── ADMIN WIZARD FORMS ───────────────────────────────────────────────────────

const ADMIN_WIZARD_FORMS: FormEntry[] = [
    {
        id: 'admin.wizard.care-plan',
        label: 'Care Plan Wizard',
        route: '/platform/admin/wizards/care-plan',
        apiEndpoint: '/v1/rn/clinical/care-plans',
        method: 'POST',
        dataCyPrefix: 'care-plan-wizard',
        category: 'admin-wizard',
        fields: [
            { name: 'clientId', label: 'Client', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/clients' },
            { name: 'goals', label: 'Care Goals', type: 'textarea', required: true },
            { name: 'serviceTypeId', label: 'Service Type', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/services' },
            { name: 'startDate', label: 'Start Date', type: 'date', required: true },
            { name: 'endDate', label: 'End Date', type: 'date', required: false },
        ],
        dependencies: [
            {
                field: 'clientId',
                entityType: 'client',
                inlineCreateEndpoint: '/v1/admin/clients',
                fetchEndpoint: '/v1/admin/clients',
                inlineCreateLabel: '+ New Client',
            },
            {
                field: 'serviceTypeId',
                entityType: 'serviceType',
                inlineCreateEndpoint: '/v1/admin/services',
                fetchEndpoint: '/v1/admin/services',
                inlineCreateLabel: '+ New Service Type',
            },
        ],
    },
    {
        id: 'admin.wizard.staff-onboarding',
        label: 'Staff Onboarding Wizard',
        route: '/platform/admin/wizards/staff-onboarding',
        apiEndpoint: '/v1/admin/users',
        method: 'POST',
        dataCyPrefix: 'staff-wizard',
        category: 'admin-wizard',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'role', label: 'Role', type: 'select', required: true },
            { name: 'certifications', label: 'Certifications', type: 'textarea', required: false },
            { name: 'startDate', label: 'Start Date', type: 'date', required: true },
        ],
    },
];

// ── CLIENT FORMS ─────────────────────────────────────────────────────────────

const CLIENT_FORMS: FormEntry[] = [
    {
        id: 'client.booking-request',
        label: 'Request a Booking',
        route: '/tenancy/client/request-booking',
        apiEndpoint: '/v1/client/bookings/request',
        method: 'POST',
        dataCyPrefix: 'booking-request',
        category: 'client',
        fields: [
            { name: 'serviceTypeId', label: 'Service Type', type: 'select', required: true, fetchOptionsFrom: '/v1/client/services/catalog' },
            { name: 'preferredDate', label: 'Preferred Date', type: 'date', required: true },
            { name: 'preferredTime', label: 'Preferred Time', type: 'time', required: true },
            { name: 'duration', label: 'Duration (hours)', type: 'number', required: true },
            { name: 'notes', label: 'Special Instructions', type: 'textarea', required: false },
        ],
    },
    {
        id: 'client.feedback',
        label: 'Submit Feedback',
        route: '/tenancy/client/feedback',
        apiEndpoint: '/v1/client/feedback',
        method: 'POST',
        dataCyPrefix: 'feedback',
        category: 'client',
        fields: [
            { name: 'visitId', label: 'Visit', type: 'select', required: true, fetchOptionsFrom: '/v1/client/bookings' },
            { name: 'rating', label: 'Rating', type: 'number', required: true },
            { name: 'comment', label: 'Comments', type: 'textarea', required: false },
        ],
    },
    {
        id: 'client.service-booking-modal',
        label: 'Service Booking (Quick)',
        route: '/tenancy/client',
        apiEndpoint: '/v1/client/bookings/request',
        method: 'POST',
        dataCyPrefix: 'quick-booking',
        category: 'client',
        fields: [
            { name: 'serviceTypeId', label: 'Service', type: 'select', required: true, fetchOptionsFrom: '/v1/client/services/catalog' },
            { name: 'date', label: 'Date', type: 'date', required: true },
            { name: 'time', label: 'Time', type: 'time', required: true },
            { name: 'notes', label: 'Notes', type: 'textarea', required: false },
        ],
    },
];

// ── PSW FORMS ────────────────────────────────────────────────────────────────

const PSW_FORMS: FormEntry[] = [
    {
        id: 'psw.handover',
        label: 'Shift Handover',
        route: '/tenancy/psw/handover',
        apiEndpoint: '/v1/psw/handover',
        method: 'POST',
        dataCyPrefix: 'handover',
        category: 'psw',
        fields: [
            { name: 'visitId', label: 'Visit', type: 'select', required: true, fetchOptionsFrom: '/v1/psw/schedule/visits' },
            { name: 'clientCondition', label: 'Client Condition Summary', type: 'textarea', required: true },
            { name: 'tasksCompleted', label: 'Tasks Completed', type: 'textarea', required: true },
            { name: 'tasksRemaining', label: 'Outstanding Tasks', type: 'textarea', required: false },
            { name: 'urgentNotes', label: 'Urgent Notes', type: 'textarea', required: false },
        ],
    },
    {
        id: 'psw.expenses',
        label: 'Expense Claim',
        route: '/tenancy/psw/expenses',
        apiEndpoint: '/v1/psw/expenses',
        method: 'POST',
        dataCyPrefix: 'expense',
        category: 'psw',
        fields: [
            { name: 'category', label: 'Expense Category', type: 'select', required: true },
            { name: 'amount', label: 'Amount ($)', type: 'number', required: true },
            { name: 'date', label: 'Date', type: 'date', required: true },
            { name: 'receipt', label: 'Receipt Upload', type: 'file', required: true },
            { name: 'description', label: 'Description', type: 'textarea', required: false },
        ],
    },
    {
        id: 'psw.availability',
        label: 'Availability Schedule',
        route: '/tenancy/psw/availability',
        apiEndpoint: '/v1/psw/availability/sync',
        method: 'POST',
        dataCyPrefix: 'availability',
        category: 'psw',
        fields: [
            { name: 'dayOfWeek', label: 'Day of Week', type: 'select', required: true },
            { name: 'startTime', label: 'Start Time', type: 'time', required: true },
            { name: 'endTime', label: 'End Time', type: 'time', required: true },
            { name: 'isRecurring', label: 'Recurring Weekly', type: 'checkbox', required: false },
        ],
    },
];

// ── MANAGER FORMS ────────────────────────────────────────────────────────────

const MANAGER_FORMS: FormEntry[] = [
    {
        id: 'manager.service-review',
        label: 'Service Review',
        route: '/tenancy/manager/service-review',
        apiEndpoint: '/v1/manager/reviews',
        method: 'POST',
        dataCyPrefix: 'service-review',
        category: 'manager',
        fields: [
            { name: 'pswId', label: 'PSW', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/users?role=psw' },
            { name: 'clientId', label: 'Client', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/clients' },
            { name: 'rating', label: 'Performance Rating', type: 'number', required: true },
            { name: 'feedback', label: 'Review Comments', type: 'textarea', required: true },
            { name: 'reviewDate', label: 'Review Date', type: 'date', required: true },
        ],
    },
    {
        id: 'manager.evaluation',
        label: 'PSW Evaluation',
        route: '/tenancy/manager/evaluations',
        apiEndpoint: '/v1/manager/evaluations',
        method: 'POST',
        dataCyPrefix: 'evaluation',
        category: 'manager',
        fields: [
            { name: 'pswId', label: 'PSW', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/users?role=psw' },
            { name: 'competencyScore', label: 'Competency Score', type: 'number', required: true },
            { name: 'punctuality', label: 'Punctuality', type: 'number', required: true },
            { name: 'clinicalSkills', label: 'Clinical Skills', type: 'number', required: true },
            { name: 'notes', label: 'Evaluation Notes', type: 'textarea', required: true },
        ],
    },
];

// ── RN FORMS ─────────────────────────────────────────────────────────────────

const RN_FORMS: FormEntry[] = [
    {
        id: 'rn.admission-assessment',
        label: 'Admission Assessment',
        route: '/tenancy/rn/assessments',
        apiEndpoint: '/v1/rn/clinical/assessments',
        method: 'POST',
        dataCyPrefix: 'assessment',
        category: 'rn',
        fields: [
            { name: 'clientId', label: 'Client', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/clients' },
            { name: 'assessmentType', label: 'Assessment Type', type: 'select', required: true },
            { name: 'vitalSigns', label: 'Vital Signs', type: 'textarea', required: true },
            { name: 'medications', label: 'Current Medications', type: 'textarea', required: true },
            { name: 'allergies', label: 'Known Allergies', type: 'textarea', required: false },
            { name: 'clinicalNotes', label: 'Clinical Notes', type: 'textarea', required: true },
            { name: 'riskLevel', label: 'Risk Level', type: 'select', required: true },
        ],
        dependencies: [
            {
                field: 'clientId',
                entityType: 'client',
                inlineCreateEndpoint: '/v1/admin/clients',
                fetchEndpoint: '/v1/admin/clients',
                inlineCreateLabel: '+ New Client',
            },
        ],
    },
];

// ── SHARED FORMS ─────────────────────────────────────────────────────────────

const SHARED_FORMS: FormEntry[] = [
    {
        id: 'shared.profile',
        label: 'Edit Profile',
        route: '/profile',
        apiEndpoint: '/v1/auth/profile',
        fetchEndpoint: '/v1/auth/profile',
        method: 'PUT',
        dataCyPrefix: 'profile',
        category: 'shared',
        fields: [
            { name: 'firstName', label: 'First Name', type: 'text', required: true },
            { name: 'lastName', label: 'Last Name', type: 'text', required: true },
            { name: 'email', label: 'Email', type: 'email', required: true },
            { name: 'phone', label: 'Phone', type: 'tel', required: false },
            { name: 'avatar', label: 'Profile Photo', type: 'file', required: false },
        ],
    },
    {
        id: 'shared.messaging',
        label: 'Send Message',
        route: '/messaging',
        apiEndpoint: '/v1/messages',
        method: 'POST',
        dataCyPrefix: 'messaging',
        category: 'shared',
        fields: [
            { name: 'recipientId', label: 'To', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/users' },
            { name: 'body', label: 'Message', type: 'textarea', required: true },
        ],
    },
    {
        id: 'shared.visit-completion',
        label: 'Complete Visit',
        route: '/visits/:id/complete',
        apiEndpoint: '/v1/psw/daily-entry',
        method: 'POST',
        dataCyPrefix: 'visit-complete',
        category: 'shared',
        fields: [
            { name: 'notes', label: 'Visit Notes', type: 'textarea', required: true },
            { name: 'clientSignature', label: 'Client Signature', type: 'text', required: true },
            { name: 'tasksCompleted', label: 'Tasks Completed', type: 'textarea', required: true },
        ],
    },
    {
        id: 'shared.support-ticket',
        label: 'Submit Support Ticket',
        route: '/support/tickets/new',
        apiEndpoint: '/v1/staff/tickets',
        method: 'POST',
        dataCyPrefix: 'support-ticket',
        category: 'shared',
        fields: [
            { name: 'subject', label: 'Subject', type: 'text', required: true },
            { name: 'category', label: 'Category', type: 'select', required: true },
            { name: 'priority', label: 'Priority', type: 'select', required: true },
            { name: 'description', label: 'Description', type: 'textarea', required: true },
            { name: 'attachment', label: 'Attachment', type: 'file', required: false },
        ],
    },
];

// ── MARKETING FORMS ──────────────────────────────────────────────────────────

const MARKETING_FORMS: FormEntry[] = [
    {
        id: 'marketing.cost-calculator',
        label: 'Cost of Care Calculator',
        route: '/platform/marketing/pipeline/cost-calculator',
        apiEndpoint: '/v1/admin/leads',
        method: 'POST',
        dataCyPrefix: 'cost-calc',
        category: 'marketing',
        fields: [
            { name: 'clientName', label: 'Client Name', type: 'text', required: true },
            { name: 'serviceTypeId', label: 'Service Type', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/services' },
            { name: 'hoursPerWeek', label: 'Hours Per Week', type: 'number', required: true },
            { name: 'startDate', label: 'Start Date', type: 'date', required: true },
        ],
        dependencies: [
            {
                field: 'serviceTypeId',
                entityType: 'serviceType',
                inlineCreateEndpoint: '/v1/admin/services',
                fetchEndpoint: '/v1/admin/services',
                inlineCreateLabel: '+ New Service Type',
            },
        ],
    },
    {
        id: 'marketing.discharge-planner',
        label: 'Discharge Planner Portal',
        route: '/platform/marketing/b2b/discharge-planner',
        apiEndpoint: '/v1/admin/leads',
        method: 'POST',
        dataCyPrefix: 'discharge-planner',
        category: 'marketing',
        fields: [
            { name: 'patientName', label: 'Patient Name', type: 'text', required: true },
            { name: 'hospitalName', label: 'Discharging Hospital', type: 'text', required: true },
            { name: 'dischargeDate', label: 'Estimated Discharge Date', type: 'date', required: true },
            { name: 'serviceNeeded', label: 'Service Needed', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/services' },
            { name: 'urgency', label: 'Urgency Level', type: 'select', required: true },
            { name: 'notes', label: 'Clinical Notes', type: 'textarea', required: false },
        ],
    },
];

// ── PLATFORM FORMS ───────────────────────────────────────────────────────────

const PLATFORM_FORMS: FormEntry[] = [
    {
        id: 'platform.provision-tenant',
        label: 'Provision Tenant',
        route: '/platform/tenants',
        apiEndpoint: '/v1/superuser/tenants',
        method: 'POST',
        dataCyPrefix: 'provision-tenant',
        category: 'platform',
        fields: [
            { name: 'name', label: 'Tenant Name', type: 'text', required: true },
            { name: 'slug', label: 'URL Slug', type: 'text', required: true },
            { name: 'adminEmail', label: 'Admin Email', type: 'email', required: true },
            { name: 'plan', label: 'Subscription Plan', type: 'select', required: true },
        ],
    },
];

// ── COORDINATOR FORMS ────────────────────────────────────────────────────────

const COORDINATOR_FORMS: FormEntry[] = [
    {
        id: 'coordinator.waitlist-entry',
        label: 'Add to Waitlist',
        route: '/tenancy/coordinator/waitlist',
        apiEndpoint: '/v1/coordinator/waitlist',
        method: 'POST',
        dataCyPrefix: 'waitlist',
        category: 'coordinator',
        fields: [
            { name: 'clientId', label: 'Client', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/clients' },
            { name: 'serviceTypeId', label: 'Service Needed', type: 'select', required: true, fetchOptionsFrom: '/v1/admin/services' },
            { name: 'urgency', label: 'Urgency', type: 'select', required: true },
            { name: 'notes', label: 'Notes', type: 'textarea', required: false },
        ],
        dependencies: [
            {
                field: 'clientId',
                entityType: 'client',
                inlineCreateEndpoint: '/v1/admin/clients',
                fetchEndpoint: '/v1/admin/clients',
                inlineCreateLabel: '+ New Client',
            },
            {
                field: 'serviceTypeId',
                entityType: 'serviceType',
                inlineCreateEndpoint: '/v1/admin/services',
                fetchEndpoint: '/v1/admin/services',
                inlineCreateLabel: '+ New Service Type',
            },
        ],
    },
];

// ── AGGREGATE EXPORT ─────────────────────────────────────────────────────────

export const FormRegistry = [
    ...AUTH_FORMS,
    ...ADMIN_FORMS,
    ...ADMIN_WIZARD_FORMS,
    ...CLIENT_FORMS,
    ...PSW_FORMS,
    ...MANAGER_FORMS,
    ...RN_FORMS,
    ...SHARED_FORMS,
    ...MARKETING_FORMS,
    ...PLATFORM_FORMS,
    ...COORDINATOR_FORMS,
] as const;

// ── LOOKUP HELPERS ───────────────────────────────────────────────────────────

/** Find a form by its unique ID */
export const getFormById = (id: string): FormEntry | undefined =>
    FormRegistry.find(f => f.id === id);

/** Get all forms that belong to a category */
export const getFormsByCategory = (category: FormEntry['category']): FormEntry[] =>
    FormRegistry.filter(f => f.category === category);

/** Get all forms that have at least one dependency (inline creators) */
export const getFormsWithDependencies = (): FormEntry[] =>
    FormRegistry.filter(f => f.dependencies && f.dependencies.length > 0);

/** Get the total count of forms */
export const FORM_REGISTRY_COUNT = FormRegistry.length;
