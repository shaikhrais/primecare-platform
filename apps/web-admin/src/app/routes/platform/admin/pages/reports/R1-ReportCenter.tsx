// ================================================================
// PAGE IDENTITY: R1 � Report Center
// Registry ID:   page.admin.reports
// Type:          Report
// Owner:         admin
// ================================================================
import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { RevenueTrendChart } from '@/shared/components/charts/RevenueTrendChart';
import { StaffUtilizationChart } from '@/shared/components/charts/StaffUtilizationChart';
import { ClientGrowthChart } from '@/shared/components/charts/ClientGrowthChart';

const { ContentRegistry } = AdminRegistry;

export default function ReportsPage() {
    const [activeTab, setActiveTab] = useState<'overview' | 'financial' | 'staff' | 'clients'>('overview');
    const [dateRange, setDateRange] = useState('30d');

    const handleExport = () => {
 // export
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
        <div role="main" aria-label="Report Center" data-cy="page.reports">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h2 data-cy="h2-admin.report-center-0" style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>{ContentRegistry.REPORTS.TITLE}</h2>
                    <p style={{ color: '#6B7280', margin: '0.5rem 0 0 0' }}>{ContentRegistry.REPORTS.SUBTITLE}</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <select data-cy="select-admin.report-center-0"
                        value={dateRange}
                        onChange={(e) => setDateRange(e.target.value)}
                        style={{ padding: '0.5rem', borderRadius: '0.375rem', border: '1px solid #D1D5DB' }}
                    >
                        <option value="7d">{ContentRegistry.REPORTS.DATE_RANGES[7]}</option>
                        <option value="30d">{ContentRegistry.REPORTS.DATE_RANGES[30]}</option>
                        <option value="90d">{ContentRegistry.REPORTS.DATE_RANGES[90]}</option>
                        <option value="ytd">{ContentRegistry.REPORTS.DATE_RANGES.YEAR}</option>
                    </select>
                    <button data-cy="btn-admin.report-center-0"
                        onClick={handleExport}
                        style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontWeight: 600 }}
                    >
                        {ContentRegistry.REPORTS.EXPORT_BTN}
                    </button>
                </div>
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', borderBottom: '1px solid #E5E7EB', marginBottom: '2rem' }}>
                {[
                    { key: 'overview', label: ContentRegistry.REPORTS.TABS.OVERVIEW },
                    { key: 'financial', label: ContentRegistry.REPORTS.TABS.FINANCIAL },
                    { key: 'staff', label: ContentRegistry.REPORTS.TABS.STAFF },
                    { key: 'clients', label: ContentRegistry.REPORTS.TABS.CLIENTS },
                ].map((tab) => {
                    const { key, label } = tab;
                    return (
                        <button data-cy="btn-admin.report-center-1"
                            key={key}
                            onClick={() => setActiveTab(key as any)}
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
                            {label}
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
