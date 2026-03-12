import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry, ButtonRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { useNotification } from '@/shared/context/NotificationContext';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';
import { MapContainer, TileLayer, Marker, Popup, Polyline, useMap } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';
import './DispatchMap.css';

// Fix for default marker icon in Leaflet + Vite
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';

let DefaultIcon = L.icon({
    iconUrl: markerIcon,
    shadowUrl: markerShadow,
    iconSize: [25, 41],
    iconAnchor: [12, 41]
});

L.Marker.prototype.options.icon = DefaultIcon;

const { COORDINATOR_MAP } = ContentRegistry;

// Custom pulse component for SOS
const PulseCircle = ({ lat, lng }: { lat: number, lng: number }) => {
    return (
        <Marker position={[lat, lng]} icon={L.divIcon({
            className: 'sos-pulse-marker',
            html: '<div class="radar-pulse"></div>',
            iconSize: [40, 40],
            iconAnchor: [20, 20]
        })}>
            <Popup>⚠️ ACTIVE SOS ALERT</Popup>
        </Marker>
    );
};

export default function DispatchMap() {
    const [nodes, setNodes] = useState<any[]>([]);
    const [activeVisits, setActiveVisits] = useState<any[]>([]);
    const [recentEvents, setRecentEvents] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const { showToast } = useNotification();

    const fetchMapData = async () => {
        try {
            const data: any = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.DISPATCH_MAP);
            if (data) {
                const caregivers = data.caregivers.map((p: any) => ({
                    id: p.id,
                    name: p.fullName,
                    lat: p.lastLat || 43.6532,
                    lng: p.lastLng || -79.3832,
                    status: p.status === 'urgent' ? 'sos' : p.status === 'active' ? 'active' : 'idle',
                    icon: p.status === 'urgent' ? '🚨' : '🚙'
                }));
                const clients = data.clients.map((c: any) => ({
                    id: c.id,
                    name: c.fullName,
                    lat: c.lat || 43.6600,
                    lng: c.lng || -79.3900,
                    status: 'client',
                    icon: '🏠'
                }));
                setNodes([...caregivers, ...clients]);
                setActiveVisits(data.activeVisits || []);
                setRecentEvents(data.recentEvents || []);
            }
        } catch (error) {
            console.error('Failed to fetch dispatch map:', error);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchMapData();
    }, []);

    const { isConnected } = useRealtimeSync((msg: SyncMessage) => {
        if (msg.type === 'VISIT_UPDATE' || msg.type === 'INCIDENT') {
            fetchMapData(); // Structural changes still warrant a full layout fetch
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

    if (loading) return <div className="dispatch-map-container"><p>Syncing Field Intel...</p></div>;

    return (
        <div className="dispatch-map-container">
            <header className="map-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div>
                        <h1>{COORDINATOR_MAP.TITLE}</h1>
                        <p>{COORDINATOR_MAP.SUBTITLE}</p>
                    </div>
                    {/* Synchrony Indicator */}
                    <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem', fontWeight: 800, padding: '4px 8px', borderRadius: '12px', background: isConnected ? '#ECFCCB' : '#FEF3C7', color: isConnected ? '#4D7C0F' : '#B45309', border: `1px solid ${isConnected ? '#D9F99D' : '#FDE68A'}` }}>
                        <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: isConnected ? '#65A30D' : '#D97706', animation: isConnected ? 'pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite' : 'none' }}></div>
                        {isConnected ? 'LIVE SYNC' : 'CONNECTING...'}
                    </div>
                </div>
                <div>
                    <button
                        className="btn-premium secondary"
                        onClick={async () => {
                            try {
                                const response: any = await apiClient.post('/v1/coordinator/fleet/ping', {});
                                showToast(response?.message || 'Nodes pinged successfully.', 'success');
                            } catch (e) {
                                showToast('Ping failed across the mesh.', 'error');
                            }
                        }}
                        style={{ background: 'white', color: '#475569', border: '1px solid #cbd5e1' }}
                    >
                        {ButtonRegistry.find(b => b.id === 'btn-coord-gps-ping')?.label || 'Ping Location'}
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
