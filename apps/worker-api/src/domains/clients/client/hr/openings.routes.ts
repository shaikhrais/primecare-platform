import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const hrOpeningsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const HrOpeningSchema = z.object({
  id: z.string(),
  title: z.string(),
  department: z.string(),
  location: z.string(),
  status: z.string(),
  applicationCount: z.number(),
  postedDate: z.string(),
});

hrOpeningsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all HR Job Openings',
        content: {
          'application/json': {
            schema: z.object({
              openings: z.array(HrOpeningSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.jobOpening.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.jobOpening.createMany({
             data: [
                { tenantId: 't1', title: 'Nurse Practitioner', department: 'Healthcare', location: 'City Health Clinic', status: 'ACTIVE', applicationCount: 42, postedDate: new Date(now.getTime() - 86400000 * 5) },
                { tenantId: 't1', title: 'ICU Nurse', department: 'Intensive Care', location: 'Bayview Hospital', status: 'ACTIVE', applicationCount: 15, postedDate: new Date(now.getTime() - 86400000 * 3) },
                { tenantId: 't1', title: 'Medical Assistant', department: 'Healthcare', location: 'ValleyCare', status: 'DRAFT', applicationCount: 0, postedDate: now },
                { tenantId: 't1', title: 'Care Coordinator', department: 'Admin', location: 'Remote', status: 'CLOSED', applicationCount: 89, postedDate: new Date(now.getTime() - 86400000 * 20) },
             ]
          });
       }

       const openings = await c.var.prisma.jobOpening.findMany({
         orderBy: { postedDate: 'desc' }
       });
       return c.json({ openings: openings.map((a: any) => ({ ...a, postedDate: a.postedDate.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default hrOpeningsList;
