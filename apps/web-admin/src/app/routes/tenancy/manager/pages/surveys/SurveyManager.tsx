import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

const { ButtonRegistry } = AdminRegistry;

export default function SurveyManager() {
    const { showToast } = useNotification();
    const [surveys] = useState([
        { id: '1', title: 'Annual Staff Happiness 2026', target: 'Staff', responses: 88, status: 'Active' },
        { id: '2', title: 'Client Feedback Q1', target: 'Client', responses: 24, status: 'Archived' },
    ]);

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ fontSize: '1.875rem', fontWeight: 'bold', color: '#111827' }}>Survey Manager</h1>
                    <p style={{ color: '#6b7280' }}>Launch and monitor satisfaction surveys across the organization.</p>
                </div>
                <button
                    className="btn primary"
                    onClick={() => showToast('Survey wizard launched', 'success')}
                    data-cy="btn-mgr-survey-new"
                >
                    {ButtonRegistry.find((b: any) => b.id === 'btn-mgr-survey-new')?.label || 'New Survey'}
                </button>
            </div>

            <div className="pc-card">
                <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                    <thead>
                        <tr style={{ borderBottom: '1px solid #e5e7eb', textAlign: 'left' }}>
                            <th style={{ padding: '1rem' }}>Survey Title</th>
                            <th style={{ padding: '1rem' }}>Target Role</th>
                            <th style={{ padding: '1rem' }}>Responses</th>
                            <th style={{ padding: '1rem' }}>Status</th>
                            <th style={{ padding: '1rem', textAlign: 'right' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {surveys.map(s => (
                            <tr key={s.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                <td style={{ padding: '1rem', fontWeight: '500' }}>{s.title}</td>
                                <td style={{ padding: '1rem' }}>{s.target}</td>
                                <td style={{ padding: '1rem' }}>{s.responses}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 'bold', padding: '0.25rem 0.5rem', borderRadius: '0.25rem', backgroundColor: s.status === 'Active' ? '#eff6ff' : '#f3f4f6', color: s.status === 'Active' ? '#2563eb' : '#4b5563' }}>
                                        {s.status}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem', textAlign: 'right' }}>
                                    <button className="btn secondary small">View Results</button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
