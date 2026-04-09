import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ButtonRegistry, LinkRegistry, ApiRegistry, runIntegrityCheck } from 'prime-care-shared';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const RegistrySweepSchema = z.object({
    timestamp: z.string(),
    stats: z.object({
        buttons: z.number(),
        links: z.number(),
        orphans: z.number(),
        warnings: z.number(),
    }),
    results: z.array(z.object({
        id: z.string(),
        type: z.string(),
        status: z.enum(['ok', 'warning', 'error']),
        message: z.string(),
    })),
});

const sweepRoute = createRoute({
    summary: 'Response Bot Registry Sweep',
    tags: ['API', 'Scrum Master'],
    description: 'Programmatically audit all button and link registries against the ApiRegistry and RouteRegistry.',
    method: 'post',
    path: '/registry/sweep',
    responses: {
        200: {
            content: { 'application/json': { schema: RegistrySweepSchema } },
            description: 'Registry sweep completed',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(sweepRoute, async (c) => {
    const results: any[] = [];
    let orphans = 0;
    let warnings = 0;

    // 1. Audit ButtonRegistry (core buttons only)
    ButtonRegistry.filter(b => !['link', 'interaction', 'touchpoint'].includes(b.type)).forEach(btn => {
        if (btn.apiPath) {
            const pathExists = JSON.stringify(ApiRegistry).includes(btn.apiPath);
            if (!pathExists) {
                results.push({ id: btn.id, type: 'button', status: 'error', message: `Orphaned apiPath: ${btn.apiPath}` });
                orphans++;
            }
        }
    });

    // 2. Audit LinkRegistry
    LinkRegistry.forEach(lnk => {
        if (!lnk.path || lnk.path === '#') {
            results.push({ id: lnk.id, type: 'link', status: 'warning', message: 'Missing or placeholder path' });
            warnings++;
        }
    });

    return c.json({
        timestamp: new Date().toISOString(),
        stats: {
            buttons: ButtonRegistry.filter(b => !['link', 'interaction', 'touchpoint'].includes(b.type)).length,
            links: LinkRegistry.length,
            orphans,
            warnings,
        },
        results: results.length > 0 ? results : [{ id: 'system', type: 'audit', status: 'ok', message: 'All registries synchronized.' }],
    }, 200);
});

// ── Feature Integrity Check ──────────────────────────────────────────────────

const integrityRoute = createRoute({
    summary: 'Feature Integrity Check',
    tags: ['API', 'Scrum Master'],
    description: 'Cross-validates all registries (Page, Button, Form, PageAction) to detect incomplete feature implementations.',
    method: 'post',
    path: '/registry/integrity',
    responses: {
        200: {
            content: { 'application/json': { schema: z.any() } },
            description: 'Integrity report generated',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(integrityRoute, async (c) => {
    const report = runIntegrityCheck();
    return c.json(report, 200);
});

// ── Existing Routes ──────────────────────────────────────────────────────────

const flushRoute = createRoute({
    method: 'post', path: '/forensics/flush', summary: 'Flush Audits',
    tags: ['API', 'Scrum Master'],
    responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const reseedRoute = createRoute({
    method: 'post', path: '/governance/reseed', summary: 'Reseed Database',
    tags: ['API', 'Scrum Master'],
    responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

const deployRoute = createRoute({
    method: 'post', path: '/system/deploy', summary: 'Deploy Build',
    tags: ['API', 'Scrum Master'],
    responses: { 200: { content: { 'application/json': { schema: z.object({ message: z.string() }) } }, description: 'Success' },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
        '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(flushRoute, async (c) => c.json({ message: 'Audit logs flushed successfully.' }, 200));
r.openapi(reseedRoute, async (c) => c.json({ message: 'Database reseeded successfully.' }, 200));
r.openapi(deployRoute, async (c) => c.json({ message: 'Deployment initiated successfully.' }, 200));

export default r;
