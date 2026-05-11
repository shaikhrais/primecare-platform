/**
 * Defines the core structure for inter-domain events in the Modular Monolith Architecture.
 * This class abstracts away physical Event Pub/Sub mechanisms (e.g. Cloudflare Queues, Redis Streams)
 * to provide a simple programmatic interface for the TypeScript endpoints.
 */

import { z } from 'zod';

export type DomainEventName = 
  | 'visit.started' 
  | 'visit.completed' 
  | 'provider.registered' 
  | 'client.onboarded'
  | 'billing.invoice_generated'
  // Phase 2 Events
  | 'case.opened'
  | 'assessment.done'
  | 'plan.updated'
  | 'goal.met'
  | 'cert.expiring'
  | 'license.revoked'
  | 'course.completed'
  | 'ticket.escalated'
  | 'ticket.closed'
  | 'territory.updated';

export const CaseOpenedPayloadSchema = z.object({
  caseId: z.string(),
  clientId: z.string(),
  priority: z.enum(['LOW', 'MEDIUM', 'HIGH', 'CRITICAL']),
  assignedRoles: z.array(z.string()).optional()
});

export const CertExpiringPayloadSchema = z.object({
  providerId: z.string(),
  certificationId: z.string(),
  daysUntilExpiry: z.number()
});

export const PlanUpdatedPayloadSchema = z.object({
  planId: z.string(),
  clientId: z.string(),
  updatedBy: z.string(),
  changes: z.array(z.string())
});

export const TicketEscalatedPayloadSchema = z.object({
  ticketId: z.string(),
  assignedTo: z.string(),
  escalationLevel: z.number(),
  reason: z.string()
});

export const TerritoryUpdatedPayloadSchema = z.object({
  territoryId: z.string(),
  managerId: z.string(),
  status: z.enum(['ACTIVE', 'INACTIVE', 'EXPANDING'])
});

export const CourseCompletedPayloadSchema = z.object({
  providerId: z.string(),
  courseId: z.string(),
  score: z.number().optional()
});

export interface DomainEventPayload<T = Record<string, any>> {
  eventId: string;
  eventName: DomainEventName;
  timestamp: string;
  tenantId: string;
  sourceDomain: string;
  data: T;
  prisma?: any; // Context-injected Prisma client for background persistence
}

export type EventCallback<T = any> = (payload: DomainEventPayload<T>) => Promise<void>;

class EventBus {
  private static instance: EventBus;
  private listeners: Map<DomainEventName | '*', EventCallback[]> = new Map();

  private constructor() {}

  public static getInstance(): EventBus {
    if (!EventBus.instance) {
      EventBus.instance = new EventBus();
    }
    return EventBus.instance;
  }

  /**
   * Registers an asynchronous listener for a specific domain event.
   * Listeners should be entirely decoupled from the emitting domain.
   */
  public subscribe(event: DomainEventName | '*', callback: EventCallback): void {
    if (!this.listeners.has(event as DomainEventName)) {
      this.listeners.set(event as DomainEventName, []);
    }
    this.listeners.get(event as DomainEventName)!.push(callback);
    console.log(`[EventBus] Domain Listener Registered for: ${event}`);
  }

  /**
   * Emits a payload to all registered listeners asynchronously.
   * This is immediately "fire-and-forget" so the core endpoint doesn't block.
   */
  public emit(event: DomainEventName, payload: Omit<DomainEventPayload, 'eventId' | 'eventName'>): void {
    const fullPayload: DomainEventPayload = {
      ...payload,
      eventId: crypto.randomUUID(),
      eventName: event,
    };

    console.log(`[EventBus] Emitting ${event} from ${payload.sourceDomain}`);

    // Get specific event listeners and wildcard listeners
    const specificListeners = this.listeners.get(event) || [];
    const wildcardListeners = this.listeners.get('*' as DomainEventName) || [];
    const eventListeners = [...specificListeners, ...wildcardListeners];
    
    // Asynchronously dispatch to avoid blocking the HTTP handler
    eventListeners.forEach(listener => {
      Promise.resolve()
        .then(() => listener(fullPayload))
        .catch(err => {
          console.error(`[EventBus] Error in listener for ${event}:`, err);
        });
    });
  }
}

export const eventBus = EventBus.getInstance();

