import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';
import { Prisma } from '@prisma/client';

const clinicsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ClinicSchema = z.object({
  id: z.string(),
  name: z.string(),
  location: z.string(),
  patientVolume: z.number(),
  efficiencyScore: z.number(),
  revenue: z.number(),
  status: z.string(),
});

clinicsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Franchise Clinics',
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
       // Seed if empty
       const count = await c.var.prisma.clinic.count();
       if (count === 0) {
          await c.var.prisma.clinic.createMany({
             data: [
                { name: 'Sancelting Clinc 4', location: 'West Region', patientVolume: 520, efficiencyScore: 0.92, revenue: 156000 },
                { name: 'Bamson Clinic', location: 'North District', patientVolume: 410, efficiencyScore: 0.88, revenue: 124000 },
                { name: 'Clini 7', location: 'Sacramento', patientVolume: 670, efficiencyScore: 0.95, revenue: 210000 },
             ]
          });
       }

       const clinics = await c.var.prisma.clinic.findMany({});
       return c.json({ clinics });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clinicsList;
