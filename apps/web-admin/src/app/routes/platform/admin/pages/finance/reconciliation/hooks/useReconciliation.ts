import { useState } from 'react';
import { apiClient } from '../../../../../../../../shared/utils/apiClient';
import { useRegistryQuery } from '../../../../../../../../shared/hooks/useRegistryQuery';
import { useQueryClient } from '@tanstack/react-query';

export interface BankFeedItem {
    id: string;
    bankDate: string;
    description: string;
    amount: string | number;
    status: string;
}

export interface LedgerEntryItem {
    id: string;
    createdAt: string;
    type: string;
    referenceId: string;
    amount: string | number;
    status: string;
}

interface ReconciliationData {
    bankFeeds: BankFeedItem[];
    ledgerEntries: LedgerEntryItem[];
}

export function useReconciliation() {
    const queryClient = useQueryClient();
    const [matching, setMatching] = useState(false);

    // TanStack Query: auto-cached unmatched reconciliation data
    const { data, isLoading: loading } = useRegistryQuery<ReconciliationData>(
        '/v1/admin/financial/reconciliation/unmatched',
        {
            queryKey: ['admin', 'financial', 'reconciliation', 'unmatched'],
            staleTime: 15_000,
        }
    );

    const bankFeeds = data?.bankFeeds || [];
    const ledgerEntries = data?.ledgerEntries || [];

    const matchItems = async (bankTransactionId: string, ledgerTransactionId: string) => {
        setMatching(true);
        try {
            const res = await apiClient.post('/v1/admin/financial/reconciliation/match', {
                bankTransactionId,
                ledgerTransactionId
            });
            
            if (res.ok) {
                // Invalidate cache to refetch unmatched items
                queryClient.invalidateQueries({ queryKey: ['admin', 'financial', 'reconciliation', 'unmatched'] });
                return true;
            }
            return false;
        } catch (error) {
            console.error("Match failed", error);
            return false;
        } finally {
            setMatching(false);
        }
    };

    const refresh = () => queryClient.invalidateQueries({ queryKey: ['admin', 'financial', 'reconciliation', 'unmatched'] });

    return {
        bankFeeds,
        ledgerEntries,
        loading,
        matching,
        matchItems,
        refresh
    };
}
