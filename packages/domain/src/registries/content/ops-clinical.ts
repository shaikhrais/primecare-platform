// Governance - Category: service | Purpose: Core implementation file for the Ops Clinical platform logic.
export const opsClinicalContent = {
    RN_SUPERVISION: {
        TITLE: 'Clinical Supervision Hub',
        SUBTITLE: 'Professional RN oversight and sign-off.',
        LOG_TITLE: 'Supervision Activity Log',
        LIST: {
            PENDING: 'Pending Supervision',
            COMPLETED: 'Supervision History',
            NO_ENTRIES: 'No entries requiring supervision.',
        }
    },
    CLINICAL_MESSAGES: {
        SUCCESS_SIGN_OFF: 'RN Sign-off Complete',
        ERROR_SIGN_OFF: 'Failed to complete sign-off',
    },
    RN_CARE_PLAN: {
        TITLE: 'Clinical Care Plan Management',
        SUBTITLE: 'Design and authorize customized care pathways.',
        BUILDER_TITLE: 'Clinical Care Plan Builder',
        BUILDER_SUBTITLE: 'Structured assessment and intervention design.',
        ACTIONS: {
            CREATE: 'Create Care Plan',
            EDIT: 'Edit Plan',
            AUTHORIZE: 'Authorize Plan',
            SAVE: 'Save Plan',
        },
        TABS: {
            ASSESSMENT: 'Registered Nurse Assessment',
            DIAGNOSES: 'Associated Diagnoses',
            GOALS: 'Care Goals',
            INTERVENTIONS: 'Nursing Interventions',
        },
        SUCCESS_SAVE: 'Care plan saved successfully!',
        ERROR_SAVE: 'Failed to save care plan',
        FIELDS: {
            CLIENT: 'Client Name',
            DIAGNOSIS: 'Primary Diagnosis',
            DIAGNOSES: 'Associated Diagnoses',
            ASSESSMENT: 'Registered Nurse Assessment',
            GOALS: 'Care Goals',
            INTERVENTIONS: 'Nursing Interventions',
            FREQUENCY: 'Service Frequency',
            SIGNATURE: 'RN Digital Signature',
            DATE: 'Date Authorized',
        },
        TABLE: {
            CLIENT: 'Client',
            VERSION: 'Version',
            STATUS: 'Status',
            DATE: 'Last Updated',
        }
    },
    RN_DAILY_AUDIT: {
        TITLE: 'Clinical Daily Audit',
        SUBTITLE: 'Peer review and quality assurance of caregiver entries.',
        ACTIONS: {
            VERIFY: 'Verify Entry',
            FLAG: 'Flag for Review',
            CLOSE: 'Close Audit',
        },
        VERIFY_BUTTON: 'Confirm Clinical Integrity',
        FLAG_BUTTON: 'Flag for Clinical Review',
        TABLE: {
            CAREGIVER: 'Caregiver',
            CLIENT: 'Client',
            STATUS: 'Audit Status',
            DATE: 'Entry Date',
        }
    },
    RN_ASSESSMENTS: {
        TITLE: 'Clinical Patient Assessments',
        SUBTITLE: 'In-home evaluations and physiological audits.',
        ACTIONS: {
            NEW: 'New Assessment',
            CONTINUE: 'Continue Draft',
            VIEW: 'View Assessment',
        },
        NEW_BUTTON: 'Initiate New Assessment',
        TYPE_LABELS: {
            INITIAL: 'Initial Intake',
            QUARTERLY: 'Quarterly Review',
            POST_HOSPITAL: 'Post-Hospitalization',
            INCIDENT: 'Incident-Response',
            ADL: 'Activities of Daily Living',
            COGNITIVE: 'Cognitive Evaluation',
            VITALS: 'Vitals Monitoring',
        },
        FIELDS: {
            CLIENT: 'Client Name',
            PATIENT: 'Patient Name',
            LOCATION: 'Assessment Location',
            DURATION: 'Assessment Duration',
            INSTRUCTOR: 'Assigned RN',
            GENERAL_HEALTH: 'General Health Status',
            COGNITIVE: 'Cognitive Function',
            MOBILITY: 'Mobility & Falls Risk',
            NUTRITION: 'Nutritional Intake',
            MEDICATION: 'Medication Management',
            VITALS: 'Baseline Vitals',
            SCORE: 'Clinical Score',
            CATEGORY: 'Risk Category',
            COMMENTS: 'Nursing Comments',
        },
        TABLE: {
            CLIENT: 'Client',
            TYPE: 'Assessment Type',
            STATUS: 'Status',
            DATE: 'Date',
        }
    },
    CLINICAL_FORMS: {
        TITLE: 'Medical Documentation',
        SUBTITLE: 'Authorized clinical forms and nursing notes.',
        SEARCH_PLACEHOLDER: 'Search forms...',
        NO_FORMS: 'No authorized forms found.',
    },
} as const;
