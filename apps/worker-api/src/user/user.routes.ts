import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';

const user = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All /v1/user routes require authentication
user.use('*', async (c, next) => {
    const secret = c.env.JWT_SECRET || 'fallback_secret';
    const middleware = requireAuth(secret);
    await middleware(c, next);
});

// GET /v1/user/profile
const getProfileRoute = createRoute({
    method: 'get',
    path: '/profile',
    summary: 'Get User Profile',
    description: 'Retrieve the standardized profile for the currently authenticated user based on their active role.',
    tags: ['User Profile'],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        profile: z.any(),
                    }),
                },
            },
            description: 'User profile details',
        },
        404: {
            description: 'User not found',
        },
        500: {
            description: 'Internal server error',
        },
    },
});

user.openapi(getProfileRoute, async (c) => {
    const prisma = c.get('prisma');
    const jwtPayload = c.get('jwtPayload');
    const { sub: userId } = jwtPayload;

    try {
        const userWithProfile = await prisma.user.findUnique({
            where: { id: userId },
            include: {
                pswProfile: true,
                clientProfile: true
            }
        });

        if (!userWithProfile) {
            return c.json({ error: 'User not found' }, 404);
        }

        const activeRole = jwtPayload.activeRole || userWithProfile.roles[0];
        let profile = null;

        if (activeRole === 'psw') {
            profile = {
                firstName: userWithProfile.pswProfile?.fullName?.split(' ')[0] || '',
                lastName: userWithProfile.pswProfile?.fullName?.split(' ').slice(1).join(' ') || '',
                email: userWithProfile.email,
                phoneNumber: userWithProfile.phone,
                address: userWithProfile.pswProfile?.address,
                avatarUrl: userWithProfile.pswProfile?.avatarUrl,
                bio: userWithProfile.pswProfile?.bio,
                createdAt: userWithProfile.createdAt
            };
        } else if (activeRole === 'client') {
            profile = {
                firstName: userWithProfile.clientProfile?.fullName?.split(' ')[0] || '',
                lastName: userWithProfile.clientProfile?.fullName?.split(' ').slice(1).join(' ') || '',
                email: userWithProfile.email,
                phoneNumber: userWithProfile.phone,
                address: userWithProfile.clientProfile?.addressLine1,
                createdAt: userWithProfile.createdAt
            };
        } else {
            profile = {
                email: userWithProfile.email,
                phoneNumber: userWithProfile.phone,
                createdAt: userWithProfile.createdAt
            };
        }

        return c.json({ profile }, 200);
    } catch (error) {
        console.error('Error fetching profile:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

// PUT /v1/user/profile
const updateProfileRoute = createRoute({
    method: 'put',
    path: '/profile',
    summary: 'Update User Profile',
    description: 'Update the profile details and phone number for the currently authenticated user.',
    tags: ['User Profile'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        firstName: z.string().optional(),
                        lastName: z.string().optional(),
                        phoneNumber: z.string().optional(),
                        phone: z.string().optional(),
                        address: z.string().optional(),
                        avatarUrl: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        message: z.string(),
                    }),
                },
            },
            description: 'Profile updated successfully',
        },
        404: {
            description: 'User not found',
        },
        500: {
            description: 'Internal server error',
        },
    },
});

user.openapi(updateProfileRoute, async (c) => {
    const prisma = c.get('prisma');
    const jwtPayload = c.get('jwtPayload');
    const { sub: userId } = jwtPayload;
    const body = await c.req.json();

    try {
        const user = await prisma.user.findUnique({
            where: { id: userId },
            include: { pswProfile: true, clientProfile: true }
        });

        if (!user) {
            return c.json({ error: 'User not found' }, 404);
        }

        const activeRole = jwtPayload.activeRole || user.roles[0];
        const fullName = `${body.firstName || ''} ${body.lastName || ''}`.trim();

        await prisma.user.update({
            where: { id: userId },
            data: {
                phone: body.phoneNumber || body.phone
            }
        });

        if (activeRole === 'psw') {
            await prisma.pswProfile.upsert({
                where: { userId: userId },
                create: {
                    userId: userId,
                    fullName: fullName,
                    address: body.address,
                    avatarUrl: body.avatarUrl,
                    tenantId: user.tenantId
                },
                update: {
                    fullName: fullName,
                    address: body.address,
                    avatarUrl: body.avatarUrl
                }
            });
        } else if (activeRole === 'client') {
            await prisma.clientProfile.upsert({
                where: { userId: userId },
                create: {
                    userId: userId,
                    fullName: fullName,
                    addressLine1: body.address,
                    tenantId: user.tenantId
                },
                update: {
                    fullName: fullName,
                    addressLine1: body.address
                }
            });
        }

        return c.json({ success: true, message: 'Profile updated successfully' }, 200);
    } catch (error) {
        console.error('Error updating profile:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

export default user;
