import React from 'react';
import { Clock, Edit3, CheckCircle, FileText, AlertTriangle } from 'lucide-react';

interface AuditEvent {
    id: string;
    timestamp: Date;
    actor: { name: string; role: string };
    action: string;
    details?: string;
    type: 'creation' | 'modification' | 'approval' | 'system';
}

import { apiClient } from '@/shared/utils/apiClient';

export const AuditTimeline: React.FC = () => {
    const [events, setEvents] = React.useState<AuditEvent[]>([]);
    const [loading, setLoading] = React.useState(true);

    React.useEffect(() => {
        const fetchAudits = async () => {
            try {
                const res = await apiClient.get('/v1/system/platform/audit-logs');
                if (res.ok) {
                    const data = await res.json();
                    
                    const mapped = data.map((d: any) => ({
                        id: d.id,
                        timestamp: new Date(d.createdAt || d.timestamp),
                        actor: { name: d.actorUserId || 'System', role: 'Authorized Entity' },
                        action: d.action,
                        details: d.metadataJson ? JSON.stringify(d.metadataJson) : `Resource: ${d.resourceType} [${d.resourceId}]`,
                        type: d.action.toLowerCase().includes('create') ? 'creation' 
                              : d.action.toLowerCase().includes('approve') ? 'approval'
                              : d.action.toLowerCase().includes('update') ? 'modification'
                              : 'system'
                    }));
                    setEvents(mapped.slice(0, 10)); // keep last 10
                }
            } catch (error) {
                console.error("Failed to fetch audit logs", error);
            } finally {
                setLoading(false);
            }
        };
        fetchAudits();
    }, []);

    const getIcon = (type: string) => {
        switch (type) {
            case 'creation': return <FileText size={16} color="#3B82F6" />;
            case 'system': return <AlertTriangle size={16} color="#F59E0B" />;
            case 'modification': return <Edit3 size={16} color="#8B5CF6" />;
            case 'approval': return <CheckCircle size={16} color="#10B981" />;
            default: return <Clock size={16} color="#64748B" />;
        }
    };

    const getRingColor = (type: string) => {
        switch (type) {
            case 'creation': return '#DBEAFE'; // blue-100
            case 'system': return '#FEF3C7'; // amber-100
            case 'modification': return '#EDE9FE'; // violet-100
            case 'approval': return '#D1FAE5'; // green-100
            default: return '#F1F5F9';
        }
    };

    return (
        <div style={{ backgroundColor: 'white', padding: '32px', borderRadius: '16px', border: '1px solid #E2E8F0', maxWidth: '600px', margin: '0 auto' }}>
            <h2 style={{ fontSize: '1.25rem', fontWeight: 800, margin: '0 0 4px 0', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '8px' }}>
                <Clock color="#64748B" /> Immutable Forensic Log
            </h2>
            <p style={{ color: '#64748B', margin: '0 0 32px 0', fontSize: '0.9rem' }}>Entity ID: <code style={{ backgroundColor: '#F1F5F9', padding: '2px 6px', borderRadius: '4px' }}>TS-88492-X</code></p>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0', position: 'relative' }}>
                {/* Vertical Line Anchor */}
                <div style={{ position: 'absolute', left: '23px', top: '24px', bottom: '24px', width: '2px', backgroundColor: '#E2E8F0', zIndex: 0 }} />

                {loading ? <div style={{ padding: '24px', color: '#64748B' }}>Loading forensic trail...</div> : events.map((event, index) => (
                    <div key={event.id} style={{ display: 'flex', gap: '24px', position: 'relative', paddingBottom: index === events.length - 1 ? '0' : '32px' }}>
                        {/* Timeline Node */}
                        <div style={{ 
                            width: '48px', height: '48px', 
                            backgroundColor: getRingColor(event.type), 
                            borderRadius: '50%', 
                            display: 'flex', alignItems: 'center', justifyContent: 'center', 
                            zIndex: 1, 
                            border: '4px solid white',
                            boxShadow: '0 0 0 1px #E2E8F0'
                        }}>
                            {getIcon(event.type)}
                        </div>

                        {/* Event Content */}
                        <div style={{ flex: 1, paddingTop: '4px' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '8px' }}>
                                <div>
                                    <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1rem' }}>{event.action}</div>
                                    <div style={{ color: '#64748B', fontSize: '0.85rem', display: 'flex', gap: '8px', alignItems: 'center' }}>
                                        <span style={{ fontWeight: 700, color: '#475569' }}>{event.actor.name}</span>
                                        <span style={{ display: 'inline-block', width: '4px', height: '4px', backgroundColor: '#CBD5E1', borderRadius: '50%' }} />
                                        <span>{event.actor.role}</span>
                                    </div>
                                </div>
                                <div style={{ color: '#94A3B8', fontSize: '0.75rem', fontWeight: 600, textAlign: 'right' }}>
                                    {event.timestamp.toLocaleDateString()}
                                    <br/>
                                    {event.timestamp.toLocaleTimeString()}
                                </div>
                            </div>
                            
                            {event.details && (
                                <div style={{ backgroundColor: '#F8FAFC', padding: '12px', borderRadius: '8px', border: '1px solid #E2E8F0', color: '#475569', fontSize: '0.85rem' }}>
                                    {event.type === 'system' ? <code style={{ color: '#D97706' }}>{event.details}</code> : event.details}
                                </div>
                            )}
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
};
