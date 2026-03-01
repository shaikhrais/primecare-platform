import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { RevenueTrendChart } from '@/shared/components/charts/RevenueTrendChart';
import { StaffUtilizationChart } from '@/shared/components/charts/StaffUtilizationChart';
import { ClientGrowthChart } from '@/shared/components/charts/ClientGrowthChart';

export default function ReportsPage() {
    const [activeTab, setActiveTab] = useState<'overview' | 'financial' | 'staff' | 'clients'>('overview');
    const [dateRange, setDateRange] = useState('30d');

    const handleExport = () => {
        // Mock export
        const csvContent = "data:text/csv;charset=utf-8,Date,Metric,Value\n2023-01,Revenue,50000";
        const encodedUri = encodeURI(csvContent);
        const link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", "report_export.csv");
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    return (
        <div data-cy="page.reports">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>Reports & Analytics</h2>
                    <p style={{ color: '#6B7280', margin: '0.5rem 0 0 0' }}>Visualize key performance indicators and operational metrics.</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <select
                        value={dateRange}
                        onChange={(e) => setDateRange(e.target.value)}
                        style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #D1D5DB' }}
                    >
                        <option value="7d">Last 7 Days</option>
                        <option value="30d">Last 30 Days</option>
                        <option value="90d">Last Quarter</option>
                        <option value="ytd">Year to Date</option>
                    </select>
                    <button
                        onClick={handleExport}
                        style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontWeight: 600 }}
                    >
                        Export CSV
                    </button>
                </div>
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', borderBottom: '1px solid #E5E7EB', marginBottom: '2rem' }}>
                {['Overview', 'Financial', 'Staff', 'Clients'].map((tab) => {
                    const key = tab.toLowerCase() as any;
                    return (
                        <button
                            key={key}
                            onClick={() => setActiveTab(key)}
                            style={{
                                padding: '1rem 1.5rem',
                                borderBottom: activeTab === key ? '2px solid #00875A' : '2px solid transparent',
                                color: activeTab === key ? '#00875A' : '#6B7280',
                                fontWeight: activeTab === key ? 600 : 400,
                                background: 'none',
                                borderTop: 'none',
                                borderLeft: 'none',
                                borderRight: 'none',
                                cursor: 'pointer',
                                fontSize: '1rem'
                            }}
                        >
                            {tab}
                        </button>
                    );
                })}
            </div>

            {/* Content Area */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(500px, 1fr))', gap: '1.5rem' }}>
                {(activeTab === 'overview' || activeTab === 'financial') && (
                    <RevenueTrendChart />
                )}
                {(activeTab === 'overview' || activeTab === 'clients') && (
                    <ClientGrowthChart />
                )}
                {(activeTab === 'overview' || activeTab === 'staff') && (
                    <StaffUtilizationChart />
                )}
            </div>
        </div>
    );
}
