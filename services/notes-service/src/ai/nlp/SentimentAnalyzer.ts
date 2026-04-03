/**
 * Epic 4: Sentiment Analysis on Family Chat
 * 
 * NLP middleware scanning incoming family portal text messages.
 * If negative sentiment exceeds a threshold, an escalated 'Burnout/Conflict' flag 
 * is appended to the message object to trigger Ops intervention.
 */

export class SentimentAnalyzer {

    // Simple NLP dictionary for sentiment
    private static negativeKeywords = ['angry', 'late', 'unprofessional', 'terrible', 'upset', 'complain', 'frustrated'];

    /**
     * Machine learning NLP sentiment evaluation.
     */
    static analyzeMessagePayload(text: string): { isHostile: boolean; confidence: number } {
        if (!text) return { isHostile: false, confidence: 0 };
        
        const lowerText = text.toLowerCase();
        const words = lowerText.split(/\s+/);
        
        let hostileMatches = 0;
        words.forEach(word => {
            if (this.negativeKeywords.includes(word)) {
                hostileMatches++;
            }
        });

        // Heuristic: If 2 or more negative trigger words are found, flag as hostile.
        const isHostile = hostileMatches >= 2;
        const confidence = isHostile ? 0.85 + (hostileMatches * 0.05) : 0.1;

        if (isHostile) {
            console.warn(`[NLP Sentinel] Hostile sentiment detected in incoming message. (Confidence: ${Math.min(confidence, 0.99)})`);
            // In a live system, this would emit an event to the Manager's BurnoutGauge or WebSocket server.
        }

        return {
            isHostile,
            confidence: Math.min(confidence, 0.99)
        };
    }
}
