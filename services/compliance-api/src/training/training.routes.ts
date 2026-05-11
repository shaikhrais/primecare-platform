import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { handleGetSummary, handleCompleteCourse } from './training.handlers';

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

const validateRoute = createRoute({
  method: 'post',
  path: '/complete',
  tags: ['TRAINING'],
  description: 'Provisions a high-priority training course completion and asynchronously notifies telemetry.',
  request: {
    body: {
      content: {
        'application/json': {
          schema: z.object({
            providerId: z.string().optional(),
            courseId: z.string().optional(),
            score: z.number().optional()
          })
        }
      }
    }
  },
  responses: {
    200: {
      description: 'Training complete successfully updated via EventBus.',
      content: { 'application/json': { schema: z.object({ status: z.string(), courseId: z.string(), message: z.string() }) } }
    },
    500: {
      description: 'Error processing update.',
      content: { 'application/json': { schema: z.object({ status: z.string(), message: z.string() }) } }
    }
  }
});

trainingRoutes.openapi(summaryRoute, handleGetSummary);
trainingRoutes.openapi(validateRoute, handleCompleteCourse);
