import React, { useState, useEffect } from 'react';
import { AlertCircle, Clock, FileWarning, ShieldAlert } from 'lucide-react';

interface Anomaly {
    id: string;
    type: 'late' | 'overtime' | 'incident';
    message: string;
    timestamp: Date;
    severity: 'critical' | 'warning';
}

const MOCK_ANOMALIES: Anomaly[] = [
    { id: '1', type: 'late', message: 'PSW S. Connor is 45m late for Client B. Morrison', timestamp: new Date(), severity: 'warning' },
    { id: '2', type: 'overtime', message: 'Nurse J. Reynolds approaching 60h weekly limit', timestamp: new Date(Date.now() - 3600000), severity: 'critical' },
    { id: '3', type: 'incident', message: 'Fall Risk Level 4 reported at Facility North', timestamp: new Date(Date.now() - 7200000), severity: 'critical' },
];

export const AnomalyTicker: React.FC = () => {
    const [anomalies, setAnomalies] = useState<Anomaly[]>(MOCK_ANOMALIES);

    // Simulate new anomalies rolling in
    useEffect(() => {
        const interval = setInterval(() => {
            if (Math.random() > 0.7) {
                const newAnomaly: Anomaly = {
                    id: Math.random().toString(),
                    type: 'late',
                    message: `System Alert: Missed EVV Check-out detected for Shift #${Math.floor(Math.random() * 1000)}`,
                    timestamp: new Date(),
                    severity: 'critical'
                };
                setAnomalies(prev => [newAnomaly, ...prev].slice(0, 5)); // Keep last 5
            }
        }, 8000);
        return () => clearInterval(interval);
    }, []);

    const getIcon = (type: string, severity: string) => {
        const color = severity === 'critical' ? '#DC2626' : '#F59E0B';
        if (type === 'late') return <Clock size={16} color={color} />;
        if (type === 'overtime') return <ShieldAlert size={16} color={color} />;
        return <FileWarning size={16} color={color} />;
    };

    return (
        <div style={{ backgroundColor: '#020617', padding: '12px 24px', borderRadius: '12px', border: '1px solid #1E293B', display: 'flex', alignItems: 'center', gap: '16px', overflow: 'hidden' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#F1F5F9', fontWeight: 800, whiteSpace: 'nowrap', borderRight: '1px solid #334155', paddingRight: '16px' }}>
                <AlertCircle color="#EF4444" size={18} className="animate-pulse" /> Live Exceptions
            </div>
            
            <div style={{ flex: 1, overflow: 'hidden', position: 'relative', height: '24px' }}>
                <div style={{
                    display: 'flex',
                    flexDirection: 'column',
                    gap: '8px',
                    transition: 'transform 0.5s ease-in-out',
                }}>
                    {/* Just showing the top anomaly in a ticker style */}
                    {anomalies.length > 0 && (
                        <div key={anomalies[0].id} className="animate-fade-in" style={{ display: 'flex', alignItems: 'center', gap: '12px', whiteSpace: 'nowrap' }}>
                            {getIcon(anomalies[0].type, anomalies[0].severity)}
                            <span style={{ color: anomalies[0].severity === 'critical' ? '#FCA5A5' : '#FDE68A', fontWeight: 600, fontSize: '0.9rem' }}>
                                [{anomalies[0].timestamp.toLocaleTimeString()}] {anomalies[0].message}
                            </span>
                            <button style={{ marginLeft: '16px', background: 'transparent', border: '1px solid #334155', color: '#94A3B8', padding: '2px 8px', borderRadius: '4px', fontSize: '0.75rem', cursor: 'pointer' }}>Acknowledge</button>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};
