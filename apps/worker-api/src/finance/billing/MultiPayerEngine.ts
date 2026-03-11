/**
 * Epic 21: Multi-Payer Contract Engine
 * 
 * Simulated calculation engine that triggers upon visit completion.
 * Splits a unified baseline cost into required fractional payloads corresponding 
 * to Medicare rules, VA coverage, and fractional Out-Of-Pocket (OOP) leftovers.
 */

interface CompletedVisit {
    id: string;
    patientId: string;
    totalBillableHours: number;
    baseHourlyRate: number; // e.g., $35.00
    modifiers: string[]; // e.g., 'WEEKEND', 'NIGHT_SHIFT', 'STAT_HOLIDAY'
}

interface SplitManifest {
    totalInvoice: number;
    medicarePortion: number;
    vaPortion: number;
    outOfPocket: number;
}

export class MultiPayerEngine {

    /**
     * Mocks fetching the complex insurance rules for a specific patient.
     */
    private static async getPatientCoverageRules(patientId: string) {
        // Assume patient is a Veteran with partial Medicare crossover
        return {
            hasVA: true,
            vaCoverageRatio: 0.60, // VA covers 60%
            hasMedicare: true,
            medicareMaxHourly: 25.00 // Medicare caps at $25/hr
        };
    }

    /**
     * Evaluates the completed visit and returns the split ledger payload.
     */
    static async generateInvoiceSplit(visit: CompletedVisit): Promise<SplitManifest> {
        console.log(`[Finance Engine] Calculating Multi-Payer Split for Visit ${visit.id}...`);
        const rules = await this.getPatientCoverageRules(visit.patientId);
        
        // 1. Calculate Gross Original
        let multiplier = 1.0;
        if (visit.modifiers.includes('WEEKEND')) multiplier += 0.2;
        if (visit.modifiers.includes('STAT_HOLIDAY')) multiplier += 1.0;

        const effectiveHourly = visit.baseHourlyRate * multiplier;
        const totalGross = effectiveHourly * visit.totalBillableHours;

        let remainingBalance = totalGross;
        let medicareAllocated = 0;
        let vaAllocated = 0;

        // 2. Medicare operates first, but has a hard cap mechanism
        if (rules.hasMedicare) {
            const medicareCoveredRate = Math.min(effectiveHourly, rules.medicareMaxHourly);
            medicareAllocated = medicareCoveredRate * visit.totalBillableHours;
            remainingBalance -= medicareAllocated;
        }

        // 3. VA picks up its percentage of the *remaining* balance (Secondary Payer)
        if (rules.hasVA && remainingBalance > 0) {
            vaAllocated = remainingBalance * rules.vaCoverageRatio;
            remainingBalance -= vaAllocated;
        }

        // 4. Whatever is left drops to the Family Portal Invoice
        const oop = remainingBalance;

        // Round to 2 decimals
        return {
            totalInvoice: Number(totalGross.toFixed(2)),
            medicarePortion: Number(medicareAllocated.toFixed(2)),
            vaPortion: Number(vaAllocated.toFixed(2)),
            outOfPocket: Number(oop.toFixed(2))
        };
    }
}
