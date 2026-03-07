import React, { useState, useEffect } from 'react';
import { apiClient } from '../../../../../../shared/utils/apiClient';

interface SystemEvent {
    id: string;
    operation: string;
    modelName: string;
    entityId: string | null;
    payload: any;
    previousData: any;
    actorUserId: string | null;
    deviceId: string | null;
    ipAddress: string | null;
    createdAt: string;
    actor?: {
        email: string;
    } | null;
}

export default function ForensicTrails() {
    const [events, setEvents] = useState<SystemEvent[]>([]);
    const [loading, setLoading] = useState(true);
    const [selectedEvent, setSelectedEvent] = useState<SystemEvent | null>(null);

    useEffect(() => {
        fetchEvents();
    }, []);

    const fetchEvents = async () => {
        try {
            const res = await apiClient.get('/v1/admin/settings/security/forensic-trails');
            if (res.ok) {
                const data = await res.json();
                setEvents(data);
            }
        } catch (err) {
            console.error('Failed to fetch forensic trails:', err);
        } finally {
            setLoading(false);
        }
    };

    const OperationBadge = ({ op }: { op: string }) => {
        const colors: Record<string, string> = {
            CREATE: '#059669',
            UPDATE: '#3B82F6',
            DELETE: '#EF4444',
            UPSERT: '#8B5CF6'
        };
        return (
            <span style={{
                padding: '2px 8px',
                background: colors[op] || '#6B7280',
                color: '#fff',
                borderRadius: '4px',
                fontSize: '11px',
                fontWeight: '700'
            }}>
                {op}
            </span>
        );
    };

    if (loading) return <div style={{ padding: '24px' }}>Gathering forensic data...</div>;

    return (
        <div style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px' }}>
                <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Forensic Audit Trails</h1>
                <p style={{ color: '#6B7280' }}>Granular event store for system reconstruction. Every mutation is captured with full context for forensic investigation.</p>
            </div>

            <div className="pc-card">
                <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <span>System Mutation Log</span>
                    <button className="btn secondary sm" onClick={fetchEvents}>Refresh</button>
                </div>
                <div className="pc-card-b" style={{ padding: '0' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead style={{ background: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                            <tr>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>TIME</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>OP</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>MODEL / ID</th>
                                <th style={{ textAlign: 'left', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>ACTOR</th>
                                <th style={{ textAlign: 'right', padding: '16px', fontSize: '12px', fontWeight: '600', color: '#6B7280' }}>DETAILS</th>
                            </tr>
                        </thead>
                        <tbody>
                            {events.map(event => (
                                <tr key={event.id} style={{ borderBottom: '1px solid #E5E7EB' }}>
                                    <td style={{ padding: '16px', fontSize: '13px' }}>
                                        {new Date(event.createdAt).toLocaleString()}
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <OperationBadge op={event.operation} />
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ fontWeight: '600', fontSize: '14px' }}>{event.modelName}</div>
                                        <div style={{ fontSize: '11px', color: '#6B7280', fontFamily: 'monospace' }}>{event.entityId || 'N/A'}</div>
                                    </td>
                                    <td style={{ padding: '16px' }}>
                                        <div style={{ fontSize: '13px' }}>{event.actor?.email || 'System'}</div>
                                        <div style={{ fontSize: '11px', color: '#9CA3AF' }}>IP: {event.ipAddress || 'Internal'}</div>
                                    </td>
                                    <td style={{ padding: '16px', textAlign: 'right' }}>
                                        <button
                                            className="btn secondary sm"
                                            onClick={() => setSelectedEvent(event)}
                                            style={{ fontSize: '11px' }}
                                        >
                                            Inspect State
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                    {events.length === 0 && (
                        <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>
                            No forensic events recorded yet.
                        </div>
                    )}
                </div>
            </div>

            {selectedEvent && (
                <div style={{
                    position: 'fixed',
                    top: 0, left: 0, right: 0, bottom: 0,
                    background: 'rgba(0,0,0,0.6)',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    zIndex: 1000,
                    backdropFilter: 'blur(8px)'
                }}>
                    <div className="pc-card" style={{ width: '90%', maxWidth: '900px', maxHeight: '90vh', display: 'flex', flexDirection: 'column' }}>
                        <div className="pc-card-h" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span>Forensic Inspection: {selectedEvent.modelName} ({selectedEvent.operation})</span>
                            <button onClick={() => setSelectedEvent(null)} style={{ background: 'none', border: 'none', color: '#fff', cursor: 'pointer', fontSize: '24px' }}>×</button>
                        </div>
                        <div className="pc-card-b" style={{ flex: 1, overflow: 'auto', padding: '24px', background: '#111827' }}>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                                <div>
                                    <h4 style={{ color: '#9CA3AF', fontSize: '12px', marginBottom: '8px', textTransform: 'uppercase' }}>Payload / New State</h4>
                                    <pre style={{
                                        background: '#1F2937',
                                        padding: '16px',
                                        borderRadius: '8px',
                                        color: '#10B981',
                                        fontSize: '12px',
                                        overflow: 'auto',
                                        maxHeight: '400px'
                                    }}>
                                        {JSON.stringify(selectedEvent.payload, null, 2)}
                                    </pre>
                                </div>
                                <div>
                                    <h4 style={{ color: '#9CA3AF', fontSize: '12px', marginBottom: '8px', textTransform: 'uppercase' }}>Investigation Context</h4>
                                    <div style={{ background: '#1F2937', padding: '16px', borderRadius: '8px', color: '#D1D5DB', fontSize: '13px' }}>
                                        <div style={{ marginBottom: '12px' }}>
                                            <div style={{ color: '#6B7280', fontSize: '10px' }}>ACTOR ID</div>
                                            <div>{selectedEvent.actorUserId || 'N/A'}</div>
                                        </div>
                                        <div style={{ marginBottom: '12px' }}>
                                            <div style={{ color: '#6B7280', fontSize: '10px' }}>DEVICE ID</div>
                                            <div style={{ fontFamily: 'monospace' }}>{selectedEvent.deviceId || 'N/A'}</div>
                                        </div>
                                        <div style={{ marginBottom: '12px' }}>
                                            <div style={{ color: '#6B7280', fontSize: '10px' }}>TRANSACTION IP</div>
                                            <div>{selectedEvent.ipAddress || 'Internal'}</div>
                                        </div>
                                        <div>
                                            <div style={{ color: '#6B7280', fontSize: '10px' }}>EVENT TIMESTAMP</div>
                                            <div>{new Date(selectedEvent.createdAt).toISOString()}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style={{ padding: '16px', borderTop: '1px solid #374151', textAlign: 'right', background: '#1F2937' }}>
                            <button className="btn secondary" onClick={() => setSelectedEvent(null)}>Dismiss Trace</button>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
