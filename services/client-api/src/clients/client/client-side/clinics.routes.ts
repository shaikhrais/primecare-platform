import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const clientClinicsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ClinicSchema = z.object({
  id: z.string(),
  clinicName: z.string(),
  starRating: z.number(),
  revenueString: z.string(),
  rank: z.number(),
});

clientClinicsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Client Clinics Leaderboard',
        content: {
          'application/json': {
            schema: z.object({
              clinics: z.array(ClinicSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.clientClinicNode.count();
       if (count === 0) {
          await c.var.prisma.clientClinicNode.createMany({
             data: [
                { tenantId: 't1', rank: 1, clinicName: 'Sacramento Central', starRating: 5, revenueString: '$645,820' },
                { tenantId: 't1', rank: 2, clinicName: 'Oak Park Regional', starRating: 4, revenueString: '$412,345' },
                { tenantId: 't1', rank: 3, clinicName: 'Midtown Express', starRating: 4, revenueString: '$313,385' },
                { tenantId: 't1', rank: 4, clinicName: 'Natomas Family', starRating: 3, revenueString: '$213,390' },
             ]
          });
       }

       const items = await c.var.prisma.clientClinicNode.findMany({
         orderBy: { rank: 'asc' }
       });
       return c.json({ clinics: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clientClinicsList;
