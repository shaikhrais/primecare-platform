import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const TechnicalGovernance: React.FC = () => {
    const { t } = useTranslation();

    const guardrails = [
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.DATA_ISOLATION), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.ENCRYPTION), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.AUDIT_TRAIL), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
    ];

    return (
        <div className="sm-card" style={{ padding: '2rem', background: '#ffffff', marginBottom: '3rem', borderTop: '4px solid var(--brand-500)' }}>
            <h3 style={{ margin: '0 0 1.5rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                🛡️ {t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.TITLE)}
            </h3>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))', gap: '1.5rem' }}>
                {guardrails.map((g, i) => (
                    <div key={i} style={{ padding: '1.25rem', background: '#F9FAFB', borderRadius: '16px', border: '1px solid #E5E7EB' }}>
                        <div style={{ fontSize: '0.75rem', color: 'var(--text-300)', marginBottom: '4px', textTransform: 'uppercase', fontWeight: 800 }}>{g.label}</div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                            <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: g.color }}></div>
                            <span style={{ fontWeight: 700, color: 'var(--text-400)' }}>{g.status}</span>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};
