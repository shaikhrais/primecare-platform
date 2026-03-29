import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const intakeQueueList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IntakeQueueSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  status: z.string(),
  priority: z.string(),
  franchiseCity: z.string(),
  createdAt: z.string(),
});

intakeQueueList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all patient intakes for the queue',
        content: {
          'application/json': {
            schema: z.object({
              intakes: z.array(IntakeQueueSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.patientIntake.count();
       if (count === 0) {
          await c.var.prisma.patientIntake.createMany({
             data: [
                { tenantId: 't1', patientName: 'A. Chen', status: 'Pending Review', priority: 'High', franchiseCity: 'City Health' },
                { tenantId: 't1', patientName: 'J. Smith', status: 'In Progress', priority: 'Med', franchiseCity: 'Bayview' },
                { tenantId: 't1', patientName: 'M. Patel', status: 'Scheduled', priority: 'Med', franchiseCity: 'City Health' },
                { tenantId: 't1', patientName: 'L. Garcia', status: 'Approved', priority: 'Low', franchiseCity: 'ValleyCare' },
                { tenantId: 't1', patientName: 'R. Lee', status: 'Draft', priority: 'Low', franchiseCity: 'ValleyCare' },
             ]
          });
       }

       const intakes = await c.var.prisma.patientIntake.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ intakes: intakes.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default intakeQueueList;
