import React, { useState, useEffect } from 'react';
import { AdminRegistry, SummaryRegistry, SummaryContext } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import { Link } from 'react-router-dom';

const { ContentRegistry } = AdminRegistry;

/**
 * RegistrySummaryDashboard: Visualizes platform-wide KPIs and filtering metadata
 * defined in the SummaryRegistry. Adheres to zero-hardcoded-text policy.
 */
export const RegistrySummaryDashboard: React.FC = () => {
    const { t } = useTranslation();
    const [contexts, setContexts] = useState<SummaryContext[]>(SummaryRegistry);
    const [isSyncing, setIsSyncing] = useState(false);

    const handleSync = () => {
        setIsSyncing(true);
        // Simulate registry node calibration
        setTimeout(() => {
            setContexts(prev => prev.map(ctx => ({
                ...ctx,
                lastUpdated: new Date().toISOString()
            })));
            setIsSyncing(false);
        }, 1500);
    };

    return (
        <div style={{ padding: '2rem', maxWidth: '1400px', margin: '0 auto' }} data-cy="registry-summary-dashboard">
            <header style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '3rem' }}>
                <div>
                    <h1 style={{ fontSize: '2.5rem', fontWeight: 800, color: 'var(--brand-500)', margin: 0 }}>
                        {t(ContentRegistry.SUMMARY_DASHBOARD.TITLE)}
                    </h1>
                    <p style={{ color: 'var(--text-300)', marginTop: '0.5rem', fontSize: '1.125rem' }}>
                        {t(ContentRegistry.SUMMARY_DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <button
                    onClick={handleSync}
                    disabled={isSyncing}
                    className="pc-button-primary"
                    style={{
                        padding: '1rem 2rem',
                        borderRadius: '0.75rem',
                        background: 'var(--brand-gradient)',
                        border: 'none',
                        color: 'white',
                        fontWeight: '700',
                        cursor: 'pointer',
                        boxShadow: '0 10px 20px rgba(0, 77, 64, 0.2)',
                        transition: 'transform 0.2s',
                    }}
                >
                    {isSyncing ? t(ContentRegistry.SUMMARY_DASHBOARD.MESSAGES.SYNCING) : t(ContentRegistry.SUMMARY_DASHBOARD.HEADER.SYNC_NOW)}
                </button>
            </header>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '3rem' }}>
                {contexts.map((context) => (
                    <section key={context.id} className="pc-card" style={{ padding: '2rem', background: 'rgba(255, 255, 255, 0.8)', backdropFilter: 'blur(10px)' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', borderBottom: '1px solid var(--border-100)', paddingBottom: '1.5rem', marginBottom: '2rem' }}>
                            <div>
                                <h2 style={{ fontSize: '1.5rem', fontWeight: 700, margin: 0, color: 'var(--text-400)' }}>{context.name}</h2>
                                <span style={{ fontSize: '0.75rem', color: 'var(--text-200)', textTransform: 'uppercase', letterSpacing: '0.05em' }}>
                                    ID: {context.id}
                                </span>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                                <div style={{ fontSize: '0.75rem', color: 'var(--text-200)' }}>{t(ContentRegistry.SUMMARY_DASHBOARD.HEADER.LAST_UPDATED)}</div>
                                <div style={{ fontWeight: 600, color: 'var(--brand-600)' }}>
                                    {context.lastUpdated ? new Date(context.lastUpdated).toLocaleString() : t(ContentRegistry.COMMON.FALLBACKS.TBD)}
                                </div>
                            </div>
                        </div>

                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '1.5rem' }}>
                            {context.kpis.map((kpi) => (
                                <div key={kpi.id} style={{
                                    padding: '1.5rem',
                                    borderRadius: '1rem',
                                    border: '1px solid var(--border-100)',
                                    display: 'flex',
                                    flexDirection: 'column',
                                    gap: '0.75rem',
                                    position: 'relative',
                                    overflow: 'hidden'
                                }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <span style={{ fontSize: '0.875rem', fontWeight: 600, color: 'var(--text-300)' }}>{kpi.label}</span>
                                        <span style={{ fontSize: '1.5rem' }}>{kpi.icon}</span>
                                    </div>
                                    <div style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--brand-500)' }}>
                                        {kpi.unit === '$' && '$'}
                                        --
                                        {kpi.unit && kpi.unit !== '$' && ` ${kpi.unit}`}
                                    </div>
                                    {kpi.targetRoute && (
                                        <Link to={kpi.targetRoute} style={{ fontSize: '0.75rem', color: 'var(--brand-400)', textDecoration: 'none', fontWeight: 600 }}>
                                            {t(ContentRegistry.ADMIN_DASHBOARD.ACTIONS.VIEW_DETAILS)}
                                        </Link>
                                    )}
                                </div>
                            ))}
                        </div>

                        {context.filters.length > 0 && (
                            <div style={{ marginTop: '2.5rem', background: '#f9fafb', padding: '1.25rem', borderRadius: '0.75rem' }}>
                                <h3 style={{ fontSize: '0.875rem', fontWeight: 700, marginBottom: '1rem', color: 'var(--text-300)' }}>
                                    {t(ContentRegistry.SUMMARY_DASHBOARD.CARDS.TREND)} / Filters
                                </h3>
                                <div style={{ display: 'flex', gap: '1rem', flexWrap: 'wrap' }}>
                                    {context.filters.map(filter => (
                                        <div key={filter.id} style={{
                                            padding: '0.5rem 1rem',
                                            background: 'white',
                                            border: '1px solid var(--border-200)',
                                            borderRadius: '0.5rem',
                                            fontSize: '0.875rem',
                                            color: 'var(--text-400)'
                                        }}>
                                            <strong>{filter.label}</strong>: {filter.type}
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}
                    </section>
                ))}
            </div>
        </div>
    );
};

export default RegistrySummaryDashboard;
