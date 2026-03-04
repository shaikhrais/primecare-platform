import { RouteRegistry } from '../apps/web-admin/RouteRegistry';

export type InteractionType = 'button' | 'link' | 'submit' | 'tab' | 'nav_item';

export interface InteractionDef {
    id: string;
    label: string;
    type: InteractionType;
    icon?: string;
    route?: string;
    apiEndpoint?: string | ((...args: any[]) => string);
    permission?: string;
    module: 'ADMIN' | 'MANAGER' | 'STAFF' | 'PSW' | 'CLIENT' | 'RN' | 'SCRUM_MASTER' | 'MARKETING' | 'HR';
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
    },
    MARKETING: {
        DASHBOARD: {
            NEW_CAMPAIGN: {
                id: 'mkt-campaign-new',
                label: 'New Campaign',
                type: 'button',
                module: 'MARKETING',
                purpose: 'Launch a new lead acquisition campaign.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.MARKETING
            },
            EXPORT_CRM: {
                id: 'mkt-crm-export',
                label: 'Export CRM',
                type: 'button',
                module: 'MARKETING',
                purpose: 'Download lead data for external marketing tools.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.MARKETING
            }
        }
    },
    HR: {
        PORTAL: {
            POST_ROLE: {
                id: 'hr-role-post',
                label: 'Post Core Role',
                type: 'button',
                module: 'HR',
                purpose: 'Publish a new job opening to regional job boards.',
                permission: 'USER_CREATE',
                route: RouteRegistry.MANAGER.RECRUITING
            },
            BULK_NOTIFY: {
                id: 'hr-compliance-notify',
                label: 'Bulk Notify',
                type: 'button',
                module: 'HR',
                purpose: 'Send certification renewal alerts to multiple caregivers.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.RECRUITING
            }
        }
    },
    FINANCE: {
        HUB: {
            PL_EXPORT: {
                id: 'fin-pl-export',
                label: 'P&L Export',
                type: 'button',
                module: 'FINANCE',
                purpose: 'Export regional profit and loss data for external analysis.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.FINANCE
            },
            AUDIT_REQUEST: {
                id: 'fin-audit-req',
                label: 'Audit Request',
                type: 'button',
                module: 'FINANCE',
                purpose: 'Initiate a formal financial audit for the current branch.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.FINANCE
            }
        }
    },
    QA: {
        DASHBOARD: {
            SAFETY_REPORT: {
                id: 'qa-safety-report',
                label: 'Safety Report',
                type: 'button',
                module: 'QA' as any,
                purpose: 'Generate a comprehensive regional safety and medication compliance report.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.CLINICAL
            },
            INVESTIGATE_ALL: {
                id: 'qa-investigate-all',
                label: 'Investigate All',
                type: 'button',
                module: 'QA' as any,
                purpose: 'Launch an immediate investigation into all pending safety flags.',
                permission: 'AUDIT_VIEW',
                route: RouteRegistry.MANAGER.CLINICAL
            }
        }
    }
} as const;
