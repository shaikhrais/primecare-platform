import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Link, useNavigate } from 'react-router-dom';
import { AdminRegistry , getButtonById } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { SM_CARD_STYLES, handleDashboardAction } from './dashboardHelpers';

// Components
import { DashboardStatus } from './components/DashboardStatus';
import { EndpointDrillModal, PageAuditModal, RoleFlowDrillModal, ServiceMeshModal } from './components/DrillDownModals';
import { SystemHealthCharts } from './components/SystemHealthCharts';
import { HealthAlerts } from './components/HealthAlerts';
import { ProductRoadmap } from './components/ProductRoadmap';
import { TechnicalGovernance } from './components/TechnicalGovernance';
import { ScrumMasterCopilot } from './components/ScrumMasterCopilot';
import { AdvancedAnalytics } from './components/AdvancedAnalytics';
import { GlobalHealthMap } from './components/GlobalHealthMap';
import { SelfHealingAudit } from './components/SelfHealingAudit';
import { ProposalBoard } from './components/ProposalBoard';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function ScrumMasterDashboard() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const [drillType, setDrillType] = useState<'endpoints' | 'pages' | 'flows' | 'mesh' | null>(null);
    const { showToast } = useNotification();

    const handleAction = (endpoint: string, successMsg: string) => handleDashboardAction(endpoint, successMsg, showToast);
    const closeModal = () => setDrillType(null);
    const handleNavigation = (path: string) => navigate(path);

    return (
        <div data-cy="scrum-master-dashboard" style={{ animation: 'fadeIn 0.6s ease-out' }}>
            <style>{SM_CARD_STYLES}</style>

            {/* Header section with Utility Links */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '3rem' }}>
                <div>
                    <h1 style={{ margin: '0 0 8px 0', fontSize: '40px', fontWeight: 900, background: 'linear-gradient(90deg, var(--text-100), var(--brand-600))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
                        {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.TITLE)}
                    </h1>
                    <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.2rem', fontWeight: 500 }}>
                        {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.SUBTITLE)}
                    </p>
                </div>
                <div style={{ display: 'flex', gap: '12px' }}>
                    <Link to={RouteRegistry.ADMIN.SUMMARY_DASHBOARD} className="btn-utility" style={{ background: 'var(--brand-gradient)', color: 'white' }}>
                        📊 {getButtonById('btn-sm-summary-registry')?.label || t(ContentRegistry.SUMMARY_DASHBOARD.CARDS.REGISTRY_HUB.TITLE)}
                    </Link>
                    <Link to={RouteRegistry.LEARN} className="btn-utility" style={{ background: 'var(--brand-50)', color: 'var(--brand-600)' }}>
                        🎓 {t(ContentRegistry.LEARN.TITLE)}
                    </Link>
                    <Link to={RouteRegistry.SCRUM_MASTER.DEV_KB} className="btn-utility" style={{ background: '#f8fafc', color: '#475569', border: '1px solid #e2e8f0' }}>
                        🛠️ {t(ContentRegistry.SCRUM_MASTER.DEV_KB?.TITLE || 'Dev KB')}
                    </Link>
                </div>
            </div>

            {/* Phase 13 actions */}
            <div style={{ display: 'flex', gap: '8px', marginBottom: '2rem' }}>
                <button data-cy="btn-index-0" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => handleAction(AdminRegistry.ApiRegistry?.SCRUM_MASTER?.LOG_FLUSH || '/v1/scrum-master/forensics/flush', 'System audits purged.')}>{getButtonById('btn-sm-flush-audits')?.label || 'Flush Audits'}</button>
                <button data-cy="btn-index-1" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => handleAction(AdminRegistry.ApiRegistry?.SCRUM_MASTER?.DB_RESEED || '/v1/scrum-master/governance/reseed', 'Governance reseed synchronized.')}>{getButtonById('btn-sm-db-reseed')?.label || 'Reseed Database'}</button>
                <button data-cy="btn-index-2" className="btn" style={{ fontSize: '0.8rem', padding: '4px 8px' }} onClick={() => handleAction('/v1/scrum-master/system/deploy', 'System deployment instantiated.')}>{getButtonById('btn-sm-build-deploy')?.label || 'Deploy Build'}</button>
            </div>

            {/* AI Copilot & Technical Governance (The "Future" layer) */}
            <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '2rem', marginBottom: '3rem' }}>
                <ScrumMasterCopilot />
                <TechnicalGovernance />
            </div>

            {/* Core Stats Section (Clickable for Drills) */}
            <div style={{ marginBottom: '3rem' }}>
                <DashboardStatus
                    onDrillEndpoints={() => setDrillType('endpoints')}
                    onDrillPages={() => setDrillType('pages')}
                    onDrillFlows={() => setDrillType('flows')}
                />
            </div>

            {/* Global Infrastructure & Self-Healing Audit */}
            <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '2rem', marginBottom: '3rem' }}>
                <GlobalHealthMap />
                <SelfHealingAudit />
            </div>

            {/* Advanced Multi-dimensional Analytics */}
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1.5fr', gap: '2rem', marginBottom: '3rem' }}>
                <AdvancedAnalytics onDrillMesh={() => setDrillType('mesh')} />
                <HealthAlerts />
            </div>

            {/* Health Analytics Section */}
            <SystemHealthCharts />

            {/* Module Mapping Section */}
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: '2rem', marginBottom: '4rem' }}>
                <Link to={RouteRegistry.SCRUM_MASTER.API_ENDPOINTS} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #6366f1, #8b5cf6)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(99, 102, 241, 0.3))' }}>🔌</div>
                        <h3 data-cy="h3-index-0" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{AdminRegistry.LinkRegistry.find((l: any) => l.id === 'lnk-sm-api-hub')?.label || 'API Integrity Hub'}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.PAGES} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #3b82f6, #2dd4bf)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(59, 130, 246, 0.3))' }}>📄</div>
                        <h3 data-cy="h3-index-1" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.PAGES.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.ROLE_FLOWS} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #f59e0b, #ef4444)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(245, 158, 11, 0.3))' }}>🔄</div>
                        <h3 data-cy="h3-index-2" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.MONITORING} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #10b981, #3b82f6)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(16, 185, 129, 0.3))' }}>💓</div>
                        <h3 data-cy="h3-index-3" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.MONITORING.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.MONITORING.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.PERFORMANCE} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #facc15, #ea580c)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(250, 204, 21, 0.3))' }}>⚡</div>
                        <h3 data-cy="h3-index-4" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{AdminRegistry.LinkRegistry.find((l: any) => l.id === 'lnk-sm-perf-metrics')?.label || 'Node Performance'}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.PERFORMANCE.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.BUILD_HEALTH} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #34d399, #059669)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(52, 211, 153, 0.3))' }}>🏗️</div>
                        <h3 data-cy="h3-index-5" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.BUILD_HEALTH.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.BUILD_HEALTH.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.SECURITY_SCANS} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #f87171, #b91c1c)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(248, 113, 113, 0.3))' }}>🛡️</div>
                        <h3 data-cy="h3-index-6" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{getButtonById('btn-sm-scan-security')?.label || 'Security Scans'}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.SECURITY_SCANS.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.LOCALIZATION} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #60a5fa, #2563eb)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(96, 165, 250, 0.3))' }}>🌍</div>
                        <h3 data-cy="h3-index-7" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.LOCALIZATION.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.LOCALIZATION.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.DEVELOPER} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #a78bfa, #7c3aed)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(167, 139, 250, 0.3))' }}>💻</div>
                        <h3 data-cy="h3-index-8" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>Dev Portal</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            Consolidated engineering tools and developer sandbox.
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.ADMIN.SUMMARY_DASHBOARD} style={{ textDecoration: 'none' }}>
                    <div className="sm-card" style={{ border: '2px border var(--brand-400)' }}>
                        <div style={{ background: 'var(--brand-gradient)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(0, 77, 64, 0.3))' }}>📊</div>
                        <h3 data-cy="h3-index-9" style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SUMMARY_DASHBOARD.CARDS.REGISTRY_HUB.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SUMMARY_DASHBOARD.CARDS.REGISTRY_HUB.SUBTITLE)}
                        </p>
                    </div>
                </Link>
            </div>

            {/* Strategic Enhancement Proposal Board */}
            <ProposalBoard />

            {/* Strategic Roadmap */}
            <ProductRoadmap />

            {/* Drill-down Modals */}
            <EndpointDrillModal
                isOpen={drillType === 'endpoints'}
                onClose={closeModal}
            />
            <PageAuditModal
                isOpen={drillType === 'pages'}
                onClose={closeModal}
            />
            <RoleFlowDrillModal
                isOpen={drillType === 'flows'}
                onClose={closeModal}
            />
            <ServiceMeshModal
                isOpen={drillType === 'mesh'}
                onClose={closeModal}
            />
        </div>
    );
}
