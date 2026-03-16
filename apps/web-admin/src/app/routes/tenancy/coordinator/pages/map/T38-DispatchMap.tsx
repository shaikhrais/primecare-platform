// ================================================================
// PAGE IDENTITY: T38 — Dispatch Map
// Type: Tool | Owner: coordinator
// ================================================================
import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry, ButtonRegistry , getButtonById } from 'prime-care-shared';
import { useApiMutation } from '@/shared/hooks/useApiMutation';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';
import { MapContainer, TileLayer, Marker, Popup, Polyline, useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import './DispatchMap.css';
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';
import { PulseCircle, fetchMapData as loadMapData } from './dispatchHelpers';

let DefaultIcon = L.icon({ iconUrl: markerIcon, shadowUrl: markerShadow, iconSize: [25, 41], iconAnchor: [12, 41] });
L.Marker.prototype.options.icon = DefaultIcon;

const { COORDINATOR_MAP } = ContentRegistry;

export default function DispatchMap() {
    const [nodes, setNodes] = useState<any[]>([]);
    const [activeVisits, setActiveVisits] = useState<any[]>([]);
    const [recentEvents, setRecentEvents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const { showToast } = useNotification();

    const fetchData = async () => {
        const data = await loadMapData();
        setNodes(data.nodes); setActiveVisits(data.activeVisits); setRecentEvents(data.recentEvents);
        setLoading(false);
    };

    useEffect(() => { fetchData(); }, []);

    const { isConnected } = useRealtimeSync((msg: SyncMessage) => {
        if (msg.type === 'VISIT_UPDATE') { fetchData(); }
        else if (msg.type === 'INCIDENT') {
            fetchData();
            // Phase 17: Real-Time Shift Latency UI Popups
            if (msg.title && msg.message) {
                showToast(`${msg.title} - ${msg.message}`, msg.severity === 'critical' ? 'error' : 'warning');
            }
        } else if (msg.type === 'TELEMETRY' && msg.pswId) {
            // Phase 16: Zero-Latency WebSocket Push Update
            // Bypasses HTTP polling, patching the Leaflet DOM state directly.
            setNodes(prev => prev.map(n => 
                n.id === msg.pswId 
                    ? { ...n, lat: msg.lat || n.lat, lng: msg.lng || n.lng, status: msg.status || n.status } 
                    : n
            ));
        }
    });

    const pingMutation = useApiMutation('/v1/coordinator/fleet/ping', {
        onSuccess: (data: any) => {
            showToast(data?.message || 'Nodes pinged successfully.', 'success');
        },
        onError: () => {
            showToast('Ping failed across the mesh.', 'error');
        },
    });

    if (loading) return <div className="dispatch-map-container"><p>Syncing Field Intel...</p></div>;

    return (
        <div data-cy="page.container" role="main" aria-label="Dispatch Map" className="dispatch-map-container">
            <header className="map-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div>
                        <h1 data-cy="page.title">{COORDINATOR_MAP.TITLE}</h1>
                        <p>{COORDINATOR_MAP.SUBTITLE}</p>
                    </div>
                    {/* Synchrony Indicator */}
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', fontWeight: 800, padding: '4px 8px', borderRadius: '12px', background: isConnected ? '#ECFCCB' : '#FEF3C7', color: isConnected ? '#4D7C0F' : '#B45309', border: `1px solid ${isConnected ? '#D9F99D' : '#FDE68A'}` }}>
                        <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: isConnected ? '#65A30D' : '#D97706', animation: isConnected ? 'pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite' : 'none' }}></div>
                        {isConnected ? 'LIVE SYNC' : 'CONNECTING...'}
                    </div>
                </div>
                <div>
                    <button data-cy="btn-coordinator.dispatch-map-0"
                        className="btn-premium secondary"
                        onClick={() => pingMutation.mutate({})}
                        style={{ background: 'white', color: '#475569', border: '1px solid #cbd5e1' }}
                    >
                        {getButtonById('btn-coord-gps-ping')?.label || 'Ping Location'}
                    </button>
                </div>
            </header>

            <div className="map-viewport-wrapper">
                <MapContainer center={[43.6532, -79.3832]} zoom={13} style={{ height: '100%', width: '100%' }}>
                    <TileLayer
                        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                    />

                    {nodes.map(node => (
                        <React.Fragment key={node.id}>
                            {node.status === 'sos' && <PulseCircle lat={node.lat} lng={node.lng} />}
                            <Marker position={[node.lat, node.lng]} icon={L.divIcon({
                                className: `custom-marker ${node.status}`,
                                html: `<div class="marker-shell">${node.icon}</div><div class="marker-tip">${node.name}</div>`,
                                iconSize: [40, 40],
                                iconAnchor: [20, 20]
                            })}>
                                <Popup>
                                    <strong>{node.name}</strong><br />
                                    Status: {node.status.toUpperCase()}
                                </Popup>
                            </Marker>
                        </React.Fragment>
                    ))}

                    {activeVisits.map(visit => {
                        if (!visit.psw?.lastLat || !visit.client?.lat) return null;
                        return (
                            <Polyline
                                key={visit.id}
                                positions={[
                                    [visit.psw.lastLat, visit.psw.lastLng],
                                    [visit.client.lat, visit.client.lng]
                                ]}
                                pathOptions={{
                                    color: visit.status === 'in_progress' ? '#10b981' : '#3b82f6',
                                    weight: 3,
                                    dashArray: '5, 10',
                                    opacity: 0.6
                                }}
                            />
                        );
                    })}
                </MapContainer>

                <aside className="map-sidebar">
                    <div className="legend">
                        <div className="legend-item">
                            <span className="dot blue"></span>
                            <span>{COORDINATOR_MAP.LEGEND.ACTIVE}</span>
                        </div>
                        <div className="legend-item">
                            <span className="dot green"></span>
                            <span>{COORDINATOR_MAP.LEGEND.IDLE}</span>
                        </div>
                        <div className="legend-item">
                            <span className="dot red"></span>
                            <span>{COORDINATOR_MAP.LEGEND.SOS}</span>
                        </div>
                    </div>

                    <div className="live-feed">
                        <div className="feed-header">LIVE ATTENDANCE FEED</div>
                        {recentEvents.length === 0 && <div className="feed-item">Waiting for check-in events...</div>}
                        {recentEvents.map(event => (
                            <div key={event.id} className={`feed-item ${event.eventType}`}>
                                <span className="time">{new Date(event.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                <span className="event-type">{event.eventType === 'check_in' ? '🟢 IN' : '🔴 OUT'}</span>
                                <span className="psw-name">{event.pswProfile?.fullName}</span>
                                <span className="result">{event.result.toUpperCase()}</span>
                            </div>
                        ))}
                        {nodes.filter(n => n.status === 'sos').map(n => (
                            <div key={n.id} className="feed-item danger">🚨 SOS: {n.name}</div>
                        ))}
                    </div>
                </aside>
            </div>
        </div>
    );
}
