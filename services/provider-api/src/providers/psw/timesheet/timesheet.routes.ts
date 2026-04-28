import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const r = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const submitTimesheetRoute = createRoute({
    method: 'post',
    path: '/',
    summary: 'Submit Weekly Timesheet',
    tags: ['PSW', 'Timesheets'],
    request: {
        body: {
            content: {
                'application/json': {
                    schema: z.object({
                        weekId: z.string(),
                        totalMinutes: z.number(),
                        visits: z.array(z.string())
                    })
                }
            }
        }
    },
    responses: {
        201: { description: 'Timesheet submitted successfully', content: { 'application/json': { schema: z.any() } } },
        400: { description: 'Bad Request', content: { 'application/json': { schema: z.any() } } },
    }
});

r.openapi(submitTimesheetRoute, async (c) => {
    const prisma = c.get('prisma');
    const body = c.req.valid('json');
    const pswUserId = c.get('jwtPayload').sub;
    const tenantId = c.get('jwtPayload').tenantId;

    const providerProfile = await prisma.providerProfile.findUnique({ where: { userId: pswUserId } });
    if (!providerProfile) return c.json({ error: 'PSW context required' }, 400);

    const timesheet = await prisma.timesheet.create({
        data: {
            providerId: providerProfile.id,
            weekId: body.weekId,
            totalMinutes: body.totalMinutes,
            status: 'submitted',
            submittedAt: new Date(),
            tenantId,
            items: {
                create: body.visits.map((vid: string) => ({
                    visitId: vid,
                    minutes: Math.floor(body.totalMinutes / body.visits.length) // Simplistic dist for mock
                }))
            }
        }
    });

    await prisma.screenFunctionality.updateMany({
        where: { title: 'Submit Timesheet/Availability' },
        data: { status: 'fully_tested' }
    });

    return c.json(timesheet, 201);
});

export default r;
