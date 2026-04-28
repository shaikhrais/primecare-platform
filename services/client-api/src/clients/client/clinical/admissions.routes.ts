import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const clinicalAdmissionsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const AdmissionSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  priority: z.string(),
  condition: z.string(),
  location: z.string(),
  attendingPhys: z.string(),
  status: z.string(),
  createdAt: z.string(),
});

clinicalAdmissionsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all active Clinical Admissions',
        content: {
          'application/json': {
            schema: z.object({
              admissions: z.array(AdmissionSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.patientAdmissionNode.count();
       if (count === 0) {
          await c.var.prisma.patientAdmissionNode.createMany({
             data: [
                { tenantId: 't1', patientName: 'Robert L.', priority: 'Critical', condition: 'Cardiac Arrest', location: 'ICU Bed 4', attendingPhys: 'Dr. Sarah Chen', status: 'Admitted' },
                { tenantId: 't1', patientName: 'Maria S.', priority: 'High', condition: 'Respiratory Distress', location: 'Ward B', attendingPhys: 'Dr. Evans', status: 'Triage' },
                { tenantId: 't1', patientName: 'James W.', priority: 'Normal', condition: 'Post-Op Recovery', location: 'Ward A', attendingPhys: 'Dr. Sarah Chen', status: 'Stable' },
                { tenantId: 't1', patientName: 'Elena V.', priority: 'High', condition: 'Neurological Observation', location: 'ICU Bed 2', attendingPhys: 'Dr. Miller', status: 'Admitted' },
             ]
          });
       }

       const items = await c.var.prisma.patientAdmissionNode.findMany({
         orderBy: { createdAt: 'desc' }
       });

       return c.json({ admissions: items.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default clinicalAdmissionsList;
