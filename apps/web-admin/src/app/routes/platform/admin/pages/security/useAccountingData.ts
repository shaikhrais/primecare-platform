// D3 — Accounting Dashboard: TypeScript interfaces and data loading hook
import { useState, useEffect } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';

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

export function useAccountingData(showToast: (msg: string, type: string) => void) {
    const [tradingAcc, setTradingAcc] = useState<TradingAccount | null>(null);
    const [pAndL, setPAndL] = useState<ProfitAndLoss | null>(null);
    const [balanceSheet, setBalanceSheet] = useState<BalanceSheet | null>(null);
    const [reconSummary, setReconSummary] = useState<{ unreconciledBankCount: number; unreconciledLedgerCount: number } | null>(null);
    const [forecastData, setForecastData] = useState<ForecastingResult | null>(null);
    const [loading, setLoading] = useState(true);

    const loadData = async () => {
        setLoading(true);
        try {
            const [taRes, plRes, bsRes, reconRes, forecastRes] = await Promise.all([
                apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.TRADING_ACCOUNT),
                apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.PROFIT_LOSS),
                apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.BALANCE_SHEET),
                apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.RECONCILIATION_SUMMARY),
                apiClient.get(ApiRegistry.PLATFORM.ADMIN.REPORTING.FORECAST)
            ]);
            if (taRes.ok) setTradingAcc(await taRes.json());
            if (plRes.ok) setPAndL(await plRes.json());
            if (bsRes.ok) setBalanceSheet(await bsRes.json());
            if (reconRes.ok) setReconSummary(await reconRes.json());
            if (forecastRes.ok) setForecastData(await forecastRes.json());
        } catch (error) {
            showToast('Failed to load accounting data', 'error');
            console.error('Failed to load accounting data:', error);
        } finally {
            setLoading(false);
        }
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

    useEffect(() => { loadData(); }, []);

    return { tradingAcc, pAndL, balanceSheet, reconSummary, forecastData, loading, loadData, handleAutoReconcile };
}
