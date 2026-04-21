import { ButtonDef } from '../01_I_button_registry';

/**
 * Training Director Button Definitions
 * Reusable action buttons for the Training & Compliance module.
 */
export const TRAINING_BUTTONS: ButtonDef[] = [
    {
        id: 'BTN_TRAINING_ASSIGN',
        label: 'Assign Course',
        role: 'training_director',
        module: 'TRAINING',
        type: 'primary',
        action: 'ASSIGN',
        description: 'Opens assignment flow for specific training modules.',
        apiPath: '/v1/training/assign',
        category: 'button'
    },
    {
        id: 'BTN_TRAINING_VERIFY',
        label: 'Verify Certificate',
        role: 'training_director',
        module: 'TRAINING',
        type: 'secondary',
        action: 'VERIFY',
        description: 'Verify and log external certifications for compliance records.',
        apiPath: '/v1/training/verify',
        category: 'button'
    },
    {
        id: 'BTN_TRAINING_RENEW',
        label: 'Bulk Renewal',
        role: 'training_director',
        module: 'TRAINING',
        type: 'secondary',
        action: 'RENEW',
        description: 'Triggers bulk renewal reminders for expiring certifications.',
        apiPath: '/v1/training/renew',
        category: 'button'
    },
    {
        id: 'BTN_TRAINING_EXPORT',
        label: 'Export Compliance',
        role: 'training_director',
        module: 'TRAINING',
        type: 'ghost',
        action: 'EXPORT',
        description: 'Generates platform-wide staff compliance reports.',
        apiPath: '/v1/training/export',
        category: 'button'
    }
];
