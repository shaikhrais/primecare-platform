import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary } from './reporting.handlers';

export const reportingRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['REPORTING'],
  description: 'Fetching standard payload for reporting domain',
  responses: {
    200: {
      description: 'reporting domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

reportingRoutes.openapi(summaryRoute, handleGetSummary);
