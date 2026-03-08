import { Context, Next } from 'hono';

export const errorHandler = async (c: Context, next: Next) => {
    try {
        await next();
    } catch (err: any) {
        // R11: Don't log full error object or leak message
        const origin = c.req.header('Origin') || '';

        return c.json({
            error: 'Internal Server Error',
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
