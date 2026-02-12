import { Hono } from 'hono';
import { Bindings, Variables } from '../../bindings';
import { requireRole } from '../../_shared/middleware/rbac';

const r = new Hono<{ Bindings: Bindings; Variables: Variables }>();

// GET Invoices
r.get('/invoices', requireRole(['client']), async (c) => {
    const prisma = c.get('prisma');
    const userId = c.get('jwtPayload').sub;

    const profile = await prisma.clientProfile.findUnique({ where: { userId } });
    if (!profile) return c.json({ error: 'Profile not found' }, 404);

    const invoices = await prisma.invoice.findMany({
        where: { clientId: profile.id },
        orderBy: { createdAt: 'desc' },
        include: { payments: true },
    });

    return c.json(invoices);
});

// GET Available Services
r.get('/services', async (c) => {
    const prisma = c.get('prisma');
    const services = await prisma.service.findMany({
        where: { tenantId: c.get('jwtPayload').tenantId }
    });
    return c.json(services);
});

export default r;
