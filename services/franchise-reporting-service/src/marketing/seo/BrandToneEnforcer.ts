/**
 * Epic 40: Brand Tone-of-Voice Enforcer
 * 
 * Backend NLP worker. * PrimeCare's brand voice must be "empathetic and accessible," never 
 * "cold or clinical." This script hooks into the outbound email server.
 * Before a mass newsletter is sent, it scans the text. If a marketer 
 * uses overly clinical jargon (e.g., "myocardial infarction" instead 
 * of "heart attack"), it blocks the email and alerts the CMO.
 */

interface OutboundEmail {
    id: string;
    subject: string;
    body: string;
    author: string;
}

export class BrandToneEnforcer {

    // A dictionary of cold/clinical terms vs accessible terms
    private static clinicalDictionary: Record<string, string> = {
        'myocardial infarction': 'heart attack',
        'cerebrovascular accident': 'stroke',
        'ambulate': 'walk',
        'expired': 'passed away',
        'non-compliant': 'struggling to follow the care plan',
        'hypertension': 'high blood pressure'
    };

    static async scanOutboundCommunication(email: OutboundEmail) {
        console.log(`[Brand Voice Guard] Scanning outbound mass email (ID: ${email.id})...`);
        
        const bodyLower = email.body.toLowerCase();
        const infractions: string[] = [];

        Object.keys(this.clinicalDictionary).forEach(clinicalTerm => {
            if (bodyLower.includes(clinicalTerm)) {
                infractions.push(`Found "${clinicalTerm}". Suggestion: Use "${this.clinicalDictionary[clinicalTerm]}"`);
            }
        });

        if (infractions.length > 0) {
            console.log(`\n🚨 [BRAND GUARD ALERT] Cold/Clinical language detected in email from ${email.author}.`);
            console.log(`-> Subject: "${email.subject}"`);
            console.log(`-> Violations:`);
            infractions.forEach(inf => console.log(`   - ${inf}`));
            
            console.log(`\n[Action Executed] Mass transmission BLOCKED. Draft forwarded to CMO for Tone-of-Voice approval.\n`);
            return false;
        }

        console.log(`✅ [Brand Voice Guard] Scan passed. Tone is empathetic and accessible. Transmission approved.\n`);
        return true;
    }

    /**
     * Demo execution
     */
    static async runDemo() {
        await this.scanOutboundCommunication({
            id: 'campaign_9918',
            author: 'Junior Copywriter',
            subject: 'New Care Plans Available',
            body: 'If your loved one recently suffered a cerebrovascular accident, our nurses can help them ambulate around the home.'
        });
    }
}
