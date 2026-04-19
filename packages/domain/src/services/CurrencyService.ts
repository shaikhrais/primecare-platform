import { PrismaClient } from '@primecare/database';
import { Decimal } from '@prisma/client/runtime/library';
import { Result } from '../utils/Result';

const prisma = new PrismaClient();

// Mock exchange rates for Phase 10 implementation.
// In production, these should be fetched from an external API or a rates table.
const MOCK_RATES: Record<string, number> = {
    'CAD_USD': 0.74,
    'USD_CAD': 1.35,
    'CAD_GBP': 0.58,
    'GBP_CAD': 1.72,
    'CAD_EUR': 0.68,
    'EUR_CAD': 1.47,
};

export class CurrencyService {
    /**
     * Fetches the exchange rate between two currencies.
     * @param from Source currency (e.g., 'USD')
     * @param to Target currency (e.g., 'CAD')
     * @returns The exchange rate as a result
     */
    static async getExchangeRate(from: string, to: string): Promise<Result<number>> {
        return Result.guard(async () => {
            if (from === to) return 1.0;

            const pair = `${from}_${to}`;
            const rate = MOCK_RATES[pair];

            if (!rate) {
                // Fallback: If we have Rate(A->B) but not Rate(B->A), use 1/Rate(A->B)
                const inversePair = `${to}_${from}`;
                const inverseRate = MOCK_RATES[inversePair];
                if (inverseRate) return 1 / inverseRate;
                
                // Default fallback for development
                console.warn(`Exchange rate not found for ${pair}. Falling back to 1.0`);
                return 1.0;
            }

            return rate;
        });
    }

    /**
     * Converts an amount to the tenant's base currency.
     * @param amount The original amount
     * @param from The original currency
     * @param tenantId The tenant's ID to look up base currency
     */
    static async convertToBase(amount: number | Decimal, from: string, tenantId: string): Promise<Result<{ baseAmount: Decimal; rate: number; baseCurrency: string }>> {
        return Result.guard(async () => {
            const tenant = await prisma.tenant.findUnique({
                where: { id: tenantId },
                select: { baseCurrency: true }
            });

            const targetCurrency = tenant?.baseCurrency || 'CAD';
            const rateResult = await this.getExchangeRate(from, targetCurrency);
            
            // Accessing data through result.data will throw if it's a failure,
            // which is then caught by Result.guard and turned into a failure Result.
            const rate = rateResult.data;
            
            const numericAmount = typeof amount === 'number' ? amount : amount.toNumber();
            const baseAmount = new Decimal(numericAmount).mul(rate);

            return {
                baseAmount,
                rate,
                baseCurrency: targetCurrency
            };
        });
    }
}
