import React from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export const GlobalHealthMap: React.FC = () => {
    const { t } = useTranslation();

    const nodes = [
        { id: 'us', name: t(ContentRegistry.SCRUM_MASTER.GLOBAL_NODES.US_EAST), x: '25%', y: '40%', status: 'Healthy', latency: '42ms' },
        { id: 'eu', name: t(ContentRegistry.SCRUM_MASTER.GLOBAL_NODES.EU_WEST), x: '50%', y: '35%', status: 'Healthy', latency: '38ms' },
        { id: 'asia', name: t(ContentRegistry.SCRUM_MASTER.GLOBAL_NODES.ASIA_PACIFIC), x: '80%', y: '50%', status: 'Degraded', latency: '112ms' },
    ];

    return (
        <div className="sm-card" style={{ padding: '2.5rem', background: '#ffffff', marginBottom: '3rem', position: 'relative', overflow: 'hidden' }}>
            <h3 data-cy="h3-global-health-map-0" style={{ margin: '0 0 2rem 0', display: 'flex', alignItems: 'center', gap: '10px', fontSize: '1.25rem', fontWeight: 800 }}>
                🌍 {t(ContentRegistry.SCRUM_MASTER.GLOBAL_NODES.TITLE)}
            </h3>

            <div style={{ position: 'relative', height: '350px', background: '#f8fafc', borderRadius: '24px', border: '1px solid #e2e8f0' }}>
                {/* Simplified World SVG background */}
                <svg viewBox="0 0 1000 500" style={{ width: '100%', height: '100%', opacity: 0.1 }}>
                    <path d="M150,200 Q300,100 500,200 T850,200" fill="none" stroke="var(--brand-500)" strokeWidth="2" strokeDasharray="5,5" />
                    <circle cx="200" cy="200" r="100" fill="var(--brand-200)" />
                    <circle cx="500" cy="180" r="120" fill="var(--brand-200)" />
                    <circle cx="800" cy="250" r="110" fill="var(--brand-200)" />
                </svg>

                {nodes.map(node => (
                    <div
                        key={node.id}
                        style={{
                            position: 'absolute',
                            left: node.x,
                            top: node.y,
                            transform: 'translate(-50%, -50%)',
                            display: 'flex',
                            flexDirection: 'column',
                            alignItems: 'center',
                            cursor: 'pointer'
                        }}
                    >
                        <div style={{ position: 'relative' }}>
                            <div style={{
                                width: '16px',
                                height: '16px',
                                background: node.id === 'asia' ? '#f59e0b' : '#10b981',
                                borderRadius: '50%',
                                boxShadow: `0 0 20px ${node.id === 'asia' ? '#f59e0b' : '#10b981'}`
                            }} />
                            <div className="pulse" style={{
                                position: 'absolute',
                                top: 0,
                                left: 0,
                                width: '16px',
                                height: '16px',
                                background: node.id === 'asia' ? '#f59e0b' : '#10b981',
                                borderRadius: '50%',
                                opacity: 0.5
                            }} />
                        </div>
                        <div style={{
                            marginTop: '12px',
                            background: 'white',
                            padding: '8px 12px',
                            borderRadius: '12px',
                            boxShadow: '0 4px 12px rgba(0,0,0,0.08)',
                            border: '1px solid #e2e8f0',
                            textAlign: 'center',
                            minWidth: '120px'
                        }}>
                            <div style={{ fontSize: '0.7rem', fontWeight: 800, color: 'var(--text-400)' }}>{node.name}</div>
                            <div style={{ fontSize: '0.65rem', color: node.id === 'asia' ? '#f59e0b' : '#10b981', fontWeight: 700 }}>{node.latency}</div>
                        </div>
                    </div>
                ))}
            </div>

            <style>{`
                @keyframes pulse {
                    0% { transform: scale(1); opacity: 0.5; }
                    100% { transform: scale(3); opacity: 0; }
                }
                .pulse { animation: pulse 2s infinite ease-out; }
            `}</style>
        </div>
    );
};
