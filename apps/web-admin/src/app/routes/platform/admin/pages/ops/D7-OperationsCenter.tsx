// ================================================================
// PAGE IDENTITY: D7 · Live Operations Center
// Type: Dashboard | Owner: admin
// ================================================================
import React, { useState, useMemo } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useRealtimeQuery } from '@/shared/hooks/useRealtimeQuery';
import { LiveIndicator } from '@/shared/components/ui/LiveIndicator';
import { DashboardSkeleton } from '@/shared/components/ui/Skeleton';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

/* ── Types ─────────────────────────────────────────────────────── */
interface FleetUnit { id: string; name: string; status: 'available' | 'en_route' | 'on_site' | 'offline'; lat?: number; lng?: number; currentVisitId?: string; batteryLevel?: number; lastHeartbeatAt: string; }
interface ActiveVisit { id: string; clientName: string; pswName: string; status: string; startAt: string; duration: number; city?: string; checkInAt?: string; checkOutAt?: string; }
interface OpsAlert { id: string; type: 'late_arrival' | 'missed_checkin' | 'sos' | 'low_battery' | 'overtime' | 'unassigned'; severity: 'info' | 'warning' | 'critical'; message: string; timestamp: string; visitId?: string; pswId?: string; }
interface OpsStats { activeVisits: number; enRoutePsws: number; availablePool: number; completedToday: number; incidentsOpen: number; avgResponseMin: number; utilizationRate: number; lateArrivals: number; }

const STATUS_CONFIG: Record<string, { color: string; bg: string; label: string; icon: string }> = {
    available: { color: '#059669', bg: '#D1FAE5', label: 'Available', icon: '🟢' },
    en_route: { color: '#D97706', bg: '#FEF3C7', label: 'En Route', icon: '🚗' },
    on_site: { color: '#2563EB', bg: '#DBEAFE', label: 'On Site', icon: '🏠' },
    offline: { color: '#6B7280', bg: '#F3F4F6', label: 'Offline', icon: '⚫' },
};

const ALERT_SEVERITY_CONFIG: Record<string, { color: string; bg: string; border: string; icon: string }> = {
    critical: { color: '#DC2626', bg: '#FEF2F2', border: '#FECACA', icon: '🚨' },
    warning: { color: '#D97706', bg: '#FFFBEB', border: '#FDE68A', icon: '⚠️' },
    info: { color: '#2563EB', bg: '#EFF6FF', border: '#BFDBFE', icon: 'ℹ️' },
};

/* ── Sub-components ────────────────────────────────────────────── */

function MetricCard({ label, value, icon, trend, color = '#0369A1' }: { label: string; value: string | number; icon: string; trend?: string; color?: string }) {
    return (
        <div data-cy="ops-metric-card" style={{ background: 'var(--card-bg, white)', borderRadius: '16px', padding: '20px 24px', border: '1px solid var(--border, #E2E8F0)', display: 'flex', flexDirection: 'column', gap: '8px', position: 'relative', overflow: 'hidden' }}>
            <div style={{ position: 'absolute', top: '-8px', right: '-8px', fontSize: '3rem', opacity: 0.08 }}>{icon}</div>
            <span style={{ fontSize: '0.75rem', fontWeight: 600, textTransform: 'uppercase', letterSpacing: '0.05em', color: 'var(--text-muted, #94A3B8)' }}>{label}</span>
            <span style={{ fontSize: '2rem', fontWeight: 800, color, lineHeight: 1 }}>{value}</span>
            {trend && <span style={{ fontSize: '0.7rem', color: trend.startsWith('+') ? '#059669' : '#DC2626', fontWeight: 600 }}>{trend}</span>}
        </div>
    );
}

function LiveFleetMap({ fleet }: { fleet: FleetUnit[] }) {
    const grouped = useMemo(() => {
        const g: Record<string, FleetUnit[]> = { available: [], en_route: [], on_site: [], offline: [] };
        fleet.forEach(f => { (g[f.status] || g.offline).push(f); });
        return g;
    }, [fleet]);

    return (
        <div data-cy="ops-fleet-map" style={{ background: 'var(--card-bg, white)', borderRadius: '16px', border: '1px solid var(--border, #E2E8F0)', padding: '24px', height: '100%' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                <h3 style={{ margin: 0, fontSize: '1rem', fontWeight: 700, color: 'var(--text, #0F172A)' }}>🗺️ Fleet Tracker</h3>
                <div style={{ display: 'flex', gap: '12px', flexWrap: 'wrap' }}>
                    {Object.entries(STATUS_CONFIG).map(([key, cfg]) => (
                        <span key={key} style={{ display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.7rem', fontWeight: 600, color: cfg.color }}>
                            {cfg.icon} {cfg.label} ({grouped[key]?.length || 0})
                        </span>
                    ))}
                </div>
            </div>

            {/* Map visualization placeholder - renders as an interactive grid */}
            <div style={{ background: 'linear-gradient(135deg, #0F172A 0%, #1E293B 50%, #0F172A 100%)', borderRadius: '12px', padding: '20px', minHeight: '320px', position: 'relative', overflow: 'hidden' }}>
                {/* Grid overlay */}
                <div style={{ position: 'absolute', inset: 0, opacity: 0.1, backgroundImage: 'linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px)', backgroundSize: '40px 40px' }} />

                {/* PSW dots on map */}
                <div style={{ position: 'relative', display: 'flex', flexWrap: 'wrap', gap: '8px', padding: '12px' }}>
                    {fleet.length === 0 && (
                        <div style={{ width: '100%', textAlign: 'center', padding: '60px 20px', color: 'rgba(255,255,255,0.4)' }}>
                            <div style={{ fontSize: '2rem', marginBottom: '8px' }}>📡</div>
                            <div style={{ fontSize: '0.85rem' }}>Waiting for fleet heartbeats...</div>
                        </div>
                    )}
                    {fleet.map((unit, i) => {
                        const cfg = STATUS_CONFIG[unit.status] || STATUS_CONFIG.offline;
                        return (
                            <div key={unit.id} data-cy={`fleet-unit-${unit.id}`} title={`${unit.name} — ${cfg.label}`} style={{
                                background: cfg.bg, border: `2px solid ${cfg.color}`, borderRadius: '10px', padding: '8px 12px',
                                display: 'flex', alignItems: 'center', gap: '8px', cursor: 'pointer',
                                transition: 'transform 0.2s, box-shadow 0.2s',
                                animation: unit.status === 'en_route' ? 'pulse 2s infinite' : 'none',
                            }}>
                                <span style={{ fontSize: '1rem' }}>{cfg.icon}</span>
                                <div>
                                    <div style={{ fontSize: '0.75rem', fontWeight: 700, color: cfg.color, maxWidth: '120px', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>{unit.name}</div>
                                    <div style={{ fontSize: '0.6rem', color: '#64748B' }}>
                                        {unit.batteryLevel != null && `🔋 ${unit.batteryLevel}%`}
                                    </div>
                                </div>
                            </div>
                        );
                    })}
                </div>

                {/* Animated scan line */}
                <div style={{ position: 'absolute', bottom: 0, left: 0, right: 0, height: '2px', background: 'linear-gradient(90deg, transparent, #38BDF8, transparent)', animation: 'scanline 3s linear infinite' }} />
            </div>
        </div>
    );
}

function VisitTimeline({ visits }: { visits: ActiveVisit[] }) {
    return (
        <div data-cy="ops-visit-timeline" style={{ background: 'var(--card-bg, white)', borderRadius: '16px', border: '1px solid var(--border, #E2E8F0)', padding: '24px', height: '100%' }}>
            <h3 style={{ margin: '0 0 16px 0', fontSize: '1rem', fontWeight: 700, color: 'var(--text, #0F172A)' }}>📋 Live Visit Feed</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', maxHeight: '400px', overflowY: 'auto' }}>
                {visits.length === 0 && (
                    <div style={{ textAlign: 'center', padding: '40px 20px', color: 'var(--text-muted, #94A3B8)' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>📋</div>
                        <div style={{ fontSize: '0.8rem' }}>No active visits right now</div>
                    </div>
                )}
                {visits.map(visit => {
                    const isCheckedIn = !!visit.checkInAt;
                    const isCompleted = visit.status === 'completed';
                    const statusColor = isCompleted ? '#059669' : isCheckedIn ? '#2563EB' : '#D97706';
                    const statusLabel = isCompleted ? '✅ Completed' : isCheckedIn ? '🏠 In Progress' : '⏳ Pending';
                    return (
                        <div key={visit.id} data-cy={`visit-${visit.id}`} style={{
                            display: 'flex', alignItems: 'center', gap: '12px', padding: '12px 16px', borderRadius: '10px',
                            background: 'var(--bg-secondary, #F8FAFC)', border: '1px solid var(--border, #E2E8F0)',
                            transition: 'background 0.2s',
                        }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: statusColor, flexShrink: 0, boxShadow: `0 0 8px ${statusColor}40` }} />
                            <div style={{ flex: 1, minWidth: 0 }}>
                                <div style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--text, #0F172A)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                    {visit.clientName}
                                </div>
                                <div style={{ fontSize: '0.7rem', color: 'var(--text-muted, #94A3B8)' }}>
                                    {visit.pswName} • {visit.duration}min {visit.city ? `• ${visit.city}` : ''}
                                </div>
                            </div>
                            <span style={{ fontSize: '0.65rem', fontWeight: 600, color: statusColor, background: `${statusColor}15`, padding: '4px 8px', borderRadius: '6px', whiteSpace: 'nowrap' }}>{statusLabel}</span>
                        </div>
                    );
                })}
            </div>
        </div>
    );
}

function AlertsPanel({ alerts }: { alerts: OpsAlert[] }) {
    return (
        <div data-cy="ops-alerts-panel" style={{ background: 'var(--card-bg, white)', borderRadius: '16px', border: '1px solid var(--border, #E2E8F0)', padding: '24px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '16px' }}>
                <h3 style={{ margin: 0, fontSize: '1rem', fontWeight: 700, color: 'var(--text, #0F172A)' }}>🔔 Smart Alerts</h3>
                {alerts.length > 0 && (
                    <span style={{ background: '#DC2626', color: 'white', fontSize: '0.65rem', fontWeight: 700, padding: '2px 8px', borderRadius: '10px' }}>{alerts.length}</span>
                )}
            </div>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', maxHeight: '320px', overflowY: 'auto' }}>
                {alerts.length === 0 && (
                    <div style={{ textAlign: 'center', padding: '40px 20px', color: 'var(--text-muted, #94A3B8)' }}>
                        <div style={{ fontSize: '1.5rem', marginBottom: '8px' }}>✅</div>
                        <div style={{ fontSize: '0.8rem' }}>All clear — no active alerts</div>
                    </div>
                )}
                {alerts.map(alert => {
                    const cfg = ALERT_SEVERITY_CONFIG[alert.severity] || ALERT_SEVERITY_CONFIG.info;
                    return (
                        <div key={alert.id} data-cy={`alert-${alert.id}`} style={{
                            display: 'flex', gap: '10px', padding: '10px 14px', borderRadius: '10px',
                            background: cfg.bg, border: `1px solid ${cfg.border}`,
                        }}>
                            <span style={{ fontSize: '1rem', flexShrink: 0 }}>{cfg.icon}</span>
                            <div style={{ flex: 1, minWidth: 0 }}>
                                <div style={{ fontSize: '0.78rem', fontWeight: 600, color: cfg.color }}>{alert.message}</div>
                                <div style={{ fontSize: '0.65rem', color: '#94A3B8', marginTop: '2px' }}>
                                    {new Date(alert.timestamp).toLocaleTimeString()} • {alert.type.replace(/_/g, ' ')}
                                </div>
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
}

function UtilizationGauge({ rate }: { rate: number }) {
    const pct = Math.min(Math.max(rate, 0), 100);
    const color = pct >= 85 ? '#059669' : pct >= 60 ? '#D97706' : '#DC2626';
    return (
        <div data-cy="ops-utilization" style={{ background: 'var(--card-bg, white)', borderRadius: '16px', border: '1px solid var(--border, #E2E8F0)', padding: '24px', textAlign: 'center' }}>
            <h3 style={{ margin: '0 0 16px 0', fontSize: '1rem', fontWeight: 700, color: 'var(--text, #0F172A)' }}>📊 Staff Utilization</h3>
            <div style={{ width: '140px', height: '140px', margin: '0 auto', position: 'relative' }}>
                <svg viewBox="0 0 120 120" style={{ transform: 'rotate(-90deg)' }}>
                    <circle cx="60" cy="60" r="50" fill="none" stroke="var(--border, #E2E8F0)" strokeWidth="10" />
                    <circle cx="60" cy="60" r="50" fill="none" stroke={color} strokeWidth="10"
                        strokeDasharray={`${pct * 3.14} ${(100 - pct) * 3.14}`}
                        strokeLinecap="round" style={{ transition: 'stroke-dasharray 1s ease' }} />
                </svg>
                <div style={{ position: 'absolute', inset: 0, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{ fontSize: '1.8rem', fontWeight: 800, color }}>{pct}%</span>
                    <span style={{ fontSize: '0.65rem', color: 'var(--text-muted, #94A3B8)' }}>utilization</span>
                </div>
            </div>
        </div>
    );
}

/* ── CSS Keyframes ─────────────────────────────────────────────── */
const keyframeStyles = `
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
@keyframes scanline { 0% { transform: translateX(-100%); } 100% { transform: translateX(100%); } }
`;

/* ── Main Page ─────────────────────────────────────────────────── */
export default function OperationsCenter() {
    const [filterStatus, setFilterStatus] = useState<string | null>(null);

    // Real-time data polling
    const { data: opsData, isLoading, isLive, lastUpdated } = useRealtimeQuery<{
        stats: OpsStats; fleet: FleetUnit[]; visits: ActiveVisit[]; alerts: OpsAlert[];
    }>('/v1/admin/ops/center', {
        queryKey: ['ops', 'center'],
        interval: 5_000, // 5-second refresh for live ops
    });

    const stats: OpsStats = opsData?.stats ?? { activeVisits: 0, enRoutePsws: 0, availablePool: 0, completedToday: 0, incidentsOpen: 0, avgResponseMin: 0, utilizationRate: 0, lateArrivals: 0 };
    const fleet: FleetUnit[] = useMemo(() => {
        const f = opsData?.fleet ?? [];
        return filterStatus ? f.filter(u => u.status === filterStatus) : f;
    }, [opsData?.fleet, filterStatus]);
    const visits: ActiveVisit[] = opsData?.visits ?? [];
    const alerts: OpsAlert[] = opsData?.alerts ?? [];

    if (isLoading) return <DashboardSkeleton />;

    return (
        <div data-cy="D7-page" style={{ padding: '24px', maxWidth: '1600px', margin: '0 auto' }}>
            <style>{keyframeStyles}</style>

            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px', flexWrap: 'wrap', gap: '12px' }}>
                <div>
                    <h1 style={{ margin: '0 0 4px 0', fontSize: '1.75rem', fontWeight: 800, color: 'var(--text, #0F172A)' }} data-cy="page.title">
                        🛰️ Live Operations Center
                    </h1>
                    <p style={{ margin: 0, fontSize: '0.85rem', color: 'var(--text-muted, #94A3B8)', display: 'flex', alignItems: 'center', gap: '8px' }} data-cy="page.subtitle">
                        Real-time visibility into field operations, fleet tracking, and visit management
                        <LiveIndicator isLive={isLive} lastUpdated={lastUpdated} />
                    </p>
                </div>
                <div style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
                    <button data-cy="btn-filter-all" onClick={() => setFilterStatus(null)}
                        style={{ padding: '6px 14px', borderRadius: '8px', border: !filterStatus ? '2px solid #0369A1' : '1px solid var(--border, #E2E8F0)', background: !filterStatus ? '#0369A110' : 'var(--card-bg, white)', color: !filterStatus ? '#0369A1' : 'var(--text-muted, #64748B)', fontWeight: 600, fontSize: '0.75rem', cursor: 'pointer' }}>
                        All
                    </button>
                    {Object.entries(STATUS_CONFIG).map(([key, cfg]) => (
                        <button key={key} data-cy={`btn-filter-${key}`} onClick={() => setFilterStatus(filterStatus === key ? null : key)}
                            style={{ padding: '6px 14px', borderRadius: '8px', border: filterStatus === key ? `2px solid ${cfg.color}` : '1px solid var(--border, #E2E8F0)', background: filterStatus === key ? cfg.bg : 'var(--card-bg, white)', color: filterStatus === key ? cfg.color : 'var(--text-muted, #64748B)', fontWeight: 600, fontSize: '0.75rem', cursor: 'pointer' }}>
                            {cfg.icon} {cfg.label}
                        </button>
                    ))}
                </div>
            </div>

            {/* KPI Cards */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))', gap: '12px', marginBottom: '24px' }}>
                <MetricCard label="Active Visits" value={stats.activeVisits} icon="🏠" color="#2563EB" />
                <MetricCard label="En Route" value={stats.enRoutePsws} icon="🚗" color="#D97706" />
                <MetricCard label="Available Pool" value={stats.availablePool} icon="👤" color="#059669" />
                <MetricCard label="Completed Today" value={stats.completedToday} icon="✅" color="#059669" />
                <MetricCard label="Incidents Open" value={stats.incidentsOpen} icon="🚨" color={stats.incidentsOpen > 0 ? '#DC2626' : '#059669'} />
                <MetricCard label="Avg Response" value={`${stats.avgResponseMin}m`} icon="⚡" color="#7C3AED" />
                <MetricCard label="Late Arrivals" value={stats.lateArrivals} icon="⏰" color={stats.lateArrivals > 0 ? '#DC2626' : '#059669'} />
            </div>

            {/* Main Grid: Map + Timeline + Alerts */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px', marginBottom: '24px' }}>
                <LiveFleetMap fleet={fleet} />
                <VisitTimeline visits={visits} />
            </div>

            {/* Bottom Row: Alerts + Utilization */}
            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '16px' }}>
                <AlertsPanel alerts={alerts} />
                <UtilizationGauge rate={stats.utilizationRate} />
            </div>
        </div>
    );
}
