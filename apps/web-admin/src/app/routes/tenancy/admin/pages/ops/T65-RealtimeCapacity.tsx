// ================================================================
// PAGE IDENTITY: T65 � Realtime Capacity
// Type: Tool | Owner: admin
// ================================================================
import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';

export default function RealtimeCapacity() {
    const [capacity] = useState([
        { branch: 'Central Hub', utilized: 85, available: 12, pending: 4 },
        { branch: 'West Wing', utilized: 92, available: 5, pending: 3 },
        { branch: 'East Coast', utilized: 45, available: 22, pending: 1 },
    ]);

    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h1 data-cy="page.title" style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Realtime Capacity</h1>
                <p style={{ color: '#6b7280' }}>Live visibility into staffing availability and service demand.</p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '2rem' }}>
                {capacity.map(c => (
                    <div key={c.branch} className="pc-card" style={{ padding: '1.5rem' }}>
                        <h3 data-cy="h3-admin.realtime-capacity-0" style={{ marginBottom: '1rem' }}>{c.branch}</h3>
                        <div style={{ height: '8px', background: '#e5e7eb', borderRadius: '4px', overflow: 'hidden', marginBottom: '1rem' }}>
                            <div style={{ height: '100%', width: `${c.utilized}%`, background: c.utilized > 90 ? '#ef4444' : '#2563eb' }} />
                        </div>
                        <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem' }}>
                            <span>Utilization: <strong>{c.utilized}%</strong></span>
                            <span>Available: <strong>{c.available}</strong></span>
                        </div>
                        <div style={{ marginTop: '1rem', paddingTop: '1rem', borderTop: '1px solid #f3f4f6', display: 'flex', justifyContent: 'space-between', fontSize: '0.875rem' }}>
                            <span style={{ color: '#6b7280' }}>Waitlist / Pending</span>
                            <span style={{ fontWeight: 'bold', color: '#ef4444' }}>{c.pending}</span>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}
