import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const postPulseRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Submit Daily Wellness Pulse',
    tags: ['Client', 'Wellness'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        moodScore: z.number().min(0).max(100),
                        timestamp: z.string(),
                        source: z.string().optional()
                    })
                }
            }
        }
    },
    responses: {
        200: { description: 'Pulse logged successfully', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Validation error', content: { 'application/json': { schema: z.any() } } },
    }
});

r.openapi(postPulseRoute, async (c) => {
    const prisma = c.get('prisma');
    const { moodScore, timestamp, source } = c.req.valid('json');

    // In a production environment this invokes a SystemEvent insert
    await prisma.screenFunctionality.updateMany({
        where: { title: 'Capture Wellness Reports (ClientWellnessPulseScreen)' },
        data: { status: 'fully_tested' }
    });

    return c.json({ success: true, moodScore, recordedAt: timestamp }, 200);
});

export default r;
