import { RouteRegistry } from '../apps/web-admin/RouteRegistry';
import { ApiRegistry } from './ApiRegistry';

export type InteractionType = 'button' | 'link' | 'submit' | 'tab' | 'nav_item';

export interface InteractionDef {
    id: string;
    label: string;
    type: InteractionType;
    icon?: string;
    route?: string;
    apiEndpoint?: string | ((...args: any[]) => string);
    permission?: string;
    module: 'ADMIN' | 'MANAGER' | 'STAFF' | 'PSW' | 'CLIENT' | 'RN' | 'SCRUM_MASTER' | 'MARKETING' | 'HR' | 'COORDINATOR';
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
    },
    COORDINATOR: {
        HUB: {
            SOS_ACK: {
                id: 'coord-sos-ack',
                label: 'Acknowledge SOS',
                type: 'button',
                module: 'COORDINATOR',
                purpose: 'Formally acknowledge an SOS alert and begin investigation.',
                permission: 'COORDINATOR_DISPATCH',
                apiEndpoint: '/v1/coordinator/incident/ack'
            },
            MATCH_OVERRIDE: {
                id: 'coord-match-override',
                label: 'Override Match',
                type: 'button',
                module: 'COORDINATOR',
                purpose: 'Manually override a PSW assignment for a specific visit.',
                permission: 'COORDINATOR_DISPATCH',
                apiEndpoint: '/v1/coordinator/match/override'
            },
            WAITLIST_SYNC: {
                id: 'coord-waitlist-sync',
                label: 'Sync Waitlist',
                type: 'button',
                module: 'COORDINATOR',
                purpose: 'Update and synchronize waitlist entry priorities.',
                permission: 'COORDINATOR_DISPATCH',
                apiEndpoint: '/v1/coordinator/waitlist/sync'
            }
        }
    },
    MANAGER: {
        OPS: {
            STATS_REFRESH: {
                id: 'mgr-ops-stats-refresh',
                label: 'Refresh Ops Stats',
                type: 'button',
                module: 'MANAGER',
                purpose: 'Recalculate and update regional operational metrics.',
                permission: 'AUDIT_VIEW',
                apiEndpoint: '/v1/manager/ops/stats'
            },
            COMPLIANCE_SYNC: {
                id: 'mgr-compliance-sync',
                label: 'Sync Branch Compliance',
                type: 'button',
                module: 'MANAGER',
                purpose: 'Audit and synchronize regional branch compliance records.',
                permission: 'AUDIT_VIEW',
                apiEndpoint: '/v1/manager/ops/compliance/sync'
            },
            FEEDBACK_TRIAGE: {
                id: 'mgr-feedback-triage',
                label: 'Triage Feedback',
                type: 'button',
                module: 'MANAGER',
                purpose: 'Review and triage caregiver or client feedback.',
                permission: 'AUDIT_VIEW'
            }
        }
    },
    CLIENT: {
        ENGAGEMENT: {
            FEED: {
                id: 'client-family-feed',
                label: 'Family Hub',
                type: 'nav_item',
                module: 'CLIENT',
                purpose: 'Access the family care timeline and notifications.',
                route: RouteRegistry.PLAN.CLIENT.FAMILY_HUB
            },
            PAY_INVOICE: {
                id: 'client-pay-invoice',
                label: 'Pay Now',
                type: 'button',
                module: 'CLIENT',
                purpose: 'Complete payment for an outstanding care invoice.',
                apiEndpoint: ApiRegistry.TENANCY.CLIENT.INVOICE_PAY
            },
            SUBMIT_FEEDBACK: {
                id: 'client-feedback-submit',
                label: 'Rate Experience',
                type: 'button',
                module: 'CLIENT',
                purpose: 'Submit a star rating and comment for a visit.',
                apiEndpoint: ApiRegistry.TENANCY.CLIENT.FEEDBACK_SUBMIT
            }
        }
    }
} as const;
