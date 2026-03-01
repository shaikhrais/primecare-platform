import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import brandingRoutes from './branding.routes';

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
        console.error('Schema sync pending - business model settings failed', e);
        return c.json({
            success: false,
            error: 'DATABASE_OUT_OF_SYNC',
            message: 'Database missing new columns. Run prisma db push with production DATABASE_URL.'
        }, 500);
    }
});

// POST /logo - Upload business logo to R2
r.post('/logo', async (c) => {
    const formData = await c.req.formData();
    const file = formData.get('file');

    if (!file || typeof file === 'string') {
        console.error('Logo Upload: No file or invalid file in formData');
        return c.json({ error: 'No file uploaded' }, 400);
    }

    const logoFile = file as any as File;
    const tenantId = c.get('jwtPayload').tenantId;
    const fileExtension = logoFile.name.split('.').pop();
    const key = `logos/${tenantId}/${Date.now()}.${fileExtension}`;

    // Upload to R2
    await c.env.DOCS_BUCKET.put(key, await logoFile.arrayBuffer(), {
        httpMetadata: { contentType: logoFile.type },
    });

    // Generate public URL (assuming a public R2 bucket or worker proxy)
    // For now, we'll return a path that the worker can serve or a public dev domain
    const logoUrl = `/v1/system/files/${key}`;

    return c.json({ logoUrl }, 201);
});

r.route('/branding', brandingRoutes);

export default r;
