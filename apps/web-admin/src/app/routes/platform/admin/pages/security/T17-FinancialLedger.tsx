// ================================================================
// PAGE IDENTITY: T17 · Financial Ledger
// Registry ID:   page.admin.financial-ledger
// Type:          Tool
// Owner:         admin
// ================================================================
import React, { useEffect, useState } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';

interface JournalEntry {
    id: string;
    account: {
        code: string;
        name: string;
    };
    debit: number;
    credit: number;
    balanceBefore: number;
    balanceAfter: number;
}

interface FinancialTransaction {
    id: string;
    type: string;
    referenceId: string;
    amount: number;
    status: string;
    createdAt: string;
    journalEntries: JournalEntry[];
}

interface AccountBalance {
    code: string;
    name: string;
    type: string;
    balance: number;
}

export default function FinancialLedger() {
    const [transactions, setTransactions] = useState<FinancialTransaction[]>([]);
    const [balances, setBalances] = useState<AccountBalance[]>([]);
    const [loading, setLoading] = useState(true);
    const [activeTab, setActiveTab] = useState<'ledger' | 'reconciliation' | 'reports'>('ledger');
    const [expandedTx, setExpandedTx] = useState<string | null>(null);
    const [pAndL, setPAndL] = useState<any>(null);
    const [balanceSheet, setBalanceSheet] = useState<any>(null);
    const { showToast } = useNotification();

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

    useEffect(() => {
        loadData();
    }, []);

    const handleReconcile = async (invoiceTxId: string, paymentTxId: string) => {
        try {
            const res = await apiClient.post('/platform/admin/financial/reconcile', { invoiceTxId, paymentTxId });
            if (res.ok) {
                showToast('Successfully matched transactions', 'success');
                loadData();
            }
        } catch (error) {
            console.error('Reconciliation failed', error);
        }
    };

    if (loading) return <div style={{ padding: '24px' }}>Syncing financial engine...</div>;

    const cashBalance = balances.find(b => b.code === '1000')?.balance || 0;
    const arBalance = balances.find(b => b.code === '1100')?.balance || 0;
    const revenue = balances.filter(b => b.type === 'REVENUE').reduce((sum, b) => sum + b.balance, 0);

    return (
        <div className="pc-page" style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', color: '#111827' }}>Financial Command Center</h1>
                    <p style={{ color: '#6B7280', fontSize: '16px' }}>Advanced ledger matching, real-time balances, and GAAP reporting.</p>
                </div>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <button className="btn secondary" onClick={loadData}>Refresh Data</button>
                    <button className="btn primary">Export Ledger</button>
                </div>
            </div>

            {/* Quick Balance Dashboard */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '20px', backgroundColor: '#F0F9FF', border: '1px solid #BAE6FD' }}>
                    <div style={{ color: '#0369A1', fontSize: '11px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Cash Position</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>${cashBalance.toLocaleString()}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px', backgroundColor: '#F0FDF4', border: '1px solid #BBF7D0' }}>
                    <div style={{ color: '#15803D', fontSize: '11px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Accounts Receivable</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>${arBalance.toLocaleString()}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px', backgroundColor: '#FFF7ED', border: '1px solid #FED7AA' }}>
                    <div style={{ color: '#9A3412', fontSize: '11px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Total Revenue</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px' }}>${revenue.toLocaleString()}</div>
                </div>
                <div className="pc-card" style={{ padding: '20px', backgroundColor: '#FAF5FF', border: '1px solid #E9D5FF' }}>
                    <div style={{ color: '#6B21A8', fontSize: '11px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.05em' }}>Net Income</div>
                    <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px', color: (pAndL?.netIncome >= 0 ? '#166534' : '#991B1B') }}>
                        ${pAndL?.netIncome?.toLocaleString() || 0}
                    </div>
                </div>
            </div>

            {/* Navigation Tabs */}
            <div style={{ display: 'flex', gap: '32px', borderBottom: '1px solid #E5E7EB', marginBottom: '24px' }}>
                {['ledger', 'reconciliation', 'reports'].map(tab => (
                    <button
                        key={tab}
                        onClick={() => setActiveTab(tab as any)}
                        style={{
                            padding: '12px 4px',
                            fontSize: '14px',
                            fontWeight: '700',
                            borderBottom: activeTab === tab ? '2px solid #2563EB' : '2px solid transparent',
                            color: activeTab === tab ? '#2563EB' : '#6B7280',
                            background: 'none',
                            border: 'none',
                            cursor: 'pointer',
                            textTransform: 'uppercase',
                            letterSpacing: '0.025em'
                        }}
                    >
                        {tab}
                    </button>
                ))}
            </div>

            {/* Tab Secret Content */}
            {activeTab === 'ledger' && (
                <div className="pc-card" style={{ padding: '0px', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                            <tr>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Date</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Type</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Reference</th>
                                <th style={{ textAlign: 'right', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Amount</th>
                                <th style={{ textAlign: 'center', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Status</th>
                                <th style={{ width: '100px' }}></th>
                            </tr>
                        </thead>
                        <tbody>
                            {transactions.map(tx => (
                                <React.Fragment key={tx.id}>
                                    <tr style={{ borderBottom: '1px solid #F3F4F6' }}>
                                        <td style={{ padding: '16px', fontSize: '13px' }}>{new Date(tx.createdAt).toLocaleDateString()}</td>
                                        <td style={{ padding: '16px' }}>
                                            <span style={{ fontSize: '10px', fontWeight: '800', padding: '2px 6px', background: '#E5E7EB', borderRadius: '4px' }}>{tx.type}</span>
                                        </td>
                                        <td style={{ padding: '16px', fontSize: '13px', color: '#6B7280', fontFamily: 'monospace' }}>{tx.referenceId}</td>
                                        <td style={{ padding: '16px', textAlign: 'right', fontWeight: '700' }}>${Number(tx.amount).toFixed(2)}</td>
                                        <td style={{ padding: '16px', textAlign: 'center' }}>
                                            <span style={{
                                                fontSize: '10px',
                                                fontWeight: '900',
                                                padding: '4px 10px',
                                                borderRadius: '12px',
                                                background: tx.status === 'reconciled' ? '#DCFCE7' : tx.status === 'matched' ? '#DBEAFE' : '#FEF9C3',
                                                color: tx.status === 'reconciled' ? '#166534' : tx.status === 'matched' ? '#1E40AF' : '#854D0E',
                                                textTransform: 'uppercase'
                                            }}>{tx.status}</span>
                                        </td>
                                        <td style={{ padding: '16px', textAlign: 'right' }}>
                                            <button className="btn secondary sm" onClick={() => setExpandedTx(expandedTx === tx.id ? null : tx.id)}>Inspect</button>
                                        </td>
                                    </tr>
                                    {expandedTx === tx.id && (
                                        <tr style={{ background: '#F8FAFC' }}>
                                            <td colSpan={6} style={{ padding: '24px' }}>
                                                <div style={{ background: '#fff', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '20px' }}>
                                                    <h4 style={{ fontSize: '12px', fontWeight: '900', marginBottom: '16px', textTransform: 'uppercase', color: '#64748B' }}>Audit Trail & Ledger Impact</h4>
                                                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                                                        <thead>
                                                            <tr style={{ borderBottom: '1px solid #F1F5F9' }}>
                                                                <th style={{ textAlign: 'left', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Account</th>
                                                                <th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Before</th>
                                                                <th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Change (Dr/Cr)</th>
                                                                <th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>After</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            {tx.journalEntries.map(entry => {
                                                                const change = Number(entry.debit) - Number(entry.credit);
                                                                return (
                                                                    <tr key={entry.id} style={{ borderBottom: '1px solid #F9FAFB' }}>
                                                                        <td style={{ padding: '12px', fontSize: '13px', fontWeight: '600' }}>{entry.account.name}</td>
                                                                        <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', color: '#64748B' }}>${Number(entry.balanceBefore).toFixed(2)}</td>
                                                                        <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', fontWeight: '700', color: change > 0 ? '#10B981' : '#EF4444' }}>
                                                                            {change > 0 ? `+${change.toFixed(2)}` : `${change.toFixed(2)}`}
                                                                        </td>
                                                                        <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', fontWeight: '700' }}>${Number(entry.balanceAfter).toFixed(2)}</td>
                                                                    </tr>
                                                                );
                                                            })}
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    )}
                                </React.Fragment>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {activeTab === 'reconciliation' && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    <div className="pc-card">
                        <div className="pc-card-h">Unmatched Invoices</div>
                        <div className="pc-card-b">
                            {transactions.filter(t => t.type === 'INVOICE' && t.status === 'posted').map(tx => (
                                <div key={tx.id} style={{ padding: '12px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                    <div>
                                        <div style={{ fontWeight: '700' }}>INV: {tx.referenceId}</div>
                                        <div style={{ fontSize: '11px', color: '#6B7280' }}>ID: {tx.id.substring(0, 8)}</div>
                                    </div>
                                    <div style={{ fontWeight: '800' }}>${Number(tx.amount).toFixed(2)}</div>
                                </div>
                            ))}
                        </div>
                    </div>
                    <div className="pc-card">
                        <div className="pc-card-h">Recent Payments</div>
                        <div className="pc-card-b">
                            {transactions.filter(t => t.type === 'PAYMENT' && t.status === 'posted').map(tx => (
                                <div key={tx.id} style={{ padding: '12px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                    <div>
                                        <div style={{ fontWeight: '700' }}>PAYMENT: {tx.referenceId}</div>
                                        <div style={{ fontSize: '11px', color: '#6B7280' }}>ID: {tx.id.substring(0, 8)}</div>
                                    </div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                        <div style={{ fontWeight: '800' }}>${Number(tx.amount).toFixed(2)}</div>
                                        <button className="btn secondary sm" onClick={() => handleReconcile(transactions.find(inv => inv.type === 'INVOICE' && Number(inv.amount) === Number(tx.amount))?.id || '', tx.id)}>Auto-Match</button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            )}

            {activeTab === 'reports' && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    {/* Income Statement */}
                    {pAndL && (
                        <div className="pc-card">
                            <div className="pc-card-h" style={{ textAlign: 'center' }}>
                                <div style={{ fontSize: '16px', fontWeight: '800' }}>Profit & Loss Statement</div>
                                <div style={{ fontSize: '10px', color: '#94A3B8' }}>Period: {new Date(pAndL.period.startDate).toLocaleDateString()} - {new Date(pAndL.period.endDate).toLocaleDateString()}</div>
                            </div>
                            <div className="pc-card-b" style={{ padding: '24px' }}>
                                <section style={{ marginBottom: '24px' }}>
                                    <h3 style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #E2E8F0', paddingBottom: '4px', marginBottom: '12px' }}>Revenue</h3>
                                    {Object.entries(pAndL.breakdown.revenue || {}).map(([name, amount]: any) => (
                                        <div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}>
                                            <span>{name}</span>
                                            <span style={{ fontWeight: '700' }}>${Number(amount).toFixed(2)}</span>
                                        </div>
                                    ))}
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}>
                                        <span>Total Revenue</span>
                                        <span>${Number(pAndL.totalRevenue).toFixed(2)}</span>
                                    </div>
                                </section>
                                <section style={{ marginBottom: '24px' }}>
                                    <h3 style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #E2E8F0', paddingBottom: '4px', marginBottom: '12px' }}>Expenses</h3>
                                    {Object.entries(pAndL.breakdown.expenses || {}).map(([name, amount]: any) => (
                                        <div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}>
                                            <span>{name}</span>
                                            <span style={{ fontWeight: '700' }}>(${Number(amount).toFixed(2)})</span>
                                        </div>
                                    ))}
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}>
                                        <span>Total Expenses</span>
                                        <span>(${Number(pAndL.totalExpenses).toFixed(2)})</span>
                                    </div>
                                </section>
                                <div style={{ background: '#F8FAFC', padding: '12px', borderRadius: '8px', display: 'flex', justifyContent: 'space-between', fontWeight: '900', fontSize: '16px', border: '1px solid #E2E8F0' }}>
                                    <span>NET INCOME</span>
                                    <span style={{ color: pAndL.netIncome >= 0 ? '#10B981' : '#EF4444' }}>${Number(pAndL.netIncome).toFixed(2)}</span>
                                </div>
                            </div>
                        </div>
                    )}

                    {/* Balance Sheet */}
                    {balanceSheet && (
                        <div className="pc-card">
                            <div className="pc-card-h" style={{ textAlign: 'center' }}>
                                <div style={{ fontSize: '16px', fontWeight: '800' }}>Balance Sheet</div>
                                <div style={{ fontSize: '10px', color: '#94A3B8' }}>As of {new Date(balanceSheet.date).toLocaleDateString()}</div>
                            </div>
                            <div className="pc-card-b" style={{ padding: '24px' }}>
                                <section style={{ marginBottom: '24px' }}>
                                    <h3 style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #BAE6FD', paddingBottom: '4px', marginBottom: '12px' }}>Assets</h3>
                                    {Object.entries(balanceSheet.assets.accounts || {}).map(([name, amount]: any) => (
                                        <div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}>
                                            <span>{name}</span>
                                            <span style={{ fontWeight: '700' }}>${Number(amount).toFixed(2)}</span>
                                        </div>
                                    ))}
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}>
                                        <span>Total Assets</span>
                                        <span>${Number(balanceSheet.assets.total).toFixed(2)}</span>
                                    </div>
                                </section>
                                <section style={{ marginBottom: '24px' }}>
                                    <h3 style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #FED7AA', paddingBottom: '4px', marginBottom: '12px' }}>Liabilities</h3>
                                    {Object.entries(balanceSheet.liabilities.accounts || {}).map(([name, amount]: any) => (
                                        <div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}>
                                            <span>{name}</span>
                                            <span style={{ fontWeight: '700' }}>${Number(amount).toFixed(2)}</span>
                                        </div>
                                    ))}
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}>
                                        <span>Total Liabilities</span>
                                        <span>${Number(balanceSheet.liabilities.total).toFixed(2)}</span>
                                    </div>
                                </section>
                                <section style={{ marginBottom: '24px' }}>
                                    <h3 style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #E9D5FF', paddingBottom: '4px', marginBottom: '12px' }}>Equity</h3>
                                    {Object.entries(balanceSheet.equity.accounts || {}).map(([name, amount]: any) => (
                                        <div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}>
                                            <span>{name}</span>
                                            <span style={{ fontWeight: '700' }}>${Number(amount).toFixed(2)}</span>
                                        </div>
                                    ))}
                                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}>
                                        <span>Total Equity</span>
                                        <span>${Number(balanceSheet.equity.total).toFixed(2)}</span>
                                    </div>
                                </section>
                                <div style={{ background: '#F8FAFC', padding: '12px', borderRadius: '8px', display: 'flex', justifyContent: 'space-between', fontWeight: '900', fontSize: '16px', border: '1px solid #E2E8F0' }}>
                                    <span>L + E Total</span>
                                    <span>${(Number(balanceSheet.liabilities.total) + Number(balanceSheet.equity.total)).toFixed(2)}</span>
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            )}
        </div>
    );
}
