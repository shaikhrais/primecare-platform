import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './BranchP_L.css';

const { REGIONAL_STATS } = ContentRegistry;

export default function BranchPL() {
    const [period, setPeriod] = useState('Quarterly');
    const [financials, setFinancials] = useState<any>({
        revenue: '$928,000',
        expenses: '$607,000',
        profit: '$321,000',
        margin: '34.5%'
    });
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchFinancials = async () => {
            try {
                const data = await apiClient.get(ApiRegistry.TENANCY.MANAGER.OPS_STATS);
                if (data) {
                    const d = data as any;
                    setFinancials({
                        revenue: d.revenueMtd || '$928,000',
                        expenses: d.expensesMtd || '$607,000',
                        profit: d.profitMtd || '$321,000',
                        margin: d.profitMargin || '34.5%'
                    });
                }
            } catch (error) {
                console.error('Failed to fetch financials:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchFinancials();
    }, [period]);

    if (loading) {
        return (
            <div className="finance-hub-container">
                <div style={{ textAlign: 'center', padding: '100px' }}>
                    <p style={{ fontWeight: 700, color: '#64748b' }}>Calculating Branch Profitability Ledger...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="finance-hub-container">
            <header className="finance-header">
                <div>
                    <h1>Branch Profit & Loss</h1>
                    <p>Real-time financial performance and operational expense audit.</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <select
                        className="btn-secondary-pc"
                        value={period}
                        onChange={(e) => setPeriod(e.target.value)}
                        style={{ padding: '0.5rem 1rem' }}
                    >
                        <option>Monthly</option>
                        <option>Quarterly</option>
                        <option>Year-to-Date</option>
                    </select>
                    <button className="export-btn-premium">Export Statement</button>
                </div>
            </header>

            <section className="finance-bento-grid">
                <div className="finance-card">
                    <div className="finance-card-metric">
                        <span className="metric-label">Gross Revenue</span>
                        <div className="metric-value">{financials.revenue}</div>
                        <div className="metric-trend" style={{ color: '#10b981' }}>↑ 14.2% vs prev.</div>
                    </div>
                </div>
                <div className="finance-card">
                    <div className="finance-card-metric">
                        <span className="metric-label">Total Expenses</span>
                        <div className="metric-value">{financials.expenses}</div>
                        <div className="metric-trend" style={{ color: '#ef4444' }}>↑ 8.1% vs prev.</div>
                    </div>
                </div>
                <div className="finance-card">
                    <div className="finance-card-metric">
                        <span className="metric-label">Net Profit</span>
                        <div className="metric-value">{financials.profit}</div>
                        <span className="badge-premium badge-green" style={{ width: 'fit-content', marginTop: '0.5rem' }}>
                            {financials.margin} MARGIN
                        </span>
                    </div>
                </div>

                <div className="finance-card finance-card-large">
                    <div className="card-header" style={{ background: 'none', border: 'none', padding: 0 }}>
                        <h2 style={{ fontSize: '1.25rem', fontWeight: 800 }}>Revenue vs Expense Trend</h2>
                    </div>
                    <div className="chart-container-premium">
                        <p style={{ color: '#94a3b8', fontWeight: 700 }}>[ INTERACTIVE P&L PROJECTION ENGINE ]</p>
                    </div>
                </div>

                <div className="finance-card">
                    <div className="card-header" style={{ background: 'none', border: 'none', padding: 0 }}>
                        <h2 style={{ fontSize: '1rem', fontWeight: 800 }}>Expense Distribution</h2>
                    </div>
                    <div className="expense-breakdown">
                        {[
                            { name: 'Payroll', value: '65%', color: '#3b82f6' },
                            { name: 'Logistics', value: '15%', color: '#10b981' },
                            { name: 'Marketing', value: '10%', color: '#f59e0b' },
                            { name: 'Operations', value: '10%', color: '#6366f1' },
                        ].map(exp => (
                            <div key={exp.name} className="expense-item">
                                <div className="expense-info">
                                    <div className="expense-dot" style={{ background: exp.color }}></div>
                                    <span className="expense-text">{exp.name}</span>
                                </div>
                                <span className="expense-percent">{exp.value}</span>
                            </div>
                        ))}
                    </div>
                </div>
            </section>

            <article className="finance-card" style={{ background: '#0f172a', color: 'white' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div>
                        <h3 style={{ fontSize: '1.125rem', fontWeight: 800, color: '#3b82f6' }}>Efficiency Insight</h3>
                        <p style={{ color: '#94a3b8', fontSize: '0.875rem', marginTop: '0.5rem', maxWidth: '600px' }}>
                            Branch profit margins have increased by 4.2% this quarter due to optimized travel routing for PSWs,
                            reducing average fuel reimbursement costs.
                        </p>
                    </div>
                    <button className="btn-secondary-pc" style={{ background: 'transparent', color: 'white', borderColor: '#334155' }}>
                        VIEW LOGISTICS AUDIT →
                    </button>
                </div>
            </article>
        </div>
    );
}
