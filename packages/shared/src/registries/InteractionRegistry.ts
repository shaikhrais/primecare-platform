export type InteractionType = 'button' | 'link' | 'submit' | 'tab' | 'nav_item';

export interface InteractionDef {
    id: string;
    label: string;
    type: InteractionType;
    icon?: string;
    route?: string;
    apiEndpoint?: string | ((...args: any[]) => string);
    permission?: string;
    module: 'ADMIN' | 'MANAGER' | 'STAFF' | 'PSW' | 'CLIENT' | 'RN' | 'SCRUM_MASTER';
    purpose: string;
}

export const InteractionRegistry = {
    RN: {
        CARE_PLANS: {
            CREATE: {
                id: 'rn-care-plan-create',
                label: 'New Care Plan',
                type: 'button',
                icon: 'plus',
                module: 'RN',
                purpose: 'Initiate a new clinical care plan for a client.',
                permission: 'CARE_PLAN_UPDATE'
            },
            EDIT: {
                id: 'rn-care-plan-edit',
                label: 'Edit',
                type: 'link',
                module: 'RN',
                purpose: 'Modify clinical goals or diagnoses of an existing plan.',
                permission: 'CARE_PLAN_UPDATE'
            }
        },
        AUDIT: {
            VERIFY: {
                id: 'rn-daily-audit-verify',
                label: 'Verify Entry',
                type: 'button',
                module: 'RN',
                purpose: 'Professional RN sign-off on PSW daily records.',
                permission: 'DAILY_ENTRY_REVIEW',
                apiEndpoint: '/v1/rn/clinical/audit/entries/:id/verify'
            },
            FLAG: {
                id: 'rn-daily-audit-flag',
                label: 'Flag for Edit',
                type: 'button',
                module: 'RN',
                purpose: 'Request corrections to clinical documentation.',
                permission: 'DAILY_ENTRY_REVIEW'
            }
        },
        SUPERVISION: {
            DRILL_DOWN: {
                id: 'rn-supervision-view',
                label: 'Supervise',
                type: 'link',
                module: 'RN',
                purpose: 'Access detailed performance and incident history for a caregiver.',
                permission: 'PSW_SUPERVISE',
                route: '/tenancy/rn/supervision/psw/:pswId'
            }
        }
    },
    SCRUM_MASTER: {
        AUDIT: {
            START: {
                id: 'sm-integrity-check',
                label: 'Run Integrity Sweep',
                type: 'button',
                icon: 'zap',
                module: 'SCRUM_MASTER',
                purpose: 'Check all platform interactions for 404s and registry alignment.',
                permission: 'AUDIT_VIEW'
            }
        }
    }
} as const;
