// T17 Financial Ledger: interfaces and data loading hook
import { useState, useEffect } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';

export interface JournalEntry {
    id: string;
    account: { code: string; name: string };
    debit: number;
    credit: number;
    balanceBefore: number;
    balanceAfter: number;
}

export interface FinancialTransaction {
    id: string;
    type: string;
    referenceId: string;
    amount: number;
    status: string;
    createdAt: string;
    journalEntries: JournalEntry[];
}

export interface AccountBalance {
    code: string;
    name: string;
    type: string;
    balance: number;
}

export function useLedgerData(showToast: (msg: string, type: string) => void) {
    const [transactions, setTransactions] = useState<FinancialTransaction[]>([]);
    const [balances, setBalances] = useState<AccountBalance[]>([]);
    const [loading, setLoading] = useState(true);
    const [pAndL, setPAndL] = useState<any>(null);
    const [balanceSheet, setBalanceSheet] = useState<any>(null);

    const loadData = async () => {
        setLoading(true);
        try {
            const [txRes, balRes, plRes, bsRes] = await Promise.all([
                apiClient.get('/platform/admin/financial'),
                apiClient.get('/platform/admin/financial/balances'),
                apiClient.get('/platform/admin/financial/reports/p-and-l'),
                apiClient.get('/platform/admin/financial/reports/balance-sheet')
            ]);
            if (txRes.ok) setTransactions(await txRes.json());
            if (balRes.ok) setBalances(await balRes.json());
            if (plRes.ok) setPAndL(await plRes.json());
            if (bsRes.ok) setBalanceSheet(await bsRes.json());
        } catch (error) {
            console.error('Failed to load financial data:', error);
        } finally {
            setLoading(false);
        }
    };

    const handleReconcile = async (invoiceTxId: string, paymentTxId: string) => {
        try {
            const res = await apiClient.post('/platform/admin/financial/reconcile', { invoiceTxId, paymentTxId });
            if (res.ok) { showToast('Successfully matched transactions', 'success'); loadData(); }
        } catch (error) {
            console.error('Reconciliation failed', error);
        }
    };

    useEffect(() => { loadData(); }, []);

    return { transactions, balances, loading, pAndL, balanceSheet, loadData, handleReconcile };
}
