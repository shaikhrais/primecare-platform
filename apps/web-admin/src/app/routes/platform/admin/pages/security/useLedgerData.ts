// T17 Financial Ledger: interfaces and data loading hook
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { useRegistryQuery } from '../../../../../../shared/hooks/useRegistryQuery';
import { useQueryClient } from '@tanstack/react-query';

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

const LEDGER_QK = ['platform', 'admin', 'financial'];

export function useLedgerData(showToast: (msg: string, type: string) => void) {
    const queryClient = useQueryClient();

    // 4 parallel useRegistryQuery hooks (React Query fetches them independently & in parallel)
    const { data: transactions = [], isLoading: txLoading } = useRegistryQuery<FinancialTransaction[]>(
        '/platform/admin/financial',
        { queryKey: [...LEDGER_QK, 'transactions'], staleTime: 30_000 }
    );

    const { data: balances = [], isLoading: balLoading } = useRegistryQuery<AccountBalance[]>(
        '/platform/admin/financial/balances',
        { queryKey: [...LEDGER_QK, 'balances'], staleTime: 30_000 }
    );

    const { data: pAndL = null, isLoading: plLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/p-and-l',
        { queryKey: [...LEDGER_QK, 'p-and-l'], staleTime: 60_000 }
    );

    const { data: balanceSheet = null, isLoading: bsLoading } = useRegistryQuery<any>(
        '/platform/admin/financial/reports/balance-sheet',
        { queryKey: [...LEDGER_QK, 'balance-sheet'], staleTime: 60_000 }
    );

    const loading = txLoading || balLoading || plLoading || bsLoading;

    const loadData = () => {
        queryClient.invalidateQueries({ queryKey: LEDGER_QK });
    };

    const handleReconcile = async (invoiceTxId: string, paymentTxId: string) => {
        try {
            const res = await apiClient.post('/platform/admin/financial/reconcile', { invoiceTxId, paymentTxId });
            if (res.ok) { showToast('Successfully matched transactions', 'success'); loadData(); }
        } catch (error) {
            console.error('Reconciliation failed', error);
        }
    };

    return { transactions, balances, loading, pAndL, balanceSheet, loadData, handleReconcile };
}
