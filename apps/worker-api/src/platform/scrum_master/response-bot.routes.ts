import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ButtonRegistry, LinkRegistry, InteractionARegistry, ApiRegistry } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const sweepRegistryRoute = createRoute({
    summary: 'Platform Registry Sweep',
    description: 'Iterates through all platform registries to detect 404s or connectivity errors. Optionally pings public URLs.',
    tags: ['Scrum Master'],
    method: 'post',
    path: '/sweep',
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        publicUrlBase: z.string().optional(), // e.g., 'https://primecare-admin.pages.dev'
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

const updateTouchpointRoute = createRoute({
    summary: 'Update System Touchpoint',
    description: 'Manual override of a registry touchpoint (label or path) from the UI.',
    tags: ['Scrum Master'],
    method: 'patch',
    path: '/touchpoints/{id}',
    request: {
        params: z.object({
            id: z.string(),
        }),
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        label: z.string().optional(),
                        path: z.string().optional(),
                        isOverridden: z.boolean().optional(),
                    }),
                },
            },
        },
    },
    responses: {
        200: {
            content: {
                'application/json': {
                    schema: z.any(),
                },
            },
            description: 'Touchpoint updated',
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
    const { publicUrlBase } = (await c.req.json()) as { publicUrlBase?: string };

    let totalAudited = 0;
    let errorsFound = 0;

    // Helper to check public URL
    const checkPublic = async (path: string) => {
        if (!publicUrlBase) return { status: 'OK' as const };
        try {
            const url = `${publicUrlBase.replace(/\/$/, '')}${path}`;
            const res = await fetch(url, { method: 'HEAD' });
            if (res.status === 404) return { status: '404' as const, detail: 'Public 404' };
            if (!res.ok) return { status: 'ERROR' as const, detail: `Public HTTP ${res.status}` };
            return { status: 'OK' as const };
        } catch (e) {
            return { status: 'ERROR' as const, detail: `Public Fetch Failed: ${e}` };
        }
    };

    // 1. Audit Buttons
    for (const btn of ButtonRegistry) {
        totalAudited++;
        let status: 'OK' | '404' | 'WARNING' | 'ERROR' = 'OK';
        let errorDetail = null;

        if (btn.apiPath) {
            if (btn.apiPath.includes(':') || btn.apiPath.includes('undefined')) {
                status = 'WARNING';
                errorDetail = 'Path contains placeholders.';
            } else if (publicUrlBase) {
                const publicCheck = await checkPublic(btn.apiPath);
                if (publicCheck.status !== 'OK') {
                    status = publicCheck.status;
                    errorDetail = publicCheck.detail;
                }
            }
        }

        await prisma.systemTouchpoint.upsert({
            where: { touchpointId: btn.id },
            update: { status, errorDetail, lastChecked: new Date(), label: btn.label },
            create: {
                touchpointId: btn.id,
                type: 'BUTTON',
                role: btn.role,
                module: btn.module,
                label: btn.label,
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
        let status: 'OK' | '404' | 'WARNING' | 'ERROR' = 'OK';
        let errorDetail = null;

        if (!link.path || link.path === '/shared/404') {
            status = '404';
            errorDetail = 'Static link is broken.';
        } else if (publicUrlBase) {
            const publicCheck = await checkPublic(link.path);
            if (publicCheck.status !== 'OK') {
                status = publicCheck.status;
                errorDetail = publicCheck.detail;
            }
        }

        await prisma.systemTouchpoint.upsert({
            where: { touchpointId: link.id },
            update: { status, errorDetail, lastChecked: new Date(), label: link.label },
            create: {
                touchpointId: link.id,
                type: 'LINK',
                role: link.role,
                module: link.module,
                label: link.label,
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

r.openapi(updateTouchpointRoute, async (c) => {
    const prisma = c.get('prisma');
    const { id } = c.req.param();
    const data = await c.req.json();

    const updated = await prisma.systemTouchpoint.update({
        where: { id },
        data: {
            label: data.label,
            path: data.path,
            isOverridden: data.isOverridden ?? true,
            overrideValue: data.label || data.path, // Store the primary override
        },
    });

    return c.json(updated, 200);
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
