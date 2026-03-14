/**
 * Public Routes — extracted from index.ts
 * Health, branding, stats, marketing leads, public registries
 */
import { OpenAPIHono, z } from '@hono/zod-openapi';
import { Bindings, Variables } from './bindings';

type AppType = OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>;

const MarketingLeadSchema = z.object({ name: z.string().min(1).max(100), email: z.string().email().max(200), phone: z.string().max(30).optional(), source: z.string().max(50).optional(), message: z.string().max(1000).optional(), tenantId: z.string().uuid() });

const DEFAULT_BRAND = { name: 'PrimeCare', slug: '', status: 'active', logoUrl: '/primecare-logo-white.svg', brandingConfig: { primaryColor: '#0F172A', accentColor: '#3B82F6', logoUrl: '/primecare-logo-white.svg', name: 'PrimeCare', tagline: 'Compassionate Home Healthcare', isPlatform: true }, _needsSetup: true };

const EMPTY_STATS = { totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, syncedAt: new Date().toISOString() };

export function registerPublicRoutes(app: AppType) {
    // Health check
    app.get('/v1/health', async (c) => {
        try { const prisma = c.get('prisma'); if (prisma) await prisma.$queryRaw`SELECT 1`; return c.json({ status: 'ok', db: 'connected', time: new Date().toISOString(), architecture: 'role-first-modular' }); }
        catch (e: any) { return c.json({ status: 'degraded', db: 'disconnected', time: new Date().toISOString() }, 503); }
    });

    app.get('/favicon.ico', (c) => c.body(null, 204));

    // Public branding
    app.get('/v1/public/branding', async (c) => {
        const slug = c.req.query('slug');
        if (!slug) return c.json({ error: 'Slug required' }, 400);
        return c.json({ ...DEFAULT_BRAND, slug });
    });

    // Marketing leads
    app.post('/v1/marketing/leads', async (c) => {
        const prisma = c.get('prisma'); const body = await c.req.json();
        const parsed = MarketingLeadSchema.safeParse(body);
        if (!parsed.success) return c.json({ error: 'Validation failed', details: parsed.error.flatten() }, 400);
        const lead = await prisma.lead.create({ data: { ...parsed.data, status: 'new' } });
        return c.json({ success: true, lead }, 201);
    });

    // Public stats (tenant-scoped)
    app.get('/v1/public/stats', async (c) => {
        try {
            const prisma = c.get('prisma'); const tenantId = c.req.header('X-Tenant-ID') || c.req.header('x-tenant-id');
            if (!prisma) return c.json(EMPTY_STATS);
            if (!tenantId) return c.json({ ...EMPTY_STATS, error: 'Tenant context required' });
            const result: any[] = await prisma.$queryRaw`SELECT (SELECT COUNT(*) FROM users WHERE "tenantId" = ${tenantId})::int AS "totalUsers", (SELECT COUNT(*) FROM visits WHERE "tenantId" = ${tenantId})::int AS "totalVisits", (SELECT COUNT(*) FROM visits WHERE "tenantId" = ${tenantId} AND status = 'requested')::int AS "pendingVisits", (SELECT COUNT(*) FROM leads WHERE "tenantId" = ${tenantId})::int AS "totalLeads"`;
            const row = result[0] || EMPTY_STATS;
            return c.json({ totalUsers: row.totalUsers || 0, pendingVisits: row.pendingVisits || 0, totalVisits: row.totalVisits || 0, totalLeads: row.totalLeads || 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, syncedAt: new Date().toISOString() });
        } catch (e: any) { return c.json({ totalUsers: 0, pendingVisits: 0, totalVisits: 0, totalLeads: 0, modelScore: 0, MTD_REVENUE: '0.00', healthAlerts: { complianceRisk: 0, coverageGap: 0, pipelineStagnation: 0 }, error: 'Stats aggregation failed', syncedAt: new Date().toISOString() }); }
    });

    // Public registries
    app.get('/v1/public/registries', async (c) => {
        const prisma = c.get('prisma'); const category = c.req.query('category'); const section = c.req.query('section');
        try {
            const where: any = {}; if (category) where.category = category; if (section) where.section = section;
            const take = Math.min(parseInt(c.req.query('limit') || '100'), 500); const skip = parseInt(c.req.query('offset') || '0');
            const items = await prisma.registry.findMany({ where, orderBy: { key: 'asc' }, take, skip });
            return c.json({ total: items.length, items, syncedAt: new Date().toISOString() });
        } catch (e: any) { return c.json({ total: 0, items: [], error: 'Failed to fetch registries' }); }
    });
}
