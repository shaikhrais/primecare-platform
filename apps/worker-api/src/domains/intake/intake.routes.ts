import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary, handleOpenCase } from './intake.handlers';

export const intakeRoutes = new OpenAPIHono();

const summaryRoute = createRoute({
  method: 'get',
  path: '/summary',
  tags: ['INTAKE'],
  description: 'Fetching standard payload for intake domain',
  responses: {
    200: {
      description: 'intake domain operational',
      content: { 'application/json': { schema: z.object({ status: z.string() }) } }
    }
  }
});

const openCaseRoute = createRoute({
  method: 'post',
  path: '/cases',
  tags: ['INTAKE'],
  description: 'Provisions a new intake case and asynchronously triggers downstream compliance.',
  request: {
    body: {
      content: {
        'application/json': {
          schema: z.object({
            tenantId: z.string().optional(),
            clientId: z.string().optional(),
            priority: z.string().optional()
          })
        }
      }
    }
  },
  responses: {
    200: {
      description: 'Case formally tracked and dispatched across EventBus.',
      content: { 'application/json': { schema: z.object({ status: z.string(), caseId: z.string(), message: z.string() }) } }
    }
  }
});

intakeRoutes.openapi(summaryRoute, handleGetSummary);
intakeRoutes.openapi(openCaseRoute, handleOpenCase);
