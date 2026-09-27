// Governance - Category: service | Purpose: Core implementation file for the Manager Forms platform logic.
import type { FormEntry } from '../form_registry';

export const MANAGER_FORMS: FormEntry[] = [
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
