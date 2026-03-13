import React from 'react';
import { Link } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

interface SetupBannerProps {
    modelScore: number;
}

export const SetupBanner: React.FC<SetupBannerProps> = ({ modelScore }) => {
    const { t } = useTranslation();

    return (
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 300px', gap: '1.5rem', marginBottom: '2rem' }}>
            <div style={{
                background: 'linear-gradient(135deg, #004d40 0%, #00695c 100%)',
                padding: '2rem',
                borderRadius: '1.5rem',
                color: 'white',
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)'
            }} data-cy="setup-wizard-banner">
                <div>
                    <h2 data-cy="h2-admin.setup-banner-0" style={{ fontSize: '1.5rem', fontWeight: '800', marginBottom: '0.5rem' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.TITLE)}</h2>
                    <p style={{ opacity: 0.9 }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.SUBTITLE)}</p>
                </div>
                <div style={{ display: 'flex', gap: '1rem' }}>
                    <Link to={RouteRegistry.LEARN}>
                        <button data-cy="btn-admin.setup-banner-0" style={{
                            padding: '1rem 2rem',
                            background: 'rgba(255,255,255,0.1)',
                            color: 'white',
                            fontWeight: 'bold',
                            border: '1px solid rgba(255,255,255,0.2)',
                            borderRadius: '1rem',
                            cursor: 'pointer'
                        }}>
                            {t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.TRAINING)}
                        </button>
                    </Link>
                    <Link to={RouteRegistry.ADMIN.BUSINESS_STATUS}>
                        <button data-cy="btn-admin.setup-banner-1" style={{
                            padding: '1rem 2rem',
                            background: 'white',
                            color: '#004d40',
                            fontWeight: 'bold',
                            border: 'none',
                            borderRadius: '1rem',
                            cursor: 'pointer'
                        }}>
                            {t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.ACTION)}
                        </button>
                    </Link>
                </div>
            </div>

            <div style={{ background: 'white', padding: '1.5rem', borderRadius: '1.5rem', border: '1px solid #e5e7eb', display: 'flex', flexDirection: 'column', justifyContent: 'center' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                    <span style={{ fontWeight: '700', fontSize: '0.875rem' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.SCORE_LABEL)}</span>
                    <span style={{ fontWeight: '800', color: '#4f46e5' }}>{modelScore || 0}%</span>
                </div>
                <div style={{ width: '100%', height: '10px', background: '#f3f4f6', borderRadius: '5px', overflow: 'hidden' }}>
                    <div style={{
                        width: `${modelScore || 0}%`,
                        height: '100%',
                        background: 'linear-gradient(90deg, #4f46e5 0%, #7c3aed 100%)',
                        transition: 'width 0.5s ease-out'
                    }} />
                </div>
                <p style={{ fontSize: '0.75rem', color: '#6b7280', marginTop: '0.75rem' }}>
                    Complete your <Link to={RouteRegistry.ADMIN.BUSINESS_MODEL_WIZARD} style={{ color: '#4f46e5', fontWeight: '600' }}>{t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.STRATEGY_LINK)}</Link> {t(ContentRegistry.ADMIN_DASHBOARD.SETUP_BANNER.STRATEGY_DESC)}
                </p>
            </div>
        </div>
    );
};
