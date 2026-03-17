// ================================================================
// DEV PREVIEW — Public page that renders ALL premium pages inline
// No auth required. Visit /dev-preview to see everything.
// DELETE THIS BEFORE PRODUCTION.
// ================================================================
import React, { Suspense, lazy, useState } from 'react';

const pages = [
    // Manager premium
    { id: 'gamification', label: '🎮 Gamification Hub', component: lazy(() => import('../../tenancy/manager/pages/engagement/H19-GamificationHub')), route: '/tenancy/manager/gamification' },
    { id: 'iot', label: '📡 IoT Monitoring', component: lazy(() => import('../../tenancy/manager/pages/iot/H20-IoTMonitoring')), route: '/tenancy/manager/iot-monitoring' },
    { id: 'doc-signing', label: '✍️ Document Signing', component: lazy(() => import('../../tenancy/manager/pages/documents/H21-DocumentSigningCenter')), route: '/tenancy/manager/document-signing' },
    { id: 'sms', label: '📱 SMS Hub', component: lazy(() => import('../../platform/admin/pages/communications/H22-SMSHub')), route: '/tenancy/manager/sms-hub' },
    { id: 'reviews', label: '📊 Performance Reviews', component: lazy(() => import('../../tenancy/manager/pages/hr/L15-PerformanceReviews')), route: '/tenancy/manager/performance-reviews' },
    { id: 'training', label: '🎓 Training Academy', component: lazy(() => import('../../tenancy/manager/pages/training/H24-TrainingAcademy')), route: '/tenancy/manager/training-academy' },
    // Admin premium
    { id: 'ai', label: '🧠 AI Command Center', component: lazy(() => import('../../platform/admin/pages/ai/D7-AICommandCenter')), route: '/platform/admin/ai-command' },
    { id: 'currency', label: '💱 Multi-Currency', component: lazy(() => import('../../platform/admin/pages/settings/S8-MultiCurrencySettings')), route: '/platform/admin/multi-currency' },
    { id: 'audit', label: '🔍 Audit Trail', component: lazy(() => import('../../platform/admin/pages/security/L16-AuditTrailViewer')), route: '/platform/admin/audit-trail' },
    { id: 'franchise', label: '🏢 Franchise Mgmt', component: lazy(() => import('../../platform/admin/pages/franchise/H23-FranchiseManagement')), route: '/platform/admin/franchise' },
    { id: 'supply', label: '📦 Supply Chain', component: lazy(() => import('../../platform/admin/pages/supply-chain/L14-SupplyChainManagement')), route: '/platform/admin/supply-chain' },
];

export default function DevPreview() {
    const [active, setActive] = useState<string | null>(null);
    const ActivePage = active ? pages.find(p => p.id === active)?.component : null;

    return (
        <div style={{ minHeight: '100vh', background: '#0F172A', color: 'white', fontFamily: "'Inter', system-ui, sans-serif" }}>
            {/* Header */}
            <div style={{ padding: '32px 40px', borderBottom: '1px solid rgba(255,255,255,0.1)' }}>
                <h1 style={{ margin: 0, fontSize: '1.8rem', fontWeight: 900, background: 'linear-gradient(135deg, #3B82F6, #8B5CF6)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                    🚀 PrimeCare Dev Preview
                </h1>
                <p style={{ margin: '8px 0 0', color: '#94A3B8', fontSize: '0.9rem' }}>
                    11 premium pages • No auth required • Click any page to preview
                </p>
            </div>

            {/* Page Grid */}
            {!active && (
                <div style={{ padding: '32px 40px' }}>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(260px, 1fr))', gap: '16px' }}>
                        {pages.map(p => (
                            <button key={p.id} onClick={() => setActive(p.id)} style={{
                                padding: '24px', borderRadius: '16px', border: '1px solid rgba(255,255,255,0.1)',
                                background: 'rgba(255,255,255,0.03)', cursor: 'pointer', textAlign: 'left',
                                transition: 'all 0.3s', color: 'white',
                            }}
                                onMouseEnter={e => { e.currentTarget.style.background = 'rgba(59,130,246,0.15)'; e.currentTarget.style.borderColor = '#3B82F6'; e.currentTarget.style.transform = 'translateY(-3px)'; }}
                                onMouseLeave={e => { e.currentTarget.style.background = 'rgba(255,255,255,0.03)'; e.currentTarget.style.borderColor = 'rgba(255,255,255,0.1)'; e.currentTarget.style.transform = 'translateY(0)'; }}
                            >
                                <div style={{ fontSize: '1.1rem', fontWeight: 700, marginBottom: '8px' }}>{p.label}</div>
                                <div style={{ fontSize: '0.7rem', fontFamily: 'monospace', color: '#64748B', wordBreak: 'break-all' }}>{p.route}</div>
                            </button>
                        ))}
                    </div>
                </div>
            )}

            {/* Active Page */}
            {active && ActivePage && (
                <div>
                    <div style={{ padding: '12px 40px', background: 'rgba(59,130,246,0.1)', borderBottom: '1px solid rgba(59,130,246,0.3)', display: 'flex', alignItems: 'center', gap: '16px' }}>
                        <button onClick={() => setActive(null)} style={{
                            padding: '6px 16px', borderRadius: '8px', border: '1px solid #3B82F6',
                            background: 'transparent', color: '#3B82F6', fontWeight: 700, cursor: 'pointer', fontSize: '0.85rem',
                        }}>← Back to Grid</button>
                        <span style={{ fontWeight: 700, color: '#E2E8F0' }}>{pages.find(p => p.id === active)?.label}</span>
                        <span style={{ fontSize: '0.7rem', fontFamily: 'monospace', color: '#64748B' }}>{pages.find(p => p.id === active)?.route}</span>
                    </div>
                    <div style={{ background: 'var(--pc-bg-primary, #F9FAFB)', minHeight: 'calc(100vh - 150px)' }}>
                        <Suspense fallback={<div style={{ padding: '40px', textAlign: 'center', color: '#94A3B8' }}>Loading page...</div>}>
                            <ActivePage />
                        </Suspense>
                    </div>
                </div>
            )}
        </div>
    );
}
