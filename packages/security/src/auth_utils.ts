// Governance - Category: service | Purpose: Standard Auth Middleware using HttpOnly Secure Cookies. R22: Cookie-only JWT authentication — NO header fallback Head...
import { Context, Next } from 'hono';
import { jwt } from 'hono/jwt';

/**
 * Standard Auth Middleware using HttpOnly Secure Cookies.
 */
export const requireAuth = (secret: string) => {
    return async (c: Context, next: Next) => {
        // R22: Cookie-only JWT authentication — NO header fallback
        // Header-based auth was removed because it defeats HttpOnly cookie XSS protection.
        // Dual-Auth Support for Mobile / Web SPAs
        const authHeader = c.req.header('Authorization');
        
        let dynamicMiddleware;
        if (authHeader && authHeader.startsWith('Bearer ')) {
            dynamicMiddleware = jwt({ secret, alg: 'HS256' }); // Automatically parses header
        } else {
            dynamicMiddleware = jwt({ secret, alg: 'HS256', cookie: 'accessToken' });
        }

        try {
            await dynamicMiddleware(c, async () => { });
        } catch (e) {
            console.error("REQUIRE_AUTH ERROR:", e);
            return c.json({ error: 'Unauthorized', message: 'Valid session not found' }, 401);
        }

        const payload = c.get('jwtPayload') as { sub: string; roles: string[]; activeRole?: string; iss?: string; aud?: string; type?: string; jti?: string };
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

        // R23: Check JWT denylist — revoked tokens (from logout) are blocked here
        if (payload.jti) {
            const kv = (c.env as any)?.TOKEN_DENYLIST;
            if (kv) {
                const denied = await kv.get(`deny:${payload.jti}`);
                if (denied) {
                    return c.json({ error: 'Unauthorized', message: 'Session has been revoked' }, 401);
                }
            }
        }

        // Map sub to id and roles to role (primary current role)
        c.set('user' as any, {
            id: payload.sub,
            role: payload.activeRole || payload.roles[0]
        });

        await next();
    };
};

// R23: requireHeaderAuth DELETED — dead code that defeated HttpOnly cookie protection (L20)

