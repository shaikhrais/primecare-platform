import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

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
r.get('/profile', requireRole(['client', 'rn', 'admin']), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({
        where: { userId },
        include: { user: { select: { email: true, phone: true } } },
    });

    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    return c.json(profile);
});

// PUT Profile
r.put('/profile', requireRole(['client']), zValidator('json', ProfileUpdateSchema), async (c) => {
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

    return c.json(profile);
});

// GET Dashboard Stats
r.get('/stats', requireRole(['client']), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    // Get client profile ID
    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    // 1. Budget Utilization (From Invoices)
    const invoices = await prisma.invoice.findMany({
        where: { clientId: profile.id },
        select: { status: true, total: true }
    });

    // Mock budget for now (e.g. $5000/mo) - In real app, this would be in the ServiceAgreement model
    const totalBudget = 5000;
    const usedBudget = invoices.reduce((acc, inv) => acc + (Number(inv.total) || 0), 0);
    const spendingData = [
        { name: 'Used', value: usedBudget },
        { name: 'Remaining', value: Math.max(0, totalBudget - usedBudget) }
    ];

    // 2. Wellness Trends (From Daily Entries)
    const entries = await prisma.dailyEntry.findMany({
        where: { clientId: profile.id },
        orderBy: { createdAt: 'desc' },
        take: 7,
        select: { createdAt: true, mood: true }
    });

    // Format for chart: { day: 'Mon', mood: 8 }
    const wellnessData = entries.reverse().map(e => ({
        day: new Date(e.createdAt).toLocaleDateString('en-US', { weekday: 'short' }),
        mood: e.mood || 0,
        energy: Math.floor(Math.random() * 3) + (e.mood ? e.mood - 1 : 5) // Mock energy slightly correlated to mood
    }));

    // 3. Care Continuity (From Visits)
    const visits = await prisma.visit.findMany({
        where: { clientId: profile.id, status: 'completed' },
        include: { psw: true },
        take: 50
    });

    // Group by month and calculate primary vs relief
    // Simplified specific logic for the chart
    const continuityData = [
        { month: 'Jan', primary: 80, relief: 20 },
        { month: 'Feb', primary: 85, relief: 15 },
        { month: 'Mar', primary: 90, relief: 10 },
        // In a real implementation, we would aggregate the 'visits' array by month
    ];

    return c.json({
        budget: spendingData,
        wellness: wellnessData.length > 0 ? wellnessData : [{ day: 'N/A', mood: 0, energy: 0 }],
        continuity: continuityData
    });
});

export default r;
