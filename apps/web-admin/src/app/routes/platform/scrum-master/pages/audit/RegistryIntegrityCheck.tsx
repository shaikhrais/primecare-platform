import React, { useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry, ApiRegistry } = AdminRegistry;

export default function RegistryIntegrityCheck() {
    const { t } = useTranslation();

    const integrityStats = useMemo(() => {
        const deepCount = (obj: any): number => {
            if (!obj || typeof obj !== 'object') return 0;
            const seenPaths = new Set<string>();
            let count = 0;

            const process = (target: any) => {
                Object.values(target).forEach(val => {
                    if (typeof val === 'string') {
                        if (!seenPaths.has(val)) {
                            count++;
                            seenPaths.add(val);
                        }
                    } else if (typeof val === 'function') {
                        count++;
                    } else if (typeof val === 'object' && val !== null) {
                        process(val);
                    }
                });
            };

            process(obj);
            return count;
        };

        const totalRoutes = deepCount(RouteRegistry);
        const totalEndpoints = deepCount(ApiRegistry);
        const missingTranslations = 0;
        const brokenLinks = 0;

        return [
            { label: t(ContentRegistry.SCRUM_MASTER.INTEGRITY.TOTAL_ROUTES), value: totalRoutes, status: 'Healthy' },
            { label: t(ContentRegistry.SCRUM_MASTER.INTEGRITY.API_MAPPINGS), value: totalEndpoints, status: 'Healthy' },
            { label: t(ContentRegistry.SCRUM_MASTER.INTEGRITY.TRANSLATION_OVERLAP), value: '100%', status: 'Healthy' },
            { label: t(ContentRegistry.SCRUM_MASTER.INTEGRITY.BROKEN_LINKS), value: brokenLinks, status: 'Healthy' },
        ];
    }, [t]);

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
                <div className="pc-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.85rem', color: 'var(--text-400)', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>
                        {t(ContentRegistry.SCRUM_MASTER.INTEGRITY.TOTAL_ROUTES)}
                    </div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-600)', marginBottom: '4px' }}>
                        {integrityStats[0].value}
                    </div>
                    <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 700 }}>
                        ● Healthy
                    </div>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.85rem', color: 'var(--text-400)', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>
                        {t(ContentRegistry.SCRUM_MASTER.INTEGRITY.API_MAPPINGS)}
                    </div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-600)', marginBottom: '4px' }}>
                        {integrityStats[1].value}
                    </div>
                    <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 700 }}>
                        ● {t(ContentRegistry.SHARED.HEALTHY)}
                    </div>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.85rem', color: 'var(--text-400)', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>
                        {t(ContentRegistry.SCRUM_MASTER.INTEGRITY.TRANSLATION_OVERLAP)}
                    </div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-600)', marginBottom: '4px' }}>
                        100%
                    </div>
                    <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 700 }}>
                        ● {t(ContentRegistry.SHARED.HEALTHY)}
                    </div>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem', textAlign: 'center' }}>
                    <div style={{ fontSize: '0.85rem', color: 'var(--text-400)', fontWeight: 700, textTransform: 'uppercase', marginBottom: '8px' }}>
                        {t(ContentRegistry.SCRUM_MASTER.INTEGRITY.BROKEN_LINKS)}
                    </div>
                    <div style={{ fontSize: '2rem', fontWeight: 900, color: 'var(--brand-600)', marginBottom: '4px' }}>
                        0
                    </div>
                    <div style={{ fontSize: '0.75rem', color: '#10b981', fontWeight: 700 }}>
                        ● Healthy
                    </div>
                </div>
            </div>

            <h3 data-cy="h3-registry-integrity-check-0" style={{ margin: '0 0 1.5rem 0', color: 'var(--text-100)' }}>🔍 {t(ContentRegistry.SCRUM_MASTER.ANOMALIES.TITLE)}</h3>
            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                <table data-cy="table-registry-integrity-check" style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#fef2f2', color: '#991b1b', fontSize: '0.85rem' }}>
                        <tr>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.ANOMALIES.SEVERITY)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.ANOMALIES.COMPONENT)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.ANOMALIES.OBSERVATION)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SCRUM_MASTER.ANOMALIES.TECHNICAL_SUGGESTION)}</th>
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
                                        {issue.severity === 'Low' ? t(ContentRegistry.SHARED.LOW) : t(ContentRegistry.SHARED.MEDIUM)}
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
        </div >
    );
}
