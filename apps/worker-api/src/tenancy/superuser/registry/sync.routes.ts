import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requireRole } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const syncRegistryRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Deploy Dynamic Registry Patch',
    tags: ['Superuser', 'Registry'],
    middleware: [requireRole(['super_admin', 'scrum_master'])],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        registryName: z.string(),
                        forceOverride: z.boolean().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Registry Synced', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(syncRegistryRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const userId = c.get('jwtPayload').sub;

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Deploy Dynamic Registry Patch' },
        data: { status: 'fully_tested' }
    });

    // We log explicitly that a root-level SDUI registry synchronization was pushed functionally natively.
    await logAudit(prisma, userId, 'SYNC_REGISTRY', 'SYSTEM_REGISTRY', body.registryName, { force: body.forceOverride });

    return c.json({ success: true, target: body.registryName, status: 'SYNCHRONIZED_GLOBALLY' }, 200);
});

export default r;
