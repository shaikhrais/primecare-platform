import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const billingInvoicesList = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const InvoiceSchema = z.object({
  id: z.string(),
  invoiceId: z.string(),
  patientName: z.string(),
  clinicLocation: z.string(),
  amount: z.number(),
  status: z.string(),
  issueDate: z.string(),
});

billingInvoicesList.openapi(
  createRoute({
    method: 'get',
    path: '/',
    responses: {
      200: {
        description: 'Gets all Billing Invoices',
        content: {
          'application/json': {
            schema: z.object({
              invoices: z.array(InvoiceSchema),
            }),
          },
        },
      },
      500: { description: 'Internal Server Error' },
    },
  }),
  async (c) => {
    try {
       const count = await c.var.prisma.invoiceRecord.count();
       if (count === 0) {
          const now = new Date();
          await c.var.prisma.invoiceRecord.createMany({
             data: [
                { tenantId: 't1', invoiceId: '10F4081', patientName: 'Patient Chen', clinicLocation: 'North Clinic', amount: 150.00, status: 'Paid', issueDate: new Date(now.getTime() - 86400000 * 5) },
                { tenantId: 't1', invoiceId: '10F4002', patientName: 'Esiiim Chen', clinicLocation: 'ValleyCare', amount: 450.00, status: 'Paid', issueDate: new Date(now.getTime() - 86400000 * 3) },
                { tenantId: 't1', invoiceId: '10F4003', patientName: 'Sarah Chen', clinicLocation: 'South Health', amount: 200.00, status: 'Pending', issueDate: now },
                { tenantId: 't1', invoiceId: '10F4005', patientName: 'Keliin Chen', clinicLocation: 'Central', amount: 50.00, status: 'Overdue', issueDate: new Date(now.getTime() - 86400000 * 20) },
             ]
          });
       }

       const invoices = await c.var.prisma.invoiceRecord.findMany({
         orderBy: { issueDate: 'desc' }
       });
       return c.json({ invoices: invoices.map((a: any) => ({ ...a, issueDate: a.issueDate.toISOString() })) });
    } catch (e: any /* Audit 63 Notice: Should be unknown */) {
       console.error(JSON.stringify({ error: e?.message || e }));
       return c.json({ error: 'Internal error' }, 500 as any);
    }
  }
);

export default billingInvoicesList;
