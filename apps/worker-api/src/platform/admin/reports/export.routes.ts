import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../../bindings';

const reports = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const exportDataRoute = createRoute({
    method: 'get',
    path: '/export',
    summary: 'Export Platform Data',
    description: 'Export specific collections as CSV or PDF.',
    tags: ['Admin.Reports'],
    request: {
        query: z.object({
            type: z.enum(['users', 'visits', 'leads', 'invoices']),
            format: z.enum(['csv', 'pdf']).default('csv'),
        }),
    },
    responses: {
        200: {
            content: {
                'text/csv': { schema: z.string() },
                'application/pdf': { schema: z.any() },
            },
            description: 'Data Export',
        },
        500: {
            content: {
                'application/json': {
                    schema: z.object({
                        error: z.string(),
                    }),
                },
            },
            description: 'Internal Server Error',
        },
    },
});

reports.openapi(exportDataRoute, async (c) => {
    const prisma = c.get('prisma');
    const { type, format } = c.req.valid('query');

    try {
        let data: any[] = [];
        if (type === 'users') {
            data = await prisma.user.findMany({ select: { email: true, status: true, roles: true, createdAt: true } });
        } else if (type === 'visits') {
            data = await prisma.visit.findMany({ include: { client: true, service: true } });
        } else if (type === 'leads') {
            data = await prisma.lead.findMany();
        } else if (type === 'invoices') {
            data = await prisma.invoice.findMany({ include: { client: true } });
        }

        if (format === 'csv') {
            if (data.length === 0) return c.text('No data for export', 200);
            const headers = Object.keys(data[0]).join(',');
            const rows = data.map(obj => Object.values(obj).map(v => `"${v}"`).join(',')).join('\n');
            const csv = `${headers}\n${rows}`;
            c.header('Content-Type', 'text/csv');
            c.header('Content-Disposition', `attachment; filename="export_${type}.csv"`);
            return c.text(csv, 200);
        }

        // PDF implementation would go here (e.g. using a lib or specialized worker)
        return c.json({ error: 'PDF export not yet implemented' }, 501);

    } catch (error: any) {
        return c.json({ error: error.message }, 500);
    }
});

export default reports;
