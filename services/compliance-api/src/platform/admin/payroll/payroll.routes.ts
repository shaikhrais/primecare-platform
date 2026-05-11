import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';
import { handlePending, handleBatchApprove, handleRun, handleSummary } from './payroll-handlers';

const payroll = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

const pendingRoute = createRoute({ method: 'get', path: '/pending', summary: 'List timesheets pending approval', tags: ['Payroll'], request: { query: z.object({ weekId: z.string().optional() }) }, responses: { 200: { content: { 'application/json': { schema: z.array(z.object({ id: z.string(), providerId: z.string(), pswName: z.string(), weekId: z.string(), totalMinutes: z.number(), status: z.string() })) } }, description: 'Pending timesheets' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const batchApproveRoute = createRoute({ method: 'post', path: '/batch/approve', summary: 'Bulk approve timesheets', tags: ['Payroll'], request: { body: { content: { 'application/json': { schema: z.object({ timesheetIds: z.array(z.string()) }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.object({ approvedCount: z.number(), failedIds: z.array(z.string()) }) } }, description: 'Batch result' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const runRoute = createRoute({ method: 'post', path: '/run', summary: 'Generate payouts from approved timesheets for a pay period', tags: ['Payroll'], request: { body: { content: { 'application/json': { schema: z.object({ weekId: z.string(), hourlyRate: z.number().optional() }) } } } }, responses: { 200: { content: { 'application/json': { schema: z.object({ payoutsGenerated: z.number(), totalAmount: z.string() }) } }, description: 'Payroll run result' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });
const summaryRoute = createRoute({ method: 'get', path: '/summary/{weekId}', summary: 'Payroll summary for a pay period', tags: ['Payroll'], request: { params: z.object({ weekId: z.string() }) }, responses: { 200: { content: { 'application/json': { schema: z.object({ weekId: z.string(), totalTimesheets: z.number(), totalMinutes: z.number(), totalPayouts: z.number(), totalPaid: z.string(), statusBreakdown: z.record(z.number()) }) } }, description: 'Summary' },
    '400': { description: 'Bad Request', content: { 'application/json': { schema: z.object({ error: z.string() }) } } },
    '404': { description: 'Not Found', content: { 'application/json': { schema: z.object({ error: z.string() }) } } }
} });

payroll.openapi(pendingRoute, handlePending);
payroll.openapi(batchApproveRoute, handleBatchApprove);
payroll.openapi(runRoute, handleRun);
payroll.openapi(summaryRoute, handleSummary);

export default payroll;
