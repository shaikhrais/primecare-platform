import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const OperationalStatus: React.FC = () => {
    const { t } = useTranslation();

    return (
        <div className="pc-card">
            <div className="pc-card-h">
                {t(ContentRegistry.ADMIN_DASHBOARD.TITLES.OPERATIONAL_STATUS)}
            </div>
            <div className="pc-card-b">
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-api">
                        <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.API)}</span>
                        <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.HEALTHY)}</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0', borderBottom: '1px solid var(--card-border)' }} data-cy="status-item-client-app">
                        <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.CLIENT_APP)}</span>
                        <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')}</span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', padding: '0.75rem 0' }} data-cy="status-item-psw-app">
                        <span style={{ color: 'var(--text-200)' }}>{t(ContentRegistry.ADMIN_DASHBOARD.STATUS.PSW_APP)}</span>
                        <span style={{ color: 'var(--success-600)', fontWeight: '900' }}>{ContentRegistry.ADMIN_DASHBOARD.STATUS.ONLINE('1.0.4')}</span>
                    </div>
                </div>
            </div>
        </div>
    );
};
