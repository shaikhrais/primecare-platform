import { Context } from 'hono';
import { eventBus } from '@primecare/shared-events';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'FRANCHISE domain operational' }, 200);
};

export const handleUpdateTerritory = async (c: Context) => {
  try {
    const body = await c.req.json();
    const territoryId = body.territoryId || crypto.randomUUID();

    eventBus.emit('territory.updated', {
      timestamp: new Date().toISOString(),
      tenantId: 'system',
      sourceDomain: 'franchise',
      data: {
        territoryId: territoryId,
        managerId: body.managerId || crypto.randomUUID(),
        status: body.status || 'ACTIVE'
      }
    });

    return c.json({ status: 'success', territoryId, message: 'Territory analytics synchronized.' }, 200);
  } catch (error) {
    return c.json({ status: 'error', message: 'Failed to update territory' }, 500);
  }
};
