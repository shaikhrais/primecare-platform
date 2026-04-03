import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../../../../bindings';

const familyAppointmentsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const FamilyApptSchema = z.object({
  id: z.string(),
  title: z.string(),
  patientName: z.string(),
  doctorName: z.string(),
  date: z.string(),
  time: z.string(),
  location: z.string(),
  status: z.string(),
});

familyAppointmentsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all upcoming Family Appointments',
        content: {
          'application/json': {
            schema: z.object({
              appointments: z.array(FamilyApptSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.familyAppointment.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.familyAppointment.createMany({
             data: [
                { title: 'Cardiology Checkup', patientName: 'Liam Jensen', doctorName: 'Dr. Evans', date: now, time: '10:00 AM', location: 'St. Judes Medical Center', status: 'PLANNED' },
                { title: 'Vaccine Follow-up', patientName: 'Emily Jensen', doctorName: 'Dr. Smith', date: new Date(now.getTime() + 86400000 * 2), time: '1:30 PM', location: 'Downtown Clinic', status: 'PLANNED' },
                { title: 'Annual Physical', patientName: 'Liam Jensen', doctorName: 'Dr. Evans', date: new Date(now.getTime() + 86400000 * 14), time: '9:00 AM', location: 'St. Judes Medical Center', status: 'PLANNED' },
             ]
          });
       }

       const appointments = await c.var.prisma.familyAppointment.findMany({
         orderBy: { date: 'asc' }
       });
       return c.json({ appointments: appointments.map((a: any) => ({ ...a, date: a.date.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default familyAppointmentsList;
