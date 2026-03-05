import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry, ButtonRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './CoordinatorHub.css';

const { COORDINATOR_HUB } = ContentRegistry;

export default function CoordinatorHub() {
    const [stats, setStats] = useState({
        livePsw: 0,
        sosActive: 0,
        pendingMatches: 0,
        waitlistCount: 0
    });
    const [incidents, setIncidents] = useState<any[]>([]);
    const [waitlist, setWaitlist] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchData = async () => {
            try {
                // Fetch live stats from ApiRegistry
                const statsData = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.DASHBOARD_STATS);
                if (statsData) setStats(statsData as any);

                // Fetch waitlist sync from ApiRegistry
                const waitlistData = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.WAITLIST_SYNC);
                if (waitlistData && Array.isArray(waitlistData)) setWaitlist(waitlistData);

                // Mocking incidents for now as per shared logic
                setIncidents([
                    { id: '1', type: 'sos_alert', description: 'Emergency SOS: PSW Jane Doe at 123 Main St', status: 'open', createdAt: new Date().toISOString() }
                ]);

                setLoading(false);
            } catch (error) {
                console.error('Failed to fetch coordinator data:', error);
                setLoading(false);
            }
        };

        fetchData();
    }, []);

    const acknowledgeSos = async (incidentId: string) => {
        try {
            await apiClient.post(ApiRegistry.COORDINATOR.SOS_ACK, { incidentId });
            setIncidents(incidents.map(inc => inc.id === incidentId ? { ...inc, status: 'investigating' } : inc));
        } catch (error) {
            console.error('Failed to acknowledge SOS:', error);
        }
    };

    if (loading) {
        return (
            <div className="coordinator-hub-container">
                <div className="empty-state">
                    <div className="loading-spinner"></div>
                    <p>Synchronizing Logistics Control Center...</p>
                </div>
            </div>
        );
    }

    return (
        <div className="coordinator-hub-container">
            <header className="hub-header">
                <h1>{COORDINATOR_HUB.TITLE}</h1>
                <p>{COORDINATOR_HUB.SUBTITLE}</p>
            </header>

            <section className="stats-grid">
                <div className="stat-card blue">
                    <span className="stat-label">{COORDINATOR_HUB.STATS.LIVE_PSW}</span>
                    <div className="stat-value">{stats.livePsw}</div>
                </div>
                <div className="stat-card red">
                    <span className="stat-label">{COORDINATOR_HUB.STATS.SOS_ACTIVE}</span>
                    <div className="stat-value" style={{ color: '#ef4444' }}>{stats.sosActive}</div>
                </div>
                <div className="stat-card amber">
                    <span className="stat-label">{COORDINATOR_HUB.STATS.PENDING_MATCHES}</span>
                    <div className="stat-value">{stats.pendingMatches}</div>
                </div>
                <div className="stat-card green">
                    <span className="stat-label">{COORDINATOR_HUB.STATS.WAITLIST_COUNT}</span>
                    <div className="stat-value">{stats.waitlistCount}</div>
                </div>
            </section>

            <div className="main-content-grid">
                <div className="left-column">
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{COORDINATOR_HUB.SOS_TITLE}</h2>
                            {incidents.length > 0 && <span className="pc-badge danger">{incidents.length} Critical</span>}
                        </div>
                        <div className="card-body">
                            {incidents.length === 0 ? (
                                <div className="empty-state">No active SOS alerts.</div>
                            ) : (
                                incidents.map(inc => (
                                    <div key={inc.id} className="incident-item">
                                        <div className="incident-info">
                                            <h3>{inc.description}</h3>
                                            <p>{new Date(inc.createdAt).toLocaleTimeString()} • US-EAST-1 Node</p>
                                        </div>
                                        {inc.status === 'open' && (
                                            <button onClick={() => acknowledgeSos(inc.id)} className="btn-premium danger">
                                                {ButtonRegistry.find(b => b.id === 'btn-coord-sos-ack-v2')?.label || COORDINATOR_HUB.ACTIONS.ACKNOWLEDGE_SOS}
                                            </button>
                                        )}
                                    </div>
                                ))
                            )}
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{COORDINATOR_HUB.MAP_TITLE}</h2>
                            <button className="btn-premium secondary" style={{ fontSize: '0.75rem' }}>
                                {ButtonRegistry.find(b => b.id === 'btn-coord-optimize')?.label || 'Open Advanced Radar'}
                            </button>
                        </div>
                        <div className="card-body">
                            <div className="map-placeholder">
                                <span className="map-icon">📍</span>
                                <p style={{ fontWeight: 700, fontSize: '1.2rem' }}>Live Interactive Dispatch Radar</p>
                                <p style={{ color: '#64748b', marginTop: '0.5rem' }}>Tracking {stats.livePsw} encrypted provider nodes across the region.</p>
                            </div>
                        </div>
                    </article>
                </div>

                <div className="right-column">
                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{COORDINATOR_HUB.WAITLIST_TITLE}</h2>
                        </div>
                        <div className="card-body" style={{ padding: 0 }}>
                            <div className="waitlist-list">
                                {waitlist.length === 0 ? (
                                    <div className="empty-state">Waitlist is clear.</div>
                                ) : (
                                    waitlist.map(entry => (
                                        <div key={entry.id} className="waitlist-item">
                                            <div>
                                                <div style={{ fontWeight: 700 }}>{entry.clientName}</div>
                                                <div style={{ fontSize: '0.75rem', color: '#64748b' }}>{entry.serviceType}</div>
                                            </div>
                                            <span className="pc-badge info">P{entry.priority}</span>
                                        </div>
                                    ))
                                )}
                            </div>
                            <div style={{ padding: '1.5rem', borderTop: '1px solid #f1f5f9' }}>
                                <button className="btn-premium" style={{ width: '100%' }}>
                                    {ButtonRegistry.find(b => b.id === 'btn-coord-waitlist-sync')?.label || COORDINATOR_HUB.ACTIONS.SYNC_WAITLIST}
                                </button>
                            </div>
                        </div>
                    </article>

                    <article className="bento-card">
                        <div className="card-header">
                            <h2>{COORDINATOR_HUB.GRID_TITLE}</h2>
                        </div>
                        <div className="card-body">
                            <div style={{ background: '#fef2f2', padding: '1rem', borderRadius: '0.75rem', border: '1px dashed #ef4444' }}>
                                <div style={{ fontWeight: 800, fontSize: '0.875rem', color: '#991b1b' }}>Unassigned Morning Shift</div>
                                <div style={{ fontSize: '0.75rem', color: '#b91c1c', marginTop: '0.25rem' }}>08:00 - 12:00 • Essential Care</div>
                                <button className="btn-premium" style={{ marginTop: '1rem', width: '100%', padding: '0.5rem' }}>
                                    {ButtonRegistry.find(b => b.id === 'btn-coord-match-override')?.label || COORDINATOR_HUB.ACTIONS.OVERRIDE_MATCH}
                                </button>
                            </div>
                        </div>
                    </article>
                </div>
            </div>
        </div>
    );
}
