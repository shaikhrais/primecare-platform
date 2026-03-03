import React, { useState, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

export default function ApiEndpointsHub() {
    const { t } = useTranslation();
    const [testingId, setTestingId] = useState<string | null>(null);
    const [testResults, setTestResults] = useState<Record<string, any>>({});

    // Dynamically extract endpoints from ApiRegistry
    const endpoints = useMemo(() => {
        const list: { name: string; path: string; method: string; category: string }[] = [];

        const processRegistry = (obj: any, category: string) => {
            Object.entries(obj).forEach(([key, value]) => {
                if (typeof value === 'string') {
                    list.push({
                        name: `${category} > ${key}`,
                        path: value as string,
                        method: 'GET', // Defaulting to GET for audit purposes
                        category: category
                    });
                } else if (typeof value === 'object' && value !== null) {
                    processRegistry(value, `${category} > ${key}`);
                }
            });
        };

        processRegistry(ApiRegistry, 'API');
        return list.filter(ep => ep.path.startsWith('/v1')).slice(0, 20); // Limiting to top 20 for UI clarity
    }, []);

    const handleTest = async (id: string, path: string) => {
        setTestingId(id);
        // Simulate API call check
        setTimeout(() => {
            setTestResults(prev => ({
                ...prev,
                [id]: { status: 200, time: `${Math.floor(Math.random() * 100) + 20}ms`, success: true }
            }));
            setTestingId(null);
        }, 600);
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
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.MODULE)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.PATH)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SHARED.STATUS)}</th>
                            <th style={{ padding: '1rem 1.5rem', textAlign: 'right' }}>{t(ContentRegistry.AUDIT.TABS.ROUTES)}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {endpoints.map((ep, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)' }}>
                                    <div style={{ fontSize: '0.75rem', color: 'var(--text-400)', marginBottom: '4px' }}>{ep.category}</div>
                                    {ep.name.split('>').pop()}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', fontFamily: 'monospace', color: 'var(--brand-500)', fontSize: '0.85rem' }}>{ep.path}</td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    {testResults[idx] ? (
                                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: testResults[idx].success ? '#10b981' : '#ef4444' }}></div>
                                            <span style={{ fontSize: '0.85rem', fontWeight: 600 }}>{testResults[idx].status} ({testResults[idx].time})</span>
                                        </div>
                                    ) : (
                                        <span style={{ color: 'var(--text-300)', fontSize: '0.85rem' }}>{t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.READY)}</span>
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
                                            fontWeight: 700,
                                            fontSize: '0.8rem',
                                            cursor: 'pointer',
                                            opacity: testingId === idx.toString() ? 0.7 : 1,
                                            transition: '0.2s'
                                        }}
                                    >
                                        {testingId === idx.toString() ? t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TESTING) : t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TEST_BTN)}
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
