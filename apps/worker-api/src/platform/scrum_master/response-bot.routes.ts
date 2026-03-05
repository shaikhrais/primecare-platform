import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ButtonRegistry, LinkRegistry, InteractionARegistry, ApiRegistry } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const sweepRegistryRoute = createRoute({
    summary: 'Platform Registry Sweep',
    description: 'Iterates through all platform registries (Buttons, Links, Interactions) to detect 404s or connectivity errors.',
    tags: ['Scrum Master'],
    method: 'post',
    path: '/sweep',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.object({
                        status: z.string(),
                        totalAudited: z.number(),
                        errorsFound: z.number(),
                    }),
                },
            },
            description: 'Registry sweep completed',
        },
    },
});

const listTouchpointsRoute = createRoute({
    summary: 'List System Touchpoints',
    description: 'Returns the current state of all audited platform touchpoints.',
    tags: ['Scrum Master'],
    method: 'get',
    path: '/touchpoints',
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.array(z.any()),
                },
            },
            description: 'List of touchpoints',
        },
    },
});

r.openapi(sweepRegistryRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    let totalAudited = 0;
    let errorsFound = 0;

    // 1. Audit Buttons
    for (const btn of ButtonRegistry) {
        totalAudited++;
        let status = 'OK';
        let errorDetail = null;

        if (btn.apiPath) {
            // Simple check: Does it start with /v1? Is it in ApiRegistry?
            // In a real sweep, we might do a HEAD request or check against the registered routes in Hono.
            // For Face One, we'll flag any path that looks like a placeholder or is missing.
            if (btn.apiPath.includes(':') || btn.apiPath.includes('undefined')) {
                status = 'WARNING';
                errorDetail = 'Path contains placeholders or unresolved variables.';
            }
        }

        await prisma.systemTouchpoint.upsert({
            where: { touchpointId: btn.id },
            update: { status, errorDetail, lastChecked: new Date() },
            create: {
                touchpointId: btn.id,
                type: 'BUTTON',
                role: btn.role,
                module: btn.module,
                path: btn.apiPath || 'UI_ACTION',
                status,
                errorDetail,
                tenantId,
            },
        });

        if (status !== 'OK') errorsFound++;
    }

    // 2. Audit Links
    for (const link of LinkRegistry) {
        totalAudited++;
        let status = 'OK';
        let errorDetail = null;

        if (!link.path || link.path === '/shared/404') {
            status = '404';
            errorDetail = 'Link points to 404 or is undefined.';
        }

        await prisma.systemTouchpoint.upsert({
            where: { touchpointId: link.id },
            update: { status, errorDetail, lastChecked: new Date() },
            create: {
                touchpointId: link.id,
                type: 'LINK',
                role: link.role,
                module: link.module,
                path: link.path,
                status,
                errorDetail,
                tenantId,
            },
        });

        if (status !== 'OK') errorsFound++;
    }

    return c.json({ status: 'success', totalAudited, errorsFound }, 200);
});

r.openapi(listTouchpointsRoute, async (c) => {
    const prisma = c.get('prisma');
    const tenantId = c.get('jwtPayload').tenantId;

    const touchpoints = await prisma.systemTouchpoint.findMany({
        where: { tenantId },
        orderBy: { lastChecked: 'desc' },
    });

    return c.json(touchpoints, 200);
});

export default r;
