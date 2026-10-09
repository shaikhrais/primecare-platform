// Governance - Category: adapter | Purpose: Core implementation file for the Client Forms platform logic.
import type { FormEntry } from '../form_registry';

export const CLIENT_FORMS: FormEntry[] = [
    {
        id: 'client.booking-request',
        label: 'Request a Booking',
        route: '/tenancy/client/request-booking',
        apiEndpoint: '/v1/client/bookings/request',
        method: 'POST',
        requiredHeaders: ['Idempotency-Key'],
        description: 'Submit an owned pending request, not a confirmed appointment. Use one Idempotency-Key per submission and retain it for retries. preferred_date is an explicit UTC timestamp.',
        dataCyPrefix: 'booking-request',
        category: 'client',
        fields: [
            { name: 'service_type', label: 'Requested Service', type: 'text', required: true },
            { name: 'preferred_date', label: 'Preferred Date (UTC)', type: 'text', required: true, placeholder: '2026-10-08T12:00:00Z' },
            { name: 'preferred_time', label: 'Preferred Time', type: 'time', required: false },
            { name: 'notes', label: 'Special Instructions', type: 'textarea', required: false },
        ],
    },
    {
        id: 'client.feedback',
        label: 'Submit Feedback',
        route: '/tenancy/client/feedback',
        apiEndpoint: '/v1/client/feedback',
        method: 'POST',
        dataCyPrefix: 'feedback',
        category: 'client',
        fields: [
            { name: 'visitId', label: 'Visit', type: 'select', required: true, fetchOptionsFrom: '/v1/client/bookings' },
            { name: 'rating', label: 'Rating', type: 'number', required: true },
            { name: 'comment', label: 'Comments', type: 'textarea', required: false },
        ],
    },
    {
        id: 'client.service-booking-modal',
        label: 'Service Booking (Quick)',
        route: '/tenancy/client',
        apiEndpoint: '/v1/client/bookings/request',
        method: 'POST',
        requiredHeaders: ['Idempotency-Key'],
        description: 'Submit an owned pending request. Use one Idempotency-Key per submission and retain it for retries. preferred_date is an explicit UTC timestamp.',
        dataCyPrefix: 'quick-booking',
        category: 'client',
        fields: [
            { name: 'service_type', label: 'Requested Service', type: 'text', required: true },
            { name: 'preferred_date', label: 'Preferred Date (UTC)', type: 'text', required: true, placeholder: '2026-10-08T12:00:00Z' },
            { name: 'preferred_time', label: 'Preferred Time', type: 'time', required: false },
            { name: 'notes', label: 'Notes', type: 'textarea', required: false },
        ],
    },
];
