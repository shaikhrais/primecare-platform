import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const incidentRoutes = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const IncidentSchema = z.object({
  id: z.string().uuid(),
  severity: z.enum(['Low', 'Medium', 'High', 'Critical']),
  description: z.string().min(5),
  patientId: z.string().uuid().optional(),
  latitude: z.number().optional(),
  longitude: z.number().optional(),
  timestamp: z.string()
});

const reportIncidentRoute = createRoute({
  method: 'post',
  path: '/',
  summary: 'Report an emergency incident',
  security: [{ BearerAuth: [] }],
  request: {
    body: {
      content: {
        'application/json': { schema: IncidentSchema }
      }
    }
  },
  responses: {
    200: { description: 'Incident successfully logged', content: { 'application/json': { schema: z.object({ success: z.boolean(), incidentId: z.string() }) } } },
    400: { description: 'Validation error', content: { 'application/json': { schema: z.any() } } },
    500: { description: 'Server error', content: { 'application/json': { schema: z.any() } } }
  }
});

incidentRoutes.openapi(reportIncidentRoute, async (c) => {
  const body = c.req.valid('json');
  
  // Here we would typically hit Prisma to write the incident into the active database,
  // and trigger a broadcast socket alert to the Coordinator Home.
  console.log('[SOS INGESTION]: Payload secured for incident:', body.id);
  
  return c.json({ success: true, incidentId: body.id }, 200);
});

export default incidentRoutes;
