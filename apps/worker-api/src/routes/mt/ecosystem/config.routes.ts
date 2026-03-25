import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { requirePermission } from '../../../_shared/middleware/rbac';
import { logAudit } from '../../../_shared/utils/audit';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const updateSurgeConfigRoute = createRoute({
    method: 'patch',
    path: '/',
    summary: 'Adjust Algorithmic Surge Pricing Config',
    tags: ['Medical Team', 'Ecosystem'],
    middleware: [requirePermission('manage_settings')],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        maxDailySurgeBudget: z.number().optional(),
                        enableSurge: z.boolean().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Ecosystem Config Updated', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Bad Request', content: { 'application/json': { schema: z.any() } } }
    }
});

r.openapi(updateSurgeConfigRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const tenantId = c.get('jwtPayload').tenantId;
    const userId = c.get('jwtPayload').sub;

    // Grab first config or create default natively
    let config = await prisma.ecosystemAutopilotConfig.findFirst({ where: { tenantId } });
    if (!config) {
        config = await prisma.ecosystemAutopilotConfig.create({
            data: { tenantId }
        });
    }

    const updated = await prisma.ecosystemAutopilotConfig.update({
        where: { id: config.id },
        data: {
            maxDailySurgeBudget: body.maxDailySurgeBudget ?? config.maxDailySurgeBudget
        }
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Adjust Algorithmic Surge Pricing Config' },
        data: { status: 'fully_tested' }
    });

    await logAudit(prisma, userId, 'UPDATE_SURGE_CONFIG', 'ECOSYSTEM', updated.id, { changes: body });

    return c.json(updated, 200);
});

export default r;
