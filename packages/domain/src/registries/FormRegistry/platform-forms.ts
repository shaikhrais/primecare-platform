import type { FormEntry } from '../form_registry';

export const MARKETING_FORMS: FormEntry[] = [
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
            { field: 'serviceTypeId', entityType: 'serviceType', inlineCreateEndpoint: '/v1/admin/services', fetchEndpoint: '/v1/admin/services', inlineCreateLabel: '+ New Service Type' },
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

export const PLATFORM_FORMS: FormEntry[] = [
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

export const COORDINATOR_FORMS: FormEntry[] = [
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
            { field: 'clientId', entityType: 'client', inlineCreateEndpoint: '/v1/admin/clients', fetchEndpoint: '/v1/admin/clients', inlineCreateLabel: '+ New Client' },
            { field: 'serviceTypeId', entityType: 'serviceType', inlineCreateEndpoint: '/v1/admin/services', fetchEndpoint: '/v1/admin/services', inlineCreateLabel: '+ New Service Type' },
        ],
    },
];
