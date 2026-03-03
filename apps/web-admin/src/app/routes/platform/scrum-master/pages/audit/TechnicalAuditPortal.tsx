import React, { useState, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function TechnicalAuditPortal() {
    const { t } = useTranslation();
    const [activeTab, setActiveTab] = useState<'pages' | 'components'>('pages');

    // Dynamically extract routes from RouteRegistry
    const pages = useMemo(() => {
        const list: { name: string; path: string; variable: string; category: string }[] = [];

        const processRegistry = (obj: any, category: string) => {
            Object.entries(obj).forEach(([key, value]) => {
                if (typeof value === 'string') {
                    list.push({
                        name: key,
                        path: value as string,
                        variable: `${category}.${key}`,
                        category: category
                    });
                } else if (typeof value === 'object' && value !== null) {
                    processRegistry(value, `${category}.${key}`);
                }
            });
        };

        processRegistry(RouteRegistry, 'RouteRegistry');
        return list.filter(p => !p.path.includes(':') && p.path.startsWith('/')).slice(0, 30);
    }, []);

    const components = [
        { name: 'AppLayout', path: 'shared/components/layout/AppLayout', type: 'Layout' },
        { name: 'RequireRole', path: 'shared/rbac/RequireRole', type: 'Guard' },
        { name: 'NotificationCenter', path: 'shared/context/NotificationCenterContext', type: 'Context' },
        { name: 'CommandPalette', path: 'shared/components/CommandPaletteWrapper', type: 'UI' },
        { name: 'Sidebar', path: 'shared/components/layout/Sidebar', type: 'Layout' },
        { name: 'TopBar', path: 'shared/components/layout/TopBar', type: 'Layout' },
    ];

    return (
        <div data-cy="technical-audit-portal">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.PAGES.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'flex', gap: '8px', marginBottom: '2rem', borderBottom: '1px solid var(--border)', paddingBottom: '12px' }}>
                <button
                    onClick={() => setActiveTab('pages')}
                    style={{
                        padding: '10px 24px',
                        border: 'none',
                        borderRadius: '12px',
                        backgroundColor: activeTab === 'pages' ? 'var(--brand-500)' : 'transparent',
                        color: activeTab === 'pages' ? 'white' : 'var(--text-300)',
                        fontWeight: 700,
                        cursor: 'pointer',
                        transition: '0.2s'
                    }}
                >
                    📁 {t(ContentRegistry.AUDIT.TABS.ROUTES)}
                </button>
                <button
                    onClick={() => setActiveTab('components')}
                    style={{
                        padding: '10px 24px',
                        border: 'none',
                        borderRadius: '12px',
                        backgroundColor: activeTab === 'components' ? 'var(--brand-500)' : 'transparent',
                        color: activeTab === 'components' ? 'white' : 'var(--text-300)',
                        fontWeight: 700,
                        cursor: 'pointer',
                        transition: '0.2s'
                    }}
                >
                    🧩 {t(ContentRegistry.AUDIT.TABS.COMPONENTS)}
                </button>
            </div>

            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                {activeTab === 'pages' ? (
                    <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                            <tr>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.ROUTE_NAME)}</th>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.PATH)}</th>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.REFERENCE)}</th>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.MODULE)}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {pages.map((p, idx) => (
                                <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)' }}>{p.name}</td>
                                    <td style={{ padding: '1.2rem 1.5rem', color: 'var(--brand-500)', fontSize: '0.85rem' }}>
                                        <code>{p.path}</code>
                                    </td>
                                    <td style={{ padding: '1.2rem 1.5rem', color: 'var(--text-400)', fontSize: '0.8rem', fontFamily: 'monospace' }}>
                                        {p.variable}
                                    </td>
                                    <td style={{ padding: '1.2rem 1.5rem' }}>
                                        <span style={{ backgroundColor: '#f1f5f9', color: '#475569', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700 }}>
                                            {p.category.split('.').pop()}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                ) : (
                    <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                            <tr>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.COMPONENT_NAME)}</th>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.PATH)}</th>
                                <th style={{ padding: '1rem 1.5rem' }}>{t(ContentRegistry.AUDIT.TABLE.LAYER)}</th>
                            </tr>
                        </thead>
                        <tbody>
                            {components.map((c, idx) => (
                                <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)' }}>{c.name}</td>
                                    <td style={{ padding: '1.2rem 1.5rem', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                                        <code>@/{c.path}</code>
                                    </td>
                                    <td style={{ padding: '1.2rem 1.5rem' }}>
                                        <span style={{ backgroundColor: '#e0f2fe', color: '#0369a1', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700 }}>
                                            {c.type}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                )}
            </div>
        </div>
    );
}
