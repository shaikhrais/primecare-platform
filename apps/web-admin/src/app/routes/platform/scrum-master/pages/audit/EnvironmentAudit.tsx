import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function EnvironmentAudit() {
    const { t } = useTranslation();

    // Mapping of environment variables (sanitized for security)
    const envVars = [
        { key: 'VITE_API_URL', value: import.meta.env.VITE_API_URL || 'http://localhost:4000', security: 'Public' },
        { key: 'VITE_APP_ENV', value: import.meta.env.MODE || 'development', security: 'Public' },
        { key: 'VITE_BASE_URL', value: window.location.origin, security: 'Public' },
        { key: 'AUTH_DOMAIN', value: 'auth.primecare.io', security: 'System' },
        { key: 'DB_DIALECT', value: 'PostgreSQL', security: 'Sensitive' },
        { key: 'STORAGE_BUCKET', value: 'primecare-assets-prod', security: 'System' },
    ];

    return (
        <div data-cy="environment-audit-page">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.ENV_AUDIT.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.ENV_AUDIT.SUBTITLE)}
                </p>
            </div>

            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: 'var(--bg-200)', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                        <tr>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SHARED.VARIABLE_KEY)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SHARED.CURRENT_VALUE)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SHARED.SECURITY_LEVEL)}</th>
                            <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.SHARED.STATUS)}</th>
                        </tr>
                    </thead>
                    <tbody>
                        {envVars.map((env, idx) => (
                            <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)', fontFamily: 'monospace' }}>
                                    {env.key}
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem', color: 'var(--brand-500)', fontSize: '0.85rem' }}>
                                    <code>{env.value}</code>
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    <span style={{
                                        backgroundColor: env.security === 'Public' ? '#ecfdf5' : env.security === 'System' ? '#f0f9ff' : '#fff7ed',
                                        color: env.security === 'Public' ? '#059669' : env.security === 'System' ? '#0284c7' : '#d97706',
                                        padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700
                                    }}>
                                        {env.security === 'Public' ? t(ContentRegistry.SHARED.PUBLIC) : env.security === 'System' ? t(ContentRegistry.SHARED.SYSTEM) : t(ContentRegistry.SHARED.SENSITIVE)}
                                    </span>
                                </td>
                                <td style={{ padding: '1.2rem 1.5rem' }}>
                                    <span style={{ color: '#10b981', fontWeight: 700, fontSize: '0.8rem' }}>● {t(ContentRegistry.SHARED.HEALTHY)}</span>
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div style={{ marginTop: '2rem', padding: '1.5rem', backgroundColor: 'var(--brand-50)', borderRadius: '12px', border: '1px solid var(--brand-100)' }}>
                <h4 style={{ margin: '0 0 8px 0', color: 'var(--brand-600)' }}>🔒 {t(ContentRegistry.SHARED.SECURITY_NOTE)}</h4>
                <p style={{ margin: 0, fontSize: '0.9rem', color: 'var(--brand-700)', lineHeight: 1.5 }}>
                    {t(ContentRegistry.SCRUM_MASTER.ENV_AUDIT.SECURITY_NOTE)}
                </p>
            </div>
        </div>
    );
}
