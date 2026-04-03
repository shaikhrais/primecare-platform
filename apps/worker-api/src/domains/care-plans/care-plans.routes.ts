import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary, handleUpdatePlan } from './care-plans.handlers';

export const carePlansRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['CARE_PLANS'],
  description: 'Fetching standard payload for care plans domain',
  responses: {
    200: {
      description: 'care plans domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

const updateRoute = createRoute({
  method: 'post',
  path: '/update',
  tags: ['CARE_PLANS'],
  description: 'Provisions a high-priority care plan update and asynchronously notifies telemetry.',
  request: {
    body: {
      content: {
        'application/json': {
          schema: z.object({
            planId: z.string().optional(),
            clientId: z.string().optional(),
            updatedBy: z.string().optional(),
            changes: z.array(z.string()).optional()
          })
        }
      }
    }
  },
  responses: {
    200: {
      description: 'Care Plan successfully updated via EventBus.',
      content: { 'application/json': { schema: z.object({ status: z.string(), planId: z.string(), message: z.string() }) } }
    },
    500: {
      description: 'Error processing update.',
      content: { 'application/json': { schema: z.object({ status: z.string(), message: z.string() }) } }
    }
  }
});

carePlansRoutes.openapi(summaryRoute, handleGetSummary);
carePlansRoutes.openapi(updateRoute, handleUpdatePlan);
