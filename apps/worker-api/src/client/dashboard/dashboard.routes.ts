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

export default r;
