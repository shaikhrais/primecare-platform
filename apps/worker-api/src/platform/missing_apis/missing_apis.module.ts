import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

app.get('/pulse', async (c) => {
    const prisma = c.get('prisma');
    const events = await prisma.systemEvent.findMany({ where: { type: 'PULSE_HEARTBEAT' }, take: 10, orderBy: { createdAt: 'desc' } });
    if (events.length === 0) {
        return c.json([{ id: 'mock-1', title: 'Cardiac Regularity', detail: 'Normal Sinus Rhythm' }, { id: 'mock-2', title: 'Blood Oxygen', detail: '98% SpO2' }]);
    }
    return c.json(events);
});

app.get('/settings', async (c) => {
    const prisma = c.get('prisma');
    const settings = await prisma.systemPolicy.findMany({ take: 10 });
    if (settings.length === 0) return c.json([{ id: 'mock-1', title: 'Global SSL Enforced', detail: 'Enabled' }, { id: 'mock-2', title: 'Session Timeout', detail: '15 Minutes' }]);
    return c.json(settings);
});

app.get('/staff', async (c) => {
    const prisma = c.get('prisma');
    const staff = await prisma.user.findMany({ where: { role: { not: 'client' } }, take: 10, select: { id: true, firstName: true, lastName: true, role: true } });
    if (staff.length === 0) return c.json([{ id: 'mock-1', title: 'John Doe', detail: 'Registered Nurse' }]);
    return c.json(staff.map((s: any) => ({ id: s.id, title: `${s.firstName} ${s.lastName}`, detail: s.role })));
});

app.get('/approvals', async (c) => {
    const prisma = c.get('prisma');
    const approvals = await prisma.auditLog.findMany({ take: 10, orderBy: { timestamp: 'desc' } });
    if (approvals.length === 0) return c.json([{ id: 'mock-1', title: 'Annual Policy Override', detail: 'Pending GM Approval' }]);
    return c.json(approvals.map((a: any) => ({ id: a.id, title: a.action, detail: a.category })));
});

app.get('/reports', async (c) => {
    const prisma = c.get('prisma');
    const reports = await prisma.supplyForecastMetrics.findMany({ take: 10 });
    if (reports.length === 0) return c.json([{ id: 'mock-1', title: 'Q3 Asset Utilization', detail: 'Generated 2 hours ago' }, { id: 'mock-2', title: 'Ecosystem Load Metrics', detail: 'Stable across all nodes' }]);
    return c.json(reports);
});

app.get('/teams', async (c) => {
    const prisma = c.get('prisma');
    const teams = await prisma.staffGroup.findMany({ take: 10 });
    if (teams.length === 0) return c.json([{ id: 'mock-1', title: 'Alpha Response Team', detail: 'Deployed to Sector 7' }, { id: 'mock-2', title: 'Triage Specialists', detail: 'Standby for immediate action' }]);
    return c.json(teams);
});

app.get('/clients', async (c) => {
    const prisma = c.get('prisma');
    const clients = await prisma.user.findMany({ where: { role: 'client' }, take: 10, select: { id: true, firstName: true, lastName: true } });
    if (clients.length === 0) return c.json([{ id: 'mock-1', title: 'Jane Smith', detail: 'Active Client Protocol' }, { id: 'mock-2', title: 'Robert Evans', detail: 'Stable Condition' }]);
    return c.json(clients.map((c: any) => ({ id: c.id, title: `${c.firstName} ${c.lastName}`, detail: 'Active Client' })));
});

export default app;
