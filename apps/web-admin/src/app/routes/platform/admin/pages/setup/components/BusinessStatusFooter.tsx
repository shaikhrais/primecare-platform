import React from 'react';
import { Link } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';

const { RouteRegistry, ContentRegistry } = AdminRegistry;

export const BusinessStatusFooter: React.FC = () => {
    const { t } = useTranslation();

    return (
        <div style={{ marginTop: '4rem', padding: '2rem', background: '#f9fafb', borderRadius: '1.5rem', textAlign: 'center' }}>
            <h4 style={{ fontWeight: '800', marginBottom: '1rem' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.TITLE)}</h4>
            <div style={{ display: 'flex', justifyContent: 'center', gap: '2rem', flexWrap: 'wrap' }}>
                <Link to={RouteRegistry.ADMIN.USERS} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.VIEW_STAFF)}</Link>
                <Link to={RouteRegistry.ADMIN.LEADS} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.MANAGE_LEADS)}</Link>
                <Link to={RouteRegistry.ADMIN.SCHEDULE} style={{ color: '#4f46e5', fontWeight: '600', textDecoration: 'none' }}>{t(ContentRegistry.BUSINESS_STATUS.FOOTER.DISPATCH_SHIFTS)}</Link>
            </div>
        </div>
    );
};
