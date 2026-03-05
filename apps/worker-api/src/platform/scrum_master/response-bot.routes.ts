import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { ButtonRegistry, LinkRegistry, InteractionARegistry, ApiRegistry, InteractionRegistry } from 'prime-care-shared';

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

    const upsertTouchpoint = async (data: {
        id: string;
        type: 'BUTTON' | 'LINK' | 'INTERACTION';
        role: string;
        module: string;
        label: string;
        path: string;
        status: 'OK' | '404' | 'WARNING' | 'ERROR';
        errorDetail?: string | null;
    }) => {
        totalAudited++;
        if (data.status !== 'OK') errorsFound++;

        const existing = await prisma.systemTouchpoint.findUnique({
            where: { touchpointId: data.id }
        });

        if (existing) {
            await prisma.systemTouchpoint.update({
                where: { touchpointId: data.id },
                update: {
                    status: data.status,
                    errorDetail: data.errorDetail,
                    lastChecked: new Date(),
                    // Only update label/path if NOT overridden
                    label: existing.isOverridden ? undefined : data.label,
                    path: existing.isOverridden ? undefined : data.path,
                },
            });
        } else {
            await prisma.systemTouchpoint.create({
                data: {
                    touchpointId: data.id,
                    type: data.type,
                    role: data.role,
                    module: data.module,
                    label: data.label,
                    path: data.path,
                    status: data.status,
                    errorDetail: data.errorDetail,
                    tenantId,
                },
            });
        }
    };

    // 1. Audit Buttons (Flat)
    for (const btn of ButtonRegistry) {
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

        await upsertTouchpoint({
            id: btn.id,
            type: 'BUTTON',
            role: btn.role,
            module: btn.module,
            label: btn.label,
            path: btn.apiPath || 'UI_ACTION',
            status,
            errorDetail,
        });
    }

    // 2. Audit Links (Flat)
    for (const link of LinkRegistry) {
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

        await upsertTouchpoint({
            id: link.id,
            type: 'LINK',
            role: link.role,
            module: link.module,
            label: link.label,
            path: link.path,
            status,
            errorDetail,
        });
    }

    // 3. Audit InteractionA (Flat)
    for (const ia of InteractionARegistry) {
        let status: 'OK' | '404' | 'WARNING' | 'ERROR' = 'OK';
        let errorDetail = null;
        const target = ia.target || 'UI_ACTION';

        if (target !== 'UI_ACTION' && publicUrlBase) {
            const publicCheck = await checkPublic(target);
            if (publicCheck.status !== 'OK') {
                status = publicCheck.status;
                errorDetail = publicCheck.detail;
            }
        }

        await upsertTouchpoint({
            id: ia.id,
            type: 'INTERACTION',
            role: ia.role,
            module: ia.module,
            label: ia.label,
            path: target,
            status,
            errorDetail,
        });
    }

    // 4. Audit InteractionRegistry (Recursive)
    const crawlInteractions = async (obj: any, currentRole: string = 'unknown') => {
        for (const key in obj) {
            const val = obj[key];
            if (val && typeof val === 'object') {
                if (val.id && val.label) {
                    // This is a leaf node (InteractionDef)
                    let status: 'OK' | '404' | 'WARNING' | 'ERROR' = 'OK';
                    let errorDetail = null;
                    const path = val.apiEndpoint || val.route || 'UI_ACTION';

                    if (path !== 'UI_ACTION' && typeof path === 'string' && publicUrlBase) {
                        const publicCheck = await checkPublic(path);
                        if (publicCheck.status !== 'OK') {
                            status = publicCheck.status;
                            errorDetail = publicCheck.detail;
                        }
                    }

                    await upsertTouchpoint({
                        id: val.id,
                        type: 'INTERACTION',
                        role: currentRole.toLowerCase(),
                        module: val.module || 'UNKNOWN',
                        label: val.label,
                        path: typeof path === 'function' ? 'DYNAMIC_FUNC' : path,
                        status,
                        errorDetail,
                    });
                } else {
                    // Recurse deeper
                    await crawlInteractions(val, isNaN(Number(key)) ? key : currentRole);
                }
            }
        }
    };

    await crawlInteractions(InteractionRegistry);

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
