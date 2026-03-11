/**
 * Epic 6: Smart Voice Triage 
 * 
 * Twilio Voice Webhook hook. Receives the real-time transcription 
 * of a patient's voice response to an automated AI attendant ("How can I help you today?").
 * Evaluates the transcript to route directly to 911 constraints, an RN, or the dispatcher queue.
 */

interface TwilioVoicePayload {
    CallSid: string;
    From: string;
    TranscriptionText?: string;
}

export class SmartVoiceTriage {

    // Hardcoded trigger strings for simulation
    private static medicalEmergencyKeywords = ['chest pain', 'heart', 'bleed', 'ambulance', 'cannot breathe', 'fall', 'floor'];
    private static clinicalKeywords = ['medication', 'pill', 'fever', 'wound', 'rash'];
    private static schedulingKeywords = ['cancel', 'reschedule', 'late', 'time', 'tomorrow'];

    private static evaluateTranscription(text: string): 'ROUTE_911' | 'ROUTE_RN_TRIAGE' | 'ROUTE_DISPATCH' | 'ROUTE_VOICEMAIL' {
        const lowerText = text.toLowerCase();

        for (const keyword of this.medicalEmergencyKeywords) {
            if (lowerText.includes(keyword)) return 'ROUTE_911';
        }

        for (const keyword of this.clinicalKeywords) {
            if (lowerText.includes(keyword)) return 'ROUTE_RN_TRIAGE';
        }

        for (const keyword of this.schedulingKeywords) {
            if (lowerText.includes(keyword)) return 'ROUTE_DISPATCH';
        }

        return 'ROUTE_VOICEMAIL';
    }

    /**
     * Express/Hono route handler intercepting the Twilio Webhook
     */
    static async handleInboundCall(prisma: any, payload: TwilioVoicePayload): Promise<string> {
        console.log(`[Twilio Webhook] Analyzing Voice Transcription from ${payload.From}...`);

        await prisma.communicationLog.create({
            data: {
                recipientId: payload.From,
                channel: 'VOICE',
                status: 'processed',
                metadata: JSON.stringify(payload)
            }
        });
        
        const text = payload.TranscriptionText;
        if (!text) {
             console.log(`[Twilio Webhook] Empty transcription. Routing to generic dispatcher menu.`);
             return '<Response><Say>Please hold while we connect you to a dispatcher.</Say><Dial>+15551234567</Dial></Response>';
        }

        const routingDecision = this.evaluateTranscription(text);
        let twimlResponse = '';

        switch (routingDecision) {
            case 'ROUTE_911':
                console.warn(`[EMERGENCY DETECTED] Auto-Routing ${payload.From} to 911 equivalent services.`);
                twimlResponse = '<Response><Say>I understand you may be experiencing a medical emergency. I am transferring you to Emergency Services now.</Say><Dial>911</Dial></Response>';
                break;
            case 'ROUTE_RN_TRIAGE':
                console.log(`[CLINICAL TRIAGE] Auto-Routing ${payload.From} to On-Call RN.`);
                twimlResponse = '<Response><Say>I understand you have a clinical question. Routing you to an evaluating nurse.</Say><Dial>+1555NURSE00</Dial></Response>';
                break;
            case 'ROUTE_DISPATCH':
                console.log(`[SCHEDULING TICK] Auto-Routing ${payload.From} to Dispatcher Queue.`);
                twimlResponse = '<Response><Say>I understand you need to modify your schedule. Hold for a dispatcher.</Say><Dial>+1555DISP000</Dial></Response>';
                break;
            default:
                twimlResponse = '<Response><Say>Please leave a message and we will call you back.</Say><Record maxLength="60" /></Response>';
                break;
        }

        return twimlResponse;
    }
}
