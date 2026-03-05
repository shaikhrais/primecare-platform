import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry, ButtonRegistry } from 'prime-care-shared';

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
                // In a real app, these would be API calls
                // Fetch stats, incidents, waitlist
                setStats({
                    livePsw: 12,
                    sosActive: 1,
                    pendingMatches: 8,
                    waitlistCount: 5
                });

                setIncidents([
                    { id: '1', type: 'sos_alert', description: 'Emergency SOS: PSW Jane Doe at 123 Main St', status: 'open', createdAt: new Date().toISOString() }
                ]);

                setWaitlist([
                    { id: '1', clientName: 'Alice Smith', serviceType: 'Basic Care', priority: 1 },
                    { id: '2', clientName: 'Bob Jones', serviceType: 'Medication Management', priority: 2 }
                ]);

                setLoading(false);
            } catch (error) {
                console.error('Failed to fetch coordinator data:', error);
            }
        };

        fetchData();
    }, []);

    const acknowledgeSos = async (incidentId: string) => {
        // API call to ApiRegistry.TENANCY.COORDINATOR.SOS_ACK
        alert(COORDINATOR_HUB.SUCCESS.SOS_ACK);
        setIncidents(incidents.map(inc => inc.id === incidentId ? { ...inc, status: 'investigating' } : inc));
    };

    if (loading) {
        return <div className="p-8">Loading Logistics Control Center...</div>;
    }

    return (
        <div style={{ padding: '24px', backgroundColor: '#F9FAFB', minHeight: '100vh' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '32px', fontWeight: '800', color: '#111827' }}>{COORDINATOR_HUB.TITLE}</h1>
                <p style={{ color: '#6B7280', fontSize: '16px' }}>{COORDINATOR_HUB.SUBTITLE}</p>
            </div>

            {/* KPI Section */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px', borderLeft: '4px solid #3B82F6' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{COORDINATOR_HUB.STATS.LIVE_PSW}</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>{stats.livePsw}</div>
                </div>
                <div className="pc-card" style={{ padding: '24px', borderLeft: '4px solid #EF4444' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{COORDINATOR_HUB.STATS.SOS_ACTIVE}</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#EF4444', marginTop: '8px' }}>{stats.sosActive}</div>
                </div>
                <div className="pc-card" style={{ padding: '24px', borderLeft: '4px solid #F59E0B' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{COORDINATOR_HUB.STATS.PENDING_MATCHES}</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>{stats.pendingMatches}</div>
                </div>
                <div className="pc-card" style={{ padding: '24px', borderLeft: '4px solid #10B981' }}>
                    <div style={{ fontSize: '14px', fontWeight: '600', color: '#6B7280' }}>{COORDINATOR_HUB.STATS.WAITLIST_COUNT}</div>
                    <div style={{ fontSize: '28px', fontWeight: '800', color: '#111827', marginTop: '8px' }}>{stats.waitlistCount}</div>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '2fr 1fr', gap: '32px' }}>
                {/* Main Dispatch & SOS Column */}
                <div>
                    {/* SOS Section */}
                    <div className="pc-card" style={{ marginBottom: '32px', backgroundColor: incidents.some(i => i.status === 'open') ? '#FEF2F2' : 'white' }}>
                        <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span>{COORDINATOR_HUB.SOS_TITLE}</span>
                            {incidents.length > 0 && <span className="pc-badge secondary">{incidents.length} Urgent</span>}
                        </div>
                        <div className="pc-card-b">
                            {incidents.length === 0 ? (
                                <p style={{ color: '#6B7280', textAlign: 'center', padding: '24px' }}>No active SOS alerts.</p>
                            ) : (
                                incidents.map(inc => (
                                    <div key={inc.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', borderBottom: '1px solid #E5E7EB' }}>
                                        <div>
                                            <div style={{ fontWeight: '700', color: '#B91C1C' }}>{inc.description}</div>
                                            <div style={{ fontSize: '12px', color: '#6B7280', marginTop: '4px' }}>{new Date(inc.createdAt).toLocaleTimeString()}</div>
                                        </div>
                                        {inc.status === 'open' && (
                                            <button
                                                onClick={() => acknowledgeSos(inc.id)}
                                                className="pc-btn danger"
                                                style={{ padding: '8px 16px', fontSize: '14px' }}
                                            >
                                                {COORDINATOR_HUB.ACTIONS.ACKNOWLEDGE_SOS}
                                            </button>
                                        )}
                                    </div>
                                ))
                            )}
                        </div>
                    </div>

                    {/* Dispatch Map Placeholder */}
                    <div className="pc-card" style={{ minHeight: '400px' }}>
                        <div className="pc-card-h">{COORDINATOR_HUB.MAP_TITLE}</div>
                        <div className="pc-card-b" style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', height: '340px', background: '#F3F4F6', borderRadius: '8px' }}>
                            <div style={{ textAlign: 'center' }}>
                                <div style={{ fontSize: '48px', marginBottom: '16px' }}>📍</div>
                                <p style={{ color: '#6B7280', fontWeight: '600' }}>Live Interactive Dispatch Map</p>
                                <p style={{ color: '#9CA3AF', fontSize: '14px' }}>Real-time GPS tracking for {stats.livePsw} active providers.</p>
                            </div>
                        </div>
                    </div>
                </div>

                {/* Right Column: Waitlist & Grid */}
                <div>
                    <div className="pc-card" style={{ marginBottom: '32px' }}>
                        <div className="pc-card-h">{COORDINATOR_HUB.WAITLIST_TITLE}</div>
                        <div className="pc-card-b" style={{ padding: '0' }}>
                            {waitlist.length === 0 ? (
                                <p style={{ color: '#6B7280', textAlign: 'center', padding: '24px' }}>Waitlist is clear.</p>
                            ) : (
                                waitlist.map(entry => (
                                    <div key={entry.id} style={{ padding: '16px', borderBottom: '1px solid #F3F4F6', display: 'flex', justifyContent: 'space-between' }}>
                                        <div>
                                            <div style={{ fontWeight: '600' }}>{entry.clientName}</div>
                                            <div style={{ fontSize: '12px', color: '#6B7280' }}>{entry.serviceType}</div>
                                        </div>
                                        <div style={{ textAlign: 'right' }}>
                                            <div className="pc-badge primary">P{entry.priority}</div>
                                        </div>
                                    </div>
                                ))
                            )}
                            <div style={{ padding: '16px', textAlign: 'center' }}>
                                <button className="pc-btn secondary" style={{ width: '100%', fontSize: '14px' }}>
                                    {COORDINATOR_HUB.ACTIONS.SYNC_WAITLIST}
                                </button>
                            </div>
                        </div>
                    </div>

                    <div className="pc-card">
                        <div className="pc-card-h">{COORDINATOR_HUB.GRID_TITLE}</div>
                        <div className="pc-card-b">
                            <div style={{ background: '#FDF2F2', padding: '16px', borderRadius: '8px', border: '1px dashed #EF4444', marginBottom: '16px' }}>
                                <div style={{ fontWeight: '700', fontSize: '14px', color: '#991B1B' }}>Unassigned Morning Shift</div>
                                <div style={{ fontSize: '12px', color: '#B91C1C' }}>8:00 AM - 12:00 PM • Jane Smith</div>
                                <button className="pc-btn primary" style={{ marginTop: '12px', width: '100%', padding: '6px' }}>{COORDINATOR_HUB.ACTIONS.OVERRIDE_MATCH}</button>
                            </div>
                            <p style={{ fontSize: '12px', color: '#9CA3AF', textAlign: 'center' }}>+ Drag to assign to available PSW</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
