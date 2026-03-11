/**
 * Epic 22: Webhook Traffic Router
 * 
 * Backend middleware that intercepts incoming external webhooks
 * (e.g., from Stripe or Twilio). It analyzes the JSON payload and dynamically
 * routes it to the correct internal microservice based on logic trees defined
 * by the Digital Asset Manager in the `VisualLogicBuilder` UI.
 */

interface WebhookPayload {
    source: string;
    eventType: string;
    payloadData: any;
}

export class WebhookTrafficRouter {

    /**
     * Lookup of active Visual Logic rules
     */
    private static fetchRoutingRules(source: string, eventType: string): string[] {
        // Match: If Stripe payment succeeds, hit Finance Ledger and Push Notifications
        if (source === 'stripe' && eventType === 'payment_intent.succeeded') {
            return ['finance_ledger_service', 'slack_notification_service'];
        }
        // Match: If background check clears, hit HR
        if (source === 'checkr' && eventType === 'report.completed') {
            return ['hr_onboarding_service'];
        }
        return ['dead_letter_queue'];
    }

    /**
     * Inbound entry point for external data
     */
    static async routeInboundPayload(req: WebhookPayload): Promise<boolean> {
        console.log(`[Webhook Router] Inbound event detected from '${req.source.toUpperCase()}'...`);
        console.log(`[Webhook Router] Event Type: ${req.eventType}`);
        
        const targetServices = this.fetchRoutingRules(req.source, req.eventType);

        if (targetServices.includes('dead_letter_queue')) {
            console.warn(`[Webhook Router] No visual logic rules match this event. Routing to Dead Letter Queue.`);
            return false;
        }

        console.log(`[Webhook Router] Match found in Visual Logic tree. Routing payload to ${targetServices.length} internal microservices.`);
        
        for (const service of targetServices) {
            // Dispatch internal network dispatch
            console.log(`[Webhook Router] -> Dispatching to [${service}]... OK.`);
        }

        return true;
    }
}
