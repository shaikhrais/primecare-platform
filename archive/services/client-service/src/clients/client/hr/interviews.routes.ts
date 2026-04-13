import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const hrInterviewsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const HrInterviewSchema = z.object({
  id: z.string(),
  candidateName: z.string(),
  roleTarget: z.string(),
  managerName: z.string(),
  scheduledDate: z.string(),
  scheduledTime: z.string(),
  status: z.string(),
});

hrInterviewsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all HR Interviews Scheduled',
        content: {
          'application/json': {
            schema: z.object({
              interviews: z.array(HrInterviewSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.interviewEvent.count({ where: { status: 'SCHEDULED' } });
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.interviewEvent.createMany({
             data: [
                { tenantId: 't1', candidateName: 'Mama Toreh', roleTarget: 'Medical Assistant', managerName: 'Dr. Gregory', scheduledDate: now, scheduledTime: '10:00 AM', status: 'SCHEDULED' },
                { tenantId: 't1', candidateName: 'Harry Nurse', roleTarget: 'ICU Nurse', managerName: 'Head Nurse Joy', scheduledDate: now, scheduledTime: '2:30 PM', status: 'SCHEDULED' },
                { tenantId: 't1', candidateName: 'John Doe', roleTarget: 'Care Coordinator', managerName: 'Admin Chief', scheduledDate: new Date(now.getTime() + 86400000), scheduledTime: '9:15 AM', status: 'SCHEDULED' },
             ]
          });
       }

       const interviews = await c.var.prisma.interviewEvent.findMany({
         where: { status: 'SCHEDULED' },
         orderBy: { scheduledTime: 'asc' } // Approximate sort for time
       });
       return c.json({ interviews: interviews.map((a: any) => ({ ...a, scheduledDate: a.scheduledDate.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default hrInterviewsList;
