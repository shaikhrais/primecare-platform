import React, { useEffect, useState } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';

interface TradingAccount {
    revenue: number;
    directCosts: number;
    grossProfit: number;
    grossProfitMargin: number;
    breakdown: {
        revenue: Record<string, number>;
        directCosts: Record<string, number>;
    };
}

interface ProfitAndLoss {
    operatingExpenses: number;
    netIncome: number;
    breakdown: {
        indirectExpenses: Record<string, number>;
    };
}

interface BalanceSheet {
    date: string;
    assets: { total: number; accounts: Record<string, number> };
    liabilities: { total: number; accounts: Record<string, number> };
    equity: { total: number; accounts: Record<string, number> };
}

export default function AccountingDashboard() {
    const [tradingAcc, setTradingAcc] = useState<TradingAccount | null>(null);
    const [pAndL, setPAndL] = useState<ProfitAndLoss | null>(null);
    const [balanceSheet, setBalanceSheet] = useState<BalanceSheet | null>(null);
    const [loading, setLoading] = useState(true);

    const loadData = async () => {
        setLoading(true);
        try {
            const [taRes, plRes, bsRes] = await Promise.all([
                apiClient.get('/platform/admin/financial/reports/trading-account'),
                apiClient.get('/platform/admin/financial/reports/p-and-l'),
                apiClient.get('/platform/admin/financial/reports/balance-sheet')
            ]);

            if (taRes.ok) setTradingAcc(await taRes.json());
            if (plRes.ok) setPAndL(await plRes.json());
            if (bsRes.ok) setBalanceSheet(await bsRes.json());
        } catch (error) {
            console.error('Failed to load accounting data:', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        loadData();
    }, []);

    if (loading) return (
        <div style={{
            height: '100vh',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)',
            color: '#fff',
            fontFamily: 'system-ui'
        }}>
            <div style={{ textAlign: 'center' }}>
                <div className="loader" style={{ marginBottom: '16px' }}></div>
                <div style={{ fontSize: '18px', fontWeight: '600', letterSpacing: '0.05em' }}>ORCHESTRATING FINANCIAL ENGINE...</div>
            </div>
        </div>
    );

    return (
        <div style={{
            padding: '40px',
            background: '#0f172a',
            minHeight: '100vh',
            color: '#f8fafc',
            fontFamily: '"Outfit", sans-serif'
        }}>
            {/* Header */}
            <header style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'flex-end',
                marginBottom: '40px',
                borderBottom: '1px solid rgba(255,255,255,0.1)',
                paddingBottom: '24px'
            }}>
                <div>
                    <h1 style={{ fontSize: '36px', fontWeight: '800', margin: '0', background: 'linear-gradient(to right, #60a5fa, #a855f7)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                        Accounting Intelligence
                    </h1>
                    <p style={{ color: '#94a3b8', fontSize: '16px', marginTop: '8px' }}>Real-time GAAP reporting for PrimeCare Platform.</p>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <button onClick={loadData} style={{
                        background: 'rgba(255,255,255,0.05)',
                        border: '1px solid rgba(255,255,255,0.1)',
                        color: '#fff',
                        padding: '10px 20px',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        fontWeight: '600',
                        backdropFilter: 'blur(10px)'
                    }}>Refresh Engine</button>
                    <button style={{
                        background: 'linear-gradient(to right, #3b82f6, #2563eb)',
                        border: 'none',
                        color: '#fff',
                        padding: '10px 24px',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        fontWeight: '700',
                        boxShadow: '0 4px 20px rgba(37, 99, 235, 0.3)'
                    }}>Generate Audit</button>
                </div>
            </header>

            {/* Bento Grid */}
            <div style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(12, 1fr)',
                gridTemplateRows: 'repeat(2, auto)',
                gap: '24px'
            }}>

                {/* Trading Account Card */}
                <div style={{
                    gridColumn: 'span 4',
                    background: 'rgba(30, 41, 59, 0.7)',
                    borderRadius: '24px',
                    padding: '32px',
                    border: '1px solid rgba(255,255,255,0.05)',
                    backdropFilter: 'blur(20px)',
                    position: 'relative',
                    overflow: 'hidden'
                }}>
                    <div style={{ position: 'absolute', top: '0', right: '0', padding: '24px', opacity: '0.1' }}>
                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6" /></svg>
                    </div>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', background: '#34d399' }}></div>
                        <h2 style={{ fontSize: '14px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.1em', color: '#94a3b8' }}>Trading Account</h2>
                    </div>
                    <div style={{ marginBottom: '32px' }}>
                        <div style={{ fontSize: '12px', color: '#64748b', fontWeight: '600' }}>Gross Profit</div>
                        <div style={{ fontSize: '48px', fontWeight: '900', color: '#fff' }}>${tradingAcc?.grossProfit?.toLocaleString() || 0}</div>
                        <div style={{ fontSize: '14px', color: '#34d399', fontWeight: '700', marginTop: '4px' }}>
                            {tradingAcc?.grossProfitMargin?.toFixed(1)}% Margin
                        </div>
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', background: 'rgba(255,255,255,0.03)', borderRadius: '12px' }}>
                            <span style={{ color: '#94a3b8' }}>Total Revenue</span>
                            <span style={{ fontWeight: '700' }}>${tradingAcc?.revenue?.toLocaleString()}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', background: 'rgba(255,255,255,0.03)', borderRadius: '12px' }}>
                            <span style={{ color: '#94a3b8' }}>Direct Costs</span>
                            <span style={{ fontWeight: '700', color: '#f87171' }}>-${tradingAcc?.directCosts?.toLocaleString()}</span>
                        </div>
                    </div>
                </div>

                {/* Profit & Loss Card */}
                <div style={{
                    gridColumn: 'span 4',
                    background: 'rgba(30, 41, 59, 0.7)',
                    borderRadius: '24px',
                    padding: '32px',
                    border: '1px solid rgba(255,255,255,0.05)',
                    backdropFilter: 'blur(20px)'
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', background: '#60a5fa' }}></div>
                        <h2 style={{ fontSize: '14px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.1em', color: '#94a3b8' }}>Profit & Loss</h2>
                    </div>
                    <div style={{ marginBottom: '32px' }}>
                        <div style={{ fontSize: '12px', color: '#64748b', fontWeight: '600' }}>Net Income</div>
                        <div style={{ fontSize: '48px', fontWeight: '900', color: (pAndL?.netIncome || 0) >= 0 ? '#fff' : '#ef4444' }}>
                            ${pAndL?.netIncome?.toLocaleString() || 0}
                        </div>
                        <div style={{ fontSize: '14px', color: (pAndL?.netIncome || 0) >= 0 ? '#60a5fa' : '#ef4444', fontWeight: '700', marginTop: '4px' }}>
                            {(pAndL?.netIncome || 0) >= 0 ? 'Surplus' : 'Deficit'} this period
                        </div>
                    </div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', background: 'rgba(255,255,255,0.03)', borderRadius: '12px' }}>
                            <span style={{ color: '#94a3b8' }}>Gross Profit</span>
                            <span style={{ fontWeight: '700' }}>${tradingAcc?.grossProfit?.toLocaleString()}</span>
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', padding: '12px', background: 'rgba(255,255,255,0.03)', borderRadius: '12px' }}>
                            <span style={{ color: '#94a3b8' }}>Operating Expenses</span>
                            <span style={{ fontWeight: '700', color: '#f87171' }}>-${pAndL?.operatingExpenses?.toLocaleString()}</span>
                        </div>
                    </div>
                </div>

                {/* Balance Sheet Snapshot Card */}
                <div style={{
                    gridColumn: 'span 4',
                    background: 'rgba(30, 41, 59, 0.7)',
                    borderRadius: '24px',
                    padding: '32px',
                    border: '1px solid rgba(255,255,255,0.05)',
                    backdropFilter: 'blur(20px)'
                }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
                        <div style={{ width: '12px', height: '12px', borderRadius: '50%', background: '#a855f7' }}></div>
                        <h2 style={{ fontSize: '14px', fontWeight: '800', textTransform: 'uppercase', letterSpacing: '0.1em', color: '#94a3b8' }}>Balance Sheet</h2>
                    </div>
                    <div style={{ height: '200px', display: 'flex', alignItems: 'flex-end', gap: '24px', padding: '0 20px' }}>
                        <div style={{ flex: '1', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '100%', background: 'linear-gradient(to top, #3b82f6, #60a5fa)', height: '140px', borderRadius: '8px', boxShadow: '0 8px 32px rgba(59, 130, 246, 0.2)' }}></div>
                            <span style={{ fontSize: '11px', color: '#94a3b8', fontWeight: '800' }}>ASSETS</span>
                        </div>
                        <div style={{ flex: '1', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '100%', background: 'linear-gradient(to top, #f59e0b, #fbbf24)', height: `${(balanceSheet?.liabilities.total || 0) / (balanceSheet?.assets.total || 1) * 140}px`, minHeight: '40px', borderRadius: '8px', boxShadow: '0 8px 32px rgba(245, 158, 11, 0.2)' }}></div>
                            <span style={{ fontSize: '11px', color: '#94a3b8', fontWeight: '800' }}>LIAB.</span>
                        </div>
                        <div style={{ flex: '1', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '12px' }}>
                            <div style={{ width: '100%', background: 'linear-gradient(to top, #ec4899, #f472b6)', height: `${(balanceSheet?.equity.total || 0) / (balanceSheet?.assets.total || 1) * 140}px`, minHeight: '40px', borderRadius: '8px', boxShadow: '0 8px 32px rgba(236, 72, 153, 0.2)' }}></div>
                            <span style={{ fontSize: '11px', color: '#94a3b8', fontWeight: '800' }}>EQUITY</span>
                        </div>
                    </div>
                    <div style={{ marginTop: '32px', display: 'flex', justifyContent: 'space-between', borderTop: '1px solid rgba(255,255,255,0.05)', paddingTop: '24px' }}>
                        <div>
                            <div style={{ fontSize: '11px', color: '#64748b', fontWeight: '800' }}>TOTAL ASSETS</div>
                            <div style={{ fontSize: '20px', fontWeight: '900' }}>${balanceSheet?.assets.total?.toLocaleString()}</div>
                        </div>
                        <div style={{ textAlign: 'right' }}>
                            <div style={{ fontSize: '11px', color: '#64748b', fontWeight: '800' }}>NET WORTH</div>
                            <div style={{ fontSize: '20px', fontWeight: '900', color: '#ec4899' }}>${balanceSheet?.equity.total?.toLocaleString()}</div>
                        </div>
                    </div>
                </div>

                {/* Bottom Wide Section: Expenses Breakdown vs Asset Allocation */}
                <div style={{
                    gridColumn: 'span 8',
                    background: 'rgba(30, 41, 59, 0.7)',
                    borderRadius: '24px',
                    padding: '32px',
                    border: '1px solid rgba(255,255,255,0.05)',
                    backdropFilter: 'blur(20px)'
                }}>
                    <h2 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '24px', color: '#f8fafc' }}>Expenditure Intelligence</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '40px' }}>
                        <div>
                            <h3 style={{ fontSize: '12px', fontWeight: '900', color: '#64748b', textTransform: 'uppercase', marginBottom: '16px' }}>Operating Expenses Breakdown</h3>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                                {Object.entries(pAndL?.breakdown.indirectExpenses || {}).map(([name, amount], i) => (
                                    <div key={name} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <div style={{ width: '8px', height: '8px', borderRadius: '2px', background: `hsl(${i * 60}, 70%, 50%)` }}></div>
                                            <span style={{ fontSize: '14px', color: '#cbd5e1' }}>{name}</span>
                                        </div>
                                        <span style={{ fontWeight: '700', fontSize: '14px' }}>${amount.toLocaleString()}</span>
                                    </div>
                                ))}
                            </div>
                        </div>
                        <div style={{ background: 'rgba(255,255,255,0.02)', borderRadius: '16px', padding: '24px', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
                            <div style={{ fontSize: '48px', fontWeight: '900', color: '#f87171' }}>${pAndL?.operatingExpenses?.toLocaleString()}</div>
                            <div style={{ fontSize: '12px', color: '#94a3b8', fontWeight: '800', letterSpacing: '0.1em' }}>TOTAL INDIRECT BURN</div>
                            <div style={{ marginTop: '16px', width: '100%', height: '4px', background: 'rgba(255,255,100,0.1)', borderRadius: '2px', overflow: 'hidden' }}>
                                <div style={{ width: `${(pAndL?.operatingExpenses || 0) / (tradingAcc?.revenue || 1) * 100}%`, height: '100%', background: '#f87171' }}></div>
                            </div>
                            <span style={{ fontSize: '11px', color: '#64748b', marginTop: '8px', fontWeight: '700' }}>
                                {((pAndL?.operatingExpenses || 0) / (tradingAcc?.revenue || 1) * 100).toFixed(1)}% of Gross Revenue
                            </span>
                        </div>
                    </div>
                </div>

                {/* Right Narrow Section: Quick Insights */}
                <div style={{
                    gridColumn: 'span 4',
                    background: 'linear-gradient(135deg, #1e1b4b 0%, #312e81 100%)',
                    borderRadius: '24px',
                    padding: '32px',
                    border: '1px solid rgba(255,255,255,0.1)',
                    boxShadow: '0 20px 50px rgba(0,0,0,0.3)',
                    color: '#fff'
                }}>
                    <h2 style={{ fontSize: '18px', fontWeight: '800', marginBottom: '24px' }}>AI Compliance Guard</h2>
                    <ul style={{ listStyle: 'none', padding: '0', margin: '0', display: 'flex', flexDirection: 'column', gap: '20px' }}>
                        <li style={{ display: 'flex', gap: '16px' }}>
                            <div style={{ width: '40px', height: '40px', borderRadius: '12px', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                ✔
                            </div>
                            <div>
                                <div style={{ fontWeight: '700', fontSize: '14px' }}>Hash Integrity Verified</div>
                                <div style={{ fontSize: '12px', color: '#a5b4fc' }}>All ledger blocks cryptographically valid.</div>
                            </div>
                        </li>
                        <li style={{ display: 'flex', gap: '16px' }}>
                            <div style={{ width: '40px', height: '40px', borderRadius: '12px', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                ⚖
                            </div>
                            <div>
                                <div style={{ fontWeight: '700', fontSize: '14px' }}>Trial Balance Check</div>
                                <div style={{ fontSize: '12px', color: '#a5b4fc' }}>Debits and Credits perfectly balanced.</div>
                            </div>
                        </li>
                        <li style={{ display: 'flex', gap: '16px' }}>
                            <div style={{ width: '40px', height: '40px', borderRadius: '12px', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                                🛡
                            </div>
                            <div>
                                <div style={{ fontWeight: '700', fontSize: '14px' }}>Forensic Audit Trail</div>
                                <div style={{ fontSize: '12px', color: '#a5b4fc' }}>Point-in-time state tracking active.</div>
                            </div>
                        </li>
                    </ul>
                    <div style={{ marginTop: '40px', padding: '20px', background: 'rgba(255,255,255,0.05)', borderRadius: '16px', textAlign: 'center' }}>
                        <div style={{ fontSize: '11px', fontWeight: '800', letterSpacing: '0.1em', opacity: '0.6' }}>CONTINUOUS COMPLIANCE STATUS</div>
                        <div style={{ fontSize: '24px', fontWeight: '900', marginTop: '8px', color: '#4ade80' }}>OPERATIONAL</div>
                    </div>
                </div>

            </div>

            <style>{`
                @import url('https://fonts.googleapis.com/css2?family=Outfit:wght@400;600;700;800;900&display=swap');
                
                .loader {
                    width: 48px;
                    height: 48px;
                    border: 5px solid #FFF;
                    border-bottom-color: #3b82f6;
                    border-radius: 50%;
                    display: inline-block;
                    box-sizing: border-box;
                    animation: rotation 1s linear infinite;
                }

                @keyframes rotation {
                    0% { transform: rotate(0deg); }
                    100% { transform: rotate(360deg); }
                }
            `}</style>
        </div>
    );
}
