import { Context, Next } from 'hono';
import { jwt } from 'hono/jwt';

/**
 * Standard Auth Middleware using HttpOnly Secure Cookies.
 */
export const requireAuth = (secret: string) => {
    return async (c: Context, next: Next) => {
        const middleware = jwt({
            secret,
            alg: 'HS256',
            cookie: 'accessToken'
        });

        await middleware(c, async () => {
            const payload = c.get('jwtPayload');
            if (payload) {
                // Map sub to id and roles to role (primary current role)
                c.set('user' as any, {
                    id: payload.sub,
                    role: payload.activeRole || payload.roles[0]
                });
            }
            await next();
        });
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
