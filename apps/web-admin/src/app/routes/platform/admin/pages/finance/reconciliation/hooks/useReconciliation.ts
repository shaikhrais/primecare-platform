import { useState, useEffect } from 'react';
import { apiClient } from '../../../../../../../../shared/utils/apiClient';

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

export function useReconciliation() {
    const [bankFeeds, setBankFeeds] = useState<BankFeedItem[]>([]);
    const [ledgerEntries, setLedgerEntries] = useState<LedgerEntryItem[]>([]);
    const [loading, setLoading] = useState(true);
    const [matching, setMatching] = useState(false);

    const loadData = async () => {
        setLoading(true);
        try {
            // Note: ApiRegistry doesn't have RECONCILIATION yet, using direct path
            const res = await apiClient.get('/v1/admin/financial/reconciliation/unmatched');
            if (res.ok) {
                const data = await res.json();
                setBankFeeds(data.bankFeeds || []);
                setLedgerEntries(data.ledgerEntries || []);
            }
        } catch (error) {
            console.error("Failed to load unmatched items", error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    const matchItems = async (bankTransactionId: string, ledgerTransactionId: string) => {
        setMatching(true);
        try {
            const res = await apiClient.post('/v1/admin/financial/reconciliation/match', {
                bankTransactionId,
                ledgerTransactionId
            });
            
            if (res.ok) {
                // Remove matched items from state
                setBankFeeds(prev => prev.filter(f => f.id !== bankTransactionId));
                setLedgerEntries(prev => prev.filter(l => l.id !== ledgerTransactionId));
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

    return {
        bankFeeds,
        ledgerEntries,
        loading,
        matching,
        matchItems,
        refresh: loadData
    };
}
