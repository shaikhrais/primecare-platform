import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

app.get('/pulse', async (c) => {
    const prisma = c.get('prisma');
    const events = await prisma.systemEvent.findMany({ where: { type: 'PULSE_HEARTBEAT' }, take: 10, orderBy: { createdAt: 'desc' } });

    return c.json(events);
});

app.get('/settings', async (c) => {
    const prisma = c.get('prisma');
    const settings = await prisma.systemPolicy.findMany({ take: 10 });

    return c.json(settings);
});

app.get('/staff', async (c) => {
    const prisma = c.get('prisma');
    const staff = await prisma.user.findMany({ where: { role: { not: 'client' } }, take: 10, select: { id: true, firstName: true, lastName: true, role: true } });

    return c.json(staff.map((s: any) => ({ id: s.id, title: `${s.firstName} ${s.lastName}`, detail: s.role })));
});

app.get('/approvals', async (c) => {
    const prisma = c.get('prisma');
    const approvals = await prisma.auditLog.findMany({ take: 10, orderBy: { timestamp: 'desc' } });

    return c.json(approvals.map((a: any) => ({ id: a.id, title: a.action, detail: a.category })));
});

app.get('/reports', async (c) => {
    const prisma = c.get('prisma');
    const reports = await prisma.supplyForecastMetrics.findMany({ take: 10 });

    return c.json(reports);
});

app.get('/teams', async (c) => {
    const prisma = c.get('prisma');
    const teams = await prisma.staffGroup.findMany({ take: 10 });

    return c.json(teams);
});

app.get('/clients', async (c) => {
    const prisma = c.get('prisma');
    const clients = await prisma.user.findMany({ where: { role: 'client' }, take: 10, select: { id: true, firstName: true, lastName: true } });

    return c.json(clients.map((c: any) => ({ id: c.id, title: `${c.firstName} ${c.lastName}`, detail: 'Active Client' })));
});

export default app;
