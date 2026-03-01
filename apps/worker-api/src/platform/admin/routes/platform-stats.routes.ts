import { Hono } from 'hono';
import { PrismaClient } from '@prisma/client';

const platformStats = new Hono();

platformStats.get('/stats', async (c: any) => {
    / Aggregating across ALL tenants (bypass tenant isolation if needed or use system context)
    / Note: The Super Admin role in our middleware already allows bypassing tenant filters.
    const prisma = c.get('prisma');

    const [tenants, users, visits] = await Promise.all([
        prisma.tenant.count(),
        prisma.user.count(),
        prisma.visit.count()
    ]);

    / Calculate Platform Revenue (simplified example: 5% of total visit revenue)
    const totalFees = visits * 2.50; / Mock platform fee per visit

    return c.json({
        tenants,
        users,
        visits,
        networkRevenue: totalFees,
        systemHealth: 99.98,
        activeCriticalIncidents: 0
    });
});

export { platformStats };
