import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const trainingProgramsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const ProgramSchema = z.object({
  id: z.string(),
  programName: z.string(),
  department: z.string(),
  status: z.string(),
  completionPct: z.number(),
  createdAt: z.string(),
});

trainingProgramsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all active Clinical Training Programs',
        content: {
          'application/json': {
            schema: z.object({
              programs: z.array(ProgramSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.curriculumNode.count();
       if (count === 0) {
          await c.var.prisma.curriculumNode.createMany({
             data: [
                { tenantId: 't1', programName: 'Patient Care Excellence', department: 'Clinical Service', status: 'Active', completionPct: 80 },
                { tenantId: 't1', programName: 'HIPAA Compliance', department: 'Operations', status: 'Scheduled', completionPct: 0 },
                { tenantId: 't1', programName: 'Neurology Module 2', department: 'Specialty Care', status: 'Completed', completionPct: 100 },
             ]
          });
       }

       const items = await c.var.prisma.curriculumNode.findMany({
         orderBy: { completionPct: 'desc' }
       });

       return c.json({ programs: items.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default trainingProgramsList;
