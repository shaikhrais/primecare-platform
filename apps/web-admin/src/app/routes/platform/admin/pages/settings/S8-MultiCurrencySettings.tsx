// ================================================================
// PAGE IDENTITY: S8 · Multi-Currency Settings
// Type: Settings | Owner: admin
// Feature Flag: multi-currency
// Tier: Enterprise
// ================================================================
import React, { useState } from 'react';

const currencies = [
    { code: 'CAD', name: 'Canadian Dollar', symbol: '$', rate: 1.0000, isBase: true, status: 'active' },
    { code: 'USD', name: 'US Dollar', symbol: '$', rate: 0.7412, isBase: false, status: 'active' },
    { code: 'GBP', name: 'British Pound', symbol: '£', rate: 0.5891, isBase: false, status: 'active' },
    { code: 'EUR', name: 'Euro', symbol: '€', rate: 0.6823, isBase: false, status: 'active' },
    { code: 'INR', name: 'Indian Rupee', symbol: '₹', rate: 61.45, isBase: false, status: 'inactive' },
    { code: 'PHP', name: 'Philippine Peso', symbol: '₱', rate: 41.28, isBase: false, status: 'inactive' },
];

const recentTransactions = [
    { id: 'tx-001', description: 'Invoice #INV-2847', fromCurrency: 'USD', toCurrency: 'CAD', fromAmount: '$2,340', toAmount: '$3,157.07', rate: 1.3492, date: 'Mar 15' },
    { id: 'tx-002', description: 'Supplier Payment — MedEquip UK', fromCurrency: 'CAD', toCurrency: 'GBP', fromAmount: '$4,200', toAmount: '£2,474.22', rate: 0.5891, date: 'Mar 14' },
    { id: 'tx-003', description: 'Client Billing — EU Client', fromCurrency: 'CAD', toCurrency: 'EUR', fromAmount: '$1,890', toAmount: '€1,289.55', rate: 0.6823, date: 'Mar 12' },
];

export default function MultiCurrencySettings() {
    const [showConverter, setShowConverter] = useState(false);
    const [amount, setAmount] = useState('100');
    const [fromCur, setFromCur] = useState('CAD');
    const [toCur, setToCur] = useState('USD');

    const fromRate = currencies.find(c => c.code === fromCur)?.rate || 1;
    const toRate = currencies.find(c => c.code === toCur)?.rate || 1;
    const converted = ((parseFloat(amount) || 0) / fromRate * toRate).toFixed(2);

    return (
        <div data-cy="page.container" role="main" aria-label="Multi-Currency" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>💱 Multi-Currency Settings</h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>Exchange rates, conversions & international billing</p>
                </div>
                <div style={{ padding: '6px 14px', borderRadius: '10px', background: 'rgba(124,58,237,0.1)', color: '#7C3AED', fontWeight: 700, fontSize: '0.75rem' }}>🏢 Enterprise Feature</div>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Base Currency', value: 'CAD 🇨🇦', color: 'var(--pc-primary)' },
                    { label: 'Active Currencies', value: '4', color: 'var(--pc-success)' },
                    { label: 'Last Rate Update', value: '2 hrs ago', color: 'var(--pc-info, #2563EB)' },
                    { label: 'FX Transactions', value: '156', color: '#7C3AED' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 160px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Quick Converter */}
            <div style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '24px' }}>
                <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>⚡ Quick Converter</h3>
                <div style={{ display: 'flex', gap: '12px', alignItems: 'center', flexWrap: 'wrap' }}>
                    <input type="number" value={amount} onChange={e => setAmount(e.target.value)} style={{
                        width: '120px', padding: '10px 12px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)',
                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontSize: '1rem', fontWeight: 700,
                    }} />
                    <select value={fromCur} onChange={e => setFromCur(e.target.value)} style={{
                        padding: '10px 12px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)',
                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontWeight: 700,
                    }}>
                        {currencies.map(c => <option key={c.code} value={c.code}>{c.code}</option>)}
                    </select>
                    <span style={{ fontSize: '1.3rem' }}>→</span>
                    <select value={toCur} onChange={e => setToCur(e.target.value)} style={{
                        padding: '10px 12px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)',
                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontWeight: 700,
                    }}>
                        {currencies.map(c => <option key={c.code} value={c.code}>{c.code}</option>)}
                    </select>
                    <div style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--pc-success)' }}>
                        {currencies.find(c => c.code === toCur)?.symbol}{converted}
                    </div>
                </div>
            </div>

            {/* Currency Table */}
            <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden', marginBottom: '24px' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead><tr>{['Currency', 'Symbol', 'Rate (to CAD)', 'Status'].map(h => (
                        <th key={h} style={{ padding: '12px 16px', textAlign: 'left', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', borderBottom: '2px solid var(--pc-border-primary)' }}>{h}</th>
                    ))}</tr></thead>
                    <tbody>{currencies.map(c => (
                        <tr key={c.code} style={{ background: 'var(--pc-surface-card)' }}
                            onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                            onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card)'}>
                            <td style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                {c.code} — {c.name} {c.isBase && <span style={{ fontSize: '0.65rem', color: 'var(--pc-primary)', fontWeight: 700 }}>(BASE)</span>}
                            </td>
                            <td style={{ padding: '12px 16px', fontSize: '1.2rem', borderBottom: '1px solid var(--pc-border-primary)' }}>{c.symbol}</td>
                            <td style={{ padding: '12px 16px', fontFamily: 'monospace', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{c.rate.toFixed(4)}</td>
                            <td style={{ padding: '12px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                <span style={{ padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700, color: c.status === 'active' ? 'var(--pc-success)' : 'var(--pc-text-tertiary)', background: c.status === 'active' ? 'rgba(5,150,105,0.1)' : 'var(--pc-bg-secondary)' }}>
                                    {c.status.toUpperCase()}
                                </span>
                            </td>
                        </tr>
                    ))}</tbody>
                </table>
            </div>

            {/* Recent Transactions */}
            <h3 style={{ fontWeight: 700, color: 'var(--pc-text-primary)', margin: '0 0 16px' }}>📋 Recent FX Transactions</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '10px' }}>
                {recentTransactions.map(tx => (
                    <div key={tx.id} style={{ padding: '16px 20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', display: 'flex', alignItems: 'center', gap: '16px', flexWrap: 'wrap' }}>
                        <div style={{ flex: 1 }}>
                            <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>{tx.description}</div>
                            <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '2px' }}>{tx.date} • Rate: {tx.rate}</div>
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            <div style={{ fontWeight: 700, color: 'var(--pc-text-secondary)' }}>{tx.fromCurrency} {tx.fromAmount}</div>
                            <div style={{ fontWeight: 800, color: 'var(--pc-success)' }}>→ {tx.toCurrency} {tx.toAmount}</div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
