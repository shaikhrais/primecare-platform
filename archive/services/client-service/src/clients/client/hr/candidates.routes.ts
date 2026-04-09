import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const hrCandidatesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const HrCandidateSchema = z.object({
  id: z.string(),
  candidateName: z.string(),
  appliedRole: z.string(),
  department: z.string(),
  source: z.string(),
  status: z.string(),
  rating: z.number(),
  createdAt: z.string(),
});

hrCandidatesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all HR Job Candidates for pipeline KanBan',
        content: {
          'application/json': {
            schema: z.object({
              candidates: z.array(HrCandidateSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.jobCandidate.count();
       if (count === 0) {
          await c.var.prisma.jobCandidate.createMany({
             data: [
                { tenantId: 't1', candidateName: 'Sarah Jones', appliedRole: 'Nurse Practitioner', department: 'Healthcare', source: 'Pompany', status: 'SCREENING', rating: 4 },
                { tenantId: 't1', candidateName: 'Harry Nurse', appliedRole: 'ICU Nurse', department: 'Intensive Care', source: 'Clinic', status: 'SHORTLISTED', rating: 5 },
                { tenantId: 't1', candidateName: 'Mama Toreh', appliedRole: 'Medical Assistant', department: 'Healthcare', source: 'LinkedIn', status: 'INTERVIEW', rating: 3 },
                { tenantId: 't1', candidateName: 'John Doe', appliedRole: 'Care Coordinator', department: 'Admin', source: 'Indeed', status: 'OFFER', rating: 5 },
                { tenantId: 't1', candidateName: 'Jane Smith', appliedRole: 'ICU Nurse', department: 'Intensive Care', source: 'Web', status: 'SCREENING', rating: 2 },
             ]
          });
       }

       const candidates = await c.var.prisma.jobCandidate.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ candidates: candidates.map((a: any) => ({ ...a, createdAt: a.createdAt.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default hrCandidatesList;
