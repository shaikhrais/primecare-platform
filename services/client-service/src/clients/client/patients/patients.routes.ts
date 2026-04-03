import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const patientsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const PatientSchema = z.object({
  id: z.string(),
  firstName: z.string(),
  lastName: z.string(),
  age: z.number(),
  gender: z.string(),
  status: z.string(),
  clinicId: z.string(),
});

patientsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Patients across the Franchise',
        content: {
          'application/json': {
            schema: z.object({
              patients: z.array(PatientSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       // Auto-seed dummy patients tracking the generated AI UI if empty
       const count = await c.var.prisma.patient.count();
       if (count === 0) {
          // Attempt to find a clinic to map to, or create one
          let clinic = await c.var.prisma.clinic.findFirst({});
          if (!clinic) {
            clinic = await c.var.prisma.clinic.create({ data: { name: 'Default Generated Clinic', location: 'System', patientVolume: 1, efficiencyScore: 1.0, revenue: 0 } });
          }
          await c.var.prisma.patient.createMany({
             data: [
                { firstName: 'James', lastName: 'Oswald', age: 72, gender: 'Male', status: 'ACTIVE', clinicId: clinic.id },
                { firstName: 'Mary', lastName: 'Sterling', age: 68, gender: 'Female', status: 'ACTIVE', clinicId: clinic.id },
                { firstName: 'Robert', lastName: 'Bramson', age: 81, gender: 'Male', status: 'DISCHARGED', clinicId: clinic.id },
                { firstName: 'Linda', lastName: 'Katz', age: 64, gender: 'Female', status: 'ACTIVE', clinicId: clinic.id },
                { firstName: 'William', lastName: 'Torres', age: 77, gender: 'Male', status: 'ACTIVE', clinicId: clinic.id },
             ]
          });
       }

       const patients = await c.var.prisma.patient.findMany({
         include: { clinic: true }
       });
       return c.json({ patients });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default patientsList;
