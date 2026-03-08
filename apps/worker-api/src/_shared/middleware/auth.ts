import { Context, Next } from 'hono';
import { jwt } from 'hono/jwt';

/**
 * Standard Auth Middleware using HttpOnly Secure Cookies.
 */
export const requireAuth = (secret: string) => {
    return async (c: Context, next: Next) => {
        // R22: Cookie-only JWT authentication — NO header fallback
        // Header-based auth was removed because it defeats HttpOnly cookie XSS protection.
        const cookieMiddleware = jwt({
            secret,
            alg: 'HS256',
            cookie: 'accessToken'
        });

        try {
            await cookieMiddleware(c, async () => { });
        } catch (e) {
            return c.json({ error: 'Unauthorized', message: 'Valid session not found' }, 401);
        }

        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string; iss?: string; aud?: string; type?: string };
        if (!payload) {
            return c.json({ error: 'Unauthorized', message: 'Valid session not found' }, 401);
        }

        // R22: Validate issuer and audience claims (added in R8 token generation)
        if (payload.iss !== 'primecare-api' || payload.aud !== 'primecare-web') {
            return c.json({ error: 'Unauthorized', message: 'Invalid token claims' }, 401);
        }

        // R22: Block refresh tokens from being used as access tokens
        if (payload.type === 'refresh') {
            return c.json({ error: 'Unauthorized', message: 'Invalid token type' }, 401);
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

