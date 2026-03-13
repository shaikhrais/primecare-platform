import React, { useState, useMemo, useEffect } from 'react';
import { SmartBreadcrumbs } from '@/shared/components/SmartBreadcrumbs';
import { useSearchParams } from 'react-router-dom';
import { EarningRecord } from './earnings.data';
import { apiClient } from '@/shared/utils/apiClient';
import { EarningStats } from './components/EarningStats';
import { EarningsTable } from './components/EarningsTable';
import { EarningsFilters } from './components/EarningsFilters';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export default function AdminEarningsPage() {
    const { t } = useTranslation();
    const [searchParams, setSearchParams] = useSearchParams();
    const [activeTab, setActiveTab] = useState(searchParams.get('tab') || 'Overview');
    const [searchTerm, setSearchTerm] = useState(searchParams.get('search') || '');
    const [showDatePicker, setShowDatePicker] = useState(false);
    const [dateRange, setDateRange] = useState({ start: '', end: '' });
    const [earnings, setEarnings] = useState<EarningRecord[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchEarnings = async () => {
            try {
                const res = await apiClient.get('/v1/system/financial/earnings');
                if (res.ok) {
                    const data = await res.json();
                    setEarnings(data);
                }
            } catch (error) {
                console.error("Failed to load earnings", error);
            } finally {
                setLoading(false);
            }
        };
        fetchEarnings();
    }, []);

    // Sync URL with Tab Selection
    useEffect(() => {
        const currentTab = searchParams.get('tab');
        if (currentTab && currentTab !== activeTab) {
            setActiveTab(currentTab);
        }
    }, [searchParams, activeTab]);

    const handleTabChange = (tab: string) => {
        setActiveTab(tab);
        setSearchParams(prev => {
            prev.set('tab', tab);
            return prev;
        });
    };

    // Filter Logic
    const filteredEarnings = useMemo(() => {
        let filtered = earnings;

        // Search Filter
        if (searchTerm) {
            const lowerTerm = searchTerm.toLowerCase();
            filtered = filtered.filter(r =>
                r.id.toLowerCase().includes(lowerTerm) ||
                r.client.toLowerCase().includes(lowerTerm) ||
                r.psw.toLowerCase().includes(lowerTerm) ||
                r.shiftId.toLowerCase().includes(lowerTerm)
            );
        }

        // Date Range Filter
        if (dateRange.start) {
            filtered = filtered.filter(r => r.date >= dateRange.start);
        }
        if (dateRange.end) {
            filtered = filtered.filter(r => r.date <= dateRange.end);
        }

        return filtered;
    }, [searchTerm, dateRange, earnings]);

    // Recalculate Stats based on Filtered Data
    const totalRevenue = filteredEarnings.reduce((acc: number, curr: EarningRecord) => acc + curr.revenue, 0);
    const totalPayroll = filteredEarnings.reduce((acc: number, curr: EarningRecord) => acc + curr.payroll, 0);
    const netProfit = filteredEarnings.reduce((acc: number, curr: EarningRecord) => acc + curr.profit, 0);
    const payoutsPending = filteredEarnings.filter(r => r.payoutStatus === 'Pending').reduce((acc: number, curr: EarningRecord) => acc + curr.payroll, 0);

    const stats = [
        { label: t(ContentRegistry.EARNINGS.STATS.REVENUE), value: `$${totalRevenue.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+12.5%', color: '#00875A' },
        { label: t(ContentRegistry.EARNINGS.STATS.PAYROLL), value: `$${totalPayroll.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+8.2%', color: '#3B82F6' },
        { label: t(ContentRegistry.EARNINGS.STATS.PROFIT), value: `$${netProfit.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '+18.4%', color: '#8B5CF6' },
        { label: t(ContentRegistry.EARNINGS.STATS.PENDING), value: `$${payoutsPending.toLocaleString(undefined, { minimumFractionDigits: 2 })}`, trend: '-5.1%', color: '#F59E0B' },
    ];

    const handleExport = () => {
        if (filteredEarnings.length === 0) {
            alert(t(ContentRegistry.COMMON.NO_RESULTS));
            return;
        }

        // CSV Headers
        const headers = [
            t(ContentRegistry.EARNINGS.INVOICE_ID),
            t(ContentRegistry.SHARED.STATUS),
            t(ContentRegistry.EARNINGS.CLIENT),
            t(ContentRegistry.EARNINGS.PSW),
            t(ContentRegistry.EARNINGS.REVENUE),
            t(ContentRegistry.EARNINGS.PAYROLL),
            t(ContentRegistry.EARNINGS.PROFIT)
        ];

        // CSV Rows
        const rows = filteredEarnings.map((r: EarningRecord) => [
            r.id,
            r.date,
            r.shiftId,
            r.client,
            r.psw,
            r.revenue.toFixed(2),
            r.payroll.toFixed(2),
            r.profit.toFixed(2),
            r.paymentStatus
        ]);

        // Combine to CSV string
        const csvContent = [
            headers.join(','),
            ...rows.map((row: string[]) => row.join(','))
        ].join('\n');

        // Create Blob and Download
        const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.setAttribute('href', url);
        link.setAttribute('download', `earnings_report_${new Date().toISOString().split('T')[0]}.csv`);
        link.style.visibility = 'hidden';
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    };

    return (
        <>
            <div style={{ padding: '2rem', display: 'flex', flexDirection: 'column', gap: '2rem', animation: 'fadeIn 0.5s ease-out' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end' }}>
                    <div>
                        <SmartBreadcrumbs />
                        <h1 style={{ margin: '0.5rem 0 0 0', fontSize: '2.5rem', fontWeight: 900, color: '#111827' }}>{t(ContentRegistry.EARNINGS.TITLE)}</h1>
                        <p style={{ margin: '4px 0 0 0', color: '#6B7280', fontWeight: 500 }}>{t(ContentRegistry.EARNINGS.SUBTITLE)}</p>
                    </div>
                    <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                        {showDatePicker && (
                            <div style={{ display: 'flex', gap: '8px', backgroundColor: 'white', padding: '8px', borderRadius: '12px', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}>
                                <input data-cy="input-admin.index-0"
                                    type="date"
                                    value={dateRange.start}
                                    onChange={(e) => setDateRange({ ...dateRange, start: e.target.value })}
                                    style={{ border: '1px solid #E5E7EB', borderRadius: '8px', padding: '4px' }}
                                />
                                <span style={{ alignSelf: 'center' }}>-</span>
                                <input data-cy="input-admin.index-1"
                                    type="date"
                                    value={dateRange.end}
                                    onChange={(e) => setDateRange({ ...dateRange, end: e.target.value })}
                                    style={{ border: '1px solid #E5E7EB', borderRadius: '8px', padding: '4px' }}
                                />
                            </div>
                        )}
                        <button data-cy="btn-admin.index-0"
                            onClick={() => setShowDatePicker(!showDatePicker)}
                            style={{ padding: '12px 20px', backgroundColor: showDatePicker ? '#E5E7EB' : '#F3F4F6', border: '1px solid #E5E7EB', borderRadius: '12px', fontWeight: 700, cursor: 'pointer' }}
                        >
                            📅 {dateRange.start || dateRange.end ? t(ContentRegistry.EARNINGS.ACTIONS.FILTER_ACTIVE) : t(ContentRegistry.EARNINGS.ACTIONS.DATE_RANGE)}
                        </button>
                        <button data-cy="btn-admin.index-1"
                            onClick={handleExport}
                            style={{ padding: '12px 24px', backgroundColor: '#000000', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 800, cursor: 'pointer', boxShadow: '0 4px 14px 0 rgba(0, 0, 0, 0.2)' }}
                        >
                            📤 {t(ContentRegistry.EARNINGS.ACTIONS.EXPORT)}
                        </button>
                    </div>
                </div>

                <EarningStats stats={stats} />

                {/* Tab System */}
                <div style={{ display: 'flex', gap: '2rem', borderBottom: '1px solid #E5E7EB', padding: '0 8px' }}>
                    {[
                        t(ContentRegistry.EARNINGS.TABS.OVERVIEW),
                        t(ContentRegistry.EARNINGS.TABS.INVOICES),
                        t(ContentRegistry.EARNINGS.TABS.PAYOUTS),
                        t(ContentRegistry.EARNINGS.TABS.REPORTS)
                    ].map(tab => (
                        <button data-cy="btn-admin.index-2"
                            key={tab}
                            onClick={() => handleTabChange(tab)}
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

                <EarningsFilters searchTerm={searchTerm} setSearchTerm={setSearchTerm} />

                {loading ? <div style={{ textAlign: 'center', padding: '48px', color: '#6B7280' }}>Loading earnings ledger...</div> : <EarningsTable earnings={filteredEarnings} />}
            </div>

            <style>{`
                @keyframes fadeIn {
                    from { opacity: 0; transform: translateY(10px); }
                    to { opacity: 1; transform: translateY(0); }
                }
            `}</style>
        </>
    );
}
