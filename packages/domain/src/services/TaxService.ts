import { Prisma } from '@primecare/database';
import { Result } from '../utils/Result';

export type TaxCalculation = {
    baseAmount: Prisma.Decimal;
    taxAmount: Prisma.Decimal;
    totalAmount: Prisma.Decimal;
    rate: number;
    description: string;
};

export class TaxService {
    /**
     * Resolves the tax rate based on the region code.
     * Defaulting to Canadian rules for Phase 11.
     */
    static async getRateForRegion(region: string): Promise<Result<{ rate: number; description: string }>> {
        return Result.guard(async () => {
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
                    // We maintain the default fallback but wrap it in Result for consistency
                    return { rate: 0.05, description: 'GST (Standard)' };
            }
        });
    }

    /**
     * Calculates tax amounts for a given gross or net figure.
     * @param amount The numeric amount to calculate from.
     * @param region The location code (e.g., 'ON').
     * @param inclusive Whether the input amount already includes tax.
     */
    static async calculateTax(amount: number | Prisma.Decimal, region: string, inclusive: boolean = false): Promise<Result<TaxCalculation>> {
        return Result.guard(async () => {
            const rateResult = await this.getRateForRegion(region);
            const { rate, description } = rateResult.data;
            
            const inputAmount = typeof amount === 'number' ? new Prisma.Decimal(amount) : amount;

            let baseAmount: Prisma.Decimal;
            let taxAmount: Prisma.Decimal;
            let totalAmount: Prisma.Decimal;

            if (inclusive) {
                // Amount = Base * (1 + rate) -> Base = Amount / (1 + rate)
                totalAmount = inputAmount;
                baseAmount = totalAmount.div(1 + rate).toPrisma.DecimalPlaces(2);
                taxAmount = totalAmount.minus(baseAmount);
            } else {
                // Amount = Base -> Total = Base * (1 + rate)
                baseAmount = inputAmount;
                taxAmount = baseAmount.mul(rate).toPrisma.DecimalPlaces(2);
                totalAmount = baseAmount.plus(taxAmount);
            }

            return {
                baseAmount,
                taxAmount,
                totalAmount,
                rate,
                description
            };
        });
    }
}
