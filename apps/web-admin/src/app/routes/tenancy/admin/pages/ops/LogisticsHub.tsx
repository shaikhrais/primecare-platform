import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

const { ButtonRegistry } = AdminRegistry;

export default function LogisticsHub() {
    const { showToast } = useNotification();
    const [stats] = useState([
        { id: '1', region: 'Downtown Central', activeVisits: 142, coverage: '98%', status: 'Optimal' },
        { id: '2', region: 'North Suburbs', activeVisits: 64, coverage: '85%', status: 'Warning' },
        { id: '3', region: 'West Side', activeVisits: 89, coverage: '92%', status: 'Optimal' },
    ]);

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Logistics Hub</h1>
                    <p style={{ color: '#6b7280' }}>Global monitoring and AI optimization for regional care delivery.</p>
                </div>
                <button
                    className="btn primary"
                    onClick={() => showToast('Logistics optimization triggered', 'success')}
                    data-cy="btn-adm-ops-optimize"
                >
                    {ButtonRegistry.find((b: any) => b.id === 'btn-adm-ops-optimize')?.label || 'Optimize Logistics'}
                </button>
            </div>

            <div className="pc-card">
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead>
                        <tr style={{ borderBottom: '1px solid #e5e7eb', textAlign: 'left' }}>
                            <th style={{ padding: '1rem' }}>Region</th>
                            <th style={{ padding: '1rem' }}>Active Visits</th>
                            <th style={{ padding: '1rem' }}>Staff Coverage</th>
                            <th style={{ padding: '1rem' }}>Status</th>
                            <th style={{ padding: '1rem', textAlign: 'right' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {stats.map(s => (
                            <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', fontWeight: '500' }}>{s.region}</td>
                                <td style={{ padding: '1rem' }}>{s.activeVisits}</td>
                                <td style={{ padding: '1rem' }}>{s.coverage}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 'bold', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', backgroundColor: s.status === 'Optimal' ? '#ecfdf5' : '#fff7ed', color: s.status === 'Optimal' ? '#059669' : '#c2410c' }}>
                                        {s.status}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem', textAlign: 'right' }}>
                                    <button className="btn secondary small">Drilldown</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
