import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import brandingRoutes from './branding.routes';
import securityRoutes from './security.routes';

import usageStatsRoutes from './usage-stats.routes';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// PATCH /business-model - Save tenant business model settings
const updateBusinessModelRoute = createRoute({
    method: 'patch',
    path: '/business-model',
    summary: 'Update Business Model Settings',
    description: 'Update tenant branding, tax, and profit margin settings.',
    tags: ['Admin Settings'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        businessName: z.string().optional(),
                        supportEmail: z.string().optional(),
                        businessNumber: z.string().optional(),
                        taxEnabled: z.boolean().optional(),
                        globalMarkup: z.number().optional(),
                        logoUrl: z.string().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                    }),
                },
            },
            description: 'Settings updated successfully',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({
                        success: z.boolean(),
                        error: z.string(),
                        message: z.string(),
                    }),
                },
            },
            description: 'Internal Server Error',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(updateBusinessModelRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;
    const { businessName, supportEmail, businessNumber, taxEnabled, globalMarkup, logoUrl } = c.req.valid('json');

    try {
        await prisma.tenant.update({
            where: { id: tenantId },
            data: {
                name: businessName,
                supportEmail,
                businessNumber,
                logoUrl,
                taxSettings: taxEnabled !== undefined ? { enabled: taxEnabled } : undefined,
                brandingConfig: globalMarkup !== undefined ? { globalMarkup } : undefined,
            },
        });
        return c.json({ success: true }, 200);
    } catch (e) {
        // R13: Don't leak internal migration instructions
        return c.json({
            success: false,
            error: 'Settings update failed',
            message: 'Please contact support if this persists.'
        }, 500);
    }
});

// POST /logo - Upload business logo to R2
const MAX_LOGO_SIZE = 2 * 1024 * 1024; // 2MB
const ALLOWED_IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/webp', 'image/svg+xml'];

r.post('/logo', async (c) => {
    const formData = await c.req.formData();
    const file = formData.get('file');

    if (!file || typeof file === 'string') {
        return c.json({ error: 'No file uploaded' }, 400);
    }

    const logoFile = file as any as File;

    // R13: Validate file size
    if (logoFile.size > MAX_LOGO_SIZE) {
        return c.json({ error: `Logo too large. Maximum: ${MAX_LOGO_SIZE / 1024 / 1024}MB` }, 413);
    }

    // R13: Validate content type
    if (!ALLOWED_IMAGE_TYPES.includes(logoFile.type)) {
        return c.json({ error: 'Invalid file type. Only images allowed.' }, 400);
    }

    const tenantId = c.get('jwtPayload').tenantId;
    // R13: Safe key — no user-controlled filenames
    const ext = logoFile.type.split('/')[1] || 'png';
    const key = `logos/${tenantId}/${Date.now()}.${ext}`;

    await c.env.DOCS_BUCKET.put(key, await logoFile.arrayBuffer(), {
        httpMetadata: { contentType: logoFile.type },
    });

    const logoUrl = `/v1/system/files/${key}`;
    return c.json({ logoUrl }, 201);
});

r.route('/branding', brandingRoutes);
r.route('/security', securityRoutes);
r.route('/usage-stats', usageStatsRoutes);

export default r;
