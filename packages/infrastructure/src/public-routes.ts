/**
 * Public Routes — extracted from index.ts
 * Health, branding, stats, marketing leads, public registries, telemetry
 */
import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

/** Worker start time — used to calculate uptime in health endpoint */
const WORKER_START_TIME = Date.now();

type AppType = OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>;

const MarketingLeadSchema = z.object({ name: z.string().min(1).max(100), email: z.string().email().max(200), phone: z.string().max(30).optional(), source: z.string().max(50).optional(), message: z.string().max(1000).optional(), tenantId: z.string().uuid() });

const DEFAULT_BRAND = { name: 'PrimeCare', slug: '', status: 'active', logoUrl: '/primecare-logo-white.svg', brandingConfig: { primaryColor: '#0F172A', accentColor: '#3B82F6', logoUrl: '/primecare-logo-white.svg', name: 'PrimeCare', tagline: 'Compassionate Home Healthcare', isPlatform: true }, _needsSetup: true };

const EMPTY_STATS = { totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, syncedAt: new Date().toISOString() };

const MarketingLeadRoute = createRoute({
    method: 'post',
    path: '/v1/marketing/leads',
    summary: 'Submit Marketing Lead',
    request: {
        body: {
            content: {
                'application/json': { schema: MarketingLeadSchema }
            }
        }
    },
    responses: {
        201: { description: 'Lead Created' },
        400: { description: 'Validation failed' }
    }
});

export function registerPublicRoutes(app: AppType) {
    // Enhanced health check — version, uptime, environment, DB status
    app.get('/v1/health', async (c) => {
        const now = Date.now();
        const uptimeMs = now - WORKER_START_TIME;
        const base = {
            version: '1.0.0',
            architecture: 'role-first-modular',
            environment: (c.env as any)?.ENVIRONMENT || 'development',
            uptime: {
                ms: uptimeMs,
                human: `${Math.floor(uptimeMs / 3600000)}h ${Math.floor((uptimeMs % 3600000) / 60000)}m`,
            },
            time: new Date().toISOString(),
        };
        try {
            const prisma = c.get('prisma');
            if (prisma) await prisma.$queryRaw`SELECT 1`;
            return c.json({ ...base, status: 'ok', db: 'connected' });
        } catch (e: any) {
            return c.json({ ...base, status: 'degraded', db: 'disconnected' }, 503);
        }
    });

    // Frontend error telemetry — receives ErrorBoundary + global error payloads
    app.post('/v1/telemetry/errors', async (c) => {
        try {
            const body = await c.req.json() as any;
            const reqId = (c.get as any)('requestId') || '-';
            // Log as structured JSON — never fails the request
            console.warn(JSON.stringify({
                ts: new Date().toISOString(),
                level: 'warn',
                source: 'frontend',
                reqId,
                type: body?.type || 'UNKNOWN',
                module: body?.module || 'unknown',
                url: body?.url || '-',
                error: {
                    name: body?.error?.name || body?.name || 'Error',
                    message: body?.error?.message || body?.message || '-',
                    stack: (body?.error?.stack || body?.stack || '').split?.('\n')?.slice(0, 5)?.join('\n'),
                },
            }));
        } catch { /* never let telemetry processing fail */ }
        return c.body(null, 204);
    });

    app.get('/favicon.ico', (c) => c.body(null, 204));

    // Public branding
    app.get('/v1/public/branding', async (c) => {
        const slug = c.req.query('slug');
        if (!slug) return c.json({ error: 'Slug required' }, 400);
        return c.json({ ...DEFAULT_BRAND, slug });
    });

    // Marketing leads via OpenAPI valid
    app.openapi(MarketingLeadRoute, async (c) => {
        const prisma = c.get('prisma'); 
        const parsed = c.req.valid('json');
        const lead = await prisma.lead.create({ data: { ...parsed, status: 'new' } });
        return c.json({ success: true, lead }, 201);
    });

    // Public stats (tenant-scoped)
    app.get('/v1/public/stats', async (c) => {
        try {
            const prisma = c.get('prisma'); const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
            if (!prisma) return c.json(EMPTY_STATS);
            if (!tenantId) return c.json({ ...EMPTY_STATS, error: 'Tenant context required' });
            const result: any[] = await prisma.$queryRaw`SELECT (SELECT COUNT(*) FROM users WHERE tenant_id = ${tenantId})::int AS "totalUsers", (SELECT COUNT(*) FROM visits WHERE tenant_id = ${tenantId})::int AS "totalVisits", (SELECT COUNT(*) FROM visits WHERE tenant_id = ${tenantId} AND status = 'requested')::int AS "pendingVisits", (SELECT COUNT(*) FROM leads WHERE tenant_id = ${tenantId})::int AS "totalLeads"`;
            const row = result[0] || EMPTY_STATS;
            return c.json({ totalUsers: row.totalUsers || 0, pendingVisits: row.pendingVisits || 0, totalVisits: row.totalVisits || 0, totalLeads: row.totalLeads || 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, syncedAt: new Date().toISOString() });
        } catch (e: any) { 
            return c.json({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, error: 'Stats aggregation failed', syncedAt: new Date().toISOString() }); 
        }
    });

    // Public registries
    app.get('/v1/public/registries', async (c) => {
        const prisma = c.get('prisma'); const category = c.req.query('category'); const section = c.req.query('section');
        try {
            const where: any = {}; if (category) where.category = category; if (section) where.section = section;
            const take = Math.min(parseInt(c.req.query('limit') || '100'), 500); const skip = parseInt(c.req.query('offset') || '0');
            const items = await prisma.registry.findMany({ where, orderBy: { key: 'asc' }, take, skip });
            return c.json({ total: items.length, items, syncedAt: new Date().toISOString() });
        } catch (e: any) { 
            // ---- OFFLINE MOCK BYPASS FOR FLUTTER UI TESTING ----
            if ((c.env as any).ENVIRONMENT !== 'production') {
                return c.json({
                    total: 3,
                    items: [
                        { id: 'REG-001', key: 'offline_mock_1', name: 'Local API Fallback Active', status: 'Active', updatedAt: new Date().toISOString() },
                        { id: 'REG-002', key: 'offline_mock_2', name: 'Database Temporarily Disconnected', status: 'Pending', updatedAt: new Date().toISOString() },
                        { id: 'REG-003', key: 'offline_mock_3', name: 'Flutter UI Testing Matrix', status: 'Active', updatedAt: new Date().toISOString() }
                    ],
                    syncedAt: new Date().toISOString(),
                    _mockSource: true
                });
            }
            return c.json({ total: 0, items: [], error: 'Internal Server Error' }); 
        }
    });

    // Dynamic Route Engine Map
    app.get('/v1/public/screens', async (c) => {
        const prisma = c.get('prisma');
        try {
            const screens = await prisma.platformScreen.findMany({
                orderBy: { orderIndex: 'asc' },
                select: { name: true, route: true, status: true, role: { select: { name: true } } }
            });
            return c.json({ success: true, data: screens, syncedAt: new Date().toISOString() });
        } catch (e: any) {
            console.error('[System.Screens] Fetch Error (Remote DB Down):', e.message);
            // Remediated: Never leak stack traces to client (BOLA/Info Leak)
            return c.json({ success: false, error: 'Internal Server Error' }, 500);
        }
    });
}
