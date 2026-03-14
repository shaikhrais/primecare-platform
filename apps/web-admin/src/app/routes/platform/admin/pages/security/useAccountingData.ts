// D3 — Accounting Dashboard: TypeScript interfaces and data loading hook
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';
import { useRegistryQuery } from '../../../../../../shared/hooks/useRegistryQuery';
import { useQueryClient } from '@tanstack/react-query';

const { ApiRegistry } = AdminRegistry;

export interface TradingAccount {
    revenue: number;
    directCosts: number;
    grossProfit: number;
    grossProfitMargin: number;
    breakdown: { revenue: Record<string, number>; directCosts: Record<string, number> };
}

export interface ProfitAndLoss {
    operatingExpenses: number;
    netIncome: number;
    breakdown: { indirectExpenses: Record<string, number> };
}

export interface BalanceSheet {
    date: string;
    assets: { total: number; accounts: Record<string, number> };
    liabilities: { total: number; accounts: Record<string, number> };
    equity: { total: number; accounts: Record<string, number> };
}

export interface ForecastPoint { date: string; projectedCash: number; }

export interface ForecastingResult {
    currentCash: number;
    avgDailyRevenue: number;
    avgDailyBurn: number;
    netDailyFlow: number;
    daysOfRunway: number | 'infinite';
    forecast: ForecastPoint[];
}

const ACCOUNTING_QK = ['platform', 'admin', 'reporting'];

export function useAccountingData(showToast: (msg: string, type: string) => void) {
    const queryClient = useQueryClient();

    // 5 parallel useRegistryQuery hooks (React Query fetches independently & in parallel)
    const { data: tradingAcc = null, isLoading: taLoading } = useRegistryQuery<TradingAccount>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT,
        { queryKey: [...ACCOUNTING_QK, 'trading-account'], staleTime: 60_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<ProfitAndLoss>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.PROFIT_LOSS,
        { queryKey: [...ACCOUNTING_QK, 'profit-loss'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<BalanceSheet>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.BALANCE_SHEET,
        { queryKey: [...ACCOUNTING_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const { data: reconSummary = null, isLoading: reconLoading } = useRegistryQuery<{ unreconciledBankCount: number; unreconciledLedgerCount: number }>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.RECONCILIATION_SUMMARY,
        { queryKey: [...ACCOUNTING_QK, 'reconciliation-summary'], staleTime: 30_000 }
    );

    const { data: forecastData = null, isLoading: fcLoading } = useRegistryQuery<ForecastingResult>(
        ApiRegistry.PLATFORM.ADMIN.REPORTING.FORECAST,
        { queryKey: [...ACCOUNTING_QK, 'forecast'], staleTime: 60_000 }
    );

    const loading = taLoading || plLoading || bsLoading || reconLoading || fcLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: ACCOUNTING_QK });
    };

    const handleAutoReconcile = async () => {
        try {
            const res = await apiClient.post(ApiRegistry.PLATFORM.ADMIN.REPORTING.AUTO_RECONCILE, {});
            if (res.ok) {
                const data = await res.json();
                showToast(`Successfully matched ${data.matchedCount} transactions!`, 'success');
                loadData();
            }
        } catch (error) {
            showToast('Auto-reconciliation failed', 'error');
            console.error('Auto-reconciliation failed:', error);
        }
    };

    return { tradingAcc, pAndL, balanceSheet, reconSummary, forecastData, loading, loadData, handleAutoReconcile };
}
