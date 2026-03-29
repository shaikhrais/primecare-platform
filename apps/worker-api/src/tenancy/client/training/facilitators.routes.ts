import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const trainingFacilitatorsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const InstructorSchema = z.object({
  id: z.string(),
  facilitatorName: z.string(),
  assignedCourse: z.string(),
  status: z.string(),
});

trainingFacilitatorsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all clinical instructors',
        content: {
          'application/json': {
            schema: z.object({
              facilitators: z.array(InstructorSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.instructorNode.count();
       if (count === 0) {
          await c.var.prisma.instructorNode.createMany({
             data: [
                { tenantId: 't1', facilitatorName: 'Sarah Jenkins', assignedCourse: 'Clinical Fundamentals', status: 'Active' },
                { tenantId: 't1', facilitatorName: 'Dr. Evans', assignedCourse: 'Surgical Prep', status: 'Scheduled' },
                { tenantId: 't1', facilitatorName: 'Maria Mollax', assignedCourse: 'Safety Regulations', status: 'Completed' },
             ]
          });
       }

       const items = await c.var.prisma.instructorNode.findMany({
         orderBy: { facilitatorName: 'asc' }
       });
       
       return c.json({ facilitators: items });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default trainingFacilitatorsList;
