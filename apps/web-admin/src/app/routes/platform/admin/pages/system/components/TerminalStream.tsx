import React, { useState, useEffect, useRef } from 'react';
import { Terminal } from 'lucide-react';

import { apiClient } from '@/shared/utils/apiClient';

export const TerminalStream: React.FC = () => {
    const [lines, setLines] = useState<string[]>([]);
    const [isStreaming, setIsStreaming] = useState(false);
    const scrollRef = useRef<HTMLDivElement>(null);

    // Auto-scroll effect
    useEffect(() => {
        if (scrollRef.current) {
            scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
        }
    }, [lines]);

    const startStream = async () => {
        setLines(['[00:00:00.000] INIT: Fetching system kernel logs...']);
        setIsStreaming(true);

        try {
            const res = await apiClient.get('/v1/system/platform/system-events');
            if (res.ok) {
                const data = await res.json();
                const fetchedLogs = data.map((ev: any) => {
                    const time = new Date(ev.createdAt).toISOString().split('T')[1].replace('Z', '');
                    const tag = ev.operation === 'UPDATE' ? 'SYNC' : ev.operation === 'DELETE' ? 'ERR ' : 'DB  ';
                    return `[${time}] ${tag}: ${ev.modelName} (ID: ${ev.entityId}) action [${ev.operation}] by Actor ${ev.actorUserId || 'KERNEL'}`;
                });
                
                fetchedLogs.push(`[${new Date().toISOString().split('T')[1].replace('Z', '')}] DONE: Cloudflare Worker Execution Complete.`);

                let index = 0;
                const interval = setInterval(() => {
                    if (index < fetchedLogs.length) {
                        setLines(prev => [...prev, fetchedLogs[index]]);
                        index++;
                    } else {
                        clearInterval(interval);
                        setIsStreaming(false);
                    }
                }, 100); 
            } else {
                setLines(prev => [...prev, '[00:00:00.000] ERR : Failed to communicate with worker-api.']);
                setIsStreaming(false);
            }
        } catch (error) {
            setLines(prev => [...prev, `[00:00:00.000] ERR : Fatal Exception in shell stream. ${error}`]);
            setIsStreaming(false);
        }
    };

    return (
        <div style={{ backgroundColor: '#0F172A', borderRadius: '12px', overflow: 'hidden', border: '1px solid #334155', boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.5)', height: '100%', display: 'flex', flexDirection: 'column', minHeight: '400px' }}>
            <div style={{ backgroundColor: '#1E293B', padding: '12px 16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #334155' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', color: '#94A3B8', fontFamily: 'monospace', fontSize: '0.85rem' }}>
                    <Terminal size={16} /> 
                    root@primecare-worker-api:~/system/cron/payroll
                </div>
                <div>
                    <button 
                        onClick={startStream}
                        disabled={isStreaming}
                        style={{ backgroundColor: isStreaming ? '#475569' : '#10B981', color: 'white', border: 'none', padding: '4px 12px', borderRadius: '4px', cursor: isStreaming ? 'not-allowed' : 'pointer', fontSize: '0.75rem', fontWeight: 700 }}
                    >
                        {isStreaming ? 'STREAMING...' : 'EXECUTE SHELL SCRIPT'}
                    </button>
                </div>
            </div>

            <div ref={scrollRef} style={{ padding: '16px', flex: 1, overflowY: 'auto', fontFamily: 'monospace', fontSize: '0.85rem', lineHeight: '1.5' }}>
                {lines.map((line, i) => {
                    let color = '#E2E8F0'; // default slate-200
                    if (line.includes('WRN')) color = '#FDE047'; // yellow-300
                    if (line.includes('ERR')) color = '#F87171'; // red-400
                    if (line.includes('DONE')) color = '#4ADE80'; // green-400
                    if (line.includes('INIT') || line.includes('CONN')) color = '#60A5FA'; // blue-400

                    return (
                        <div key={i} style={{ color, marginBottom: '2px' }}>
                            {line}
                        </div>
                    );
                })}
                {isStreaming && (
                    <div style={{ color: '#E2E8F0', marginTop: '4px', animation: 'blink 1s step-end infinite' }}>
                        _
                        <style>{`
                            @keyframes blink {
                                0%, 100% { opacity: 1; }
                                50% { opacity: 0; }
                            }
                        `}</style>
                    </div>
                )}
            </div>
        </div>
    );
};
