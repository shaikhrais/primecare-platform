import React, { useState, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function SystemHealthMonitor() {
    const { t } = useTranslation();
    const [logs, setLogs] = useState<string[]>([]);

    useEffect(() => {
        const mockLogs = [
            '[SYSTEM] Authentication provider ready.',
            '[INFO] Worker API latency: 45ms',
            '[SUCCESS] Daily compliance job completed.',
            '[AUDIT] Scrum Master portal accessed by Admin.',
            '[SYSTEM] Database connection pool healthy (12/20 active).',
            '[INFO] WebAdmin build v1.2.4 strictly synced.',
        ];

        setLogs(mockLogs);

        const interval = setInterval(() => {
            const newLog = `[${new Date().toLocaleTimeString()}] Heartbeat check: OK.`;
            setLogs(prev => [newLog, ...prev].slice(0, 10));
        }, 5000);

        return () => clearInterval(interval);
    }, []);

    return (
        <div data-cy="system-health-monitor-page">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.MONITORING.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.MONITORING.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '2rem', marginBottom: '2.5rem' }}>
                <div className="pc-card" style={{ padding: '2rem', background: 'linear-gradient(135deg, #1e293b, #0f172a)', color: 'white' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                        <h4 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700 }}>Worker API Cluster</h4>
                        <span style={{ backgroundColor: '#10b981', color: 'white', padding: '4px 10px', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 800 }}>LIVE</span>
                    </div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, marginBottom: '0.5rem' }}>99.98%</div>
                    <div style={{ color: '#94a3b8', fontSize: '0.9rem' }}>Uptime 24h • Average Latency 42ms</div>
                </div>

                <div className="pc-card" style={{ padding: '2rem', background: 'linear-gradient(135deg, #0284c7, #0369a1)', color: 'white' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                        <h4 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700 }}>Database Instance</h4>
                        <span style={{ backgroundColor: '#10b981', color: 'white', padding: '4px 10px', borderRadius: '20px', fontSize: '0.7rem', fontWeight: 800 }}>HEALTHY</span>
                    </div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, marginBottom: '0.5rem' }}>312ms</div>
                    <div style={{ color: '#bae6fd', fontSize: '0.9rem' }}>Complex P99 • 8.4GB Cache usage</div>
                </div>
            </div>

            <div className="pc-card" style={{ padding: '2rem', backgroundColor: '#0f172a' }}>
                <h3 style={{ margin: '0 0 1.5rem 0', color: 'white', display: 'flex', alignItems: 'center', gap: '10px' }}>
                    <span style={{ width: '8px', height: '8px', borderRadius: '50%', backgroundColor: '#10b981', display: 'inline-block' }}></span>
                    Live Logs Stream
                </h3>
                <div style={{
                    fontFamily: 'monospace',
                    fontSize: '0.9rem',
                    color: '#94a3b8',
                    lineHeight: 1.8,
                    height: '250px',
                    overflowY: 'auto',
                    padding: '1rem',
                    backgroundColor: 'rgba(255,255,255,0.03)',
                    borderRadius: '8px'
                }}>
                    {logs.map((log, i) => (
                        <div key={i} style={{ borderBottom: '1px solid rgba(255,255,255,0.05)', padding: '4px 0' }}>
                            <span style={{ color: '#3b82f6' }}>[{new Date().toLocaleDateString()}]</span> {log}
                        </div>
                    ))}
                </div>
            </div>
        </div>
    );
}
