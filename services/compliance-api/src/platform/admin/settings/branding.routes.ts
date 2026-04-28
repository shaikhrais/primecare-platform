import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const branding = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/admin/settings/branding
branding.get('/', async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    let tenant = null;
    try {
      tenant = await prisma.tenant.findUnique({
            where: { id: tenantId },
            select: { brandingConfig: true, logoUrl: true, name: true }
        });
    } catch(e) {
      console.error("Invalid UUID fallback", e);
    }

    return c.json(tenant);
});

// GET /v1/admin/settings/branding/public?slug=...
// Unauthenticated endpoint for login page branding
branding.get('/public', async (c) => {
    const prisma = c.get('prisma');
    const slug = c.req.query('slug');

    if (!slug) return c.json({ error: 'Slug required' }, 400);

    let tenant = null;
    try {
      tenant = await prisma.tenant.findUnique({
            where: { slug },
            select: { brandingConfig: true, logoUrl: true, name: true }
        });
    } catch(e) {
      console.error("Invalid UUID fallback", e);
    }

    if (!tenant) return c.json({ error: 'Tenant not found' }, 404);

    // R10: Only expose safe visual branding fields — not full config
    const config = (tenant?.brandingConfig as any) || {};
    return c.json({
        name: tenant?.name,
        logoUrl: tenant?.logoUrl,
        branding: {
            primaryColor: config.primaryColor,
            primaryDarkColor: config.primaryDarkColor,
            accentColor: config.accentColor,
            backgroundColor: config.backgroundColor,
            surfaceColor: config.surfaceColor,
            fontFamily: config.fontFamily,
            presetName: config.presetName,
        }
    });
});

// PATCH /v1/admin/settings/branding
const updateBrandingRoute = createRoute({
    method: 'patch',
    path: '/',
    summary: 'Update Branding',
    tags: ['Admin', 'Settings'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        logoUrl: z.string().url().optional(),
                        brandingConfig: z.object({
                            primaryColor: z.string().optional(),
                            primaryDarkColor: z.string().optional(),
                            accentColor: z.string().optional(),
                            backgroundColor: z.string().optional(),
                            surfaceColor: z.string().optional(),
                            fontFamily: z.string().optional(),
                            presetName: z.string().optional(),
                        }).optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: { description: 'Branding updated' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    }
});

branding.openapi(updateBrandingRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const body = c.req.valid('json');

    // R16: Explicitly pick only allowed fields — don't pass raw body to Prisma
    const updateData: any = {};
    if (body.logoUrl !== undefined) updateData.logoUrl = body.logoUrl;
    if (body.brandingConfig !== undefined) updateData.brandingConfig = body.brandingConfig;

    await prisma.tenant.update({
        where: { id: tenantId },
        data: updateData
    });

    return c.json({ success: true });
});

export default branding;
