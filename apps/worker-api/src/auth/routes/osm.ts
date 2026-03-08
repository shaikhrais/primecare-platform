import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { generateToken } from '../auth.service';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// OAuth Endpoints
const OSM_AUTH_URL = 'https://www.openstreetmap.org/oauth2/authorize';
const OSM_TOKEN_URL = 'https://www.openstreetmap.org/oauth2/token';
const OSM_USER_URL = 'https://api.openstreetmap.org/api/0.6/user/details.json';

// GET /v1/auth/osm
const osmStartRoute = createRoute({
    method: 'get',
    path: '/osm',
    summary: 'OpenStreetMap OAuth Start',
    description: 'Initializes the OAuth flow with OpenStreetMap.',
    tags: ['Authentication'],
    responses: {
        302: { description: 'Redirect to OSM' },
        500: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Internal error' }
    },
});

// GET /v1/auth/osm/callback
const osmCallbackRoute = createRoute({
    method: 'get',
    path: '/osm/callback',
    summary: 'OpenStreetMap OAuth Callback',
    description: 'Handles the OSM callback and logs the user in.',
    tags: ['Authentication'],
    request: {
        query: z.object({
            code: z.string().optional(),
            error: z.string().optional(),
        }),
    },
    responses: {
        302: { description: 'Redirect to Frontend' },
        400: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Bad request' },
        500: { content: { 'application/json': { schema: z.object({ error: z.string() }) } }, description: 'Internal error' }
    },
});

r.openapi(osmStartRoute, async (c) => {
    const clientId = c.env.OSM_CLIENT_ID;
    const redirectUri = c.env.OSM_REDIRECT_URI || `${c.env.SITE_URL || 'http://localhost:8787'}/v1/auth/osm/callback`;

    if (!clientId) {
        // R6: Don't silently fall back to dev mock — return clear error
        return c.json({ error: 'OSM OAuth not configured. Set OSM_CLIENT_ID.' }, 500);
    }

    const authUrl = `${OSM_AUTH_URL}?client_id=${clientId}&redirect_uri=${encodeURIComponent(redirectUri)}&response_type=code&scope=read_prefs`;

    return c.redirect(authUrl);
});

r.openapi(osmCallbackRoute, async (c) => {
    const { code, error } = c.req.valid('query');
    const prisma = c.get('prisma');

    if (error) {
        return c.json({ error: `OSM OAuth Error: ${error}` }, 400);
    }

    if (!code) {
        return c.json({ error: 'Missing code' }, 400);
    }

    const clientId = c.env.OSM_CLIENT_ID;
    const clientSecret = c.env.OSM_CLIENT_SECRET;
    const redirectUri = c.env.OSM_REDIRECT_URI || `${c.env.SITE_URL || 'http://localhost:8787'}/v1/auth/osm/callback`;

    // R6: Hard fail if JWT_SECRET is missing
    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    // R6: Reject mock codes in production
    if (code === 'MOCK_DEV_CODE') {
        return c.json({ error: 'Mock auth not allowed' }, 400);
    }

    try {
        // 1. Exchange Code for Token
        const tokenRes = await fetch(OSM_TOKEN_URL, {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: new URLSearchParams({
                client_id: clientId || '',
                client_secret: clientSecret || '',
                code,
                redirect_uri: redirectUri,
                grant_type: 'authorization_code',
            }),
        });

        const tokenData = await tokenRes.json() as any;
        if (!tokenRes.ok) throw new Error(tokenData.error_description || 'Token exchange failed');

        // 2. Fetch User Details
        const userRes = await fetch(OSM_USER_URL, {
            headers: { 'Authorization': `Bearer ${tokenData.access_token}` }
        });
        const userData = await userRes.json() as any;
        if (!userRes.ok) throw new Error('Failed to fetch OSM user details');

        const osmUser = userData.user;
        const osmId = osmUser.id.toString();
        const osmEmail = `${osmId}@osm.primecare.local`;

        // 3. Find or Create User
        let user = await prisma.user.findUnique({ where: { osmId } });

        if (!user) {
            const tenant = await prisma.tenant.findFirst();
            if (!tenant) throw new Error('No tenant found in system');

            user = await prisma.user.create({
                data: {
                    email: osmEmail,
                    osmId,
                    tenantId: tenant.id,
                    roles: ['client'],
                    status: 'active'
                }
            });
        }

        // 4. Generate Session — using env JWT_SECRET (no fallback)
        const accessToken = await generateToken({
            id: user.id,
            roles: user.roles as any,
            tenantId: user.tenantId
        }, jwtSecret);

        const refreshToken = await generateToken({
            id: user.id,
            roles: user.roles as any,
            tenantId: user.tenantId
        }, jwtSecret, { type: 'refresh', expiresInMinutes: 60 * 24 * 7 });

        setCookie(c, 'accessToken', accessToken, {
            httpOnly: true, secure: true, sameSite: 'None',
            maxAge: 60 * 60 * 24, path: '/'
        });

        setCookie(c, 'refreshToken', refreshToken, {
            httpOnly: true, secure: true, sameSite: 'None',
            maxAge: 60 * 60 * 24 * 7, path: '/'
        });

        // R6: Redirect WITHOUT token in URL — cookies handle auth
        const frontendUrl = c.env.SITE_URL || 'https://primecare-admin.pages.dev';
        return c.redirect(`${frontendUrl}/dashboard`);

    } catch (e: any) {
        // R6: Don't leak internal error messages
        return c.json({ error: 'OAuth authentication failed' }, 500);
    }
});

export default r;
