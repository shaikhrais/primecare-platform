import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { setCookie, getCookie, deleteCookie } from 'hono/cookie';
import { verify } from 'hono/jwt';
import { Bindings, Variables } from '../bindings';
import { LoginSchema, RegisterSchema } from './auth.validation';
import { generateToken, generateRefreshToken } from './auth.service';
import { hashPassword } from '../_shared/utils/crypto';
import { requireAuth } from '../_shared/middleware/auth';
import { requireRole } from '../_shared/middleware/rbac';

const auth = new Hono<{ Bindings: Bindings; Variables: Variables }>();

auth.post('/register', zValidator('json', RegisterSchema), async (c) => {
    const prisma = c.get('prisma');
    const { email, password, role, tenantName, tenantSlug } = c.req.valid('json');

    const existingUser = await prisma.user.findUnique({ where: { email } });
    if (existingUser) return c.json({ error: 'User already exists' }, 400);

    // Find or create tenant
    let tenant;
    if (tenantSlug) {
        tenant = await prisma.tenant.findUnique({ where: { slug: tenantSlug } });
    }

    if (!tenant) {
        const slug = tenantSlug || 'default';
        tenant = await prisma.tenant.upsert({
            where: { slug: slug },
            update: {},
            create: {
                name: tenantName || 'Default Tenant',
                slug: slug,
                status: 'active'
            }
        });
    }

    const passwordHash = await hashPassword(password);

    const user = await prisma.user.create({
        data: {
            email,
            passwordHash,
            roles: [role] as any,
            tenantId: tenant.id
        },
    });

    if (role === 'client') {
        await prisma.clientProfile.create({
            data: {
                userId: user.id,
                fullName: email.split('@')[0],
                tenantId: tenant.id
            }
        });
    } else if (role === 'psw') {
        await prisma.pswProfile.create({
            data: {
                userId: user.id,
                fullName: email.split('@')[0],
                tenantId: tenant.id
            }
        });
    }

    const accessToken = await generateToken({ ...user, tenantId: tenant.id }, c.env.JWT_SECRET || 'fallback_secret');
    const refreshToken = await generateRefreshToken(user.id, c.env.JWT_SECRET || 'fallback_secret');

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24, // 1 day
        path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7, // 7 days
        path: '/v1/auth/refresh'
    });

    return c.json({ user, token: accessToken }, 201);
});

auth.post('/login', zValidator('json', LoginSchema), async (c) => {
    const { email, password } = c.req.valid('json');
    const prisma = c.get('prisma');

    const user = await prisma.user.findUnique({ where: { email } });
    const passwordHash = await hashPassword(password);

    if (!user || user.passwordHash !== passwordHash) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    const accessToken = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, c.env.JWT_SECRET || 'fallback_secret');

    const refreshToken = await generateRefreshToken(user.id, c.env.JWT_SECRET || 'fallback_secret');

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24, // 1 day
        path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7, // 7 days
        path: '/v1/auth/refresh'
    });

    return c.json({ user, token: accessToken });
});

auth.post('/switch-role', async (c) => {
    const payload = c.get('jwtPayload');
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const { targetRole } = await c.req.json();
    const prisma = c.get('prisma');

    if (!payload.roles.includes(targetRole)) {
        return c.json({ error: 'Forbidden: Role not assigned to user' }, 403);
    }

    const user = await prisma.user.findUnique({ where: { id: payload.sub } });
    if (!user) return c.json({ error: 'User not found' }, 404);

    const token = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, c.env.JWT_SECRET || 'fallback_secret', targetRole as any);

    setCookie(c, 'accessToken', token, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24,
        path: '/'
    });

    return c.json({ token, activeRole: targetRole });
});

auth.post('/refresh', async (c) => {
    const refreshToken = getCookie(c, 'refreshToken');
    if (!refreshToken) return c.json({ error: 'No refresh token' }, 401);

    const prisma = c.get('prisma');

    try {
        const payload = await verify(refreshToken, c.env.JWT_SECRET || 'fallback_secret', 'HS256');
        const user = await prisma.user.findUnique({ where: { id: payload.sub as string } });

        if (!user) return c.json({ error: 'User not found' }, 401);

        const accessToken = await generateToken({
            id: user.id,
            roles: user.roles as any,
            tenantId: user.tenantId
        }, c.env.JWT_SECRET || 'fallback_secret');

        setCookie(c, 'accessToken', accessToken, {
            httpOnly: true,
            secure: true,
            sameSite: 'None',
            maxAge: 60 * 60 * 24,
            path: '/'
        });

        return c.json({ token: accessToken });
    } catch (e) {
        return c.json({ error: 'Invalid refresh token' }, 401);
    }
});

auth.post('/logout', (c) => {
    deleteCookie(c, 'accessToken');
    deleteCookie(c, 'refreshToken', { path: '/v1/auth/refresh' });
    return c.json({ success: true });
});

auth.get('/whoami', async (c) => {
    // 1. Check if middleware already set the payload
    const payload = c.get('jwtPayload') as any;
    let userId: string | undefined = payload?.sub;

    // 2. Fallback: Manual check (similar to requireAuth) if payload is missing
    if (!userId) {
        const accessToken = getCookie(c, 'accessToken') || c.req.header('Authorization')?.replace('Bearer ', '');
        if (accessToken) {
            try {
                const decoded = await verify(accessToken, c.env.JWT_SECRET || 'fallback_secret', 'HS256');
                userId = decoded.sub as string;
            } catch (e) {
                return c.json({ error: 'Unauthorized', message: 'Invalid or expired session' }, 401);
            }
        }
    }

    if (!userId) {
        return c.json({ error: 'Not authenticated' }, 401);
    }

    const prisma = c.get('prisma');
    const user = await prisma.user.findUnique({
        where: { id: userId as string },
        select: { id: true, email: true, roles: true, tenantId: true }
    });

    if (!user) return c.json({ error: 'User not found' }, 404);
    return c.json({ user });
});

auth.post('/impersonate', async (c) => {
    const secret = c.env.JWT_SECRET || 'fallback_secret';
    // 1. Manually trigger auth & role check (since we are inside the auth module which is usually public)
    const authMiddleware = requireAuth(secret);
    let authPassed = false;
    await authMiddleware(c, async () => { authPassed = true; });
    if (!authPassed) return; // requireAuth already sent 401 if failed

    const roleMiddleware = requireRole(['admin']);
    let rolePassed = false;
    await roleMiddleware(c, async () => { rolePassed = true; });
    if (!rolePassed) return; // requireRole already sent 403 if failed

    const { targetUserId } = await c.req.json();
    const prisma = c.get('prisma');

    const targetUser = await prisma.user.findUnique({
        where: { id: targetUserId }
    });

    if (!targetUser) return c.json({ error: 'Target user not found' }, 404);

    const accessToken = await generateToken(targetUser, secret);
    const refreshToken = await generateRefreshToken(targetUser.id, secret);

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24, // 1 day
        path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7, // 7 days
        path: '/v1/auth/refresh'
    });

    return c.json({ user: targetUser, token: accessToken });
});

export default auth;
