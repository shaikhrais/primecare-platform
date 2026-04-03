import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary, handleEscalateTicket } from './support.handlers';

export const supportRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['SUPPORT'],
  description: 'Fetching standard payload for support domain',
  responses: {
    200: {
      description: 'support domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

const escalateRoute = createRoute({
  method: 'post',
  path: '/tickets/escalate',
  tags: ['SUPPORT'],
  description: 'Provisions a high-priority ticket escalation and asynchronously notifies telemetry.',
  request: {
    body: {
      content: {
        'application/json': {
          schema: z.object({
            ticketId: z.string().optional(),
            assignedTo: z.string().optional(),
            escalationLevel: z.number().optional(),
            reason: z.string().optional()
          })
        }
      }
    }
  },
  responses: {
    200: {
      description: 'Ticket successfully escalated via EventBus.',
      content: { 'application/json': { schema: z.object({ status: z.string(), ticketId: z.string(), message: z.string() }) } }
    },
    500: {
      description: 'Error processing escalation.',
      content: { 'application/json': { schema: z.object({ status: z.string(), message: z.string() }) } }
    }
  }
});

supportRoutes.openapi(summaryRoute, handleGetSummary);
supportRoutes.openapi(escalateRoute, handleEscalateTicket);
