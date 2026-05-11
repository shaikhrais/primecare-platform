import type { FormEntry } from '../form_registry';

export const CLIENT_FORMS: FormEntry[] = [
    {
        id: 'client.booking-request',
        label: 'Request a Booking',
        route: '/tenancy/client/request-booking',
        apiEndpoint: '/v1/client/bookings/request',
        method: 'POST',
        dataCyPrefix: 'booking-request',
        category: 'client',
        fields: [
            { name: 'serviceTypeId', label: 'Service Type', type: 'select', required: true, fetchOptionsFrom: '/v1/client/services/catalog' },
            { name: 'preferredDate', label: 'Preferred Date', type: 'date', required: true },
            { name: 'preferredTime', label: 'Preferred Time', type: 'time', required: true },
            { name: 'duration', label: 'Duration (hours)', type: 'number', required: true },
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
        dataCyPrefix: 'quick-booking',
        category: 'client',
        fields: [
            { name: 'serviceTypeId', label: 'Service', type: 'select', required: true, fetchOptionsFrom: '/v1/client/services/catalog' },
            { name: 'date', label: 'Date', type: 'date', required: true },
            { name: 'time', label: 'Time', type: 'time', required: true },
            { name: 'notes', label: 'Notes', type: 'textarea', required: false },
        ],
    },
];
