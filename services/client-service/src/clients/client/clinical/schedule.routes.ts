import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const clinicalScheduleList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ScheduleSchema = z.object({
  id: z.string(),
  providerName: z.string(),
  role: z.string(),
  startTime: z.string(),
  endTime: z.string(),
  facility: z.string(),
});

clinicalScheduleList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets staff schedule tracking metrics',
        content: {
          'application/json': {
            schema: z.object({
              schedule: z.array(ScheduleSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.clinicalShiftNode.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.clinicalShiftNode.createMany({
             data: [
                { tenantId: 't1', providerName: 'Nurse Jane D.', role: 'RN', startTime: new Date(now.setHours(9, 0, 0, 0)), endTime: new Date(now.setHours(17, 0, 0, 0)), facility: 'ICU Wing A' },
                { tenantId: 't1', providerName: 'Alex M.', role: 'PSW', startTime: new Date(now.setHours(7, 0, 0, 0)), endTime: new Date(now.setHours(19, 0, 0, 0)), facility: 'Ward B' },
                { tenantId: 't1', providerName: 'Nurse Bob T.', role: 'RPN', startTime: new Date(now.setHours(18, 0, 0, 0)), endTime: new Date(now.setHours(6, 0, 0, 0)), facility: 'ER Overflow' },
             ]
          });
       }

       const items = await c.var.prisma.clinicalShiftNode.findMany({
         orderBy: { startTime: 'asc' }
       });
       
       return c.json({ schedule: items.map((a: any) => ({ ...a, startTime: a.startTime.toISOString(), endTime: a.endTime.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clinicalScheduleList;
