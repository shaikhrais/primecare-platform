import { Context, Next } from 'hono';

export const errorHandler = async (c: Context, next: Next) => {
    try {
        await next();
    } catch (err: any) {
        console.error('API Error caught in errorHandler:', err);
        const origin = c.req.header('Origin') || 'https://primecare-admin.pages.dev';

        return c.json({
            error: err.message || 'Internal Server Error',
            stack: err.stack,
            context: 'errorHandler success catch'
        }, 500, {
            'Access-Control-Allow-Origin': origin,
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With, Accept',
            'X-Error-Handled': 'true'
        });
    }
};

