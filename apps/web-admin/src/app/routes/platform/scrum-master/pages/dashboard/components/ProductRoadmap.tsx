import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const ProductRoadmap: React.FC = () => {
    const { t } = useTranslation();

    const phases = [
        {
            title: t(ContentRegistry.SCRUM_MASTER.ROADMAP.PHASE_1),
            status: t(ContentRegistry.SCRUM_MASTER.ROADMAP.STATUS_COMPLETED),
            color: '#10b981',
            icon: '📊',
            items: ['Latency Monitoring', 'Error Tracking', 'Registry Audits']
        },
        {
            title: t(ContentRegistry.SCRUM_MASTER.ROADMAP.PHASE_2),
            status: t(ContentRegistry.SCRUM_MASTER.ROADMAP.STATUS_IN_PROGRESS),
            color: '#3b82f6',
            icon: '🧠',
            items: ['Predictive Scaling', 'Auto-Healing Routes', 'LLM Debugger']
        },
        {
            title: t(ContentRegistry.SCRUM_MASTER.ROADMAP.PHASE_3),
            status: t(ContentRegistry.SCRUM_MASTER.ROADMAP.STATUS_PLANNED),
            color: '#94a3b8',
            icon: '☁️',
            items: ['Edge Deployment', 'Disaster Recovery', 'Multi-Cloud Sync']
        }
    ];

    return (
        <div className="sm-card" style={{ padding: '3rem', background: 'linear-gradient(135deg, #0f172a 0%, #1e293b 100%)', color: 'white' }}>
            <h3 style={{ margin: '0 0 2.5rem 0', display: 'flex', alignItems: 'center', gap: '15px', fontSize: '1.5rem', fontWeight: 800 }}>
                🚀 {t(ContentRegistry.SCRUM_MASTER.ROADMAP.TITLE)}
            </h3>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '2rem', position: 'relative' }}>
                {phases.map((phase, idx) => (
                    <div key={idx} style={{ position: 'relative', paddingLeft: '20px', borderLeft: `2px solid ${phase.color}` }}>
                        <div style={{
                            position: 'absolute',
                            left: '-11px',
                            top: '0',
                            width: '20px',
                            height: '20px',
                            background: phase.color,
                            borderRadius: '50%',
                            border: '4px solid #0f172a',
                            boxShadow: `0 0 15px ${phase.color}`
                        }} />

                        <div style={{ background: 'rgba(255,255,255,0.05)', borderRadius: '16px', padding: '1.5rem', border: '1px solid rgba(255,255,255,0.1)' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '1rem' }}>
                                <span style={{ fontSize: '1.5rem' }}>{phase.icon}</span>
                                <span style={{ fontSize: '0.65rem', fontWeight: 800, padding: '4px 10px', borderRadius: '20px', background: `${phase.color}20`, color: phase.color, border: `1px solid ${phase.color}40` }}>
                                    {phase.status.toUpperCase()}
                                </span>
                            </div>
                            <h4 style={{ margin: '0 0 0.75rem 0', fontSize: '1.1rem', fontWeight: 700 }}>{phase.title}</h4>
                            <ul style={{ margin: 0, paddingLeft: '1.25rem', color: '#94a3b8', fontSize: '0.85rem', lineHeight: 1.8 }}>
                                {phase.items.map((item, i) => <li key={i}>{item}</li>)}
                            </ul>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};
