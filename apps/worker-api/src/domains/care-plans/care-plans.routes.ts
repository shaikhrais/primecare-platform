import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary } from './care-plans.handlers';

export const carePlansRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['CAREPLANS'],
  description: 'Fetching standard payload for care-plans domain',
  responses: {
    200: {
      description: 'care-plans domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

carePlansRoutes.openapi(summaryRoute, handleGetSummary);
