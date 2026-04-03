import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const platform = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// All routes in this module require authentication
// POST/PUT/DELETE still require super_admin role
platform.use('*', async (c, next) => {
    const payload = c.get('jwtPayload');
    if (!payload) {
        return c.json({ error: 'Unauthorized' }, 401);
    }

    // Allow GET requests for metadata to all authenticated users
    if (c.req.method === 'GET' && (c.req.path.endsWith('/umbrellas') || c.req.path.endsWith('/roles') || c.req.path.endsWith('/stats'))) {
        return await next();
    }

    if (!payload.roles.includes('super_admin')) {
        return c.json({ error: 'Forbidden: Super Admin access required' }, 403);
    }
    await next();
});

// GET /v1/system/platform/umbrellas
platform.get('/umbrellas', async (c) => {
    const umbrellas = [
        { id: 'hq', name: 'Master Franchise HQ', roles: ['super_admin', 'admin'] },
        { id: 'ops', name: 'Operations & Logistics', roles: ['manager', 'coordinator', 'operations_manager'] },
        { id: 'clinical', name: 'Clinical Governance', roles: ['rn', 'clinical_manager', 'qa_manager'] },
        { id: 'care', name: 'Care Delivery', roles: ['psw', 'rmt', 'rpt', 'rch'] },
        { id: 'corporate', name: 'Corporate Services', roles: ['staff', 'finance', 'hr', 'marketing_manager'] },
        { id: 'client', name: 'Client Network', roles: ['client'] },
        { id: 'dev', name: 'Technical Governance', roles: ['scrum_master'] }
    ];
    return c.json(umbrellas);
});

// GET /v1/system/platform/roles
platform.get('/roles', async (c) => {
    const roles = [
        { id: 'super_admin', label: 'Platform Sovereign' },
        { id: 'admin', label: 'Master Franchise' },
        { id: 'manager', label: 'Branch Manager' },
        { id: 'coordinator', label: 'Logistics Coordinator' },
        { id: 'rn', label: 'Registered Nurse' },
        { id: 'psw', label: 'Personal Support Worker' },
        { id: 'staff', label: 'Staff Member' },
        { id: 'client', label: 'Client / Family' },
        { id: 'scrum_master', label: 'Scrum Master' }
    ];
    return c.json(roles);
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

    return c.json(logs);
});

// GET /v1/system/platform/system-events (Terminal Stream feed)
platform.get('/system-events', async (c) => {
    const prisma = c.get('prisma');
    const _tenantId = (c.get('jwtPayload') as any)?.tenantId;

    const events = await prisma.systemEvent.findMany({
        take: 30,
        orderBy: { createdAt: 'desc' }
    });

    // Provide ascending chronological order for the terminal
    return c.json(events.reverse());
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
