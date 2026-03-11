import React, { useState } from 'react';
import { AlertTriangle, Send, FileMinus, RefreshCcw } from 'lucide-react';

interface DenialItem {
    id: string;
    patientId: string;
    patientName: string;
    dateOfService: string;
    amount: number;
    payer: 'MEDICARE' | 'VA' | 'PRIVATE';
    denialReason: string;
    actionType: 'MISSING_RN_SIGNATURE' | 'INVALID_CPT' | 'NO_AUTHORIZATION';
}

export const DenialTriageQueue: React.FC = () => {
    const [queue, setQueue] = useState<DenialItem[]>([
        { id: 'den_9921', patientId: 'pt_44', patientName: 'Arthur Pendelton', dateOfService: '2026-03-08', amount: 85.50, payer: 'MEDICARE', denialReason: 'Missing Supervising RN Signature on Admission Assessment', actionType: 'MISSING_RN_SIGNATURE' },
        { id: 'den_9922', patientId: 'pt_12', patientName: 'Beatrice Webb', dateOfService: '2026-03-09', amount: 155.00, payer: 'VA', denialReason: 'Authorization Expired Prior to DOS', actionType: 'NO_AUTHORIZATION' }
    ]);
    const [processingId, setProcessingId] = useState<string | null>(null);

    const handleDelegate = (item: DenialItem) => {
        setProcessingId(item.id);
 // an API call wrapping the denial item and pushing it to the target persona's task queue
        setTimeout(() => {
            setQueue(prev => prev.filter(q => q.id !== item.id));
            setProcessingId(null);
        }, 800);
    };

    if (queue.length === 0) {
        return (
            <div style={{ padding: '24px', backgroundColor: '#F8FAFC', borderRadius: '12px', border: '1px dashed #CBD5E1', textAlign: 'center' }}>
                <CheckCircle2 size={32} color="#10B981" style={{ marginBottom: '8px' }} />
                <h4 style={{ margin: 0, color: '#0F172A', fontSize: '1.1rem' }}>Zero Rejected Claims</h4>
                <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>The clearinghouse has no active denials in the triage queue.</p>
            </div>
        );
    }

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '12px', border: '1px solid #E2E8F0', padding: '20px' }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '20px' }}>
                <div style={{ backgroundColor: '#FEF2F2', padding: '8px', borderRadius: '8px' }}>
                    <FileMinus size={20} color="#DC2626" />
                </div>
                <h3 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 800 }}>Clearinghouse Denials Queue</h3>
                <span style={{ backgroundColor: '#EF4444', color: 'white', padding: '2px 8px', borderRadius: '12px', fontSize: '0.75rem', fontWeight: 800 }}>
                    {queue.length} Pending
                </span>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {queue.map(item => (
                    <div key={item.id} style={{ border: '1px solid #E2E8F0', borderRadius: '8px', padding: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <div>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
                                <span style={{ fontSize: '0.8rem', fontWeight: 700, color: '#334155', backgroundColor: '#F1F5F9', padding: '2px 6px', borderRadius: '4px' }}>{item.payer}</span>
                                <span style={{ fontSize: '0.9rem', fontWeight: 800, color: '#0F172A' }}>${item.amount.toFixed(2)}</span>
                                <span style={{ fontSize: '0.85rem', color: '#64748B' }}>• {item.patientName}</span>
                            </div>
                            <div style={{ display: 'flex', alignItems: 'flex-start', gap: '6px', color: '#B45309', fontSize: '0.85rem', backgroundColor: '#FEF3C7', padding: '6px 12px', borderRadius: '6px' }}>
                                <AlertTriangle size={14} style={{ marginTop: '2px' }} />
                                <span><strong>Denial Cause:</strong> {item.denialReason}</span>
                            </div>
                        </div>

                        <button 
                            onClick={() => handleDelegate(item)}
                            disabled={processingId === item.id}
                            style={{ 
                                display: 'flex', alignItems: 'center', gap: '6px', padding: '8px 16px', 
                                backgroundColor: '#4F46E5', color: 'white', border: 'none', borderRadius: '6px', 
                                fontWeight: 600, cursor: processingId === item.id ? 'not-allowed' : 'pointer',
                                opacity: processingId === item.id ? 0.7 : 1
                            }}
                        >
                            {processingId === item.id ? <RefreshCcw size={14} className="spin" /> : <Send size={14} />}
                            {item.actionType === 'MISSING_RN_SIGNATURE' ? 'Route to RN' : 'Route to Auth Team'}
                        </button>
                    </div>
                ))}
            </div>
            <style>{`.spin { animation: spin 1s linear infinite; } @keyframes spin { 100% { transform: rotate(360deg); } }`}</style>
        </div>
    );
};

// Assuming CheckCircle2 wasn't imported from lucide above
const CheckCircle2 = ({ size, color, style }: any) => (
    <svg xmlns="http://www.w3.org/20清除0/svg" width={size} height={size} viewBox="0 0 24 24" fill="none" stroke={color} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={style}>
        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline>
    </svg>
);
