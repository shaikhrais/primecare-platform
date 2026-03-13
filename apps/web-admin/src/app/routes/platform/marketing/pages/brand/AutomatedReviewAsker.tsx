import React, { useState } from 'react';
import { Star, MessageSquarePlus, Smartphone, Send, Clock, CheckCircle2 } from 'lucide-react';

interface ReviewCampaign {
    id: string;
    patientName: string;
    daysActive: number;
    status: 'ELIGIBLE' | 'SMS_SENT' | 'REVIEW_RECEIVED';
    sentDate: string | null;
}

export const AutomatedReviewAsker: React.FC = () => {
    const [campaigns, setCampaigns] = useState<ReviewCampaign[]>([
        { id: 'cam_1', patientName: 'Martha Stewart', daysActive: 31, status: 'ELIGIBLE', sentDate: null },
        { id: 'cam_2', patientName: 'James Wilson', daysActive: 45, status: 'SMS_SENT', sentDate: '2023-10-15' },
        { id: 'cam_3', patientName: 'Dawson Estate', daysActive: 12, status: 'ELIGIBLE', sentDate: null }, // Not 30 days yet, but for demo we can trigger
        { id: 'cam_4', patientName: 'Harrison Family', daysActive: 88, status: 'REVIEW_RECEIVED', sentDate: '2023-08-01' }
    ]);

    const handleSendSms = (id: string, e: React.MouseEvent) => {
        e.stopPropagation();
        setCampaigns(campaigns.map(c => 
            c.id === id ? { ...c, status: 'SMS_SENT', sentDate: new Date().toISOString() } : c
        ));
    };

    const eligibleCount = campaigns.filter(c => c.status === 'ELIGIBLE' && c.daysActive >= 30).length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF9C3', padding: '12px', borderRadius: '8px' }}>
                        <Star size={28} color="#CA8A04" />
                    </div>
                    <div>
                        <h3 data-cy="h3-automated-review-asker-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Automated Review Solicitation</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Text families a direct Google Business link automatically on their 30th day of service.</p>
                    </div>
                </div>

                {eligibleCount > 0 && (
                    <button data-cy="btn-automated-review-asker-0" style={{ backgroundColor: '#10B981', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.85rem' }}>
                        <Send size={16} /> Bulk Send {eligibleCount} SMS Invites
                    </button>
                )}
            </div>

            <table data-cy="table-automated-review-asker" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Family / Account</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Trigger Condition</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Campaign Status</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Action</th>
                    </tr>
                </thead>
                <tbody>
                    {campaigns.map(camp => {
                        const isReady = camp.daysActive >= 30 && camp.status === 'ELIGIBLE';

                        return (
                            <tr key={camp.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', fontWeight: 800, color: '#0F172A', fontSize: '1.05rem' }}>
                                    {camp.patientName}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    <span style={{ color: camp.daysActive >= 30 ? '#10B981' : '#64748B', fontWeight: 700, display: 'flex', alignItems: 'center', gap: '6px', justifyContent: 'center' }}>
                                        <Clock size={16}/> Day {camp.daysActive} / 30
                                    </span>
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    {camp.status === 'ELIGIBLE' && <span style={{ backgroundColor: isReady ? '#FEF9C3' : '#F1F5F9', color: isReady ? '#CA8A04' : '#64748B', padding: '4px 12px', borderRadius: '16px', fontWeight: 800, fontSize: '0.8rem' }}>{isReady ? 'QUEUED FOR SEND' : 'WAITING'}</span>}
                                    {camp.status === 'SMS_SENT' && <span style={{ backgroundColor: '#EFF6FF', color: '#2563EB', padding: '4px 12px', borderRadius: '16px', fontWeight: 800, fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', justifyContent: 'center' }}><Smartphone size={14}/> SMS SENT</span>}
                                    {camp.status === 'REVIEW_RECEIVED' && <span style={{ backgroundColor: '#DCFCE7', color: '#16A34A', padding: '4px 12px', borderRadius: '16px', fontWeight: 800, fontSize: '0.8rem', display: 'flex', alignItems: 'center', gap: '4px', justifyContent: 'center' }}><CheckCircle2 size={14}/> REVIEWED</span>}
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                    {camp.status === 'ELIGIBLE' && (
                                        <button data-cy="btn-automated-review-asker-1" 
                                            onClick={(e) => handleSendSms(camp.id, e)}
                                            style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '6px', padding: '6px 12px', fontWeight: 700, cursor: 'pointer', display: 'inline-flex', alignItems: 'center', gap: '6px', fontSize: '0.85rem' }}
                                        >
                                            <MessageSquarePlus size={14} /> Send Manual Text
                                        </button>
                                    )}
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};
