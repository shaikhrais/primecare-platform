import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const trainingComplianceList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ComplianceSchema = z.object({
  id: z.string(),
  staffName: z.string(),
  clinicalRole: z.string(),
  certName: z.string(),
  expiresAt: z.string(),
  status: z.string(),
});

trainingComplianceList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Staff Compliance expirations',
        content: {
          'application/json': {
            schema: z.object({
              compliance: z.array(ComplianceSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.certificationNode.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.certificationNode.createMany({
             data: [
                { tenantId: 't1', staffName: 'Jane Smith', clinicalRole: 'RN', certName: 'ACLS', expiresAt: new Date(now.setMonth(now.getMonth() + 4)), status: 'Compliant' },
                { tenantId: 't1', staffName: 'Robert Lee', clinicalRole: 'PSW', certName: 'Background Check', expiresAt: new Date(now.setMonth(now.getMonth() - 1)), status: 'Expired' },
                { tenantId: 't1', staffName: 'Anna Davis', clinicalRole: 'RPN', certName: 'CPR / BLS', expiresAt: new Date(now.setDate(now.getDate() + 14)), status: 'Expiring Soon' },
             ]
          });
       }

       const records = await c.var.prisma.certificationNode.findMany({
         orderBy: { expiresAt: 'asc' }
       });
       return c.json({ compliance: records.map((a: any) => ({ ...a, expiresAt: a.expiresAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default trainingComplianceList;
