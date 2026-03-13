import React, { useState } from 'react';
import { BankFeedItem, LedgerEntryItem } from '../hooks/useReconciliation';
import { AlertCircle, ArrowRightLeft, CheckCircle2, Search } from 'lucide-react';

interface Props {
    bankTx: BankFeedItem;
    ledgerCandidates: LedgerEntryItem[];
    onMatch: (bankTxId: string, ledgerTxId: string) => Promise<boolean>;
}

export const FuzzyMatcher: React.FC<Props> = ({ bankTx, ledgerCandidates, onMatch }) => {
    const [matching, setMatching] = useState(false);

    // Naive fuzzy score logic based on amount diff
    const getConfidenceScore = (ledger: LedgerEntryItem) => {
        const bankAmt = Math.abs(Number(bankTx.amount));
        const ledgerAmt = Math.abs(Number(ledger.amount));
        const diff = Math.abs(bankAmt - ledgerAmt);
        
        if (diff === 0) return 99; // Perfect amount match
        if (diff <= 5) return 85;  // Slight FX or fee difference
        return 0; // Not a good match
    };

    const sortedCandidates = [...ledgerCandidates]
        .map(c => ({ ...c, score: getConfidenceScore(c) }))
        .sort((a, b) => b.score - a.score)
        .slice(0, 3); // Top 3 candidates

    const topCandidate = sortedCandidates[0];
    const isHighConfidence = topCandidate && topCandidate.score > 90;

    const handleMatch = async (ledgerId: string) => {
        setMatching(true);
        await onMatch(bankTx.id, ledgerId);
        setMatching(false);
    };

    return (
        <div style={{ background: 'rgba(30, 41, 59, 0.7)', borderRadius: '16px', border: '1px solid rgba(255,255,255,0.05)', padding: '24px', marginBottom: '24px', display: 'flex', gap: '32px', alignItems: 'stretch' }}>
            
            {/* Left Side: Bank Statement */}
            <div style={{ flex: 1, borderRight: '1px solid rgba(255,255,255,0.1)', paddingRight: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                    <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#38bdf8' }}></div>
                    <span style={{ color: '#94a3b8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.05em' }}>External Bank Feed</span>
                </div>
                
                <h3 data-cy="h3-admin.fuzzy-matcher-0" style={{ fontSize: '1.2rem', fontWeight: 700, margin: 0, color: '#f8fafc', marginBottom: '8px' }}>
                    {bankTx.description || 'Unknown Electronic Deposit'}
                </h3>
                
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginTop: '16px' }}>
                    <div style={{ color: '#94a3b8', fontSize: '0.85rem' }}>{new Date(bankTx.bankDate).toLocaleDateString()}</div>
                    <div style={{ fontSize: '1.4rem', fontWeight: 900, color: Number(bankTx.amount) > 0 ? '#4ade80' : '#f87171' }}>
                        ${Math.abs(Number(bankTx.amount)).toFixed(2)}
                    </div>
                </div>
            </div>

            {/* Middle: Connector */}
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <div style={{ background: 'rgba(255,255,255,0.05)', padding: '12px', borderRadius: '50%', border: '1px solid rgba(255,255,255,0.1)' }}>
                    <ArrowRightLeft color="#64748b" size={24} />
                </div>
            </div>

            {/* Right Side: Ledger Match */}
            <div style={{ flex: 1 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '16px' }}>
                     <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: '#a78bfa' }}></div>
                    <span style={{ color: '#94a3b8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '0.05em' }}>Internal Ledger Candidates</span>
                </div>

                {sortedCandidates.length === 0 ? (
                    <div style={{ padding: '16px', background: 'rgba(255,255,255,0.02)', borderRadius: '12px', textAlign: 'center', color: '#64748b', fontSize: '0.85rem' }}>
                        <Search size={24} style={{ margin: '0 auto 8px auto', opacity: 0.5 }} />
                        No posted ledger transactions found nearby.
                    </div>
                ) : (
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                        {sortedCandidates.map((ledger, idx) => (
                            <div key={ledger.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '12px 16px', background: idx === 0 && isHighConfidence ? 'rgba(74, 222, 128, 0.05)' : 'rgba(255,255,255,0.02)', border: `1px solid ${idx === 0 && isHighConfidence ? 'rgba(74, 222, 128, 0.2)' : 'rgba(255,255,255,0.05)'}`, borderRadius: '12px' }}>
                                <div>
                                    <div style={{ fontSize: '0.9rem', fontWeight: 700, color: '#e2e8f0' }}>{ledger.type} #{ledger.referenceId}</div>
                                    <div style={{ fontSize: '0.75rem', color: '#64748b', marginTop: '4px' }}>${Math.abs(Number(ledger.amount)).toFixed(2)} • {new Date(ledger.createdAt).toLocaleDateString()}</div>
                                </div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                                    <div style={{ fontSize: '0.7re', fontWeight: 800, color: ledger.score > 90 ? '#4ade80' : '#fbbf24', background: ledger.score > 90 ? 'rgba(74,222,128,0.1)' : 'rgba(251,191,36,0.1)', padding: '4px 8px', borderRadius: '4px' }}>
                                        {ledger.score}% MATCH
                                    </div>
                                    <button data-cy="btn-admin.fuzzy-matcher-0" 
                                        onClick={() => handleMatch(ledger.id)}
                                        disabled={matching}
                                        style={{ background: '#3b82f6', color: '#fff', border: 'none', padding: '6px 12px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                                    >
                                        <CheckCircle2 size={14} /> POST
                                    </button>
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </div>
    );
}
