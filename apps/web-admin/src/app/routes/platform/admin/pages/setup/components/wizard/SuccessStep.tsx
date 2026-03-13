import React from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export const SuccessStep: React.FC = () => {
    const { t } = useTranslation();
    const navigate = useNavigate();

    return (
        <div style={{ textAlign: 'center', padding: '2rem 1rem' }}>
            <div style={{ fontSize: '4rem', marginBottom: '1.5rem' }}>🎉</div>
            <h2 data-cy="h2-admin.success-step-0" style={{ fontSize: '1.75rem', fontWeight: '800', marginBottom: '1rem' }}>{t(ContentRegistry.SETUP_WIZARD.SUCCESS.TITLE)}</h2>
            <p style={{ color: '#6b7280', fontSize: '1.125rem', marginBottom: '2.5rem' }}>{t(ContentRegistry.SETUP_WIZARD.SUCCESS.MESSAGE)}</p>
            <button data-cy="btn-admin.success-step-0" onClick={() => navigate(RouteRegistry.ADMIN.SCHEDULE)} style={{ width: '100%', padding: '1.25rem', background: '#004d40', color: 'white', fontWeight: 'bold', borderRadius: '1rem', border: 'none', cursor: 'pointer', fontSize: '1rem' }}>
                Go to Schedule & Start Booking
            </button>
            <button data-cy="btn-admin.success-step-1" onClick={() => navigate(RouteRegistry.ADMIN.DASHBOARD)} style={{ width: '100%', marginTop: '1rem', padding: '1rem', background: 'transparent', color: '#6b7280', fontWeight: '600', borderRadius: '1rem', border: 'none', cursor: 'pointer' }}>
                Back to Dashboard
            </button>
        </div>
    );
};
