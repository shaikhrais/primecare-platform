import type { FormEntry } from '../01_I_form_registry';

export const SHARED_FORMS: FormEntry[] = [
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
