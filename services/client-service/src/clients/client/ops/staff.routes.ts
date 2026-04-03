import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const opsStaffList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const StaffSchema = z.object({
  id: z.string(),
  staffName: z.string(),
  role: z.string(),
  totalHours: z.number(),
  clinicalHours: z.number(),
  adminHours: z.number(),
  status: z.string(),
});

opsStaffList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Staff Utilization Data',
        content: {
          'application/json': {
            schema: z.object({
              staffs: z.array(StaffSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.staffUtilization.count();
       if (count === 0) {
          await c.var.prisma.staffUtilization.createMany({
             data: [
                { tenantId: 't1', staffName: 'Dr. Sarah', role: 'Physician', totalHours: 40, clinicalHours: 35, adminHours: 5, status: 'Optimized' },
                { tenantId: 't1', staffName: 'Nurse John', role: 'Registered Nurse', totalHours: 48, clinicalHours: 46, adminHours: 2, status: 'Overworked' },
                { tenantId: 't1', staffName: 'Nurse Jane', role: 'Registered Nurse', totalHours: 20, clinicalHours: 10, adminHours: 10, status: 'Underutilized' },
             ]
          });
       }

       const staffs = await c.var.prisma.staffUtilization.findMany({
         orderBy: { totalHours: 'desc' }
       });
       return c.json({ staffs });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default opsStaffList;
