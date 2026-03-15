// ================================================================
// PAGE IDENTITY: T59 � Reconciliation
// Type: Tool | Owner: admin
// ================================================================
import React from 'react';
import { useReconciliation } from './hooks/useReconciliation';
import { FuzzyMatcher } from './components/FuzzyMatcher';
import { RefreshCw, ShieldCheck } from 'lucide-react';

export default function FinancialReconciliation() {
    const { bankFeeds, ledgerEntries, loading, matchItems, refresh } = useReconciliation();

    return (
        <div data-cy="page.container" role="main" aria-label="Reconciliation" style={{ padding: '40px', background: '#0f172a', minHeight: '100vh', color: '#fff', fontFamily: "'Outfit', 'Inter', sans-serif" }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '48px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '32px', fontWeight: '900', letterSpacing: '-0.02em', margin: '0', display: 'flex', alignItems: 'center', gap: '16px' }}>
                        <ShieldCheck color="#4ade80" size={36} />
                        Financial Reconciliation Hub
                    </h1>
                    <p style={{ color: '#64748b', marginTop: '8px', fontSize: '14px', fontWeight: '600', maxWidth: '600px', lineHeight: 1.5 }}>
                        Verify the ledger against external reality. This engine flags imported banking transactions and uses deterministic fuzzy-logic to suggest corresponding internal double-entry invoice or payroll logs.
                    </p>
                </div>
                
                <button data-cy="btn-admin.reconciliation-0" 
                    onClick={refresh} 
                    disabled={loading}
                    style={{ background: 'rgba(255,255,255,0.05)', color: '#e2e8f0', border: '1px solid rgba(255,255,255,0.1)', padding: '12px 24px', borderRadius: '12px', fontSize: '0.85rem', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}
                >
                    <RefreshCw size={16} style={{ animation: loading ? 'spin 1s linear infinite' : 'none' }} /> 
                    {loading ? 'SYNCING...' : 'SYNC BANK FEEDS'}
                </button>
            </div>

            {loading && bankFeeds.length === 0 ? (
                <div style={{ padding: '60px', textAlign: 'center', color: '#64748b' }}>
                    <div className="loader" style={{ marginBottom: '24px' }}></div>
                    <div style={{ fontSize: '1rem', fontWeight: 600 }}>Pulling from Plaid/Yodlee Gateways...</div>
                </div>
            ) : bankFeeds.length === 0 ? (
                <div style={{ background: 'rgba(74, 222, 128, 0.05)', border: '1px solid rgba(74, 222, 128, 0.2)', borderRadius: '24px', padding: '60px', textAlign: 'center' }}>
                    <ShieldCheck size={64} color="#4ade80" style={{ margin: '0 auto 24px auto', opacity: 0.8 }} />
                    <h2 data-cy="h2-admin.reconciliation-0" style={{ fontSize: '24px', fontWeight: 800, color: '#f8fafc', marginBottom: '12px' }}>Ledger Perfectly Reconciled.</h2>
                    <p style={{ color: '#94a3b8', fontSize: '15px' }}>There are no unmatched bank feed transactions remaining. The ledger represents immutable reality.</p>
                </div>
            ) : (
                <div style={{ display: 'flex', flexDirection: 'column' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px', padding: '0 8px' }}>
                        <div style={{ fontSize: '0.9rem', color: '#94a3b8', fontWeight: 700, textTransform: 'uppercase' }}>
                            {bankFeeds.length} Items Require Reconciliation
                        </div>
                    </div>

                    {bankFeeds.map(feed => (
                        <FuzzyMatcher 
                            key={feed.id} 
                            bankTx={feed} 
                            // Only pass ledger entries that are of the same polarity (deposit = revenue/invoice, withdraw = expense)
                            ledgerCandidates={ledgerEntries.filter(l => 
                                (Number(feed.amount) > 0 && Number(l.amount) > 0) || 
                                (Number(feed.amount) < 0 && Number(l.amount) < 0)
                            )} 
                            onMatch={matchItems} 
                        />
                    ))}
                </div>
            )}

            <style>{`
                @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap');
                .loader { width: 48px; height: 48px; border: 5px solid rgba(255,255,255,0.1); border-bottom-color: #3b82f6; border-radius: 50%; display: inline-block; animation: rotation 1s linear infinite; }
                @keyframes rotation { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
                @keyframes spin { 100% { transform: rotate(360deg); } }
            `}</style>
        </div>
    );
}
