// Governance - Category: service | Purpose: Core implementation file for the Ops platform logic.
import { RouteRegistry } from '../../apps/web-admin/RouteRegistry';
import { ApiRegistry } from '../ApiRegistry';
import { InteractionDef } from './types';

export const OPS = {
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
};
