import { Context } from 'hono';
import { eventBus } from '../../_shared/events/eventBus';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'INTAKE domain operational' }, 200);
};

export const handleOpenCase = async (c: Context) => {
  const body = await c.req.json();
  const caseId = crypto.randomUUID();

  // EMIT EVENT: Async Pub/Sub choreography decoupled from the response thread
  eventBus.emit('case.opened', {
    timestamp: new Date().toISOString(),
    tenantId: body.tenantId || 'system',
    sourceDomain: 'intake',
    data: {
      caseId: caseId,
      clientId: body.clientId || crypto.randomUUID(),
      priority: body.priority || 'MEDIUM',
      assignedRoles: ['RN', 'PSW']
    }
  });

  return c.json({ status: 'success', caseId, message: 'Case formally tracked and dispatched across EventBus.' }, 200);
};
