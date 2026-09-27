// Governance - Category: service | Purpose: Classify an error into a category for structured logging. Categories: 'validation' (Zod), 'database' (Prisma), 'auth'...
import { Context, Next } from 'hono';

/**
 * Classify an error into a category for structured logging.
 * Categories: 'validation' (Zod), 'database' (Prisma), 'auth', 'unknown'
 */
export function classifyError(err: any): { category: string; statusCode: number; publicMessage: string } {
    // Zod validation errors
    if (err?.name === 'ZodError' || err?.issues) {
        return { category: 'validation', statusCode: 400, publicMessage: 'Validation Error' };
    }
    // Prisma errors (P2000–P2034 are query errors, P2001 = record not found)
    if (err?.code?.startsWith?.('P2') || err?.name?.includes?.('Prisma')) {
        const statusCode = err.code === 'P2025' ? 404 : 500;
        return { category: 'database', statusCode, publicMessage: statusCode === 404 ? 'Record Not Found' : 'Internal Server Error' };
    }
    // Auth errors
    if (err?.status === 401 || err?.status === 403) {
        return { category: 'auth', statusCode: err.status, publicMessage: err.status === 401 ? 'Unauthorized' : 'Forbidden' };
    }
    return { category: 'unknown', statusCode: 500, publicMessage: 'Internal Server Error' };
}

export const errorHandler = async (c: Context, next: Next) => {
    try {
        await next();
    } catch (err: any) {
        const reqId = (c.get as any)('requestId') || '-';
        const { category, statusCode, publicMessage } = classifyError(err);

        // Structured error log — includes correlation ID, category, and truncated stack
        console.error(JSON.stringify({
            ts: new Date().toISOString(),
            level: 'error',
            reqId,
            category,
            method: c.req.method,
            path: c.req.path,
            statusCode,
            error: {
                name: err?.name || 'Error',
                message: err?.message || 'Unknown error',
                stack: typeof err?.stack === 'string' ? err.stack.split('\n').slice(0, 5).join('\n') : String(err?.stack || ''),
                ...(category === 'validation' && err.issues ? { issues: err.issues.slice(0, 5) } : {}),
                ...(category === 'database' && err.code ? { prismaCode: err.code } : {}),
            },
        }));

        // R23: Validate origin — don't blindly reflect any Origin header
        const origin = c.req.header('Origin') || '';
        const allowedOrigins = ['https://primecare-admin.pages.dev', 'http://localhost:5173', 'http://localhost:8787'];
        const isPreview = /^https:\/\/[a-z0-9]+\.primecare-admin\.pages\.dev$/.test(origin);
        const safeOrigin = (allowedOrigins.includes(origin) || isPreview) ? origin : allowedOrigins[0]!;

        return c.json({
            error: publicMessage,
            context: 'errorHandler',
            requestId: reqId,
        }, statusCode as any, {
            'Access-Control-Allow-Origin': safeOrigin,
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, PATCH, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, X-Requested-With, Accept, X-Tenant-ID',
            'X-Error-Handled': 'true'
        });
    }
};
