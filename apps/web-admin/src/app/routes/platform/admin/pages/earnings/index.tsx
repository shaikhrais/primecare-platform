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
import { calculateStats, filterEarnings, handleExport } from './earningsHelpers';

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

    const filteredEarnings = useMemo(() => filterEarnings(earnings, searchTerm, dateRange), [searchTerm, dateRange, earnings]);
    const stats = calculateStats(filteredEarnings, t, ContentRegistry);

    const onExport = () => handleExport(filteredEarnings, t, ContentRegistry);

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
                            onClick={onExport}
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
