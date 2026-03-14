// T38 DispatchMap: data fetcher and PulseCircle component extracted
import React from 'react';
import { apiClient } from '@/shared/utils/apiClient';
import { ApiRegistry } from 'prime-care-shared';
import { Marker, Popup } from 'react-leaflet';
import L from 'leaflet';

export const PulseCircle = ({ lat, lng }: { lat: number, lng: number }) => (
    <Marker position={[lat, lng]} icon={L.divIcon({
        className: 'sos-pulse-marker',
        html: '<div class="radar-pulse"></div>',
        iconSize: [40, 40], iconAnchor: [20, 20]
    })}>
        <Popup>⚠️ ACTIVE SOS ALERT</Popup>
    </Marker>
);

export async function fetchMapData(): Promise<{ nodes: any[]; activeVisits: any[]; recentEvents: any[] }> {
    try {
        const data: any = await apiClient.get(ApiRegistry.TENANCY.COORDINATOR.DISPATCH_MAP);
        if (!data) return { nodes: [], activeVisits: [], recentEvents: [] };
        const caregivers = data.caregivers.map((p: any) => ({
            id: p.id, name: p.fullName, lat: p.lastLat || 43.6532, lng: p.lastLng || -79.3832,
            status: p.status === 'urgent' ? 'sos' : p.status === 'active' ? 'active' : 'idle',
            icon: p.status === 'urgent' ? '🚨' : '🚙'
        }));
        const clients = data.clients.map((c: any) => ({
            id: c.id, name: c.fullName, lat: c.lat || 43.6600, lng: c.lng || -79.3900,
            status: 'client', icon: '🏠'
        }));
        return { nodes: [...caregivers, ...clients], activeVisits: data.activeVisits || [], recentEvents: data.recentEvents || [] };
    } catch (error) { console.error('Failed to fetch dispatch map:', error); return { nodes: [], activeVisits: [], recentEvents: [] }; }
}
