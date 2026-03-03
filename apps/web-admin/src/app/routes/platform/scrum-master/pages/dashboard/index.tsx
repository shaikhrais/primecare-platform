import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { useAuth } from '@/shared/context/AuthContext';
import { Link } from 'react-router-dom';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

/*
## Phase 6: Registry Centralization [/]
- [x] Update `ContentRegistry.ts` in shared project
- [/] [Part 1] Refactor `ScrumMasterDashboard` & Base Tools
- [ ] [Part 2] Refactor Audit Tools & Page Hubs
- [ ] [Part 3] Global Dashboard Sync
- [ ] Verify platform-wide string consistency
*/

export default function ScrumMasterDashboard() {
    const { t } = useTranslation();
    const { user } = useAuth();

    return (
        <div data-cy="scrum-master-dashboard" style={{ animation: 'fadeIn 0.6s ease-out' }}>
            <style>
                {`
                    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
                    .sm-card {
                        background: rgba(255, 255, 255, 0.7);
                        backdrop-filter: blur(12px);
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.07);
                        border-radius: 20px;
                        padding: 2rem;
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                        cursor: pointer;
                        display: flex;
                        flex-direction: column;
                        height: 100%;
                    }
                    .sm-card:hover { 
                        transform: translateY(-8px); 
                        box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.12);
                        border-color: var(--brand-200);
                    }
                    .btn-utility {
                        padding: 12px 24px;
                        border-radius: 12px;
                        font-weight: 700;
                        text-decoration: none;
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        transition: all 0.2s;
                    }
                    .btn-utility:hover { transform: scale(1.05); }
                `}
            </style>

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
                    <Link to={RouteRegistry.LEARN} className="btn-utility" style={{ background: 'var(--brand-50)', color: 'var(--brand-600)' }}>
                        🎓 {t(ContentRegistry.LEARN.TITLE)}
                    </Link>
                    <Link to={RouteRegistry.ADMIN.DEV_KB} className="btn-utility" style={{ background: '#f8fafc', color: '#475569', border: '1px solid #e2e8f0' }}>
                        🛠️ {t(ContentRegistry.DEV_KB.TITLE)}
                    </Link>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))', gap: '2rem', marginBottom: '4rem' }}>
                <Link to={RouteRegistry.SCRUM_MASTER.API_ENDPOINTS} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #6366f1, #8b5cf6)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(99, 102, 241, 0.3))' }}>�</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.PAGES} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #3b82f6, #2dd4bf)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(59, 130, 246, 0.3))' }}>📄</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.PAGES.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.ROLE_FLOWS} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #f59e0b, #ef4444)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(245, 158, 11, 0.3))' }}>🔄</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.MONITORING} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #10b981, #3b82f6)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(16, 185, 129, 0.3))' }}>💓</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.MONITORING.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.MONITORING.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.ENV_AUDIT} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #06b6d4, #0891b2)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(6, 182, 212, 0.3))' }}>🌐</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.ENV_AUDIT.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.ENV_AUDIT.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.REGISTRY_CHECK} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #f43f5e, #e11d48)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(244, 63, 94, 0.3))' }}>📋</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.REGISTRY_CHECK.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.REGISTRY_CHECK.SUBTITLE)}
                        </p>
                    </div>
                </Link>

                <Link to={RouteRegistry.SCRUM_MASTER.DATABASE_SCHEMA} style={{ textDecoration: 'none' }}>
                    <div className="sm-card">
                        <div style={{ background: 'linear-gradient(135deg, #a855f7, #7c3aed)', width: '60px', height: '60px', borderRadius: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '2rem', marginBottom: '1.5rem', color: 'white', filter: 'drop-shadow(0 4px 12px rgba(168, 85, 247, 0.3))' }}>🗄️</div>
                        <h3 style={{ margin: '0 0 12px 0', color: 'var(--text-100)', fontSize: '1.5rem', fontWeight: 800 }}>{t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.TITLE)}</h3>
                        <p style={{ margin: 0, color: 'var(--text-300)', lineHeight: 1.6 }}>
                            {t(ContentRegistry.SCRUM_MASTER.DATABASE_SCHEMA.SUBTITLE)}
                        </p>
                    </div>
                </Link>
            </div>

            <div style={{ background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)', borderRadius: '32px', padding: '3rem', position: 'relative', overflow: 'hidden', color: 'white' }}>
                <div style={{ position: 'absolute', top: '-50px', right: '-50px', width: '200px', height: '200px', background: 'var(--brand-500)', opacity: 0.1, filter: 'blur(60px)', borderRadius: '50%' }}></div>
                <div style={{ position: 'absolute', bottom: '-50px', left: '-50px', width: '200px', height: '200px', background: '#ec4899', opacity: 0.1, filter: 'blur(60px)', borderRadius: '50%' }}></div>

                <h2 style={{ margin: '0 0 2rem 0', display: 'flex', alignItems: 'center', gap: '15px', fontSize: '2rem', fontWeight: 800 }}>
                    <span>🚀</span> {t(ContentRegistry.SCRUM_MASTER.DASHBOARD.TITLE)} {t(ContentRegistry.SHARED.STATUS)}
                </h2>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '3rem' }}>
                    <div style={{ transition: 'transform 0.3s' }} onMouseEnter={e => e.currentTarget.style.transform = 'scale(1.05)'} onMouseLeave={e => e.currentTarget.style.transform = 'scale(1)'}>
                        <div style={{ fontSize: '0.9rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.API_ENDPOINTS.TITLE)}</div>
                        <div style={{ fontSize: '3.5rem', fontWeight: 900, margin: '10px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>142</div>
                        <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '6px 12px', background: 'rgba(16, 185, 129, 0.15)', color: '#34d399', borderRadius: '30px', fontSize: '0.85rem', fontWeight: 700 }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#10b981', boxShadow: '0 0 10px #10b981' }}></div>
                            100% {t(ContentRegistry.SHARED.STATUS)}
                        </div>
                    </div>

                    <div style={{ transition: 'transform 0.3s' }} onMouseEnter={e => e.currentTarget.style.transform = 'scale(1.05)'} onMouseLeave={e => e.currentTarget.style.transform = 'scale(1)'}>
                        <div style={{ fontSize: '0.9rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.PAGES.TITLE)}</div>
                        <div style={{ fontSize: '3.5rem', fontWeight: 900, margin: '10px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>68</div>
                        <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '6px 12px', background: 'rgba(59, 130, 246, 0.15)', color: '#60a5fa', borderRadius: '30px', fontSize: '0.85rem', fontWeight: 700 }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#3b82f6', boxShadow: '0 0 10px #3b82f6' }}></div>
                            {t(ContentRegistry.SHARED.STATUS)}
                        </div>
                    </div>

                    <div style={{ transition: 'transform 0.3s' }} onMouseEnter={e => e.currentTarget.style.transform = 'scale(1.05)'} onMouseLeave={e => e.currentTarget.style.transform = 'scale(1)'}>
                        <div style={{ fontSize: '0.9rem', opacity: 0.6, textTransform: 'uppercase', fontWeight: 800, letterSpacing: '1px' }}>{t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}</div>
                        <div style={{ fontSize: '3.5rem', fontWeight: 900, margin: '10px 0', background: 'linear-gradient(135deg, #fff, #94a3b8)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>100%</div>
                        <div style={{ display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '6px 12px', background: 'rgba(245, 158, 11, 0.15)', color: '#fbbf24', borderRadius: '30px', fontSize: '0.85rem', fontWeight: 700 }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#f59e0b', boxShadow: '0 0 10px #f59e0b' }}></div>
                            {t(ContentRegistry.SHARED.STATUS)}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
