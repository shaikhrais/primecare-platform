import type { FormEntry } from '../01_I_form_registry';

export const RN_FORMS: FormEntry[] = [
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
            { field: 'clientId', entityType: 'client', inlineCreateEndpoint: '/v1/admin/clients', fetchEndpoint: '/v1/admin/clients', inlineCreateLabel: '+ New Client' },
        ],
    },
];
