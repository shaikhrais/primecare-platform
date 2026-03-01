import React, { useState, useEffect } from 'react';
import { ChartCard } from '@/shared/components/charts/ChartCard';
import { RevenueChart } from '@/shared/components/charts/RevenueChart';
import { VisitVolumeChart } from '@/shared/components/charts/VisitVolumeChart';
import { StaffUtilizationChart } from '@/shared/components/charts/StaffUtilizationChart';
import { MOCK_MANAGER_DATA } from '@/shared/data/mockChartData';

export default function ManagementPortfolio() {
    const [stats, setStats] = useState<any>(null);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        // In a real app, this would fetch aggregate data for all departments
        const timer = setTimeout(() => {
            setStats(MOCK_MANAGER_DATA);
            setLoading(false);
        }, 800);
        return () => clearTimeout(timer);
    }, []);

    if (loading) return <div style={{ padding: '2rem' }}>Loading Portfolio...</div>;

    return (
        <div data-cy="page.container">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 6px 0', fontSize: '34px', letterSpacing: '.2px', color: 'var(--text-100)' }}>Management Portfolio</h1>
                <p style={{ margin: 0, color: 'var(--text-400)' }}>Executive overview across all departments</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '24px', marginBottom: '2.5rem' }}>
                <div className="pc-card" style={{ padding: '1.5rem' }}>
                    <h4 style={{ margin: '0 0 0.5rem 0', color: 'var(--text-300)', textTransform: 'uppercase', fontSize: '0.7rem', letterSpacing: '1px' }}>Total Revenue (All Depts)</h4>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-500)' }}>$1,248,500</div>
                    <div style={{ fontSize: '0.85rem', color: '#10B981', marginTop: '0.5rem' }}>▲ 12.5% vs last month</div>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem' }}>
                    <h4 style={{ margin: '0 0 0.5rem 0', color: 'var(--text-300)', textTransform: 'uppercase', fontSize: '0.7rem', letterSpacing: '1px' }}>Fulfillment Rate</h4>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--text-900)' }}>94.2%</div>
                    <div style={{ fontSize: '0.85rem', color: '#10B981', marginTop: '0.5rem' }}>▲ 2.1% improvement</div>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem' }}>
                    <h4 style={{ margin: '0 0 0.5rem 0', color: 'var(--text-300)', textTransform: 'uppercase', fontSize: '0.7rem', letterSpacing: '1px' }}>Open Incidents</h4>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: '#EF4444' }}>8</div>
                    <div style={{ fontSize: '0.85rem', color: '#EF4444', marginTop: '0.5rem' }}>Critical attention required</div>
                </div>
            </div>

            <h2 style={{ fontSize: '1rem', fontWeight: 800, marginBottom: '1.5rem', color: 'var(--text-200)' }}>Departmental Health</h2>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(450px, 1fr))', gap: '24px' }}>
                <ChartCard title="Marketing & Sales" subtitle="Lead conversion and campaign ROI">
                    <RevenueChart data={stats.revenue} isDemo />
                </ChartCard>
                <ChartCard title="Operations & Logistics" subtitle="Visit volume and staff utilization">
                    <VisitVolumeChart data={stats.visitVolume} isDemo />
                </ChartCard>
                <ChartCard title="Human Resources" subtitle="Staff attendance and retention">
                    <StaffUtilizationChart data={stats.staffUtilization} isDemo />
                </ChartCard>
                <ChartCard title="Clinical Quality" subtitle="Incident tracking and adherence">
                    <div style={{ height: '300px', display: 'flex', alignItems: 'center', justifyContent: 'center', border: '2px dashed var(--border-100)', borderRadius: '12px', color: 'var(--text-400)' }}>
                        Quality Metrics Content
                    </div>
                </ChartCard>
            </div>
        </div>
    );
}
