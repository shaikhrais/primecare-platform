import { RouteRegistry } from '../../apps/web-admin/RouteRegistry';
import { ApiRegistry } from '../ApiRegistry';
import { InteractionDef } from './types';

export const BASE = {
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
};
