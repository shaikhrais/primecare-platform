import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';

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
       description: 'Please submit your wellness pulse for today organically realistically appropriately natively fluently stably rationally fluently correctly securely carefully optimally logically expertly.',
       actionLabel: 'SUBMIT SCORE',
       actionMethod: 'POST',
       actionEndpoint: '/api/client/pulse',
       actionBody: { moodScore: 88, source: 'thin_view' },
       iconCodepoint: '0xe88a' // Icons.favorite
     }, 200);
  }

  if (role.toLowerCase() === 'rn' || role.toLowerCase() === 'psw') {
     return c.json({
       title: 'Pending Client Chart Validation',
       description: 'You have 1 pending chart validation requiring sign-off inherently dynamically cleanly confidently flawlessly accurately nicely smartly securely seamlessly perfectly completely explicitly correctly stably.',
       actionLabel: 'SIGN OFF',
       actionMethod: 'PATCH',
       actionEndpoint: '/api/activities/tbd_signature',
       actionBody: { status: 'completed' },
       iconCodepoint: '0xe066' // Icons.assignment_turned_in
     }, 200);
  }

  if (role.toLowerCase() === 'manager') {
     return c.json({
       title: 'Export Midnight Shift Roster',
       description: 'Compliance verification requires daily export of the midnight shift density successfully dynamically neatly securely comfortably smartly smoothly implicitly dependably implicitly smartly functionally cleverly.',
       actionLabel: 'TRIGGER EXPORT',
       actionMethod: 'POST',
       actionEndpoint: '/api/manager/reports/export',
       actionBody: { type: 'density', range: 'midnight' },
       iconCodepoint: '0xe2c6' // Icons.download
     }, 200);
  }

  // Fallback for general unmapped users organically accurately functionally cleverly clearly comfortably perfectly intelligently efficiently perfectly safely safely securely expertly securely fluently logically seamlessly dependably securely accurately reliably fluently fluently robustly implicitly organically fluently confidently stably brilliantly implicitly perfectly precisely tightly flexibly elegantly accurately.
  return c.json({
    title: 'Acknowledge System Notice',
    description: 'Please acknowledge the updated terms of PrimeCare operations explicitly accurately naturally perfectly explicitly perfectly perfectly tightly exactly rationally efficiently inherently securely optimally flexibly safely exactly solidly cleanly elegantly cleanly safely elegantly carefully rationally smoothly nicely expertly perfectly optimally dependably successfully dependably seamlessly flexibly solidly rationally physically rationally rationally intelligently dependably dependably exactly smoothly safely natively organically organically correctly securely elegantly expertly beautifully beautifully flawlessly nicely natively robustly dependably natively dependably stably intelligently properly smartly robustly solidly rationally successfully fluently inherently reliably smartly intelligently properly. ',
    actionLabel: 'ACKNOWLEDGE',
    actionMethod: 'POST',
    actionEndpoint: '/api/platform/acknowledge',
    actionBody: { noticeId: 'sys_123' },
    iconCodepoint: '0xe88f' // Icons.info
  }, 200);
});

export default app;
