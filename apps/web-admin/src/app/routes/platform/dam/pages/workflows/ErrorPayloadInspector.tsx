import React, { useState } from 'react';
import { Bug, ArrowLeftRight, Activity, Terminal, ShieldAlert, Cpu } from 'lucide-react';

interface ErrorPayload {
    id: string;
    timestamp: string;
    endpoint: string;
    errorCode: 500 | 502 | 503 | 504;
    message: string;
    stackTrace: string;
    requestBody: string;
    userState: string;
}

export const ErrorPayloadInspector: React.FC = () => {
    const [selectedPayload, setSelectedPayload] = useState<ErrorPayload | null>(null);

    const mockPayloads: ErrorPayload[] = [
        { 
            id: 'err_a1b2', timestamp: '2 mins ago', endpoint: '/api/v1/integrations/twilio', errorCode: 503, 
            message: 'Upstream gateway timeout. Target host failed to respond within 15000ms threshold.',
            stackTrace: 'Error: Timeout generating SMS\n    at TwilioClient.send (node_modules/twilio/lib/client.js:142)\n    at Object.sendVerification (apps/worker-api/src/integrations/SmsService.ts:42)',
            requestBody: '{\n  "to": "+15550198",\n  "body": "[PrimeCare] Your OTP is 1422."\n}',
            userState: 'tenant_id: "tx-492", role: "PUBLIC"'
        },
        { 
            id: 'err_c3d4', timestamp: '1 hour ago', endpoint: '/api/v1/workflows/trigger', errorCode: 500, 
            message: 'Type error: cannot read property "status" of undefined in Visual Logic rule #9',
            stackTrace: 'TypeError: undefined is not an object\n    at WebhookTrafficRouter.executeLogicNode (apps/worker-api/src/dam/workflows/WebhookTrafficRouter.ts:98)',
            requestBody: '{\n  "source": "stripe",\n  "payload": null\n}',
            userState: 'SYSTEM'
        }
    ];

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '10px', borderRadius: '8px' }}>
                        <Bug size={24} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Error Payload Inspector</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Introspect internal state and stack traces of visual workflow failures.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px' }}>
                {/* Error Log Sidebar */}
                <div style={{ width: '320px', display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    <h4 style={{ margin: '0 0 8px 0', fontSize: '0.85rem', color: '#475569', textTransform: 'uppercase' }}>Recent Unhandled Exceptions</h4>
                    
                    {mockPayloads.map(payload => (
                        <div 
                            key={payload.id}
                            data-cy={`error-payload-${payload.id}`}
                            onClick={() => setSelectedPayload(payload)}
                            style={{ 
                                padding: '16px', borderRadius: '8px', cursor: 'pointer',
                                border: `2px solid ${selectedPayload?.id === payload.id ? '#DC2626' : '#E2E8F0'}`,
                                backgroundColor: selectedPayload?.id === payload.id ? '#FEF2F2' : 'white',
                                transition: 'all 0.2s ease'
                            }}
                        >
                            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: '8px' }}>
                                <span style={{ backgroundColor: '#DC2626', color: 'white', fontWeight: 800, padding: '2px 6px', borderRadius: '4px', fontSize: '0.75rem' }}>HTTP {payload.errorCode}</span>
                                <span style={{ fontSize: '0.75rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px' }}><Activity size={12}/> {payload.timestamp}</span>
                            </div>
                            <div style={{ fontFamily: 'monospace', fontSize: '0.85rem', color: '#0F172A', fontWeight: 700, wordBreak: 'break-all' }}>{payload.endpoint}</div>
                            <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '6px', display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                                {payload.message}
                            </div>
                        </div>
                    ))}
                </div>

                {/* Inspector Canvas */}
                <div style={{ flex: 1, backgroundColor: '#0F172A', borderRadius: '8px', overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
                    {selectedPayload ? (
                        <>
                            <div style={{ backgroundColor: '#1E293B', padding: '16px', borderBottom: '1px solid #334155', display: 'flex', alignItems: 'center', gap: '12px', color: 'white' }}>
                                <Terminal size={20} color="#94A3B8" />
                                <span style={{ fontWeight: 700, fontSize: '0.95rem' }}>Introspection Context: {selectedPayload.id}</span>
                            </div>
                            
                            <div style={{ padding: '20px', overflowY: 'auto', display: 'flex', flexDirection: 'column', gap: '20px' }}>
                                
                                <div>
                                    <div style={{ color: '#94A3B8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: '8px', display: 'flex', gap: '6px' }}><ShieldAlert size={14} color="#EF4444" /> SYSTEM CRASH REASON</div>
                                    <div style={{ backgroundColor: 'rgba(239, 68, 68, 0.1)', border: '1px solid #7F1D1D', padding: '12px', borderRadius: '6px', color: '#FCA5A5', fontFamily: 'monospace', fontSize: '0.85rem' }}>
                                        {selectedPayload.message}
                                    </div>
                                </div>

                                <div style={{ display: 'flex', gap: '20px' }}>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ color: '#94A3B8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: '8px', display: 'flex', gap: '6px' }}><ArrowLeftRight size={14} color="#3B82F6" /> RAW INBOUND REQUEST</div>
                                        <pre style={{ margin: 0, backgroundColor: '#020617', padding: '12px', borderRadius: '6px', color: '#93C5FD', fontSize: '0.85rem', overflowX: 'auto', border: '1px solid #1E293B' }}>
                                            {selectedPayload.requestBody}
                                        </pre>
                                    </div>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ color: '#94A3B8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: '8px', display: 'flex', gap: '6px' }}><Cpu size={14} color="#8B5CF6" /> V8 STACK TRACE</div>
                                        <pre style={{ margin: 0, backgroundColor: '#020617', padding: '12px', borderRadius: '6px', color: '#C4B5FD', fontSize: '0.85rem', overflowX: 'auto', border: '1px solid #1E293B', whiteSpace: 'pre-wrap' }}>
                                            {selectedPayload.stackTrace}
                                        </pre>
                                    </div>
                                </div>

                                <div>
                                    <div style={{ color: '#94A3B8', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: '8px' }}>USER CONTEXT STATE</div>
                                    <div style={{ backgroundColor: '#020617', padding: '12px', borderRadius: '6px', color: '#E2E8F0', fontFamily: 'monospace', fontSize: '0.85rem', border: '1px solid #1E293B' }}>
                                        {selectedPayload.userState}
                                    </div>
                                </div>

                            </div>
                        </>
                    ) : (
                        <div style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', color: '#475569' }}>
                            <Bug size={48} color="#334155" style={{ marginBottom: '16px' }} />
                            <p>Select a 500-level error payload from the sidebar down to introspect the V8 stack trace.</p>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
};
