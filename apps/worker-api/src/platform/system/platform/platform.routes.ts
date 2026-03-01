import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const platform = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All routes in this module require super_admin role
platform.use('*', async (c, next) => {
    const payload = c.get('jwtPayload');
    if (!payload?.roles.includes('super_admin')) {
        return c.json({ error: 'Forbidden: Super Admin access required' }, 403);
    }
    await next();
});

// GET /v1/system/platform/audit-logs
platform.get('/audit-logs', async (c) => {
    const prisma = c.get('prisma');

    // Note: Since super_admin bypasses the tenant extension, 
    // this findMany will see ALL records across ALL tenants.
    const logs = await prisma.auditLog.findMany({
        take: 100,
        orderBy: { createdAt: 'desc' },
        include: {
            tenant: { select: { name: true, slug: true } },
            actor: { select: { email: true } }
        }
    });

    return c.json({ logs });
});

// GET /v1/system/platform/stats
platform.get('/stats', async (c) => {
    const prisma = c.get('prisma');

    const [tenantCount, userCount, visitCount] = await Promise.all([
        prisma.tenant.count(),
        prisma.user.count(),
        prisma.visit.count()
    ]);

    return c.json({
        tenants: tenantCount,
        users: userCount,
        visits: visitCount
    });
});

export default platform;
