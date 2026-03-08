import { Context, Next } from 'hono';

export const errorHandler = async (c: Context, next: Next) => {
    try {
        await next();
    } catch (err: any) {
        console.error('API Error caught in errorHandler:', err.message);
        const origin = c.req.header('Origin') || '';

        return c.json({
            error: err.message || 'Internal Server Error',
            // #1: Never expose stack traces in production
            context: 'errorHandler'
        }, 500, {
            'Access-Control-Allow-Origin': origin || 'https://primecare-admin.pages.dev',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With, Accept, X-Tenant-ID',
            'X-Error-Handled': 'true'
        });
    }
};

