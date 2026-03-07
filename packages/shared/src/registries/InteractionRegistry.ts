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
    FINANCE_DIRECTOR: {
        DASHBOARD: {
            REFRESH: {
                id: 'fd-dashboard-refresh',
                label: 'Refresh Ledger',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Trigger a real-time ledger synchronization and P&L recalculation.',
                permission: 'FINANCIAL_ADMIN',
                apiEndpoint: ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT
            },
            GENERATE_AUDIT: {
                id: 'fd-generate-audit',
                label: 'Generate Audit',
                type: 'button',
                module: 'FINANCE_DIRECTOR' as any,
                purpose: 'Produce a GAAP-compliant forensic audit trail of all ledger entries.',
                permission: 'FINANCIAL_ADMIN'
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
                route: RouteRegistry.CLIENT.FAMILY_HUB
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
            },
            BOOKING_REQUEST: {
                id: 'client-booking-request',
                label: 'Request Service',
                type: 'button',
                module: 'CLIENT',
                purpose: 'Submit a new care service request for approval.',
                apiEndpoint: ApiRegistry.CLIENT.BOOKING_REQUESTS
            }
        }
    },
    PSW: {
        CARE: {
            CHECK_IN: {
                id: 'psw-check-in',
                label: 'Check-in Now',
                type: 'button',
                module: 'PSW',
                purpose: 'Verify caregiver arrival via geofenced timestamp.',
                apiEndpoint: ApiRegistry.TENANCY.PSW.CHECK_IN(':id')
            },
            CHECK_OUT: {
                id: 'psw-check-out',
                label: 'Complete Visit',
                type: 'button',
                module: 'PSW',
                purpose: 'Finalize visit and record geofenced departure.',
                apiEndpoint: ApiRegistry.TENANCY.PSW.CHECK_OUT(':id')
            }
        },
        FINANCE: {
            PAYOUT: {
                id: 'psw-payout-sync',
                label: 'Sync to Bank',
                type: 'button',
                module: 'PSW',
                purpose: 'Initiate earnings transfer to verified bank account.',
                apiEndpoint: ApiRegistry.TENANCY.PSW.PAYOUT_HISTORY
            }
        },
        OPERATIONS: {
            HANDOVER: {
                id: 'psw-handover-submit',
                label: 'Complete Handover',
                type: 'button',
                module: 'PSW',
                purpose: 'Submit clinical notes and supplies needed after shift completion.',
                apiEndpoint: ApiRegistry.TENANCY.PSW.HANDOVER_SUBMIT
            },
            AVAILABILITY_SYNC: {
                id: 'psw-avail-sync',
                label: 'Save Availability',
                type: 'button',
                module: 'PSW',
                purpose: 'Synchronize availability overrides and weekly schedule configurations.',
                apiEndpoint: ApiRegistry.TENANCY.PSW.AVAILABILITY_SYNC
            }
        }
    }
} as const;
