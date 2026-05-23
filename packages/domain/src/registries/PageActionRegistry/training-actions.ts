// Governance - Category: service | Purpose: Training-Specific Page Action Mappings Maps page IDs to allowed training orchestration buttons.
import type { PageActions } from '../page_action_registry';

/**
 * Training-Specific Page Action Mappings
 * Maps page IDs to allowed training orchestration buttons.
 */
export const TRAINING_ACTIONS: Record<string, PageActions> = {
    'training-director.home': {
        primary: 'BTN_TRAINING_ASSIGN',
        actions: [
            'BTN_TRAINING_VERIFY',
            'BTN_TRAINING_RENEW',
            'BTN_TRAINING_EXPORT'
        ]
    },
    'training.hub': {
        primary: 'BTN_TRAINING_ASSIGN',
        actions: ['BTN_TRAINING_VERIFY', 'BTN_TRAINING_EXPORT']
    },
    'training.cert-verifier': {
        primary: 'BTN_TRAINING_VERIFY',
        actions: []
    },
    'training.course-architect': {
        primary: 'BTN_TRAINING_ASSIGN',
        actions: []
    },
    'assignTrainingModuleForm': {
        primary: 'BTN_TRAINING_ASSIGN',
        actions: []
    },
    'verifyCertificateForm': {
        primary: 'BTN_TRAINING_VERIFY',
        actions: []
    }
};
