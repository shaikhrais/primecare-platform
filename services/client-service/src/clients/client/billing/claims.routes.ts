import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const billingClaimsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ClaimSchema = z.object({
  id: z.string(),
  claimCode: z.string(),
  patientName: z.string(),
  provider: z.string(),
  status: z.string(),
  denialReason: z.string().nullable(),
  amount: z.number(),
  submissionDate: z.string(),
});

billingClaimsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Insurance Claims',
        content: {
          'application/json': {
            schema: z.object({
              claims: z.array(ClaimSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.insuranceClaim.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.insuranceClaim.createMany({
             data: [
                { tenantId: 't1', claimCode: 'CLM-90921', patientName: 'James Doe', provider: 'BlueCross', status: 'Submission', amount: 840.00, submissionDate: now },
                { tenantId: 't1', claimCode: 'CLM-01124', patientName: 'Mary Ann', provider: 'Medicare', status: 'Review', amount: 1200.50, submissionDate: new Date(now.getTime() - 86400000 * 2) },
                { tenantId: 't1', claimCode: 'CLM-33100', patientName: 'Steve Smith', provider: 'UnitedHealth', status: 'Reimbursed', amount: 450.00, submissionDate: new Date(now.getTime() - 86400000 * 10) },
                { tenantId: 't1', claimCode: 'CLM-88123', patientName: 'Sarah Connor', provider: 'Aetna', status: 'Denied', denialReason: 'Missing Prior Auth', amount: 2000.00, submissionDate: new Date(now.getTime() - 86400000 * 5) },
             ]
          });
       }

       const claims = await c.var.prisma.insuranceClaim.findMany({
         orderBy: { submissionDate: 'desc' }
       });
       return c.json({ claims: claims.map((a: any) => ({ ...a, submissionDate: a.submissionDate.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default billingClaimsList;
