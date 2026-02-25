import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ProfileUpdateSchema = z.object({
    fullName: z.string().min(2).optional(),
    phone: z.string().optional(),
    addressLine1: z.string().optional(),
    city: z.string().optional(),
    province: z.string().optional(),
    postalCode: z.string().optional(),
    emergencyName: z.string().optional(),
    emergencyPhone: z.string().optional(),
});

// GET Profile
const getProfileRoute = createRoute({
    method: 'get',
    path: '/profile',
    summary: 'Get Client Profile',
    description: 'Retrieve the profile details for the authenticated client.',
    tags: ['Client Dashboard'],
    middleware: [requireRole(['client', 'rn', 'admin'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Client profile details',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(getProfileRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({
        where: { userId },
        include: { user: { select: { email: true, phone: true } } },
    });

    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    return c.json(profile, 200);
});

// PUT Profile
const updateProfileRoute = createRoute({
    method: 'put',
    path: '/profile',
    summary: 'Update Client Profile',
    description: 'Update the profile details for the authenticated client.',
    tags: ['Client Dashboard'],
    middleware: [requireRole(['client'])],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: ProfileUpdateSchema,
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Profile updated successfully',
        },
        401: {
            description: 'Unauthorized',
        },
        403: {
            description: 'Forbidden',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(updateProfileRoute, async (c) => {
    const prisma = c.get('prisma');
    const payload = c.get('jwtPayload');

    if (!payload) return c.json({ error: 'Unauthorized' }, 401);

    const data = c.req.valid('json');
    const can = c.get('can');
    const profileExists = await prisma.clientProfile.findUnique({ where: { userId: payload.sub } });
    if (!profileExists) return c.json({ error: 'Profile not found' }, 404);

    if (!(await can('update', 'ClientProfile', profileExists.id))) {
        return c.json({ error: 'Forbidden' }, 403);
    }

    const profile = await prisma.clientProfile.update({
        where: { userId: payload.sub },
        data: {
            fullName: data.fullName,
            addressLine1: data.addressLine1,
            city: data.city,
            province: data.province,
            postalCode: data.postalCode,
            emergencyName: data.emergencyName,
            emergencyPhone: data.emergencyPhone,
        },
    });

    return c.json(profile, 200);
});

// GET Dashboard Stats
const getClientStatsRoute = createRoute({
    method: 'get',
    path: '/stats',
    summary: 'Get Client Dashboard Statistics',
    description: 'Retrieve budget, wellness, and care continuity stats for the authenticated client.',
    tags: ['Client Dashboard'],
    middleware: [requireRole(['client'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        budget: z.array(z.any()),
                        wellness: z.array(z.any()),
                        continuity: z.array(z.any()),
                    }),
                },
            },
            description: 'Client dashboard statistics',
        },
        404: {
            description: 'Profile not found',
        },
    },
});

r.openapi(getClientStatsRoute, async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const invoices = await prisma.invoice.findMany({
        where: { clientId: profile.id },
        select: { status: true, total: true }
    });

    const totalBudget = 5000;
    const usedBudget = invoices.reduce((acc: number, inv: any) => acc + (Number(inv.total) || 0), 0);
    const spendingData = [
        { name: 'Used', value: usedBudget },
        { name: 'Remaining', value: Math.max(0, totalBudget - usedBudget) }
    ];

    const entries = await prisma.dailyEntry.findMany({
        where: { clientId: profile.id },
        orderBy: { createdAt: 'desc' },
        take: 7,
        select: { createdAt: true, mood: true }
    });

    const wellnessData = entries.reverse().map((e: any) => ({
        day: new Date(e.createdAt).toLocaleDateString('en-US', { weekday: 'short' }),
        mood: e.mood || 0,
        energy: Math.floor(Math.random() * 3) + (e.mood ? e.mood - 1 : 5)
    }));

    const continuityData = [
        { month: 'Jan', primary: 80, relief: 20 },
        { month: 'Feb', primary: 85, relief: 15 },
        { month: 'Mar', primary: 90, relief: 10 },
    ];

    return c.json({
        budget: spendingData,
        wellness: wellnessData.length > 0 ? wellnessData : [{ day: 'N/A', mood: 0, energy: 0 }],
        continuity: continuityData
    }, 200);
});

export default r;
