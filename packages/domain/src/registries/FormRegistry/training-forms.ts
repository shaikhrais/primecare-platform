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
        description: 'Command center for institution-wide staff training and compliance auditing.'
    },
    {
        id: 'assignTrainingModuleForm',
        label: 'Assign Training Module',
        category: 'training',
        fields: [
            { id: 'moduleId', label: 'Module ID', type: 'text', required: true },
            { id: 'staffId', label: 'Staff Member', type: 'text', required: true },
            { id: 'dueDate', label: 'Due Date', type: 'date', required: true }
        ],
        description: 'Form to assign specific training modules to clinical or corporate staff.'
    },
    {
        id: 'verifyCertificateForm',
        label: 'Verify Certificate',
        category: 'compliance',
        fields: [
            { id: 'certificateId', label: 'Certificate Number', type: 'text', required: true },
            { id: 'issueDate', label: 'Issue Date', type: 'date', required: true }
        ],
        description: 'Verify and log external certifications for compliance records.'
    }
];
