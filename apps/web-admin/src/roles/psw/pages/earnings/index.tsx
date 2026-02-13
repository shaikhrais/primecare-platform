import React, { useState } from 'react';
import { Breadcrumb } from '../../components/Breadcrumb';
import { SecureSessionGuard } from '../../components/SecureSessionGuard';

export default function EarningsPage() {
    const [activeTab, setActiveTab] = useState('Overview');

    return (
        <SecureSessionGuard allowedRoles={['psw', 'admin']}>
            <>
                <div style={{ padding: '2rem', display: 'flex', flexDirection: 'column', gap: '2rem', animation: 'fadeIn 0.5s ease-out' }}>
                    {/* ... content ... */}
                </div>

                <style>{`
                        @keyframes fadeIn {
                            from { opacity: 0; transform: translateY(10px); }
                            to { opacity: 1; transform: translateY(0); }
                        }
                    `}</style>
            </>
        </SecureSessionGuard >
    );
}
<div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', flexWrap: 'wrap', gap: '1rem' }}>
    <div style={{ flex: 1, minWidth: '300px' }}>
        <Breadcrumb />
        <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '2.5rem', fontWeight: 900, color: '#111827' }}>Earnings</h1>
        <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontWeight: 500 }}>Financial performance and payout management</p>
    </div>
    <div style={{ display: 'flex', gap: '12px' }}>
        <button style={{ padding: '12px 20px', backgroundColor: '#FFFFFF', border: '1px solid #E5E7EB', borderRadius: '12px', fontWeight: 700, cursor: 'pointer' }}>
            📅 Last 30 Days
        </button>
        <button style={{ padding: '12px 24px', backgroundColor: '#000000', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 800, cursor: 'pointer' }}>
            📥 Export Report
        </button>
    </div>
</div>

{/* --- KPI BOARD --- */ }
<div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
    <KpiCard title="Total Revenue" value="$42,500.00" trend="+12.5%" isPositive={true} />
    <KpiCard title="Total Payroll" value="$28,200.00" trend="+5.2%" isPositive={false} />
    <KpiCard title="Net Profit" value="$14,300.00" trend="+18.4%" isPositive={true} />
    <KpiCard title="Payouts Pending" value="$4,150.00" trend="8 shifts" isTextTrend={true} />
</div>

{/* --- TABS --- */ }
<div style={{ display: 'flex', gap: '2rem', borderBottom: '1px solid #E5E7EB' }}>
    {['Overview', 'Invoices', 'Payouts', 'Reports'].map(tab => (
        <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            style={{
                paddingBottom: '12px',
                border: 'none',
                background: 'none',
                fontSize: '1rem',
                fontWeight: activeTab === tab ? 800 : 500,
                color: activeTab === tab ? '#00875A' : '#6B7280',
                borderBottom: activeTab === tab ? '3px solid #00875A' : '3px solid transparent',
                cursor: 'pointer',
                transition: 'all 0.2s'
            }}
        >
            {tab}
        </button>
    ))}
</div>

{/* --- CHARTS & DATA --- */ }
<div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(400px, 1fr))', gap: '2rem' }}>
    {/* Revenue Trend Chart */}
    <div style={{ backgroundColor: '#FFFFFF', padding: '24px', borderRadius: '24px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)', border: '1px solid #F3F4F6' }}>
        <h3 style={{ margin: '0 0 20px 0', fontSize: '1.1rem', fontWeight: 800 }}>Revenue Trend (Weekly)</h3>
        <div style={{ height: '200px', width: '100%', position: 'relative' }}>
            <svg width="100%" height="100%" viewBox="0 0 400 100" preserveAspectRatio="none">
                <path d="M0,80 Q50,40 100,60 T200,30 T300,50 T400,20" fill="none" stroke="#00875A" strokeWidth="3" />
                <path d="M0,80 Q50,40 100,60 T200,30 T300,50 T400,20 V100 H0 Z" fill="url(#grad1)" opacity="0.1" />
                <defs>
                    <linearGradient id="grad1" x1="0%" y1="0%" x2="0%" y2="100%">
                        <stop offset="0%" style={{ stopColor: '#00875A', stopOpacity: 1 }} />
                        <stop offset="100%" style={{ stopColor: '#00875A', stopOpacity: 0 }} />
                    </linearGradient>
                </defs>
            </svg>
        </div>
    </div>

    {/* Recent Transactions Table Preview */}
    <div style={{ backgroundColor: '#FFFFFF', padding: '24px', borderRadius: '24px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)', border: '1px solid #F3F4F6' }}>
        <h3 style={{ margin: '0 0 20px 0', fontSize: '1.1rem', fontWeight: 800 }}>Recent Payouts</h3>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
            <TransactionRow name="John Doe (PSW)" amount="-$850.00" date="Feb 12" status="Completed" />
            <TransactionRow name="Jane Smith (PSW)" amount="-$1,200.00" date="Feb 11" status="Pending" />
            <TransactionRow name="Prime Health Center" amount="+$4,500.00" date="Feb 10" status="Completed" />
        </div>
    </div>
</div>
            </div >

    <style>{`
                    @keyframes fadeIn {
                        from { opacity: 0; transform: translateY(10px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                `}</style>
        </>
        </SecureSessionGuard >
    );
}

function KpiCard({ title, value, trend, isPositive, isTextTrend = false }: any) {
    return (
        <div style={{
            backgroundColor: '#FFFFFF',
            padding: '24px',
            borderRadius: '24px',
            border: '1px solid #F3F4F6',
            boxShadow: '0 4px 6px -1px rgba(0,0,0,0.05)',
            transition: 'transform 0.2s',
            cursor: 'pointer'
        }}>
            <div style={{ color: '#6B7280', fontSize: '0.85rem', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>{title}</div>
            <div style={{ fontSize: '1.75rem', fontWeight: 900, marginBottom: '8px' }}>{value}</div>
            <div style={{
                fontSize: '0.85rem',
                fontWeight: 800,
                color: isTextTrend ? '#6B7280' : isPositive ? '#00875A' : '#EF4444',
                display: 'flex',
                alignItems: 'center',
                gap: '4px'
            }}>
                {!isTextTrend && (isPositive ? '↑' : '↓')} {trend}
                <span style={{ fontWeight: 500, opacity: 0.6, fontSize: '0.75rem' }}>vs last month</span>
            </div>
        </div>
    );
}

function TransactionRow({ name, amount, date, status }: any) {
    return (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '12px', borderRadius: '12px', border: '1px solid #F9FAFB' }}>
            <div>
                <div style={{ fontWeight: 800, fontSize: '0.9rem' }}>{name}</div>
                <div style={{ fontSize: '0.75rem', color: '#9CA3AF' }}>{date}</div>
            </div>
            <div style={{ textAlign: 'right' }}>
                <div style={{ fontWeight: 800, fontSize: '0.9rem', color: amount.startsWith('+') ? '#00875A' : '#111827' }}>{amount}</div>
                <div style={{ fontSize: '0.7rem', fontWeight: 900, color: status === 'Pending' ? '#F59E0B' : '#00875A' }}>{status}</div>
            </div>
        </div>
    );
}
