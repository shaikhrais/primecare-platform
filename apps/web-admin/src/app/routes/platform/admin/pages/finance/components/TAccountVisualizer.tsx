import React, { useMemo } from 'react';
import { ArrowLeftRight, CheckCircle, AlertOctagon } from 'lucide-react';

interface LedgerEntry {
    id: string;
    account: string;
    description: string;
    debit: number | null;
    credit: number | null;
    timestamp: Date;
}

import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';

export const TAccountVisualizer: React.FC = () => {
    // TanStack Query: auto-cached financial ledger
    const { data: rawData = [], isLoading: loading } = useRegistryQuery<any[]>('/v1/system/financial', {
        queryKey: ['system', 'financial'],
        staleTime: 30_000,
    });

    // Flatten transaction journal entries into individual T-account entries
    const entries = useMemo(() => {
        const mappedEntries: LedgerEntry[] = [];
        rawData.forEach((tx: any) => {
            tx.journalEntries?.forEach((je: any) => {
                mappedEntries.push({
                    id: je.id,
                    account: `${je.account?.name || 'Unknown'} (${je.account?.code || '---'})`,
                    description: tx.description || 'System Entry',
                    debit: je.type === 'debit' ? je.amount : null,
                    credit: je.type === 'credit' ? je.amount : null,
                    timestamp: new Date(tx.createdAt)
                });
            });
        });
        return mappedEntries;
    }, [rawData]);

    const formatCurrency = (amount: number | null) => {
        if (amount === null) return '-';
        return new Intl.NumberFormat('en-US', { style: 'currency', currency: 'USD' }).format(amount);
    };

    const totalDebits = entries.reduce((sum, entry) => sum + (entry.debit || 0), 0);
    const totalCredits = entries.reduce((sum, entry) => sum + (entry.credit || 0), 0);
    const isBalanced = totalDebits === totalCredits;

    return (
        <div style={{ backgroundColor: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', fontFamily: 'monospace' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div>
                    <h2 data-cy="h2-admin.t-account-visualizer-0" style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0 0 8px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px', fontFamily: 'system-ui, sans-serif' }}>
                        <ArrowLeftRight color="#6366F1" /> Double-Entry Ledger Validation
                    </h2>
                    <p style={{ color: '#64748B', margin: 0, fontSize: '0.9rem', fontFamily: 'system-ui, sans-serif' }}>Live visualizer for debit/credit symmetry across isolated transactions.</p>
                </div>

                <div style={{ 
                    display: 'flex', alignItems: 'center', gap: '12px', padding: '12px 24px', borderRadius: '8px',
                    backgroundColor: isBalanced ? '#F0FDF4' : '#FEF2F2',
                    border: `1px solid ${isBalanced ? '#86EFAC' : '#FECACA'}`,
                    color: isBalanced ? '#16A34A' : '#DC2626',
                    fontWeight: 800, fontSize: '1.1rem'
                }}>
                    {isBalanced ? <CheckCircle size={20} /> : <AlertOctagon size={20} />}
                    {isBalanced ? 'BALANCE: VERIFIED' : 'BALANCE: MISMATCH'}
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '48px', marginTop: '32px' }}>
                
                {/* DEBITS COLUMN */}
                <div>
                    {loading && <div style={{ color: '#64748B', marginBottom: '16px' }}>Loading stream...</div>}
                    <div style={{ textAlign: 'center', fontWeight: 900, color: '#334155', borderBottom: '4px solid #6366F1', paddingBottom: '12px', marginBottom: '16px', fontSize: '1.1rem', letterSpacing: '2px' }}>
                        DEBITS (Dr)
                    </div>
                    
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                        {entries.filter(e => e.debit !== null).map(entry => (
                            <div key={`${entry.id}-dr`} style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', backgroundColor: '#F8FAFC', borderRadius: '8px', borderLeft: '4px solid #6366F1' }}>
                                <div>
                                    <div style={{ fontWeight: 700, color: '#0F172A' }}>{entry.account}</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{entry.description}</div>
                                </div>
                                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem' }}>
                                    {formatCurrency(entry.debit)}
                                </div>
                            </div>
                        ))}
                    </div>

                    <div style={{ marginTop: '24px', paddingTop: '16px', borderTop: '2px dashed #CBD5E1', display: 'flex', justifyContent: 'space-between', fontWeight: 900, fontSize: '1.25rem' }}>
                        <span>TOTAL DR:</span>
                        <span style={{ color: '#6366F1' }}>{formatCurrency(totalDebits)}</span>
                    </div>
                </div>

                {/* CREDITS COLUMN */}
                <div>
                    <div style={{ textAlign: 'center', fontWeight: 900, color: '#334155', borderBottom: '4px solid #F59E0B', paddingBottom: '12px', marginBottom: '16px', fontSize: '1.1rem', letterSpacing: '2px' }}>
                        CREDITS (Cr)
                    </div>
                    
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                        {entries.filter(e => e.credit !== null).map(entry => (
                            <div key={`${entry.id}-cr`} style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', backgroundColor: '#F8FAFC', borderRadius: '8px', borderRight: '4px solid #F59E0B' }}>
                                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem' }}>
                                    {formatCurrency(entry.credit)}
                                </div>
                                <div style={{ textAlign: 'right' }}>
                                    <div style={{ fontWeight: 700, color: '#0F172A' }}>{entry.account}</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>{entry.description}</div>
                                </div>
                            </div>
                        ))}
                    </div>

                    <div style={{ marginTop: '24px', paddingTop: '16px', borderTop: '2px dashed #CBD5E1', display: 'flex', justifyContent: 'space-between', fontWeight: 900, fontSize: '1.25rem' }}>
                        <span style={{ color: '#F59E0B' }}>{formatCurrency(totalCredits)}</span>
                        <span>:TOTAL CR</span>
                    </div>
                </div>

            </div>

            {/* Reconciliation Warning Layer */}
            {!isBalanced && (
               <div style={{ marginTop: '32px', backgroundColor: '#FEF2F2', border: '1px solid #EF4444', borderRadius: '8px', padding: '16px', color: '#991B1B', display: 'flex', alignItems: 'center', gap: '12px' }}>
                   <AlertOctagon />
                   <div>
                       <div style={{ fontWeight: 800 }}>Ledger Imbalance Detected ({formatCurrency(Math.abs(totalDebits - totalCredits))})</div>
                       <div style={{ fontSize: '0.9rem', marginTop: '4px' }}>Transaction pool is locked. A credit or debit is missing from the recent Equipment Expense posting. Contact System Administrator.</div>
                   </div>
               </div> 
            )}
        </div>
    );
};
