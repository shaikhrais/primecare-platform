import { PrismaClient } from '../../../generated/client';
import { Decimal } from 'Decimal.js';

export interface ForecastPoint {
    date: string;
    projectedCash: number;
}

export interface ForecastingResult {
    currentCash: number;
    avgDailyRevenue: number;
    avgDailyBurn: number;
    netDailyFlow: number;
    daysOfRunway: number | 'infinite';
    forecast: ForecastPoint[];
}

export class ForecastingService {
    constructor(private prisma: PrismaClient) { }

    async generateCashFlowForecast(tenantId: string, daysAhead: number = 90): Promise<ForecastingResult> {
        const now = new Date();
        const thirtyDaysAgo = new Date();
        thirtyDaysAgo.setDate(now.getDate() - 30);

        // 1. Calculate Current Cash (Sum of ASSET accounts)
        const accounts = await this.prisma.chartOfAccount.findMany({
            where: { tenantId, type: 'ASSET' },
            include: {
                journalEntries: true
            }
        });

        let currentCash = new Decimal(0);
        for (const acc of accounts) {
            for (const entry of acc.journalEntries) {
                currentCash = currentCash.plus(new Decimal(entry.debit as any)).minus(new Decimal(entry.credit as any));
            }
        }

        // 2. Calculate Historical Flows (Last 30 days)
        const historicalEntries = await this.prisma.journalEntry.findMany({
            where: {
                tenantId,
                createdAt: { gte: thirtyDaysAgo }
            },
            include: {
                account: true
            }
        });

        let totalRevenue = new Decimal(0);
        let totalExpense = new Decimal(0);

        for (const entry of historicalEntries) {
            if (entry.account.type === 'REVENUE') {
                // Revenue: Credit increases
                totalRevenue = totalRevenue.plus(new Decimal(entry.credit as any)).minus(new Decimal(entry.debit as any));
            } else if (entry.account.type === 'EXPENSE') {
                // Expense: Debit increases
                totalExpense = totalExpense.plus(new Decimal(entry.debit as any)).minus(new Decimal(entry.credit as any));
            }
        }

        const avgDailyRevenue = totalRevenue.dividedBy(30);
        const avgDailyBurn = totalExpense.dividedBy(30);
        const netDailyFlow = avgDailyRevenue.minus(avgDailyBurn);

        // 3. Calculate Runway
        let daysOfRunway: number | 'infinite' = 'infinite';
        if (netDailyFlow.isNegative()) {
            const burnRate = netDailyFlow.abs();
            daysOfRunway = currentCash.dividedBy(burnRate).toNumber();
        }

        // 4. Generate 90-day Forecast
        const forecast: ForecastPoint[] = [];
        for (let i = 0; i <= daysAhead; i++) {
            const forecastDate = new Date();
            forecastDate.setDate(now.getDate() + i);

            const projectedCash = currentCash.plus(netDailyFlow.times(i));

            forecast.push({
                date: forecastDate.toISOString().split('T')[0],
                projectedCash: Math.max(0, projectedCash.toNumber())
            });
        }

        return {
            currentCash: currentCash.toNumber(),
            avgDailyRevenue: avgDailyRevenue.toNumber(),
            avgDailyBurn: avgDailyBurn.toNumber(),
            netDailyFlow: netDailyFlow.toNumber(),
            daysOfRunway: daysOfRunway === 'infinite' ? 'infinite' : Math.floor(daysOfRunway),
            forecast
        };
    }
}
