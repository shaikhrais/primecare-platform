import { eventBus, DomainEventPayload } from '@primecare/messaging';

/**
 * Initializes all event subscriptions for the Billing Domain.
 * Call this once on API server boot.
 */
export function registerBillingEventListeners(): void {
  eventBus.subscribe('visit.completed', async (payload: DomainEventPayload) => {
    console.log(`[Finance Module] Received visit completion trigger from ${payload.sourceDomain}`);
    
    // In a real microservice, this query hits the internal Billing schema
    // and recalculates timesheets or constructs an invoice based on time payloads.
    try {
      const { visitId, providerId, finalDurationMinutes } = payload.data;
      
      console.log(`[Finance Module] Queuing Timesheet Payout Calculation for Provider: ${providerId} (Length: ${finalDurationMinutes} mins)`);
      
      // Simulating heavy asynchronous processing
      await new Promise(resolve => setTimeout(resolve, 500));
      
      console.log(`[Finance Module] Timesheet Calculation Successful for Visit: ${visitId}`);
    } catch (error) {
      console.error(`[Finance Module] Failed to process timesheet for visit:`, error);
    }
  });

  console.log('✅ Billing Domain Event Listeners Registered.');
}
