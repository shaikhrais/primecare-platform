import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/user/profile
const getProfileRoute = createRoute({
    method: 'get',
    path: '/',
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

r.openapi(getProfileRoute, async (c) => {
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

export default r;




