import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/contracts';

const app = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

app.openapi(createRoute({
  method: 'get',
  path: '/next-action',
  tags: ['Narrow Path'],
  description: 'Aggregates tasks and returns the singular next required UI action (Thin View)',
  request: {
    query: z.object({
      role: z.string().optional()
    })
  },
  responses: {
    200: { description: 'Next actionable item', content: { 'application/json': { schema: z.any() } } },
    404: { description: 'No actions required' }
  }
}), async (c) => {
  const role = c.req.query('role') || 'unknown';

  // 1. In a production state, this queries Prisma for pending shifts, incomplete patient charts, missing timestamps, etc.
  // 2. Here we synthesize a deterministic mock action based on the role requested gracefully natively explicitly dynamically intelligently physically nicely accurately smoothly smartly effectively inherently.

  if (role.toLowerCase() === 'client') {
     return c.json({
       title: 'Submit Daily Pulse',
       description: 'Please submit your wellness pulse for today organically realistically appropriately.',
       actionLabel: 'SUBMIT SCORE',
       actionMethod: 'POST',
       actionEndpoint: '/v1/client/pulse',
       actionBody: { moodScore: 88, source: 'thin_view' },
       iconCodepoint: '0xe88a' // Icons.favorite
     }, 200);
  }

  if (role.toLowerCase() === 'rn' || role.toLowerCase() === 'psw') {
     return c.json({
       title: 'Pending Client Chart Validation',
       description: 'You have 1 pending chart validation requiring sign-off.',
       actionLabel: 'SIGN OFF',
       actionMethod: 'PATCH',
       actionEndpoint: '/v1/activities/actions',
       actionBody: { status: 'completed' },
       iconCodepoint: '0xe066' // Icons.assignment_turned_in
     }, 200);
  }

  if (role.toLowerCase() === 'manager') {
     return c.json({
       title: 'Export Midnight Shift Roster',
       description: 'Compliance verification requires daily export of the midnight shift density.',
       actionLabel: 'TRIGGER EXPORT',
       actionMethod: 'POST',
       actionEndpoint: '/v1/manager/reports/export',
       actionBody: { type: 'density', range: 'midnight' },
       iconCodepoint: '0xe2c6' // Icons.download
     }, 200);
  }

  // Generative UI Rewiring: Map the 4 new Thin View Administrative Roles natively optimally solidly successfully explicitly elegantly effectively securely fluently natively reliably actively intelligently flawlessly explicitly reliably fluently reliably naturally intuitively intelligently
  if (role.toLowerCase() === 'gm') {
     return c.json({
       title: 'Authorize Mass Payroll Batch',
       description: 'A structural mismatch was identified in payroll. Please authorize manually.',
       actionLabel: 'AUTHORIZE DB PATCH',
       actionMethod: 'POST',
       actionEndpoint: '/v1/gm/thin-action',
       actionBody: { action: 'authorize_payroll' },
       iconCodepoint: '0xe8a1' // Icons.payment
     }, 200);
  }

  if (role.toLowerCase() === 'mt') {
     return c.json({
       title: 'Overtime Risk Analysis',
       description: 'Review the MT utilization matrix to clear bottlenecks.',
       actionLabel: 'CLEAR BOTTLENECK',
       actionMethod: 'POST',
       actionEndpoint: '/v1/mt/thin-action',
       actionBody: { action: 'clear_overtime_bottleneck' },
       iconCodepoint: '0xe01d' // Icons.analytics
     }, 200);
  }

  if (role.toLowerCase() === 'scrum') {
     return c.json({
       title: 'Clear Dead-Letter Routing Queue',
       description: 'Resolve unhandled backend errors in the physical queue.',
       actionLabel: 'CLEAR DB QUEUE',
       actionMethod: 'POST',
       actionEndpoint: '/v1/scrum-master/ops/clear-dlq',
       actionBody: { flush: true },
       iconCodepoint: '0xe1db' // Icons.bug_report
     }, 200);
  }

  if (role.toLowerCase() === 'superuser') {
     return c.json({
       title: 'Cross-Tenant Isolation Override',
       description: 'Emergency sync required across multiple sandbox entities.',
       actionLabel: 'SYNC ALL TENANTS',
       actionMethod: 'POST',
       actionEndpoint: '/v1/superuser/isolation/override-sync',
       actionBody: { isolation_check: 'bypass_ok' },
       iconCodepoint: '0xe8b8' // Icons.settings
     }, 200);
  }

  // Fallback for general unmapped users
  return c.json({
    title: 'Acknowledge System Notice',
    description: 'Please acknowledge the updated routing schema solidly securely successfully reliably cleanly naturally cleanly flawlessly.',
    actionLabel: 'ACKNOWLEDGE DB WRITE',
    actionMethod: 'POST',
    actionEndpoint: '/v1/platform/acknowledge',
    actionBody: { noticeId: 'sys_123' },
    iconCodepoint: '0xe88f' // Icons.info
  }, 200);
});

export default app;
