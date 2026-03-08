import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { setCookie } from 'hono/cookie';
import { Bindings, Variables } from '../../bindings';
import { LoginSchema } from '../auth.validation';
import { generateToken, generateRefreshToken } from '../auth.service';
import { hashPassword, comparePassword, isLegacyHash } from '../../_shared/utils/crypto';
import { ROUTE_METADATA } from '../../_shared/constants/route_metadata';
import { logAudit } from '../../_shared/utils/audit';
import { authRateLimit } from '../../_shared/middleware/rate-limit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// #6: Apply rate limiting to login (5 attempts per minute per IP)
r.use('/login', authRateLimit);

// Login
const loginRoute = createRoute({
    ...ROUTE_METADATA.AUTH.LOGIN,
    method: 'post',
    path: '/login',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: LoginSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        user: z.any(),
                        deviceStatus: z.string().optional(),
                        message: z.string().optional(),
                    }),
                },
            },
            description: 'Login successful',
        },
        401: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Unauthorized',
        },
        403: {
            content: {
                'application/json': {
                    schema: z.object({
                        error: z.string(),
                        message: z.string().optional()
                    }),
                },
            },
            description: 'Forbidden/Blocked',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Internal server error',
        },
    },
});

r.openapi(loginRoute, async (c) => {
    const { email, password } = c.req.valid('json');
    const prisma = c.get('prisma');

    const user = await prisma.user.findUnique({ where: { email } });

    if (!user || !user.passwordHash) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    // R23 (L19): Verify tenant context — prevent cross-tenant login
    // If a tenant context is provided (via header or JWT), ensure the user belongs to that tenant
    const requestTenantId = c.get('tenantId' as any) || c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
    if (requestTenantId && user.tenantId !== requestTenantId) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    // R3-1: Use comparePassword which supports both PBKDF2 and legacy SHA-256
    const isValid = await comparePassword(password, user.passwordHash);
    if (!isValid) {
        return c.json({ error: 'Invalid credentials' }, 401);
    }

    // R3-1: Auto-rehash legacy SHA-256 to PBKDF2 (transparent migration)
    if (isLegacyHash(user.passwordHash)) {
        const newHash = await hashPassword(password);
        await prisma.user.update({ where: { id: user.id }, data: { passwordHash: newHash } }).catch(() => { });
    }

    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const accessToken = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, jwtSecret);

    const refreshToken = await generateRefreshToken(user.id, jwtSecret);

    // --- Device Governance Registration ---
    const deviceId = c.req.header('X-Device-ID');
    const deviceName = c.req.header('X-Device-Name') || 'Unknown Device';
    const deviceType = c.req.header('X-Device-Type') || 'desktop';
    const isTempStr = c.req.header('X-Is-Temporary');
    const clientIp = c.req.header('CF-Connecting-IP') || '127.0.0.1';

    if (deviceId) {
        const tenant = await prisma.tenant.findUnique({ where: { id: user.tenantId } });
        const existingDevice = await prisma.userDevice.findUnique({
            where: { userId_deviceId: { userId: user.id, deviceId } }
        });

        if (!existingDevice) {
            // Check Device Limit
            const deviceCount = await prisma.userDevice.count({ where: { userId: user.id } });
            if (tenant && deviceCount >= tenant.maxDevicesPerUser) {
                return c.json({
                    error: 'Device Limit Exceeded',
                    message: `You have reached the maximum limit of ${tenant.maxDevicesPerUser} devices. Please revoke an existing device to continue.`
                }, 403);
            }

            // Create New Device
            await prisma.userDevice.create({
                data: {
                    userId: user.id,
                    deviceId,
                    deviceName,
                    deviceType,
                    lastIp: clientIp,
                    isAuthorized: tenant ? !tenant.requireDeviceApproval : true,
                    authorizedAt: (tenant && !tenant.requireDeviceApproval) ? new Date() : null,
                    isTemporary: isTempStr === 'true',
                    expiresAt: isTempStr === 'true' ? new Date(Date.now() + 1000 * 60 * 60 * 24) : null, // 24h for temp
                }
            });

            // If approval is required, the governance middleware will block subsequent requests 
            // but we can allow the login response to return the status.
            if (tenant?.requireDeviceApproval) {
                // R17: Return safe user fields only — the original code leaked passwordHash here!
                const safeUserPending = { id: user.id, email: user.email, roles: user.roles, tenantId: user.tenantId, status: user.status };
                return c.json({
                    user: safeUserPending,
                    // R19: token removed from body — HttpOnly cookie handles auth
                    deviceStatus: 'pending_approval',
                    message: 'Login successful, but this device requires administrator approval.'
                }, 200);
            }
        } else {
            // Update existing device
            await prisma.userDevice.update({
                where: { id: existingDevice.id },
                data: { lastActiveAt: new Date(), lastIp: clientIp }
            });

            if (existingDevice.status === 'blocked' || existingDevice.status === 'revoked') {
                return c.json({ error: 'Device Blocked', message: 'Access from this device has been revoked.' }, 403);
            }
        }
    }

    setCookie(c, 'accessToken', accessToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24,
        path: '/'
    });

    setCookie(c, 'refreshToken', refreshToken, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24 * 7,
        path: '/v1/auth/refresh'
    });

    if (deviceId) {
        await logAudit(
            prisma,
            user.id,
            'LOGIN',
            'USER',
            user.id,
            { tenantId: user.tenantId, ip: clientIp },
            deviceId
        );
    }

    // Return safe user fields only — NEVER expose passwordHash, resetToken, etc.
    const safeUser = { id: user.id, email: user.email, roles: user.roles, tenantId: user.tenantId, status: user.status };
    // R19: Don't return token in body — HttpOnly cookie handles auth
    return c.json({ user: safeUser }, 200);
});

// Switch Role
const switchRoleRoute = createRoute({
    ...ROUTE_METADATA.AUTH.SWITCH_ROLE,
    method: 'post',
    path: '/switch-role',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({ targetRole: z.string() }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        token: z.string(),
                        activeRole: z.string(),
                    }),
                },
            },
            description: 'Role switched successfully',
        },
        401: {
            description: 'Unauthorized',
        },
        403: {
            description: 'Role not assigned to user',
        },
        404: {
            description: 'User not found',
        },
    },
});

r.openapi(switchRoleRoute, async (c) => {
    const payload = c.get('jwtPayload');
    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const { targetRole } = c.req.valid('json');
    const prisma = c.get('prisma');

    if (!payload.roles.includes(targetRole)) {
        return c.json({ error: 'Forbidden: Role not assigned to user' }, 403);
    }

    const user = await prisma.user.findUnique({ where: { id: payload.sub } });
    if (!user) return c.json({ error: 'User not found' }, 404);

    const jwtSecret = c.env.JWT_SECRET;
    if (!jwtSecret) return c.json({ error: 'Server configuration error' }, 500);

    const token = await generateToken({
        id: user.id,
        roles: user.roles as any,
        tenantId: user.tenantId
    }, jwtSecret, targetRole as any);

    setCookie(c, 'accessToken', token, {
        httpOnly: true,
        secure: true,
        sameSite: 'None',
        maxAge: 60 * 60 * 24,
        path: '/'
    });

    // R19: Don't return token in body — HttpOnly cookie handles auth
    return c.json({ activeRole: targetRole }, 200);
});

export default r;



