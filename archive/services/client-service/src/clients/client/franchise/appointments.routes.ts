import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const franchiseAppointmentsList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const BookingSchema = z.object({
  id: z.string(),
  patientName: z.string(),
  clinicAssigned: z.string(),
  appointmentType: z.string(),
  scheduledTime: z.string(),
  status: z.string(),
});

franchiseAppointmentsList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets Franchise Bookings',
        content: {
          'application/json': {
            schema: z.object({
              appointments: z.array(BookingSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.franchiseBookingNode.count();
       if (count === 0) {
          await c.var.prisma.franchiseBookingNode.createMany({
             data: [
                { tenantId: 't1', patientName: 'Jason Harson', clinicAssigned: 'Boston Central', appointmentType: 'Intake Assessment', scheduledTime: '9:30 AM', status: 'Confirmed' },
                { tenantId: 't1', patientName: 'Tommy Marth', clinicAssigned: 'Chicago Metro', appointmentType: 'Follow-up', scheduledTime: '10:00 AM', status: 'Checked In' },
                { tenantId: 't1', patientName: 'Sarah Jenaen', clinicAssigned: 'Boston Central', appointmentType: 'Healthary Audit', scheduledTime: '11:15 AM', status: 'Pending' },
             ]
          });
       }

       const records = await c.var.prisma.franchiseBookingNode.findMany({
         orderBy: { createdAt: 'desc' }
       });
       return c.json({ appointments: records });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default franchiseAppointmentsList;
