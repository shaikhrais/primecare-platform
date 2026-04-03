import { eventBus, DomainEventPayload } from '../../_shared/events/eventBus';

/**
 * Initializes the universal Telemetry Interceptor.
 * Subscribes to the wildcard '*' event to catch every payload passing through the EventBus.
 */
export function registerTelemetryInterceptor(): void {
  eventBus.subscribe('*', async (payload: DomainEventPayload) => {
    // Standard structured logging
    console.log(`[Telemetry Daemon] Captured ${payload.eventId} (${payload.sourceDomain} -> ${payload.data ? Object.keys(payload.data).length : 0} fields)`);
    
    const prisma = payload.prisma;
    if (!prisma) {
      console.warn(`[Telemetry Daemon] No Prisma context provided in payload for ${payload.eventId}. Skipping database persistence.`);
      return;
    }

    try {
      // Async insert into local DB
      await prisma.systemEventLog.create({
        data: {
          eventName: payload.eventName,
          sourceDomain: payload.sourceDomain,
          tenantId: payload.tenantId || null,
          payload: payload.data
        }
      });
    } catch (e) {
      console.error(`[Telemetry Daemon] Failed to persist system event log!`, e);
    }
  });

  console.log('✅ Telemetry Interceptor Registered (Wildcard Listener active).');
}
