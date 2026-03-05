import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './OperationsHub.css';

const { MANAGER_OPERATIONS } = ContentRegistry;

export default function OperationsHub() {
    const [stats, setStats] = useState({
        revenue: '$124,500',
        utilization: '88%',
        turnover: '4.2%',
        compliance: '96.5%'
    });
    const [alerts, setAlerts] = useState<any[]>([]);
    const [activities, setActivities] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchOpsData = async () => {
            try {
                // Fetch stats from ApiRegistry
                const opsData = await apiClient.get(ApiRegistry.TENANCY.MANAGER.OPS_STATS);
                if (opsData) {
                    const data = opsData as any;
                    setStats({
                        revenue: data.revenueMtd || '$124,500',
                        utilization: `${data.staffUtilization || 88}%`,
                        turnover: `${data.caregiverTurnover || 4.2}%`,
                        compliance: `${data.complianceScore || 96.5}%`
                    });
                }

                // Mocking alerts and activities for foundational parity
                setAlerts([
                    { id: '1', title: 'Critical Document Expiry', desc: '5 caregivers have CPR certifications expiring in < 7 days.', type: 'danger' },
                    { id: '2', title: 'Shift Divergence Pulse', desc: 'High volume of manual clock-outs detected in East Region.', type: 'warning' }
                ]);

                setActivities([
                    { id: '1', type: 'Clinical', user: 'RN Sarah J.', action: 'Verified 12 Daily Entries', time: '10m ago' },
                    { id: '2', type: 'Logistics', user: 'Coord. Mike', action: 'Overrode 1 Shift Match', time: '25m ago' },
                    { id: '3', type: 'System', user: 'Auto-Bot', action: 'Synced Payroll Ledger', time: '1h ago' }
                ]);

            } catch (error) {
                console.error('Failed to fetch operational data:', error);
            } finally {
                setLoading(false);
            }
        };

        fetchOpsData();
    }, []);

    const handleForceSync = async () => {
        try {
            await apiClient.post(ApiRegistry.TENANCY.MANAGER.COMPLIANCE_SYNC, {});
            alert(ContentRegistry.MANAGER_COMPLIANCE.MESSAGES.SYNC_SUCCESS);
        } catch (error) {
            console.error('Manual branch sync failed:', error);
        }
    };

    if (loading) {
        return (
            <div className="operations-hub-container">
                <div style={{ textAlign: 'center', padding: '100px' }}>
                    <p style={{ fontWeight: 700, color: '#64748b' }}>Synchronizing Operational Command Center...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="operations-hub-container">
            <header className="hub-header">
                <div>
                    <h1>{MANAGER_OPERATIONS.TITLE}</h1>
                    <p>{MANAGER_OPERATIONS.SUBTITLE}</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem' }}>
                    <button onClick={handleForceSync} className="btn-secondary-pc">{MANAGER_OPERATIONS.ACTIONS.GLOBAL_SYNC}</button>
                    <button className="btn-primary-pc">{MANAGER_OPERATIONS.ACTIONS.DOWNLOAD_REPORT}</button>
                </div>
            </header>

            <section className="kpi-grid">
                <div className="kpi-card" style={{ '--kpi-color': '#3b82f6' } as any}>
                    <span className="kpi-label">{MANAGER_OPERATIONS.KPI.REVENUE}</span>
                    <div className="kpi-value">{stats.revenue}</div>
                    <div className="kpi-trend trend-up">↑ 12.4% vs prev. month</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': '#8b5cf6' } as any}>
                    <span className="kpi-label">{MANAGER_OPERATIONS.KPI.UTILIZATION}</span>
                    <div className="kpi-value">{stats.utilization}</div>
                    <div className="kpi-trend trend-up">↑ 2.1% Optimized</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': '#f59e0b' } as any}>
                    <span className="kpi-label">{MANAGER_OPERATIONS.KPI.TURNOVER}</span>
                    <div className="kpi-value">{stats.turnover}</div>
                    <div className="kpi-trend trend-down">↓ 0.8% Target Met</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': '#10b981' } as any}>
                    <span className="kpi-label">{MANAGER_OPERATIONS.KPI.COMPLIANCE}</span>
                    <div className="kpi-value">{stats.compliance}</div>
                    <div className="kpi-trend trend-up">↑ Perfect Sync</div>
                </div>
            </section>

            <div className="dashboard-layout">
                <div className="main-feed">
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{MANAGER_OPERATIONS.ALERTS.HIGH_RISK}</h2>
                            <span className="badge-premium badge-amber">{alerts.length} Pending Triage</span>
                        </div>
                        <div className="card-body">
                            {alerts.map(alert => (
                                <div key={alert.id} className="alert-item">
                                    <div className="alert-icon">⚠️</div>
                                    <div className="alert-content">
                                        <h3>{alert.title}</h3>
                                        <p>{alert.desc}</p>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Live Audit Timeline</h2>
                        </div>
                        <div className="card-body">
                            <div className="activity-list">
                                {activities.map(act => (
                                    <div key={act.id} className="activity-item">
                                        <div className="activity-info">
                                            <h4>{act.user} - {act.action}</h4>
                                            <span>{act.time} via {act.type} Node</span>
                                        </div>
                                        <span className={`badge-premium ${act.type === 'Clinical' ? 'badge-blue' : 'badge-green'}`}>
                                            {act.type}
                                        </span>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </article>
                </div>

                <div className="operational-tools">
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Quick Resource Links</h2>
                        </div>
                        <div className="card-body">
                            <ul style={{ listStyle: 'none', padding: 0 }}>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: '#3b82f6', fontWeight: 600, textDecoration: 'none' }}>→ Healthcare Worker Registry</a>
                                </li>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: '#3b82f6', fontWeight: 600, textDecoration: 'none' }}>→ Strategic Growth Radar</a>
                                </li>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: '#3b82f6', fontWeight: 600, textDecoration: 'none' }}>→ Global Risk Assessment</a>
                                </li>
                            </ul>
                        </div>
                    </article>

                    <article className="bento-card" style={{ background: '#0f172a', color: 'white' }}>
                        <div className="card-body">
                            <h3 style={{ fontSize: '1rem', fontWeight: 800, marginBottom: '0.5rem' }}>AI Operations Pilot</h3>
                            <p style={{ fontSize: '0.8125rem', color: '#94a3b8', marginBottom: '1rem' }}>
                                Autonomous analysis suggests increasing recruitment in North York to meet weekend demand spikes.
                            </p>
                            <button className="btn-secondary-pc" style={{ width: '100%', border: 'none' }}>Review AI Proposal</button>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    );
}
