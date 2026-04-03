import { eventBus, DomainEventPayload, CaseOpenedPayloadSchema } from '../../_shared/events/eventBus';
import { z } from 'zod';

/**
 * Initializes all event subscriptions for the Compliance & Credentials Domain.
 */
export function registerComplianceEventListeners(): void {
  eventBus.subscribe('cert.expiring', async (payload: DomainEventPayload) => {
    console.log(`[Compliance Module] Intercepted expiring credential warning from ${payload.sourceDomain}`);
    try {
      const { providerId, certType, expirationDate } = payload.data;
      console.log(`[Compliance Module] Queueing automated lockout for Provider ${providerId} if ${certType} is not renewed by ${expirationDate}.`);
    } catch (error) {
      console.error(`[Compliance Module] Error processing credential expiry:`, error);
    }
  });

  eventBus.subscribe('case.opened', async (payload: DomainEventPayload<z.infer<typeof CaseOpenedPayloadSchema>>) => {
    console.log(`[Compliance Module] Silently intercepted new 'case.opened' from ${payload.sourceDomain}.`);
    try {
      const caseData = CaseOpenedPayloadSchema.parse(payload.data);
      console.log(`[Compliance Module] Provisioning credential checklists for Case ${caseData.caseId} requiring roles: ${caseData.assignedRoles?.join(', ')}`);
      // Future: auto-assign policy templates based on caseData.priority...
    } catch (error) {
      console.error(`[Compliance Module] Invalid payload detected on case.opened channel:`, error);
    }
  });

  console.log('✅ Compliance Domain Event Listeners Registered.');
}
