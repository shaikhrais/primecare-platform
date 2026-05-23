// Governance - Category: service | Purpose: Core implementation file for the System platform logic.
export const SYSTEM_METADATA = {
    VOICE: {
        summary: 'Upload Voice Note',
        description: 'Upload a voice note (audio file) for a specific user.',
        tags: ['System Voice'],
    },
    STORAGE_UPLOAD: {
        summary: 'Upload File',
        description: 'Upload a file to the documentation bucket.',
        tags: ['System Storage'],
    },
    STORAGE_GET: {
        summary: 'Get File',
        description: 'Retrieve a file from the documentation bucket by its key.',
        tags: ['System Storage'],
    },
    PAYMENT_INTENT: {
        summary: 'Create Payment Intent',
        description: 'Create a Stripe payment intent for a given amount and currency.',
        tags: ['System Payments'],
    },
    REGISTER_DEVICE: {
        summary: 'Register Device for Push',
        description: 'Register a device token for push notifications.',
        tags: ['System Notifications'],
    },
    LIST_NOTIFICATIONS: {
        summary: 'List Notifications',
        description: 'Retrieve a list of notifications for the authenticated user.',
        tags: ['System Notifications'],
    },
    READ_NOTIFICATION: {
        summary: 'Mark Notification as Read',
        description: 'Mark a specific notification as read for the authenticated user.',
        tags: ['System Notifications'],
    },
};
