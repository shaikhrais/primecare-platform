import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, ButtonRegistry, LinkRegistry, InteractionARegistry } = AdminRegistry;

export const TechnicalGovernance: React.FC = () => {
    const { t } = useTranslation();

    const guardrails = [
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.DATA_ISOLATION), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.ENCRYPTION), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
        { label: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.AUDIT_TRAIL), status: t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.STATUS_LOCKED), color: '#10b981' },
    ];

    const registryStats = [
        { label: 'Registered Buttons', value: ButtonRegistry.length, icon: '🔘' },
        { label: 'Active Links', value: LinkRegistry.length, icon: '🔗' },
        { label: 'Interaction Hooks', value: InteractionARegistry.length, icon: '⚡' },
    ];

    return (
        <div className="sm-card" style={{ padding: '2.5rem', background: '#ffffff', marginBottom: '3rem', borderTop: '4px solid var(--brand-500)', borderRadius: '24px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '2rem' }}>
                <h3 style={{ margin: 0, display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.5rem', fontWeight: 900 }}>
                    🛡️ {t(ContentRegistry.SCRUM_MASTER.GOVERNANCE.TITLE)}
                </h3>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2rem' }}>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <h4 style={{ fontSize: '0.75rem', fontWeight: 800, color: '#94a3b8', textTransform: 'uppercase', marginBottom: '1rem' }}>Active Guardrails</h4>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        {guardrails.map((g, i) => (
                            <div key={i} style={{ padding: '1rem', background: '#F9FAFB', borderRadius: '16px', border: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <div style={{ fontSize: '0.85rem', color: '#4b5563', fontWeight: 600 }}>{g.label}</div>
                                <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    <div style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: g.color }}></div>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 800, color: '#10b981' }}>{g.status}</span>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                    <h4 style={{ fontSize: '0.75rem', fontWeight: 800, color: '#94a3b8', textTransform: 'uppercase', marginBottom: '1rem' }}>Governance Actions</h4>
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: '1rem' }}>
                        <button
                            data-cy="btn-sm-universal-sweep"
                            style={{ padding: '12px 24px', background: '#4F46E5', color: '#FFFFFF', borderRadius: '16px', border: 'none', fontWeight: 900, fontSize: '0.85rem', cursor: 'pointer', boxShadow: '0 4px 12px rgba(79, 70, 229, 0.2)' }}
                        >
                            🚀 START SWEEP
                        </button>
                        <button
                            data-cy="btn-sm-auto-fix"
                            style={{ padding: '12px 24px', background: '#F8FAFC', color: '#475569', borderRadius: '16px', border: '1px solid #E2E8F0', fontWeight: 900, fontSize: '0.85rem', cursor: 'pointer' }}
                        >
                            🔧 AUTO-FIX REGISTRY
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
};
