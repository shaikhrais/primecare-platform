// PAGE IDENTITY: F12 · Locations
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function Locations() {
    return (
        <PageTemplate pageId="F12" title="📍 Service Locations" subtitle="Manage offices, service areas & geographic zones"
            sectionData={{
                'F12.stats': { kpiCards: [
                    { label: 'Locations', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Service Zones', value: 12, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Active Clients', value: 67, color: 'var(--pc-success)' },
                    { label: 'Coverage Area', value: '250 km²', color: '#7C3AED' },
                ]},
                'F12.map': { map: {
                    title: '📍 Service Area Coverage',
                    markers: [
                        { lat: 43.65, lng: -79.38, label: 'HQ — Toronto', status: 'active' },
                        { lat: 43.72, lng: -79.34, label: 'North York Office', status: 'active' },
                        { lat: 43.59, lng: -79.64, label: 'Mississauga Branch', status: 'active' },
                        { lat: 43.85, lng: -79.42, label: 'Richmond Hill Satellite', status: 'completed' },
                    ],
                }},
            }}
        />
    );
}
