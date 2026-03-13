import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { ROUTE_METADATA } from '../../../_shared/constants/route_metadata';
import { requireRole } from '../../../_shared/middleware/rbac';
import { geocodeAddress } from '../../../_shared/utils/geocoding';

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
    ...ROUTE_METADATA.CLIENT.GET_PROFILE,
    method: 'get',
    path: '/profile',
    summary: 'Get Profile',
    tags: ['Client', 'Dashboard'],
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
    ...ROUTE_METADATA.CLIENT.UPDATE_PROFILE,
    method: 'put',
    path: '/profile',
    summary: 'Update Profile',
    tags: ['Client', 'Dashboard'],
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

    // Geocode if address has changed
    let lat = profileExists.lat;
    let lng = profileExists.lng;

    if (data.addressLine1 && data.addressLine1 !== profileExists.addressLine1) {
        const fullAddress = `${data.addressLine1}, ${data.city || profileExists.city || ''}, ${data.province || profileExists.province || ''}`;
        const geo = await geocodeAddress(fullAddress);
        if (geo) {
            lat = geo.lat;
            lng = geo.lng;
        }
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
            lat,
            lng,
        },
    });

    return c.json(profile, 200);
});

// GET Dashboard Stats
const getClientStatsRoute = createRoute({
    ...ROUTE_METADATA.CLIENT.STATS,
    method: 'get',
    path: '/stats',
    summary: 'Get Client Stats',
    tags: ['Client', 'Dashboard'],
    middleware: [requireRole(['client'])],
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        budget: z.array(z.any()),
                        wellness: z.array(z.any()),
                        continuity: z.array(z.any()),
                        nextVisit: z.any().nullable().optional(),
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

    const [invoices, entries, visits, nextVisit] = await Promise.all([
        prisma.invoice.findMany({
            where: { clientId: profile.id, status: 'paid' },
            select: { total: true }
        }),
        prisma.dailyEntry.findMany({
            where: { clientId: profile.id },
            orderBy: { createdAt: 'desc' },
            take: 7,
            select: { createdAt: true, mood: true }
        }),
        prisma.visit.findMany({
            where: { clientId: profile.id, status: 'completed' },
            include: { psw: { select: { id: true, fullName: true } } },
            take: 50
        }),
        prisma.visit.findFirst({
            where: { clientId: profile.id, status: { in: ['scheduled', 'en_route'] }, requestedStartAt: { gte: new Date() } },
            orderBy: { requestedStartAt: 'asc' },
            include: { psw: { include: { user: true } }, service: true }
        })
    ]);

    // Budget Calculation
    const totalBudget = 5000;
    const usedBudget = invoices.reduce((acc: number, inv: any) => acc + (Number(inv.total) || 0), 0);
    const spendingData = [
        { name: 'Used', value: usedBudget },
        { name: 'Remaining', value: Math.max(0, totalBudget - usedBudget) }
    ];

    // Wellness Trend (7 Days)
    const wellnessData = entries.reverse().map((e: any) => ({
        day: new Date(e.createdAt).toLocaleDateString('en-US', { weekday: 'short' }),
        mood: e.mood || 0,
        energy: Math.floor(Math.random() * 3) + (e.mood ? e.mood - 1 : 5)
    }));

    // Continuity (Primary vs Relief)
    // Logic: If a PSW has >= 30% of visits, they are "Primary"
    const pswCounts: Record<string, number> = {};
    visits.forEach((v: any) => {
        if (v.psw?.id) pswCounts[v.psw.id] = (pswCounts[v.psw.id] || 0) + 1;
    });

    const totalVisits = visits.length || 1;
    const primaryCount = Object.values(pswCounts).reduce((acc, count) => acc + (count / totalVisits >= 0.3 ? count : 0), 0);

    const continuityData = [
        { name: 'Primary Caregivers', value: Math.round((primaryCount / totalVisits) * 100) },
        { name: 'Relief Staff', value: Math.round(((totalVisits - primaryCount) / totalVisits) * 100) }
    ];

    const nextVisitFormatted = nextVisit ? {
        id: nextVisit.id,
        workerName: nextVisit.psw?.fullName || 'Unassigned',
        workerRole: nextVisit.service?.name || 'Personal Support Worker',
        arrivalTime: new Date(nextVisit.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        bio: nextVisit.psw?.user?.bio || 'Looking forward to our visit today!',
        imageUrl: nextVisit.psw?.user?.avatarUrl || `https://ui-avatars.com/api/?name=${encodeURIComponent(nextVisit.psw?.fullName || 'U')}`
    } : null;

    return c.json({
        budget: spendingData,
        wellness: wellnessData.length > 0 ? wellnessData : [{ day: 'N/A', mood: 0, energy: 0 }],
        continuity: continuityData,
        nextVisit: nextVisitFormatted
    }, 200);
});

export default r;
