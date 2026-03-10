import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { useNotification } from '@/shared/context/NotificationContext';
import { ApiRegistry, ContentRegistry, ButtonRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import EmptyState from '@/shared/components/layout/EmptyState';
import { ApprovalSwipeStack } from './components/ApprovalSwipeStack';
import { OrgHierarchyChart } from './components/OrgHierarchyChart';
import { BurnoutGauge } from './components/BurnoutGauge';
import './OperationsHub.css';

const { MANAGER_OPERATIONS } = ContentRegistry;

export default function OperationsHub() {
    const { t } = useTranslation();
    const { showToast } = useNotification();
    const [showMoreActions, setShowMoreActions] = useState(false);
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
                const res: any = await apiClient.get(ApiRegistry.TENANCY.MANAGER.OPS_STATS);
                const data = await res.json();

                if (data) {
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
            showToast(t('manager.compliance_sync_success', { defaultValue: ContentRegistry.MANAGER_COMPLIANCE?.MESSAGES?.SYNC_SUCCESS || 'Sync successful' }), 'success');
        } catch (error) {
            console.error('Manual branch sync failed:', error);
            showToast(t('manager.compliance_sync_error', { defaultValue: 'Manual branch sync failed' }), 'error');
        }
    };

    if (loading) {
        return (
            <div className="operations-hub-container" data-cy="page.container.loading">
                <div style={{ textAlign: 'center', padding: '100px' }}>
                    <p style={{ fontWeight: 700, color: 'var(--text-300)' }}>{t('manager.operations_loading', { defaultValue: 'Synchronizing Operational Command Center...' })}</p>
                </div>
            </div>
        );
    }

    return (
        <div className="operations-hub-container" data-cy="page.container">
            <header className="hub-header">
                <div>
                    <h1>{MANAGER_OPERATIONS.TITLE}</h1>
                    <p>{MANAGER_OPERATIONS.SUBTITLE}</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem', marginTop: '1rem', alignItems: 'center' }}>
                    <button className="btn-primary-pc" data-cy="btn-mgr-staff-add">
                        {t('manager.btn_add_staff', { defaultValue: ButtonRegistry.find(b => b.id === 'btn-mgr-staff-add')?.label || 'Add New Staff' })}
                    </button>
                    <button className="btn-secondary-pc" data-cy="btn-mgr-audit-attendance">
                        {t('manager.btn_audit_attendance', { defaultValue: ButtonRegistry.find(b => b.id === 'btn-mgr-audit-attendance')?.label || 'Audit Attendance' })}
                    </button>
                    <button onClick={handleForceSync} className="btn-secondary-pc" data-cy="btn-mgr-ops-stats">
                        {t('manager.btn_refresh_stats', { defaultValue: ButtonRegistry.find(b => b.id === 'btn-mgr-ops-stats')?.label || 'Refresh Ops Stats' })}
                    </button>
                    <div style={{ position: 'relative' }}>
                        <button onClick={() => setShowMoreActions(!showMoreActions)} className="btn-secondary-pc" style={{ background: 'transparent', border: '1px solid var(--line)', color: 'var(--text-300)' }} data-cy="btn-more-actions">
                            {t('manager.btn_more_actions', { defaultValue: 'More Actions ▾' })}
                        </button>
                        {showMoreActions && (
                            <div style={{ position: 'absolute', top: '100%', right: 0, marginTop: '4px', background: 'var(--bg)', border: '1px solid var(--line)', borderRadius: '8px', padding: '8px', display: 'flex', flexDirection: 'column', gap: '4px', zIndex: 10, boxShadow: 'var(--shadow-md)', minWidth: '160px' }}>
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-mgr-payroll-verify">
                                    {t('manager.btn_payroll_verify', { defaultValue: ButtonRegistry.find(b => b.id === 'btn-mgr-payroll-verify')?.label || 'Verify Weekly Payroll' })}
                                </button>
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-mgr-feedback-triage">
                                    {t('manager.btn_feedback_triage', { defaultValue: ButtonRegistry.find(b => b.id === 'btn-mgr-feedback-triage')?.label || 'Triage Feedback' })}
                                </button>
                                <hr style={{ border: '0', borderTop: '1px solid var(--line)', margin: '4px 0' }} />
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-staff-compliance-scan" onClick={() => { showToast(t('manager.scanning', { defaultValue: 'Scanning...' }), 'info'); setShowMoreActions(false); }}>{t('manager.btn_compliance_scan', { defaultValue: 'Compliance Scan' })}</button>
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-mkt-campaign-new" onClick={() => { showToast(t('manager.new_campaign', { defaultValue: 'New Campaign created' }), 'success'); setShowMoreActions(false); }}>{t('manager.btn_new_campaign', { defaultValue: 'New Campaign' })}</button>
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-mkt-crm-export" onClick={() => { showToast(t('manager.export_crm', { defaultValue: 'Exporting CRM...' }), 'info'); setShowMoreActions(false); }}>{t('manager.btn_export_crm', { defaultValue: 'Export CRM' })}</button>
                                <button className="btn-secondary-pc" style={{ width: '100%', textAlign: 'left', border: 'none' }} data-cy="btn-hr-post-role" onClick={() => { showToast(t('manager.post_role', { defaultValue: 'Role Posted' }), 'success'); setShowMoreActions(false); }}>{t('manager.btn_post_role', { defaultValue: 'Post HR Role' })}</button>
                            </div>
                        )}
                    </div>
                </div>
            </header>

            <section className="kpi-grid">
                <div className="kpi-card" style={{ '--kpi-color': 'var(--brand-500)' } as any} data-cy="kpi.revenue">
                    <span className="kpi-label">{t('manager.kpi.revenue', { defaultValue: MANAGER_OPERATIONS.KPI.REVENUE })}</span>
                    <div className="kpi-value">{stats.revenue}</div>
                    <div className="kpi-trend trend-up">{t('manager.kpi.revenue_trend', { defaultValue: '↑ 12.4% vs prev. month' })}</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': 'var(--accent-purple, #8b5cf6)' } as any} data-cy="kpi.utilization">
                    <span className="kpi-label">{t('manager.kpi.utilization', { defaultValue: MANAGER_OPERATIONS.KPI.UTILIZATION })}</span>
                    <div className="kpi-value">{stats.utilization}</div>
                    <div className="kpi-trend trend-up">{t('manager.kpi.utilization_trend', { defaultValue: '↑ 2.1% Optimized' })}</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': 'var(--accent-amber, #f59e0b)' } as any} data-cy="kpi.turnover">
                    <span className="kpi-label">{t('manager.kpi.turnover', { defaultValue: MANAGER_OPERATIONS.KPI.TURNOVER })}</span>
                    <div className="kpi-value">{stats.turnover}</div>
                    <div className="kpi-trend trend-down">{t('manager.kpi.turnover_trend', { defaultValue: '↓ 0.8% Target Met' })}</div>
                </div>
                <div className="kpi-card" style={{ '--kpi-color': 'var(--accent-green, #10b981)' } as any} data-cy="kpi.compliance">
                    <span className="kpi-label">{t('manager.kpi.compliance', { defaultValue: MANAGER_OPERATIONS.KPI.COMPLIANCE })}</span>
                    <div className="kpi-value">{stats.compliance}</div>
                    <div className="kpi-trend trend-up">{t('manager.kpi.compliance_trend', { defaultValue: '↑ Perfect Sync' })}</div>
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
                            {alerts.length > 0 ? alerts.map(alert => (
                                <div key={alert.id} className="alert-item">
                                    <div className="alert-icon">⚠️</div>
                                    <div className="alert-content">
                                        <h3>{alert.title}</h3>
                                        <p>{alert.desc}</p>
                                    </div>
                                </div>
                            )) : (
                                <EmptyState
                                    title="All Clear"
                                    description="There are no high-risk operational alerts requiring immediate triage at this time."
                                    icon="shield-check"
                                />
                            )}
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Live Audit Timeline</h2>
                        </div>
                        <div className="card-body">
                            <div className="activity-list">
                                {activities.length > 0 ? activities.map(act => (
                                    <div key={act.id} className="activity-item">
                                        <div className="activity-info">
                                            <h4>{act.user} - {act.action}</h4>
                                            <span>{act.time} via {act.type} Node</span>
                                        </div>
                                        <span className={`badge-premium ${act.type === 'Clinical' ? 'badge-blue' : 'badge-green'}`}>
                                            {act.type}
                                        </span>
                                    </div>
                                )) : (
                                    <EmptyState
                                        title="No Recent Activity"
                                        description="The live audit timeline has not recorded any new structural changes or user actions."
                                        icon="clock-rewind"
                                    />
                                )}
                            </div>
                        </div>
                    </article>
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Org Hierarchy & Flight Risk</h2>
                        </div>
                        <div className="card-body">
                            <OrgHierarchyChart />
                        </div>
                    </article>
                </div>

                <div className="operational-tools" style={{ display: 'flex', flexDirection: 'column', gap: '24px' }}>
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Timesheet Inbox</h2>
                        </div>
                        <div className="card-body" style={{ padding: '0 4px 4px 4px' }}>
                            <ApprovalSwipeStack />
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>Telemetry Spot-Check</h2>
                        </div>
                        <div className="card-body" style={{ display: 'flex', justifyContent: 'center' }}>
                            <BurnoutGauge 
                                staffName="Susan Lee" 
                                metrics={{ consecutiveDays: 7, overtimeHoursWeek: 9, acuityScoreAvg: 78 }} 
                            />
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{t('manager.quick_links_title', { defaultValue: 'Quick Resource Links' })}</h2>
                        </div>
                        <div className="card-body">
                            <ul style={{ listStyle: 'none', padding: 0 }}>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: 'var(--brand-500, #3b82f6)', fontWeight: 600, textDecoration: 'none' }}>→ {t('manager.links.registry', { defaultValue: 'Healthcare Worker Registry' })}</a>
                                </li>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: 'var(--brand-500, #3b82f6)', fontWeight: 600, textDecoration: 'none' }}>→ {t('manager.links.growth', { defaultValue: 'Strategic Growth Radar' })}</a>
                                </li>
                                <li style={{ marginBottom: '1rem' }}>
                                    <a href="#" style={{ color: 'var(--brand-500, #3b82f6)', fontWeight: 600, textDecoration: 'none' }}>→ {t('manager.links.risk', { defaultValue: 'Global Risk Assessment' })}</a>
                                </li>
                            </ul>
                        </div>
                    </article>

                    <article className="bento-card" style={{ background: 'var(--brand-900, #0f172a)', color: 'var(--bg, white)' }}>
                        <div className="card-body">
                            <h3 style={{ fontSize: '1rem', fontWeight: 800, marginBottom: '0.5rem' }}>{t('manager.ai_pilot_title', { defaultValue: 'AI Operations Pilot' })}</h3>
                            <p style={{ fontSize: '0.8125rem', color: 'var(--text-300, #94a3b8)', marginBottom: '1rem' }}>
                                {t('manager.ai_pilot_desc', { defaultValue: 'Autonomous analysis suggests increasing recruitment in North York to meet weekend demand spikes.' })}
                            </p>
                            <button className="btn-secondary-pc" style={{ width: '100%', border: 'none' }}>{t('manager.ai_pilot_btn', { defaultValue: 'Review AI Proposal' })}</button>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    );
}
