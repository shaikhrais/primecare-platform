import React, { useState, useEffect, useRef } from 'react';
import { Terminal } from 'lucide-react';

const MOCK_LOGS = [
    "[10:45:01.121] INIT: Establishing WSS to worker-api...",
    "[10:45:01.300] CONN: Handshake 200 OK. Authenticated as SUPER_ADMIN_01.",
    "[10:45:01.355] EXEC: Starting routine: PAYROLL_GLOBAL_SETTLEMENT_W41",
    "[10:45:02.012] DB: Locking Timesheet tables [Agency 1 - 50]...",
    "[10:45:02.105] DB: Lock acquired.",
    "[10:45:02.890] CALC: Chunk 1/240 Processing 500 records...",
    "[10:45:03.111] CALC: Chunk 1/240 OK. 500/120000 records resolved.",
    "[10:45:03.115] CALC: Chunk 2/240 Processing 500 records...",
    "[10:45:03.402] WRN : Timecard TS-4921-X has unresolved overtime.",
    "[10:45:03.450] CALC: Chunk 2/240 OK. 1000/120000 records resolved.",
    "[10:45:03.500] CALC: Chunk 3/240 Processing 500 records...",
    "[10:45:03.655] CALC: Chunk 3/240 OK. 1500/120000 records resolved.",
    "[10:45:03.880] INFO: Memory pressure at 42%. Garbage collection triggered.",
    "[10:45:04.010] CALC: Chunk 4/240 Processing 500 records...",
    "[10:45:04.300] CALC: Chunk 4/240 OK. 2000/120000 records resolved.",
    "[10:45:04.550] CALC: Chunk 5/240 Processing 500 records...",
    "[10:45:04.890] CALC: Chunk 5/240 OK. 2500/120000 records resolved.",
    "[10:45:05.100] CALC: Chunk 6/240 Processing 500 records...",
    "[10:45:05.112] ERR : Failed constraint. Retrying chunk 6...",
    "[10:45:05.500] CALC: Chunk 6/240 OK. (Retry 1) 3000/120000 records resolved.",
    "[10:45:05.800] CALC: Fast-forwarding logs...",
    "[10:45:30.000] CALC: Chunk 240/240 OK. 120000/120000 records resolved.",
    "[10:45:30.150] DB: Committing transaction...",
    "[10:45:30.800] SYNC: Pushing remittance commands to Stripe Connect...",
    "[10:45:31.900] SYNC: 121 batches remitted successfully.",
    "[10:45:32.050] DONE: Routine PAYROLL_GLOBAL_SETTLEMENT_W41 Complete in 31.05s."
];

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

    const startStream = () => {
        setLines([]);
        setIsStreaming(true);
        let index = 0;

        const interval = setInterval(() => {
            if (index < MOCK_LOGS.length) {
                setLines(prev => [...prev, MOCK_LOGS[index]]);
                index++;
            } else {
                clearInterval(interval);
                setIsStreaming(false);
            }
        }, 150); // Fast simulation
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
