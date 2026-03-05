import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import { MapContainer, TileLayer, Marker, Popup, useMap } from 'react-leaflet';
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
    const [loading, setLoading] = useState(true);

    useEffect(() => {
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
                }
            } catch (error) {
                console.error('Failed to fetch dispatch map:', error);
            } finally {
                setLoading(false);
            }
        };
        fetchMapData();
        const interval = setInterval(fetchMapData, 30000); // Pulse every 30s
        return () => clearInterval(interval);
    }, []);

    if (loading) return <div className="dispatch-map-container"><p>Syncing Field Intel...</p></div>;

    return (
        <div className="dispatch-map-container">
            <header className="map-header">
                <h1>{COORDINATOR_MAP.TITLE}</h1>
                <p>{COORDINATOR_MAP.SUBTITLE}</p>
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
                        <div className="feed-item">[GPS] OSM INTEGRATION ACTIVE</div>
                        <div className="feed-item">[SYNC] CLOUD DISPATCH PULSE</div>
                        {nodes.filter(n => n.status === 'sos').map(n => (
                            <div key={n.id} className="feed-item danger">🚨 SOS: {n.name}</div>
                        ))}
                    </div>
                </aside>
            </div>
        </div>
    );
}
