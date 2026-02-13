import React, { useState } from 'react';
import { Breadcrumb } from '@/roles/psw/components/Breadcrumb';

interface EarningRecord {
    id: string;
    date: string;
    shiftId: string;
    client: string;
    psw: string;
    hours: number;
    revenue: number;
    payroll: number;
    profit: number;
    paymentStatus: 'Paid' | 'Unpaid' | 'Partial';
    payoutStatus: 'Paid' | 'Pending';
}

const MOCK_EARNINGS: EarningRecord[] = [
    { id: 'INV-1001', date: '2026-02-12', shiftId: 'SH-003', client: 'Alice J.', psw: 'Shaikh R.', hours: 4, revenue: 160.00, payroll: 100.00, profit: 60.00, paymentStatus: 'Paid', payoutStatus: 'Pending' },
    { id: 'INV-1002', date: '2026-02-11', shiftId: 'SH-004', client: 'John D.', psw: 'Sara K.', hours: 6, revenue: 240.00, payroll: 150.00, profit: 90.00, paymentStatus: 'Paid', payoutStatus: 'Paid' },
    { id: 'INV-1003', date: '2026-02-10', shiftId: 'SH-005', client: 'Mary L.', psw: 'Shaikh R.', hours: 8, revenue: 320.00, payroll: 200.00, profit: 120.00, paymentStatus: 'Unpaid', payoutStatus: 'Pending' },
];

export default function AdminEarningsPage() {
    const [activeTab, setActiveTab] = useState('Overview');
    const [searchTerm, setSearchTerm] = useState('');

    const stats = [
        { label: 'Total Revenue', value: '$12,450.00', trend: '+12.5%', color: '#00875A' },
        { label: 'Total Payroll', value: '$8,120.00', trend: '+8.2%', color: '#3B82F6' },
        { label: 'Net Profit', value: '$4,330.00', trend: '+18.4%', color: '#8B5CF6' },
        { label: 'Payouts Pending', value: '$1,200.00', trend: '-5.1%', color: '#F59E0B' },
    ];

    return (
            <div style={{ padding: '2rem', display: 'flex', flexDirection: 'column', gap: '2rem', animation: 'fadeIn 0.5s ease-out' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                    <div>
                        <Breadcrumb />
                        <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '2.5rem', fontWeight: 900, color: '#111827' }}>Earnings Center</h1>
                        <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontWeight: 500 }}>Enterprise-grade financial oversight and payout management</p>
                    </div>
                    <div style={{ display: 'flex', gap: '12px' }}>
                        <button style={{ padding: '12px 20px', backgroundColor: '#F3F4F6', border: '1px solid #E5E7EB', borderRadius: '12px', fontWeight: 700, cursor: 'pointer' }}>
                            📅 Date Range
                        </button>
                        <button style={{ padding: '12px 24px', backgroundColor: '#000000', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 800, cursor: 'pointer', boxShadow: '0 4px 14px 0 rgba(0, 0, 0, 0.2)' }}>
                            📤 Export Report
                        </button>
                    </div>
                </div>

                {/* KPI Cards */}
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(240px, 1fr))', gap: '1.5rem' }}>
                    {stats.map(stat => (
                        <div key={stat.label} style={{
                            padding: '24px',
                            backgroundColor: '#FFFFFF',
                            borderRadius: '24px',
                            border: '1px solid #F3F4F6',
                            boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                            transition: 'transform 0.2s ease'
                        }}>
                            <div style={{ fontSize: '0.85rem', fontWeight: 800, color: '#6B7280', textTransform: 'uppercase', letterSpacing: '0.5px', marginBottom: '12px' }}>{stat.label}</div>
                            <div style={{ fontSize: '2rem', fontWeight: 900, color: '#111827', marginBottom: '8px' }}>{stat.value}</div>
                            <div style={{ fontSize: '0.85rem', fontWeight: 700, color: stat.trend.startsWith('+') ? '#00875A' : '#EF4444' }}>
                                {stat.trend} <span style={{ color: '#9CA3AF', fontWeight: 500 }}>vs last month</span>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Tab System */}
                <div style={{ display: 'flex', gap: '2rem', borderBottom: '1px solid #E5E7EB', padding: '0 8px' }}>
                    {['Overview', 'Invoices', 'Payouts', 'Reports'].map(tab => (
                        <button
                            key={tab}
                            onClick={() => setActiveTab(tab)}
                            style={{
                                padding: '16px 4px',
                                background: 'none',
                                border: 'none',
                                color: activeTab === tab ? '#00875A' : '#6B7280',
                                fontWeight: 800,
                                fontSize: '0.95rem',
                                cursor: 'pointer',
                                borderBottom: activeTab === tab ? '3px solid #00875A' : '3px solid transparent',
                                transition: 'all 0.2s'
                            }}
                        >
                            {tab}
                        </button>
                    ))}
                </div>

                {/* Filter Bar */}
                <div style={{
                    display: 'flex',
                    gap: '1.5rem',
                    padding: '20px',
                    backgroundColor: '#FFFFFF',
                    borderRadius: '20px',
                    boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
                    alignItems: 'center'
                }}>
                    <div style={{ flex: 1 }}>
                        <input
                            type="text"
                            placeholder="Search by Invoice, Shift, or Name..."
                            value={searchTerm}
                            onChange={(e) => setSearchTerm(e.target.value)}
                            style={{
                                width: '100%',
                                padding: '12px 16px',
                                borderRadius: '12px',
                                border: '1px solid #E5E7EB',
                                fontSize: '1rem',
                                outline: 'none'
                            }}
                        />
                    </div>
                    <select style={{ padding: '12px', borderRadius: '12px', border: '1px solid #E5E7EB', outline: 'none', fontWeight: 600 }}>
                        <option>All Statuses</option>
                        <option>Paid</option>
                        <option>Unpaid</option>
                    </select>
                </div>

                {/* Data Table */}
                <div style={{
                    backgroundColor: '#FFFFFF',
                    borderRadius: '24px',
                    boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.05)',
                    overflow: 'hidden',
                    border: '1px solid #F3F4F6'
                }}>
                    <div style={{ overflowX: 'auto' }}>
                        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                            <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #F3F4F6' }}>
                                <tr>
                                    {['Invoice ID', 'Date', 'Shift ID', 'Client', 'PSW', 'Revenue', 'Profit', 'Status', 'Actions'].map(header => (
                                        <th key={header} style={{ padding: '20px', color: '#6B7280', fontSize: '0.8rem', fontWeight: 800, textTransform: 'uppercase' }}>{header}</th>
                                    ))}
                                </tr>
                            </thead>
                            <tbody>
                                {MOCK_EARNINGS.map(record => (
                                    <tr key={record.id} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                        <td style={{ padding: '20px', fontWeight: 800 }}>{record.id}</td>
                                        <td style={{ padding: '20px', fontWeight: 700 }}>{record.date}</td>
                                        <td style={{ padding: '20px', color: '#00875A', fontWeight: 800 }}>{record.shiftId}</td>
                                        <td style={{ padding: '20px', fontWeight: 700 }}>{record.client}</td>
                                        <td style={{ padding: '20px', fontWeight: 700 }}>{record.psw}</td>
                                        <td style={{ padding: '20px', fontWeight: 900 }}>${record.revenue.toFixed(2)}</td>
                                        <td style={{ padding: '20px', fontWeight: 900, color: '#00875A' }}>${record.profit.toFixed(2)}</td>
                                        <td style={{ padding: '20px' }}>
                                            <span style={{
                                                padding: '6px 12px',
                                                borderRadius: '20px',
                                                fontSize: '0.75rem',
                                                fontWeight: 900,
                                                backgroundColor: record.paymentStatus === 'Paid' ? '#E6F4EF' : '#FEE2E2',
                                                color: record.paymentStatus === 'Paid' ? '#00875A' : '#B91C1C'
                                            }}>{record.paymentStatus}</span>
                                        </td>
                                        <td style={{ padding: '20px' }}>
                                            <button style={{ padding: '8px 12px', background: '#F3F4F6', border: 'none', borderRadius: '8px', cursor: 'pointer', fontWeight: 700 }}>View Details</button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <style>{`
                @keyframes fadeIn {
                    from { opacity: 0; transform: translateY(10px); }
                    to { opacity: 1; transform: translateY(0); }
                }
            `}</style>
    );
}

