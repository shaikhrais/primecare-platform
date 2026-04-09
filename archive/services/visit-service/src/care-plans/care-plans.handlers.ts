import { Context } from 'hono';
import { eventBus } from '@primecare/shared-events';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'CARE PLANS domain operational' }, 200);
};

export const handleUpdatePlan = async (c: Context) => {
  try {
    const body = await c.req.json();
    const planId = body.planId || crypto.randomUUID();

    eventBus.emit('plan.updated', {
      timestamp: new Date().toISOString(),
      tenantId: 'system',
      sourceDomain: 'care-plans',
      data: {
        planId: planId,
        clientId: body.clientId || crypto.randomUUID(),
        updatedBy: body.updatedBy || 'RN_Coordinator',
        changes: body.changes || ['Adjusted medication schedule']
      }
    });

    return c.json({ status: 'success', planId, message: 'Care plan updated and analytics synchronized.' }, 200);
  } catch (error) {
    return c.json({ status: 'error', message: 'Failed to update care plan' }, 500);
  }
};
