import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const branding = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// GET /v1/admin/settings/branding
branding.get('/', async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const tenant = await prisma.tenant.findUnique({
        where: { id: tenantId },
        select: { brandingConfig: true, logoUrl: true, name: true }
    });

    return c.json(tenant);
});

// GET /v1/admin/settings/branding/public?slug=...
// Unauthenticated endpoint for login page branding
branding.get('/public', async (c) => {
    const prisma = c.get('prisma');
    const slug = c.req.query('slug');

    if (!slug) return c.json({ error: 'Slug required' }, 400);

    const tenant = await prisma.tenant.findUnique({
        where: { slug },
        select: { brandingConfig: true, logoUrl: true, name: true }
    });

    return c.json(tenant);
});

// PATCH /v1/admin/settings/branding
const updateBrandingRoute = createRoute({
    method: 'patch',
    path: '/',
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
        200: { description: 'Branding updated' }
    }
});

branding.openapi(updateBrandingRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const body = c.req.valid('json');

    await prisma.tenant.update({
        where: { id: tenantId },
        data: body
    });

    return c.json({ success: true });
});

export default branding;
