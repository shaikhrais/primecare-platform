import React, { useState, useEffect } from 'react';
import { AlertCircle, Clock, FileWarning, ShieldAlert } from 'lucide-react';
import { useRealtimeSync, SyncMessage } from '@/app/hooks/useRealtimeSync';
import { apiClient } from '@/shared/utils/apiClient';

interface Anomaly {
    id: string;
    type: 'late' | 'overtime' | 'incident';
    message: string;
    timestamp: Date;
    severity: 'critical' | 'warning';
}

// Removing ANOMALIES to enforce DB-only architecture

export const AnomalyTicker: React.FC = () => {
    const [anomalies, setAnomalies] = useState<Anomaly[]>([]);
    
    const fetchAnomalies = async () => {
        try {
            // Using apiClient mapped route to preserve context
            const res = await apiClient.get('/v1/manager/ops/incidents');
            
            if (res.ok) {
                const data = await res.json();
                const mapped = data.map((d: any) => ({
                    id: d.id,
                    type: d.type === 'late' || d.type === 'overtime' ? d.type : 'incident',
                    message: `[${d.type.toUpperCase()}] ${d.description}`,
                    timestamp: new Date(d.createdAt),
                    severity: d.status === 'open' ? 'critical' : 'warning'
                }));
                setAnomalies(mapped.slice(0, 5));
            }
        } catch (error) {
            console.error('Failed to load anomalies:', error);
        }
    };

    useEffect(() => {
        fetchAnomalies();
    }, []);

    useRealtimeSync((msg: SyncMessage) => {
        // Only refresh anomaly list if the event might correlate to an incident
        if (msg.type === 'VISIT_UPDATE' || msg.type === 'TELEMETRY') {
            fetchAnomalies();
        }
    });

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
                            <button data-cy="btn-manager.anomaly-ticker-0" style={{ marginLeft: '16px', background: 'transparent', border: '1px solid #334155', color: '#94A3B8', padding: '2px 8px', borderRadius: '4px', fontSize: '0.75rem', cursor: 'pointer' }}>Acknowledge</button>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};
