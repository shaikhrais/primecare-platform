import { Hono } from 'hono';
import { Bindings, Variables } from '../bindings';
import { requireAuth } from '../_shared/middleware/auth';

const user = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// All /v1/user routes require authentication
user.use('*', async (c, next) => {
    const secret = c.env.JWT_SECRET || 'fallback_secret';
    const middleware = requireAuth(secret);
    await middleware(c, next);
});

// GET /v1/user/profile
user.get('/profile', async (c) => {
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

        // Standardize response for the frontend
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
                address: userWithProfile.clientProfile?.addressLine1, // Simplified for now
                createdAt: userWithProfile.createdAt
            };
        } else {
            // Default generic profile
            profile = {
                email: userWithProfile.email,
                phoneNumber: userWithProfile.phone,
                createdAt: userWithProfile.createdAt
            };
        }

        return c.json({ profile });
    } catch (error) {
        console.error('Error fetching profile:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

// PUT /v1/user/profile
user.put('/profile', async (c) => {
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

        // Update User base table (phone)
        await prisma.user.update({
            where: { id: userId },
            data: {
                phone: body.phoneNumber || body.phone
            }
        });

        // Update Role-specific profile
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

        return c.json({ success: true, message: 'Profile updated successfully' });
    } catch (error) {
        console.error('Error updating profile:', error);
        return c.json({ error: 'Internal server error' }, 500);
    }
});

export default user;
