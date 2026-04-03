import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary } from './compliance.handlers';

export const complianceRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['COMPLIANCE'],
  description: 'Fetching standard payload for compliance domain',
  responses: {
    200: {
      description: 'compliance domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

complianceRoutes.openapi(summaryRoute, handleGetSummary);
