// ================================================================
// PAGE IDENTITY: T17 — Financial Ledger
// Registry ID:   page.admin.financial-ledger
// Type:          Tool
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useLedgerData } from './useLedgerData';

export default function FinancialLedger() {
    const { showToast } = useNotification();
    const { transactions, balances, loading, pAndL, balanceSheet, loadData, handleReconcile } = useLedgerData(showToast);
    const [activeTab, setActiveTab] = useState<'ledger' | 'reconciliation' | 'reports'>('ledger');
    const [expandedTx, setExpandedTx] = useState<string | null>(null);

    if (loading) return <div style={{ padding: '24px' }}>Syncing financial engine...</div>;

    const cashBalance = balances.find(b => b.code === '1000')?.balance || 0;
    const arBalance = balances.find(b => b.code === '1100')?.balance || 0;
    const revenue = balances.filter(b => b.type === 'REVENUE').reduce((sum, b) => sum + b.balance, 0);

    return (
        <div data-cy="page.container" role="main" aria-label="Financial Ledger" className="pc-page" style={{ padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }}>
                <div><h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', color: '#111827' }}>Financial Command Center</h1><p style={{ color: '#6B7280', fontSize: '16px' }}>Advanced ledger matching, real-time balances, and GAAP reporting.</p></div>
                <div style={{ display: 'flex', gap: '8px' }}><button data-cy="btn-admin.financial-ledger-0" className="btn secondary" onClick={loadData}>Refresh Data</button><button data-cy="btn-admin.financial-ledger-1" className="btn primary">Export Ledger</button></div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '16px', marginBottom: '32px' }}>
                {[{ label: 'Cash Position', value: cashBalance, bg: '#F0F9FF', border: '#BAE6FD', color: '#0369A1' },
                  { label: 'Accounts Receivable', value: arBalance, bg: '#F0FDF4', border: '#BBF7D0', color: '#15803D' },
                  { label: 'Total Revenue', value: revenue, bg: '#FFF7ED', border: '#FED7AA', color: '#9A3412' },
                  { label: 'Net Income', value: pAndL?.netIncome || 0, bg: '#FAF5FF', border: '#E9D5FF', color: '#6B21A8', valueColor: (pAndL?.netIncome >= 0 ? '#166534' : '#991B1B') }
                ].map((card, i) => (
                    <div key={i} className="pc-card" style={{ padding: '20px', backgroundColor: card.bg, border: `1px solid ${card.border}` }}>
                        <div style={{ color: card.color, fontSize: '11px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.05em' }}>{card.label}</div>
                        <div style={{ fontSize: '24px', fontWeight: '800', marginTop: '4px', color: (card as any).valueColor }}>${card.value.toLocaleString()}</div>
                    </div>
                ))}
            </div>

            <div style={{ display: 'flex', gap: '32px', borderBottom: '1px solid #E5E7EB', marginBottom: '24px' }}>
                {['ledger', 'reconciliation', 'reports'].map(tab => (
                    <button data-cy="btn-admin.financial-ledger-2" key={tab} onClick={() => setActiveTab(tab as any)}
                        style={{ padding: '12px 4px', fontSize: '14px', fontWeight: '700', borderBottom: activeTab === tab ? '2px solid #2563EB' : '2px solid transparent', color: activeTab === tab ? '#2563EB' : '#6B7280', background: 'none', border: 'none', cursor: 'pointer', textTransform: 'uppercase', letterSpacing: '0.025em' }}>{tab}</button>
                ))}
            </div>

            {activeTab === 'ledger' && (
                <div className="pc-card" style={{ padding: '0px', overflow: 'hidden' }}>
                    <table data-cy="table-admin.financial-ledger" style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}><tr>
                            <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Date</th>
                            <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Type</th>
                            <th style={{ textAlign: 'left', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Reference</th>
                            <th style={{ textAlign: 'right', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Amount</th>
                            <th style={{ textAlign: 'center', padding: '16px', fontSize: '11px', fontWeight: '800', color: '#6B7280', textTransform: 'uppercase' }}>Status</th>
                            <th style={{ width: '100px' }}></th>
                        </tr></thead>
                        <tbody>
                            {transactions.map(tx => (
                                <React.Fragment key={tx.id}>
                                    <tr style={{ borderBottom: '1px solid #F3F4F6' }}>
                                        <td style={{ padding: '16px', fontSize: '13px' }}>{new Date(tx.createdAt).toLocaleDateString()}</td>
                                        <td style={{ padding: '16px' }}><span style={{ fontSize: '10px', fontWeight: '800', padding: '2px 6px', background: '#E5E7EB', borderRadius: '4px' }}>{tx.type}</span></td>
                                        <td style={{ padding: '16px', fontSize: '13px', color: '#6B7280', fontFamily: 'monospace' }}>{tx.referenceId}</td>
                                        <td style={{ padding: '16px', textAlign: 'right', fontWeight: '700' }}>${Number(tx.amount).toFixed(2)}</td>
                                        <td style={{ padding: '16px', textAlign: 'center' }}><span style={{ fontSize: '10px', fontWeight: '900', padding: '4px 10px', borderRadius: '12px', background: tx.status === 'reconciled' ? '#DCFCE7' : tx.status === 'matched' ? '#DBEAFE' : '#FEF9C3', color: tx.status === 'reconciled' ? '#166534' : tx.status === 'matched' ? '#1E40AF' : '#854D0E', textTransform: 'uppercase' }}>{tx.status}</span></td>
                                        <td style={{ padding: '16px', textAlign: 'right' }}><button data-cy="btn-admin.financial-ledger-3" className="btn secondary sm" onClick={() => setExpandedTx(expandedTx === tx.id ? null : tx.id)}>Inspect</button></td>
                                    </tr>
                                    {expandedTx === tx.id && (
                                        <tr style={{ background: '#F8FAFC' }}><td colSpan={6} style={{ padding: '24px' }}>
                                            <div style={{ background: '#fff', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '20px' }}>
                                                <h4 style={{ fontSize: '12px', fontWeight: '900', marginBottom: '16px', textTransform: 'uppercase', color: '#64748B' }}>Audit Trail &amp; Ledger Impact</h4>
                                                <table data-cy="table-admin.financial-ledger" style={{ width: '100%', borderCollapse: 'collapse' }}>
                                                    <thead><tr style={{ borderBottom: '1px solid #F1F5F9' }}><th style={{ textAlign: 'left', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Account</th><th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Before</th><th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>Change (Dr/Cr)</th><th style={{ textAlign: 'right', padding: '12px', fontSize: '11px', color: '#94A3B8' }}>After</th></tr></thead>
                                                    <tbody>{tx.journalEntries.map(entry => { const change = Number(entry.debit) - Number(entry.credit); return (
                                                        <tr key={entry.id} style={{ borderBottom: '1px solid #F9FAFB' }}>
                                                            <td style={{ padding: '12px', fontSize: '13px', fontWeight: '600' }}>{entry.account.name}</td>
                                                            <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', color: '#64748B' }}>${Number(entry.balanceBefore).toFixed(2)}</td>
                                                            <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', fontWeight: '700', color: change > 0 ? '#10B981' : '#EF4444' }}>{change > 0 ? `+${change.toFixed(2)}` : `${change.toFixed(2)}`}</td>
                                                            <td style={{ padding: '12px', textAlign: 'right', fontSize: '13px', fontWeight: '700' }}>${Number(entry.balanceAfter).toFixed(2)}</td>
                                                        </tr>); })}</tbody>
                                                </table>
                                            </div>
                                        </td></tr>
                                    )}
                                </React.Fragment>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {activeTab === 'reconciliation' && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    <div className="pc-card"><div className="pc-card-h">Unmatched Invoices</div><div className="pc-card-b">{transactions.filter(t => t.type === 'INVOICE' && t.status === 'posted').map(tx => (<div key={tx.id} style={{ padding: '12px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}><div><div style={{ fontWeight: '700' }}>INV: {tx.referenceId}</div><div style={{ fontSize: '11px', color: '#6B7280' }}>ID: {tx.id.substring(0, 8)}</div></div><div style={{ fontWeight: '800' }}>${Number(tx.amount).toFixed(2)}</div></div>))}</div></div>
                    <div className="pc-card"><div className="pc-card-h">Recent Payments</div><div className="pc-card-b">{transactions.filter(t => t.type === 'PAYMENT' && t.status === 'posted').map(tx => (<div key={tx.id} style={{ padding: '12px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}><div><div style={{ fontWeight: '700' }}>PAYMENT: {tx.referenceId}</div><div style={{ fontSize: '11px', color: '#6B7280' }}>ID: {tx.id.substring(0, 8)}</div></div><div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}><div style={{ fontWeight: '800' }}>${Number(tx.amount).toFixed(2)}</div><button data-cy="btn-admin.financial-ledger-4" className="btn secondary sm" onClick={() => handleReconcile(transactions.find(inv => inv.type === 'INVOICE' && Number(inv.amount) === Number(tx.amount))?.id || '', tx.id)}>Auto-Match</button></div></div>))}</div></div>
                </div>
            )}

            {activeTab === 'reports' && (
                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                    {pAndL && (<div className="pc-card"><div className="pc-card-h" style={{ textAlign: 'center' }}><div style={{ fontSize: '16px', fontWeight: '800' }}>Profit &amp; Loss Statement</div><div style={{ fontSize: '10px', color: '#94A3B8' }}>Period: {new Date(pAndL.period.startDate).toLocaleDateString()} - {new Date(pAndL.period.endDate).toLocaleDateString()}</div></div><div className="pc-card-b" style={{ padding: '24px' }}>
                        {[{ title: 'Revenue', data: pAndL.breakdown.revenue, total: pAndL.totalRevenue, h3Id: 0, negative: false },
                          { title: 'Expenses', data: pAndL.breakdown.expenses, total: pAndL.totalExpenses, h3Id: 1, negative: true }].map(s => (
                            <section key={s.title} style={{ marginBottom: '24px' }}><h3 data-cy={`h3-admin.financial-ledger-${s.h3Id}`} style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: '1px solid #E2E8F0', paddingBottom: '4px', marginBottom: '12px' }}>{s.title}</h3>
                                {Object.entries(s.data || {}).map(([name, amount]: any) => (<div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}><span>{name}</span><span style={{ fontWeight: '700' }}>{s.negative ? `($${Number(amount).toFixed(2)})` : `$${Number(amount).toFixed(2)}`}</span></div>))}
                                <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}><span>Total {s.title}</span><span>{s.negative ? `($${Number(s.total).toFixed(2)})` : `$${Number(s.total).toFixed(2)}`}</span></div>
                            </section>
                        ))}
                        <div style={{ background: '#F8FAFC', padding: '12px', borderRadius: '8px', display: 'flex', justifyContent: 'space-between', fontWeight: '900', fontSize: '16px', border: '1px solid #E2E8F0' }}><span>NET INCOME</span><span style={{ color: pAndL.netIncome >= 0 ? '#10B981' : '#EF4444' }}>${Number(pAndL.netIncome).toFixed(2)}</span></div>
                    </div></div>)}

                    {balanceSheet && (<div className="pc-card"><div className="pc-card-h" style={{ textAlign: 'center' }}><div style={{ fontSize: '16px', fontWeight: '800' }}>Balance Sheet</div><div style={{ fontSize: '10px', color: '#94A3B8' }}>As of {new Date(balanceSheet.date).toLocaleDateString()}</div></div><div className="pc-card-b" style={{ padding: '24px' }}>
                        {[{ title: 'Assets', data: balanceSheet.assets, h3Id: 2, borderColor: '#BAE6FD' },
                          { title: 'Liabilities', data: balanceSheet.liabilities, h3Id: 3, borderColor: '#FED7AA' },
                          { title: 'Equity', data: balanceSheet.equity, h3Id: 4, borderColor: '#E9D5FF' }].map(s => (
                            <section key={s.title} style={{ marginBottom: '24px' }}><h3 data-cy={`h3-admin.financial-ledger-${s.h3Id}`} style={{ fontSize: '11px', fontWeight: '900', textTransform: 'uppercase', color: '#1E293B', borderBottom: `1px solid ${s.borderColor}`, paddingBottom: '4px', marginBottom: '12px' }}>{s.title}</h3>
                                {Object.entries(s.data.accounts || {}).map(([name, amount]: any) => (<div key={name} style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '4px', fontSize: '13px' }}><span>{name}</span><span style={{ fontWeight: '700' }}>${Number(amount).toFixed(2)}</span></div>))}
                                <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '12px', fontWeight: '800', borderTop: '1px solid #F1F5F9', paddingTop: '4px' }}><span>Total {s.title}</span><span>${Number(s.data.total).toFixed(2)}</span></div>
                            </section>
                        ))}
                        <div style={{ background: '#F8FAFC', padding: '12px', borderRadius: '8px', display: 'flex', justifyContent: 'space-between', fontWeight: '900', fontSize: '16px', border: '1px solid #E2E8F0' }}><span>L + E Total</span><span>${(Number(balanceSheet.liabilities.total) + Number(balanceSheet.equity.total)).toFixed(2)}</span></div>
                    </div></div>)}
                </div>
            )}
        </div>
    );
}
