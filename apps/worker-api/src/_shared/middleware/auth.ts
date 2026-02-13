import { Context, Next } from 'hono';
import { jwt } from 'hono/jwt';

/**
 * Standard Auth Middleware using HttpOnly Secure Cookies.
 */
export const requireAuth = (secret: string) => {
    return async (c: Context, next: Next) => {
        // 1. Try Cookie-based JWT
        const cookieMiddleware = jwt({
            secret,
            alg: 'HS256',
            cookie: 'accessToken'
        });

        let authError: any = null;
        try {
            await cookieMiddleware(c, async () => { });
        } catch (e) {
            authError = e;
        }

        // 2. If cookie fails or missing, try Header-based JWT
        if (!c.get('jwtPayload')) {
            const headerMiddleware = jwt({
                secret,
                alg: 'HS256'
            });
            try {
                await headerMiddleware(c, async () => { });
            } catch (e) {
                authError = e;
            }
        }

        const payload = c.get('jwtPayload');
        if (!payload) {
            return c.json({ error: 'Unauthorized', message: authError?.message || 'Valid session not found' }, 401);
        }

        // Map sub to id and roles to role (primary current role)
        c.set('user' as any, {
            id: payload.sub,
            role: payload.activeRole || payload.roles[0]
        });

        await next();
    };
};

/**
 * Fallback to Header-based Auth for legacy support or non-browser clients (if needed).
 */
export const requireHeaderAuth = (secret: string) => {
    return jwt({
        secret,
        alg: 'HS256'
    });
};
