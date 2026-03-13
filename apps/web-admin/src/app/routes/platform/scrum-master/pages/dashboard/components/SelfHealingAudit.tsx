import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const SelfHealingAudit: React.FC = () => {
    const { t } = useTranslation();

    const logs = [
        { action: t(ContentRegistry.SCRUM_MASTER.SELF_HEALING.ACTION_RESTART), target: 'Worker-Node-4', timestamp: '12:45 PM', status: 'Resolved' },
        { action: t(ContentRegistry.SCRUM_MASTER.SELF_HEALING.ACTION_CACHE), target: 'Admission-Gateway', timestamp: '11:20 AM', status: 'Resolved' },
        { action: t(ContentRegistry.SCRUM_MASTER.SELF_HEALING.ACTION_SYNC), target: 'Registry-Cluster', timestamp: 'Yesterday', status: 'Resolved' },
    ];

    return (
        <div className="sm-card" style={{ padding: '2rem', background: '#ffffff', marginBottom: '3rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h3 data-cy="h3-self-healing-audit-0" style={{ margin: 0, display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                    🛡️ {t(ContentRegistry.SCRUM_MASTER.SELF_HEALING.TITLE)}
                </h3>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '6px 14px', background: '#ecfdf5', color: '#059669', borderRadius: '30px', fontSize: '0.75rem', fontWeight: 800 }}>
                    <span style={{ width: '8px', height: '8px', background: '#10b981', borderRadius: '50%' }}></span>
                    {t(ContentRegistry.SHARED.STATUS).toUpperCase()}: ACTIVE
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {logs.map((log, i) => (
                    <div key={i} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '16px', background: '#f8fafc', borderRadius: '16px', border: '1px solid #f1f5f9' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '15px' }}>
                            <div style={{ width: '40px', height: '40px', background: 'white', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '1.2rem', border: '1px solid #e2e8f0', color: '#10b981' }}>✓</div>
                            <div>
                                <div style={{ fontWeight: 800, fontSize: '0.9rem', color: 'var(--text-400)' }}>{log.action}</div>
                                <div style={{ fontSize: '0.7rem', color: 'var(--text-300)' }}>{log.target} • {log.timestamp}</div>
                            </div>
                        </div>
                        <span style={{ fontSize: '0.75rem', fontWeight: 800, color: '#10b981' }}>{log.status.toUpperCase()}</span>
                    </div>
                ))}
            </div>

            <p style={{ margin: '1.5rem 0 0 0', fontSize: '0.8rem', color: 'var(--text-300)', textAlign: 'center', fontStyle: 'italic' }}>
                The AI-governance layer automatically triggers these actions when system telemetry falls below defined thresholds.
            </p>
        </div>
    );
};
