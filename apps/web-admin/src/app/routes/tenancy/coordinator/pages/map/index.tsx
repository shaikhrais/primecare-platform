import React, { useState, useEffect } from 'react';
import { ApiRegistry, ContentRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import './DispatchMap.css';

const { COORDINATOR_MAP } = ContentRegistry;

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

            <div className="map-viewport">
                <div className="radar-pulse"></div>

                {nodes.map(node => (
                    <div
                        key={node.id}
                        className={`node-marker ${node.status}`}
                        style={{
                            left: `${50 + (node.lng + 79.38) * 500}%`,
                            top: `${50 - (node.lat - 43.65) * 500}%`
                        }}
                    >
                        <span className="marker-icon">{node.icon}</span>
                        <div className="marker-label">{node.name}</div>
                    </div>
                ))}

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
                        <div className="feed-item">[14:02] GPS_SYNC_SUCCESS (US-EAST-1)</div>
                        <div className="feed-item">[14:01] NODE_MOVE: PSW_SARAH -&gt; /v1/location/77</div>
                        <div className="feed-item">[14:00] SOS_TRIGGER: PSW_ELENA (URGENT)</div>
                    </div>
                </aside>
            </div>
        </div>
    );
}
