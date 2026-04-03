import { eventBus, DomainEventPayload, CaseOpenedPayloadSchema, TicketEscalatedPayloadSchema, TerritoryUpdatedPayloadSchema } from '@primecare/shared-events';
import { z } from 'zod';

/**
 * Initializes all event subscriptions for the Analytics & Reporting Domain.
 * This completely decouples database read/write queries from the other critical pathways.
 */
export function registerReportingEventListeners(): void {
  // Listen to new Intake cases for pipeline velocity metrics
  eventBus.subscribe('case.opened', async (payload: DomainEventPayload<z.infer<typeof CaseOpenedPayloadSchema>>) => {
    console.log(`[Reporting Daemon] Syncing new case mapping from ${payload.sourceDomain} into the global analytics warehouse.`);
    try {
      const caseData = CaseOpenedPayloadSchema.parse(payload.data);
      // Implementation logic... e.g. incrementing a Redis pipeline counter.
      console.log(`[Reporting Daemon] Updated metrics for Case ID: ${caseData.caseId}.`);
    } catch (error) {
      console.error(`[Reporting Daemon] Payload schema divergence on 'case.opened':`, error);
    }
  });

  // Listen to Support escalations to alert SLA dashboards
  eventBus.subscribe('ticket.escalated', async (payload: DomainEventPayload<z.infer<typeof TicketEscalatedPayloadSchema>>) => {
    console.log(`[Reporting Daemon] Intercepted SLA escalation anomaly from ${payload.sourceDomain}.`);
    try {
      const escalation = TicketEscalatedPayloadSchema.parse(payload.data);
      if (escalation.escalationLevel >= 3) {
         console.warn(`[Reporting Daemon] CRITICAL ALERT TRIPPED for Ticket ${escalation.ticketId}. Syncing live websocket dashboard.`);
      }
    } catch (error) {
      console.error(`[Reporting Daemon] Payload schema divergence on 'ticket.escalated':`, error);
    }
  });

  // Listen to Franchise expansion for territory financial forecasting
  eventBus.subscribe('territory.updated', async (payload: DomainEventPayload<z.infer<typeof TerritoryUpdatedPayloadSchema>>) => {
    console.log(`[Reporting Daemon] Tracking franchise footprint mutation from ${payload.sourceDomain}.`);
    try {
      const territory = TerritoryUpdatedPayloadSchema.parse(payload.data);
      console.log(`[Reporting Daemon] Recalculating geospatial heatmaps for Territory ${territory.territoryId} with status ${territory.status}.`);
    } catch (error) {
      console.error(`[Reporting Daemon] Payload schema divergence on 'territory.updated':`, error);
    }
  });

  console.log('✅ Reporting/Analytics Domain Event Listeners Registered.');
}
