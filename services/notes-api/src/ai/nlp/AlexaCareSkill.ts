/**
 * Epic 37: Amazon Alexa "PrimeCare Skill"
 * 
 * AWS Lambda function backing an Alexa Custom Skill.
 * Parses natural language intents asking about upcoming schedules,
 * querying the PrimeCare API and returning a TTS (Text-to-Speech) markup response.
 */

interface AlexaConnectRequest {
    request: {
        type: 'IntentRequest';
        intent: {
            name: 'NextNurseVisitIntent' | 'MedicationReminderIntent';
            slots?: any;
        };
    };
    session: {
        user: {
            userId: string; // Used to look up the PrimeCare Patient linked to this Alexa
        };
    };
}

export class AlexaCareSkill {

    /**
     * A DB lookup mapping an Amazon UserID to a PrimeCare Schedule
     */
    private static async getNextShift(amazonUserId: string) {
        // Return upcoming schedule
        return {
            nurseName: 'Sarah',
            role: 'RN',
            arrivalTime: 'tomorrow at 9:00 AM'
        };
    }

    /**
     * Primary handler for incoming Voice Intents
     */
    static async handleVoiceIntent(payload: AlexaConnectRequest): Promise<string> {
        console.log(`[Alexa Skill] Received Intent: ${payload.request.intent.name}`);

        if (payload.request.intent.name === 'NextNurseVisitIntent') {
            const shift = await this.getNextShift(payload.session.user.userId);
            
            // Build the SSML (Speech Synthesis Markup Language) Response
            const speechOutput = `<speak>Your next visit is scheduled with ${shift.nurseName}, your assigned ${shift.role}. She will arrive ${shift.arrivalTime}.</speak>`;
            
            console.log(`[Alexa Skill] Responding: ${speechOutput}`);
            return speechOutput;
        }

        return `<speak>I'm sorry, I don't know how to help with that PrimeCare request yet.</speak>`;
    }
}
