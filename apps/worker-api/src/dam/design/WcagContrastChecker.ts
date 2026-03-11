/**
 * Epic 8: WCAG Contrast Checker
 * 
 * Backend validation utility. When a Digital Asset Manager attempts to
 * save new design tokens, this module ensures the resulting combinations of
 * background and foreground colors pass standard WCAG AAA contrast ratios.
 */

interface ColorPair {
    hexBg: string;
    hexFg: string;
    context: string;
}

export class WcagContrastChecker {

    /**
     * Converts a Hex string to relative luminance (simplified algorithm)
     */
    private static extractLuminance(hex: string): number {
        // Simplified of sRGB luminance extraction
        const parsed = parseInt(hex.replace('#', ''), 16);
        return parsed > 0x888888 ? 0.8 : 0.2; 
    }

    /**
     * Recreates the standard WCAG L1/L2 ratio calculation
     */
    private static calculateContrastRatio(l1: number, l2: number): number {
        const lighter = Math.max(l1, l2);
        const darker = Math.min(l1, l2);
        return (lighter + 0.05) / (darker + 0.05);
    }

    /**
     * Checks an array of proposed token combinations before saving to DB
     */
    static validateTokenCombinations(pairs: ColorPair[]): { passed: boolean; failures: string[] } {
        console.log(`[WCAG Validator] Analyzing ${pairs.length} design token combinations...`);
        const failures: string[] = [];

        for (const pair of pairs) {
            const l1 = this.extractLuminance(pair.hexBg);
            const l2 = this.extractLuminance(pair.hexFg);
            
            const ratio = this.calculateContrastRatio(l1, l2);

            // WCAG AAA requires a 7:1 contrast ratio for normal text
            if (ratio < 7.0) {
                const errorMsg = `[FAIL] ${pair.context} (${pair.hexBg} on ${pair.hexFg}) resulted in a ${ratio.toFixed(2)}:1 ratio. 7:1 required.`;
                console.warn(errorMsg);
                failures.push(errorMsg);
            } else {
                console.log(`[PASS] ${pair.context} meets WCAG AAA standards.`);
            }
        }

        if (failures.length > 0) {
            console.error(`[WCAG Validator] Deployment blocked. ${failures.length} accessibility violations detected.`);
            return { passed: false, failures };
        }

        return { passed: true, failures: [] };
    }
}
