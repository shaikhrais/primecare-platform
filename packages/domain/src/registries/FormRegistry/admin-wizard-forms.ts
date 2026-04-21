import type { FormEntry } from '../01_I_form_registry';

// ── Admin Wizard Forms ───────────────────────────────────────────────────────

export const ADMIN_WIZARD_FORMS: FormEntry[] = [
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
            { field: 'clientId', entityType: 'client', inlineCreateEndpoint: '/v1/admin/clients', fetchEndpoint: '/v1/admin/clients', inlineCreateLabel: '+ New Client' },
            { field: 'serviceTypeId', entityType: 'serviceType', inlineCreateEndpoint: '/v1/admin/services', fetchEndpoint: '/v1/admin/services', inlineCreateLabel: '+ New Service Type' },
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
