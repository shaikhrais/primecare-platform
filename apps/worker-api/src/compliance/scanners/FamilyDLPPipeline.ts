/**
 * Epic 13: Family DLP (Data Loss Prevention) Pipeline
 * 
 * Middleware layer analyzing outgoing chat payloads on the Family Portal.
 * Prevents staff from accidentally leaking Social Security Numbers, 
 * Canadian SINs, or Medicare Health Card numbers into the unprotected chat layer.
 */

export class FamilyDLPPipeline {

    // Common RegEx patterns for sensitive healthcare/identify information
    private static PII_PATTERNS = [
        { name: "US_SSN", regex: /\b\d{3}[- ]?\d{2}[- ]?\d{4}\b/g },
        { name: "CAN_SIN", regex: /\b\d{3}[- ]?\d{3}[- ]?\d{3}\b/g },
        { name: "HEALTH_CARD_OHIP", regex: /\b\d{4}[- ]?\d{3}[- ]?\d{3}[- ]?[A-Z]{2}\b/gi },
        { name: "CREDIT_CARD", regex: /\b(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})\b/g }
    ];

    /**
     * Scans message payloads. If a Regex fires, it replaces the string with a redacted tag
     * before allowing it to pass to the DB layer or the Family device.
     */
    static sanitizeMessagePayload(rawText: string): { sanitizedText: string, infractionFound: boolean } {
        if (!rawText) return { sanitizedText: '', infractionFound: false };

        let processedText = rawText;
        let piiDetected = false;

        this.PII_PATTERNS.forEach(pattern => {
            if (pattern.regex.test(processedText)) {
                piiDetected = true;
                processedText = processedText.replace(pattern.regex, '[REDACTED_PHI_POLICY]');
                console.warn(`[DLP Sentinel] Blocked ${pattern.name} transmission in Family Chat.`);
            }
        });

        return {
            sanitizedText: processedText,
            infractionFound: piiDetected
        };
    }
}
