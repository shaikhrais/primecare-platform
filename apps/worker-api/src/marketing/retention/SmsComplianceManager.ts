/**
 * Epic 48: SMS Compliance Manager (TCPA Defense)
 * 
 * Simulated backend worker that intercepts all inbound SMS replies 
 * from patients across the entire PrimeCare network.
 * If a patient replies "STOP", "CANCEL", "UNSUBSCRIBE" or "QUIT" to any 
 * marketing or operational text, this script intercepts it at the webhook 
 * layer, algorithms scrubs their phone number from all database arrays, 
 * and immediately fires an exclusion flag to Twilio to prevent FCC fines.
 */

interface InboundSmsWebhook {
    messageId: string;
    fromNumber: string;
    body: string;
    receivedAt: string;
}

export class SmsComplianceManager {

    // Standard TCPA opt-out keywords
    private static readonly OPT_OUT_KEYWORDS = ['stop', 'cancel', 'unsubscribe', 'quit', 'end', 'stopall'];

    static async processInboundWebhook(webhookData: InboundSmsWebhook) {
        console.log(`[Compliance Engine] Inbound Webhook Received from ${webhookData.fromNumber}. Analyzing content for TCPA opt-out commands...`);
        
        // Simulating processing delay
        await new Promise(res => setTimeout(res, 300));

        const normalizedBody = webhookData.body.trim().toLowerCase();
        
        // Check if the exact message matches an opt-out word
        if (this.OPT_OUT_KEYWORDS.includes(normalizedBody)) {
            console.log(`\n🚨 [TCPA COMPLIANCE TRIGGERED] Detected intent to opt-out via keyword: "${webhookData.body}"`);
            
            // 1. Database Scrub Action
            console.log(`>> [Action 1] Scrubbing ${webhookData.fromNumber} from all B2C_GENERAL_LEAD newsletter arrays in PostgreSQL...`);
            
            // 2. Platform Do-Not-Disturb (DND) Flag
            console.log(`>> [Action 2] Updating PrimeCare profile. Setting 'allow_marketing_sms' = false...`);
            
            // 3. Twilio Hard-Block
            console.log(`>> [Action 3] Injecting Number into Twilio Global Exclusion List. Sending final confirmation text.`);
            console.log(`>> [Twilio Dispatch] TO: ${webhookData.fromNumber} | "PrimeCare: You have successfully unsubscribed. You will not receive any further messages."`);
            
            console.log(`\n✅ [Compliance Engine] Exclusion successful. PrimeCare protected from $1,500/text FCC TCPA violations.\n`);
            return;
        }

        console.log(`✅ [Compliance Engine] Message "${webhookData.body}" does not contain opt-out commands. Routing to standard Inbox.\n`);
    }

    /**
     * Helper to mock data for terminal demonstrations
     */
    static async runDemo() {
        // Safe message
        await this.processInboundWebhook({
            messageId: 'sms_99182',
            fromNumber: '+15551234567',
            body: 'Thanks for the pricing guide!',
            receivedAt: new Date().toISOString()
        });

        // Trigger message
        await this.processInboundWebhook({
            messageId: 'sms_99183',
            fromNumber: '+15559876543',
            body: 'STOP',
            receivedAt: new Date().toISOString()
        });
    }
}
