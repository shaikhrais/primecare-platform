import { Context, Next } from 'hono';

export const errorHandler = async (c: Context, next: Next) => {
    try {
        await next();
    } catch (err: any) {
        // R23: Validate origin — don't blindly reflect any Origin header
        const origin = c.req.header('Origin') || '';
        const allowedOrigins = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
        const isPreview = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/.test(origin);
        const safeOrigin = (allowedOrigins.includes(origin) || isPreview) ? origin : allowedOrigins[0];

        return c.json({
            error: 'Internal Server Error',
            context: 'errorHandler'
        }, 500, {
            'Access-Control-Allow-Origin': safeOrigin,
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, X-Requested-With, Accept, X-Tenant-ID',
            'X-Error-Handled': 'true'
        });
    }
};
