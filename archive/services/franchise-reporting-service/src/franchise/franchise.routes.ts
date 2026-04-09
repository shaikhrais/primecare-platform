import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary, handleUpdateTerritory } from './franchise.handlers';

export const franchiseRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['FRANCHISE'],
  description: 'Fetching standard payload for franchise domain',
  responses: {
    200: {
      description: 'franchise domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

const territoryRoute = createRoute({
  method: 'post',
  path: '/territory/update',
  tags: ['FRANCHISE'],
  description: 'Mutates territory data and triggers automated async analytics.',
  request: {
    body: {
      content: {
        'application/json': {
          schema: z.object({
            territoryId: z.string().optional(),
            managerId: z.string().optional(),
            status: z.string().optional()
          })
        }
      }
    }
  },
  responses: {
    200: {
      description: 'Territory synced successfully.',
      content: { 'application/json': { schema: z.object({ status: z.string(), territoryId: z.string(), message: z.string() }) } }
    },
    500: {
      description: 'Error processing update.',
      content: { 'application/json': { schema: z.object({ status: z.string(), message: z.string() }) } }
    }
  }
});

franchiseRoutes.openapi(summaryRoute, handleGetSummary);
franchiseRoutes.openapi(territoryRoute, handleUpdateTerritory);
