import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function TechnicalAuditPortal() {
    const { t } = useTranslation();
    const [activeTab, setActiveTab] = useState<'pages' | 'components'>('pages');

    const pages = [
        { name: 'Admin Dashboard', path: 'routes/platform/admin/pages/dashboard', route: 'ADMIN.DASHBOARD', role: 'Admin' },
        { name: 'PSW Schedule', path: 'routes/tenancy/psw/pages/schedule', route: 'PSW.SCHEDULE', role: 'PSW' },
        { name: 'Manager Portfolio', path: 'routes/tenancy/manager/pages/portfolio', route: 'MANAGER.DASHBOARD', role: 'Manager' },
        { name: 'Client Bookings', path: 'routes/tenancy/client/pages/bookings', route: 'CLIENT.BOOKINGS', role: 'Client' },
    ];

    const components = [
        { name: 'AppLayout', path: 'shared/components/layout/AppLayout', type: 'Layout' },
        { name: 'RequireRole', path: 'shared/rbac/RequireRole', type: 'Guard' },
        { name: 'NotificationCenter', path: 'shared/context/NotificationCenterContext', type: 'Context' },
        { name: 'CommandPalette', path: 'shared/components/CommandPaletteWrapper', type: 'UI' },
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
                        transition: 'all 0.2s'
                    }}
                >
                    📁 Physical Pages
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
                        transition: 'all 0.2s'
                    }}
                >
                    🧩 UI Components
                </button>
            </div>

            <div className="pc-card" style={{ padding: 0, overflow: 'hidden' }}>
                {activeTab === 'pages' ? (
                    <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                        <thead style={{ backgroundColor: 'var(--bg-200)', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                            <tr>
                                <th style={{ padding: '1rem 1.5rem' }}>Page Name</th>
                                <th style={{ padding: '1rem 1.5rem' }}>Source File Path</th>
                                <th style={{ padding: '1rem 1.5rem' }}>Registry Variable</th>
                                <th style={{ padding: '1rem 1.5rem' }}>Access Role</th>
                            </tr>
                        </thead>
                        <tbody>
                            {pages.map((p, idx) => (
                                <tr key={idx} style={{ borderBottom: '1px solid var(--border)' }}>
                                    <td style={{ padding: '1.2rem 1.5rem', fontWeight: 600, color: 'var(--text-100)' }}>{p.name}</td>
                                    <td style={{ padding: '1.2rem 1.5rem', color: 'var(--text-300)', fontSize: '0.85rem' }}>
                                        <code>.../{p.path}</code>
                                    </td>
                                    <td style={{ padding: '1.2rem 1.5rem', color: 'var(--brand-500)', fontWeight: 700, fontSize: '0.85rem' }}>
                                        {p.route}
                                    </td>
                                    <td style={{ padding: '1.2rem 1.5rem' }}>
                                        <span style={{ backgroundColor: '#e0f2fe', color: '#0369a1', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700 }}>
                                            {p.role}
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
                                <th style={{ padding: '1rem 1.5rem' }}>Component Name</th>
                                <th style={{ padding: '1rem 1.5rem' }}>Module Path</th>
                                <th style={{ padding: '1rem 1.5rem' }}>Type</th>
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
                                        <span style={{ backgroundColor: '#f1f5f9', color: '#475569', padding: '4px 8px', borderRadius: '6px', fontSize: '0.75rem', fontWeight: 700 }}>
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
