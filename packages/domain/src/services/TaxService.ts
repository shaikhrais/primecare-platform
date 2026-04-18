import { Decimal } from '@prisma/client/runtime/library';

export type TaxCalculation = {
    baseAmount: Decimal;
    taxAmount: Decimal;
    totalAmount: Decimal;
    rate: number;
    description: string;
};

export class TaxService {
    /**
     * Resolves the tax rate based on the region code.
     * Defaulting to Canadian rules for Phase 11.
     */
    static getRateForRegion(region: string): { rate: number; description: string } {
        const normalizedRegion = region.toUpperCase();
        
        switch (normalizedRegion) {
            case 'ON':
                return { rate: 0.13, description: 'HST (Ontario)' };
            case 'BC':
                return { rate: 0.12, description: 'GST + PST (BC)' };
            case 'QC':
                return { rate: 0.14975, description: 'GST + QST (Quebec)' };
            case 'AB':
            case 'NT':
            case 'NU':
            case 'YT':
                return { rate: 0.05, description: 'GST Only' };
            case 'NS':
            case 'NB':
            case 'NL':
            case 'PE':
                return { rate: 0.15, description: 'HST' };
            default:
                return { rate: 0.05, description: 'GST (Standard)' };
        }
    }

    /**
     * Calculates tax amounts for a given gross or net figure.
     * @param amount The numeric amount to calculate from.
     * @param region The location code (e.g., 'ON').
     * @param inclusive Whether the input amount already includes tax.
     */
    static calculateTax(amount: number | Decimal, region: string, inclusive: boolean = false): TaxCalculation {
        const { rate, description } = this.getRateForRegion(region);
        const inputAmount = typeof amount === 'number' ? new Decimal(amount) : amount;

        let baseAmount: Decimal;
        let taxAmount: Decimal;
        let totalAmount: Decimal;

        if (inclusive) {
            // Amount = Base * (1 + rate) -> Base = Amount / (1 + rate)
            totalAmount = inputAmount;
            baseAmount = totalAmount.div(1 + rate).toDecimalPlaces(2);
            taxAmount = totalAmount.minus(baseAmount);
        } else {
            // Amount = Base -> Total = Base * (1 + rate)
            baseAmount = inputAmount;
            taxAmount = baseAmount.mul(rate).toDecimalPlaces(2);
            totalAmount = baseAmount.plus(taxAmount);
        }

        return {
            baseAmount,
            taxAmount,
            totalAmount,
            rate,
            description
        };
    }
}
