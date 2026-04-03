import { Context } from 'hono';
import { eventBus } from '../../_shared/events/eventBus';

export const handleGetSummary = async (c: Context) => {
  return c.json({ status: 'SUPPORT domain operational' }, 200);
};

export const handleEscalateTicket = async (c: Context) => {
  try {
    const body = await c.req.json();
    const ticketId = body.ticketId || crypto.randomUUID();

    eventBus.emit('ticket.escalated', {
      timestamp: new Date().toISOString(),
      tenantId: 'system',
      sourceDomain: 'support',
      data: {
        ticketId: ticketId,
        assignedTo: body.assignedTo || 'Tier3_Support',
        escalationLevel: body.escalationLevel || 3,
        reason: body.reason || 'SLA Breach'
      }
    });

    return c.json({ status: 'success', ticketId, message: 'Ticket escalated.' }, 200);
  } catch (error) {
    return c.json({ status: 'error', message: 'Failed to escalate ticket' }, 500);
  }
};
