import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary } from './training.handlers';

export const trainingRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['TRAINING'],
  description: 'Fetching standard payload for training domain',
  responses: {
    200: {
      description: 'training domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

trainingRoutes.openapi(summaryRoute, handleGetSummary);
