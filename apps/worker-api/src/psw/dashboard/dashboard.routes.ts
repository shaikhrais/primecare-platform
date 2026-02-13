import { Hono } from 'hono';
import { zValidator } from '@hono/zod-validator';
import { z } from 'zod';
import { Bindings, Variables } from '../../bindings';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

const ProfileUpdateSchema = z.object({
    bio: z.string().optional(),
    languages: z.array(z.string()).optional(),
    serviceAreas: z.array(z.string()).optional(),
    address: z.string().optional(),
});

// GET Profile
r.get('/profile', async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.pswProfile.findUnique({
        where: { userId },
        include: { user: { select: { email: true, phone: true } } },
    });

    if (!profile) return c.json({ error: 'Profile not found' }, 404);
    return c.json(profile);
});

// PUT Profile
r.put('/profile', zValidator('json', ProfileUpdateSchema), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;
    const data = c.req.valid('json');

    const can = c.get('can');
    const profileExists = await prisma.pswProfile.findUnique({ where: { userId } });
    if (!profileExists) return c.json({ error: 'Profile not found' }, 404);

    if (!(await can('update', 'PswProfile', profileExists.id))) {
        return c.json({ error: 'Forbidden' }, 403);
    }

    const profile = await prisma.pswProfile.update({
        where: { userId },
        data: {
            bio: data.bio,
            languages: data.languages,
            serviceAreas: data.serviceAreas,
            address: data.address,
        },
    });

    return c.json(profile);
});

export default r;
