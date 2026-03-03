import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

export default function ApiEndpointsHub() {
    const { t } = useTranslation();
    const [testingId, setTestingId] = useState<string | null>(null);
    const [testResults, setTestResults] = useState<Record<string, any>>({});

    const endpoints = [
        { name: 'Admin Dashboard Stats', path: ApiRegistry.ADMIN.STATS, method: 'GET' },
        { name: 'User Management', path: ApiRegistry.ADMIN.USERS, method: 'GET/POST' },
        { name: 'Client Bookings', path: ApiRegistry.CLIENT.BOOKINGS, method: 'GET/POST' },
        { name: 'Caregiver Schedule', path: ApiRegistry.PSW.VISITS, method: 'GET' },
        { name: 'Platform Tenants', path: ApiRegistry.SUPERUSER.TENANTS, method: 'GET' },
    ];

    const handleTest = async (id: string, path: string) => {
        setTestingId(id);
        // Simulate API call
        setTimeout(() => {
            setTestResults(prev => ({
                ...prev,
                [id]: { status: 200, time: '45ms', success: true }
            }));
            setTestingId(null);
        }, 800);
    };

    return (
        <div data-cy="api-endpoints-hub">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.SUBTITLE)}
                </p>
            </div>

            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', color: 'var(--text-300)', fontSize: '0.85rem', textTransform: 'uppercase' }}>
                        <tr>
                            <th style={{ padding: '1rem 1.5rem' }}>Endpoint Name</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Path</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Method</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Status</th>
                            <th style={{ padding: '1rem 1.5rem', textAlign: 'right' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {endpoints.map((ep, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)' }}>{ep.name}</td>
                                <td style={{ padding: '1.2rem 1.5rem', fontFamily: 'monospace', color: 'var(--brand-500)', fontSize: '0.9rem' }}>{ep.path}</td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    <span style={{ backgroundColor: '#f1f5f9', padding: '4px 10px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 700, color: '#475569' }}>
                                        {ep.method}
                                    </span>
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    {testResults[idx] ? (
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: testResults[idx].success ? '#10b981' : '#ef4444' }}></div>
                                            <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>{testResults[idx].status} ({testResults[idx].time})</span>
                                        </div>
                                    ) : (
                                        <span style={{ color: 'var(--text-300)', fontSize: '0.85rem' }}>Not Tested</span>
                                    )}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', textAlign: 'right' }}>
                                    <button
                                        onClick={() => handleTest(idx.toString(), ep.path)}
                                        disabled={testingId === idx.toString()}
                                        style={{
                                            padding: '8px 16px',
                                            backgroundColor: 'var(--brand-500)',
                                            color: 'white',
                                            border: 'none',
                                            borderRadius: '8px',
                                            fontWeight: 600,
                                            cursor: 'pointer',
                                            opacity: testingId === idx.toString() ? 0.7 : 1
                                        }}
                                    >
                                        {testingId === idx.toString() ? '⌛ Testing...' : t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TEST_BTN)}
                                    </button>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
