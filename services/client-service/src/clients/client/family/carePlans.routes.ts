import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const familyCarePlansList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const CarePlanTaskSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  taskName: z.string(),
  category: z.string(),
  timeSlot: z.string(),
  isCompleted: z.boolean(),
  completedBy: z.string().nullable(),
});

familyCarePlansList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all daily Care Plan Tasks for family approval interaction',
        content: {
          'application/json': {
            schema: z.object({
              tasks: z.array(CarePlanTaskSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.familyCarePlanTask.count();
       if (count === 0) {
          await c.var.prisma.familyCarePlanTask.createMany({
             data: [
                { patientName: 'James Oswald', taskName: 'Morning Lisinopril 10mg', category: 'MEDICATION', timeSlot: '08:00 AM', isCompleted: false },
                { patientName: 'James Oswald', taskName: 'Vitals: Blood Pressure Check', category: 'VITALS', timeSlot: '08:30 AM', isCompleted: false },
                { patientName: 'James Oswald', taskName: 'Afternoon Assist Walk', category: 'ACTIVITY', timeSlot: '02:00 PM', isCompleted: false },
                { patientName: 'James Oswald', taskName: 'Evening Metformin 500mg', category: 'MEDICATION', timeSlot: '08:00 PM', isCompleted: false },
             ]
          });
       }

       const tasks = await c.var.prisma.familyCarePlanTask.findMany({
         orderBy: { timeSlot: 'asc' }
       });
       return c.json({ tasks });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default familyCarePlansList;
