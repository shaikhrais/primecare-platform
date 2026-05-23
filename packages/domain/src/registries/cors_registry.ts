// Governance - Category: service | Purpose: Core implementation file for the Cors Registry platform logic.

export const CorsRegistry = {
    ALLOWED_ORIGINS: [
        'https://primecare-admin.pages.dev',
        'http://localhost:5173',
        'http://localhost:8787'
    ],
    ALLOWED_METHODS: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    ALLOWED_HEADERS: [
        'Content-Type',
        'Authorization',
        'X-Requested-With',
        'Accept',
        'X-Kinde-Status',
        'X-Tenant-ID',
        'x-tenant-id',
        'x-tenant-slug',
        'X-Device-ID',
        'X-Device-Name',
        'X-Device-Type',
        'X-Is-Temporary'
    ],
    EXPOSE_HEADERS: [
        'Content-Length',
        'X-Kinde-Status'
    ],
    MAX_AGE: 600,
    CREDENTIALS: true
} as const;
