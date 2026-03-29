import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const qaIncidentsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentSchema = z.object({
  id: z.string(),
  incidentType: z.string(),
  severity: z.string(),
  franchise: z.string(),
  description: z.string(),
  status: z.string(),
  createdAt: z.string(),
});

qaIncidentsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all QA Incident Reports',
        content: {
          'application/json': {
            schema: z.object({
              incidents: z.array(IncidentSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.incidentReportNode.count();
       if (count === 0) {
          await c.var.prisma.incidentReportNode.createMany({
             data: [
                { tenantId: 't1', incidentType: 'Bio-waste Spill', severity: 'Critical', franchise: 'NY Clinic', description: 'Floor 2 contaminated', status: 'Open' },
                { tenantId: 't1', incidentType: 'Missed Medication', severity: 'High', franchise: 'Downtown Hub', description: 'Patient missed 9AM oral', status: 'Under Investigation' },
                { tenantId: 't1', incidentType: 'Slip and Fall', severity: 'Low', franchise: 'South Ward', description: 'Staff slipped on wet floor', status: 'Closed' },
                { tenantId: 't1', incidentType: 'Incorrect Dosage', severity: 'Critical', franchise: 'NY Clinic', description: 'Wrong IV drip rate', status: 'Open' },
             ]
          });
       }

       // Severity ordering priority
       const p: Record<string, number> = { 'Critical': 1, 'High': 2, 'Low': 3 };
       const incidentsRaw = await c.var.prisma.incidentReportNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       incidentsRaw.sort((a: any, b: any) => (p[a.severity] || 4) - (p[b.severity] || 4));

       return c.json({ incidents: incidentsRaw.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any) {
       console.error(e);
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default qaIncidentsList;
