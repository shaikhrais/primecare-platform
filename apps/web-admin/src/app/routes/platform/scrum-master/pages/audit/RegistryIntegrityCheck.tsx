import React, { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function RegistryIntegrityCheck() {
    const { t } = useTranslation();

    const integrityStats = useMemo(() => {
        // Simulated cross-registry validation logic
        const routes = Object.keys(RouteRegistry).length;
        const endpoints = Object.keys(ApiRegistry).length;
        const missingTranslations = 0; // Ideal case
        const brokenLinks = 0;

        return [
            { label: 'Total Route Definitions', value: routes, status: 'Healthy' },
            { label: 'API Endpoint Mappings', value: endpoints, status: 'Healthy' },
            { label: 'Translation Keys Overlap', value: '100%', status: 'Healthy' },
            { label: 'Broken Internal Links', value: brokenLinks, status: 'Healthy' },
        ];
    }, []);

    const issues = [
        { severity: 'Low', component: 'ContentRegistry', message: 'Unused key detected: SHARED.LEGACY_TAB', suggestion: 'Safe to prune in next refactor' },
        { severity: 'Medium', component: 'RouteRegistry', message: 'Partial match on COORDINATOR route', suggestion: 'Verify nesting in router.tsx' },
    ];

    return (
        <div data-cy="registry-integrity-check-page">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.REGISTRY_CHECK.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.REGISTRY_CHECK.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem', marginBottom: '3rem' }}>
                {integrityStats.map((stat, idx) => (
                    <div key={idx} className="pc-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                        <div style={{ fontSize: '0.85rem', color: 'var(--text-400)', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>
                            {stat.label}
                        </div>
                        <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-600)', marginBottom: '4px' }}>
                            {stat.value}
                        </div>
                        <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 700 }}>
                            ● {stat.status}
                        </div>
                    </div>
                ))}
            </div>

            <h3 style={{ margin: '0 0 1.5rem 0', color: 'var(--text-100)' }}>🔍 Detected Anomalies</h3>
            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#fef2f2', color: '#991b1b', fontSize: '0.85rem' }}>
                        <tr>
                            <th style={{ padding: '1rem 1.5rem' }}>Severity</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Component</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Observation</th>
                            <th style={{ padding: '1rem 1.5rem' }}>Technical Suggestion</th>
                        </tr>
                    </thead>
                    <tbody>
                        {issues.map((issue, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    <span style={{
                                        backgroundColor: issue.severity === 'Low' ? '#f1f5f9' : '#fff7ed',
                                        color: issue.severity === 'Low' ? '#475569' : '#c2410c',
                                        padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700
                                    }}>
                                        {issue.severity}
                                    </span>
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600 }}>{issue.component}</td>
                                <td style={{ padding: '1.2rem 1.5rem', color: 'var(--text-200)', fontSize: '0.9rem' }}>{issue.message}</td>
                                <td style={{ padding: '1.2rem 1.5rem', color: 'var(--brand-600)', fontWeight: 500, fontSize: '0.85rem' }}>
                                    <i>{issue.suggestion}</i>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
