import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

const { ButtonRegistry } = AdminRegistry;

export default function RegionMapping() {
    const { showToast } = useNotification();
    const [regions] = useState([
        { id: '1', name: 'Downtown Central', city: 'Toronto', postalCodes: 'M5V, M5T, M5G', status: 'Active' },
        { id: '2', name: 'North Suburbs', city: 'Richmond Hill', postalCodes: 'L4B, L4C', status: 'Active' },
    ]);

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Region Mapping</h1>
                    <p style={{ color: '#6b7280' }}>Define and visualize operational geographic zones.</p>
                </div>
                <button
                    className="btn secondary"
                    onClick={() => showToast('New region creation opened', 'success')}
                    data-cy="btn-adm-region-new"
                >
                    {ButtonRegistry.find((b: any) => b.id === 'btn-adm-region-new')?.label || 'Define New Region'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(350px, 1fr))', gap: '1.5rem' }}>
                {regions.map(r => (
                    <div key={r.id} className="pc-card" style={{ padding: '1.5rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.5rem' }}>
                            <h3 style={{ fontSize: '1.125rem', fontWeight: '600' }}>{r.name}</h3>
                            <span style={{ fontSize: '0.75rem', color: '#059669', background: '#ecfdf5', padding: '0.2rem 0.5rem', borderRadius: '4px' }}>{r.status}</span>
                        </div>
                        <p style={{ fontSize: '0.875rem', color: '#6b7280', marginBottom: '1rem' }}>{r.city}</p>
                        <div style={{ background: '#f9fafb', padding: '1rem', borderRadius: '0.5rem', marginBottom: '1.5rem' }}>
                            <label style={{ fontSize: '0.75rem', fontWeight: 'bold', color: '#9ca3af', textTransform: 'uppercase' }}>Postal Coverage</label>
                            <p style={{ margin: '0.5rem 0 0', fontSize: '0.875rem', color: '#4b5563' }}>{r.postalCodes}</p>
                        </div>
                        <div style={{ display: 'flex', gap: '0.5rem' }}>
                            <button className="btn outline small" style={{ flex: 1 }}>Edit Boundary</button>
                            <button className="btn outline small" style={{ flex: 1 }}>Assign Manager</button>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
