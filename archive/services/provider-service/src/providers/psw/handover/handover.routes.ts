import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';
import { ROUTE_METADATA } from '@primecare/infrastructure';
import { logAudit } from '@primecare/infrastructure';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const HandoverSchema = z.object({
    visitId: z.string().uuid(),
    handoverNotes: z.string(),
    safetyConcerns: z.string().optional(),
    suppliesNeeded: z.string().optional(),
});

const submitHandoverRoute = createRoute({
    ...ROUTE_METADATA.PSW_EXTRA.HANDOVER_SUBMIT,
    method: 'post',
    path: '/',
    summary: 'Submit Handover',
    tags: ['PSW', 'Handover'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: HandoverSchema,
                },
            },
        },
    },
    responses: {
        201: {
            content: {
                'application/json': {
                    schema: z.object({ success: z.boolean(), id: z.string() }),
                },
            },
            description: 'Handover report submitted successfully',
        },
        404: {
            content: {
                'application/json': {
                    schema: z.object({ error: z.string() }),
                },
            },
            description: 'Resource not found',
        },
        '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
    },
});

r.openapi(submitHandoverRoute, async (c) => {
    const prisma = c.get('prisma');
    const user = c.get('user');
    const tenantId = c.get('jwtPayload').tenantId;
    const data = c.req.valid('json');

    // Get PSW profile ID
    const providerProfile = await prisma.providerProfile.findUnique({
        where: { userId: user.id }
    });

    if (!providerProfile) {
        return c.json({ error: 'PSW profile not found' }, 404);
    }

    const handover = await prisma.shiftHandover.create({
        data: {
            ...data,
            providerId: providerProfile.id,
            tenantId,
        }
    });

    await logAudit(prisma, user.id, 'SUBMIT_HANDOVER', 'SHIFT_HANDOVER', handover.id, { visitId: data.visitId });

    return c.json({ success: true, id: handover.id }, 201);
});

export default r;
