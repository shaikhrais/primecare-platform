import { Context } from 'hono';
import { eventBus } from '@primecare/shared-events';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'TRAINING domain operational' }, 200);
};

export const handleCompleteCourse = async (c: Context) => {
  try {
    const body = await c.req.json();
    const courseId = body.courseId || crypto.randomUUID();

    eventBus.emit('course.completed', {
      timestamp: new Date().toISOString(),
      tenantId: 'system',
      sourceDomain: 'training',
      data: {
        courseId: courseId,
        providerId: body.providerId || crypto.randomUUID(),
        score: body.score || 100
      }
    });

    return c.json({ status: 'success', courseId, message: 'Training course logged and analytics synchronized.' }, 200);
  } catch (error) {
    return c.json({ status: 'error', message: 'Failed to complete course' }, 500);
  }
};
