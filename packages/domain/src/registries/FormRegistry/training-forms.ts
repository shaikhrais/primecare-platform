import { FormEntry } from '../01_I_form_registry';

/**
 * Training Director Form Definitions
 * Standardized high-fidelity forms for the Training & Compliance module.
 */
export const TRAINING_FORMS: FormEntry[] = [
    {
        id: 'trainingDirectorDashboard',
        label: 'Training Director Dashboard',
        category: 'dashboard',
        fields: [], // Hydrated by TrainingDirectorDashboardAdapter
        apiEndpoint: '/v1/admin/training/stats',
        route: '/platform/admin/training/home',
        description: 'Command center for institution-wide staff training and compliance auditing.'
    },
    {
        id: 'assignTrainingModuleForm',
        label: 'Assign Training Module',
        category: 'training',
        fields: [
            { name: 'moduleId', label: 'Module ID', type: 'text', required: true },
            { name: 'staffId', label: 'Staff Member', type: 'text', required: true },
            { name: 'dueDate', label: 'Due Date', type: 'date', required: true }
        ],
        description: 'Form to assign specific training modules to clinical or corporate staff.'
    },
    {
        id: 'verifyCertificateForm',
        label: 'Verify Certificate',
        category: 'compliance',
        fields: [
            { name: 'certificateId', label: 'Certificate Number', type: 'text', required: true },
            { name: 'issueDate', label: 'Issue Date', type: 'date', required: true }
        ],
        description: 'Verify and log external certifications for compliance records.'
    },
    {
        id: 'trainingHub',
        label: 'Training Hub Dashboard',
        category: 'dashboard',
        fields: [],
        apiEndpoint: '/v1/staff/training/summary',
        route: '/tenancy/manager/training/hub',
        description: 'Unified gateway for staff to access assigned training modules and compliance status.'
    },
    {
        id: 'courseArchitectTool',
        label: 'Course Architect Tool',
        category: 'training',
        fields: [],
        apiEndpoint: '/v1/admin/training/architect/audit',
        route: '/platform/admin/training/architect',
        description: 'AI-assisted curriculum builder for creating and auditing training content.'
    }
];
