import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const intakeReferralsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IntakeReferralSchema = z.object({
  id: z.string(),
  sourceName: z.string(),
  conversionCount: z.number(),
  totalLeads: z.number(),
});

intakeReferralsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets referral sources analytics',
        content: {
          'application/json': {
            schema: z.object({
              referrals: z.array(IntakeReferralSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.intakeReferralMetric.count();
       if (count === 0) {
          await c.var.prisma.intakeReferralMetric.createMany({
             data: [
                { tenantId: 't1', sourceName: 'Hospital A', conversionCount: 25, totalLeads: 30 },
                { tenantId: 't1', sourceName: 'Clinic B', conversionCount: 18, totalLeads: 40 },
                { tenantId: 't1', sourceName: 'Web Portal', conversionCount: 14, totalLeads: 55 },
                { tenantId: 't1', sourceName: 'Dr. Green', conversionCount: 9, totalLeads: 10 },
             ]
          });
       }

       const referrals = await c.var.prisma.intakeReferralMetric.findMany({
         orderBy: { conversionCount: 'desc' }
       });
       return c.json({ referrals });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default intakeReferralsList;
