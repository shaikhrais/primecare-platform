import { RouteRegistry } from '../../apps/web-admin/RouteRegistry';
import { ApiRegistry } from '../ApiRegistry';
import { InteractionDef } from './types';

export const CLINICAL = {
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
            },
            SIGN_OFF: {
                id: 'rn-daily-audit-sign-off',
                label: 'Clinical Sign-off',
                type: 'button',
                module: 'RN',
                purpose: 'Official professional sign-off for clinical visit accuracy.',
                permission: 'DAILY_ENTRY_REVIEW',
                apiEndpoint: ApiRegistry.TENANCY.RN.DAILY_AUDIT_SIGN_OFF
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
                route: RouteRegistry.RN.SUPERVISION_DETAIL(':pswId')
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
};
