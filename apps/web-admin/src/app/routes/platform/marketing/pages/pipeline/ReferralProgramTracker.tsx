import React, { useState } from 'react';
import { Gift, Users, ArrowRight, CheckCircle2, DollarSign, KeySquare } from 'lucide-react';

interface ReferralRegistration {
    id: string;
    referrerName: string;
    referredFamilyName: string;
    status: 'LEAD_STAGE' | 'ASSESSMENT_BOOKED' | 'CONTRACT_SIGNED' | 'PAYOUT_ELIGIBLE' | 'REWARD_CLAIMED';
    daysActive: number;
}

export const ReferralProgramTracker: React.FC = () => {
    const [referrals, setReferrals] = useState<ReferralRegistration[]>([
        { id: 'ref_101', referrerName: 'Martha Stewart (Client)', referredFamilyName: 'Jameson Family', status: 'REWARD_CLAIMED', daysActive: 45 },
        { id: 'ref_102', referrerName: 'Sarah Jenkins (Employee)', referredFamilyName: 'Chen Elder Care', status: 'CONTRACT_SIGNED', daysActive: 12 },
        { id: 'ref_103', referrerName: 'Robert Wilson (Client)', referredFamilyName: 'Dawson Group', status: 'LEAD_STAGE', daysActive: 2 },
        { id: 'ref_104', referrerName: 'Dr. Emily Chen (B2B)', referredFamilyName: 'Harrison Estate', status: 'PAYOUT_ELIGIBLE', daysActive: 31 }
    ]);

    const handleIssueCredit = (id: string) => {
        setReferrals(referrals.map(r => r.id === id ? { ...r, status: 'REWARD_CLAIMED' } : r));
    };

    const getStatusStyle = (status: string) => {
        switch (status) {
            case 'REWARD_CLAIMED': return { bg: '#F0FDF4', color: '#16A34A', border: '#BBF7D0', label: 'Reward Claimed' };
            case 'PAYOUT_ELIGIBLE': return { bg: '#FEF2F2', color: '#DC2626', border: '#FECACA', label: 'Immediate Action: Issue Credit' };
            case 'CONTRACT_SIGNED': return { bg: '#FFF7ED', color: '#EA580C', border: '#FFEDD5', label: 'Contract Signed (Holding 30 Days)' };
            case 'ASSESSMENT_BOOKED': return { bg: '#F8FAFC', color: '#64748B', border: '#E2E8F0', label: 'Clinical Assessment' };
            case 'LEAD_STAGE': return { bg: '#F8FAFC', color: '#94A3B8', border: '#E2E8F0', label: 'Validating Lead' };
            default: return { bg: 'white', color: 'black', border: 'black', label: status };
        }
    };

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '32px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FDF4FF', padding: '12px', borderRadius: '12px' }}>
                        <Gift size={28} color="#C026D3" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Organic Referral Program Tracker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.95rem' }}>Track "Refer-a-Friend" lead progression and issue $500 Statement Credits upon maturity.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', alignItems: 'flex-end' }}>
                    <div style={{ backgroundColor: '#F8FAFC', padding: '8px 16px', borderRadius: '8px', border: '1px solid #E2E8F0', display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 700, color: '#334155', fontSize: '0.85rem' }}>
                        <KeySquare size={16} color="#64748B" /> Rule: Referred client must remain active for 30 days.
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {referrals.map(ref => {
                    const style = getStatusStyle(ref.status);
                    const isEligible = ref.status === 'PAYOUT_ELIGIBLE';

                    return (
                        <div key={ref.id} style={{ border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', display: 'flex', alignItems: 'center', gap: '24px', backgroundColor: isEligible ? '#FFF1F2' : 'white', boxShadow: isEligible ? '0 4px 12px rgba(225, 29, 72, 0.1)' : 'none', transition: 'all 0.2s' }}>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>Advocate (Referrer)</div>
                                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                    <Users size={16} color="#6366F1" /> {ref.referrerName}
                                </div>
                            </div>

                            <ArrowRight size={20} color="#CBD5E1" />

                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase', marginBottom: '4px' }}>New Family (Referred)</div>
                                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem' }}>
                                    {ref.referredFamilyName}
                                </div>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', marginTop: '4px' }}>Active since {ref.daysActive} days ago</div>
                            </div>

                            <div style={{ width: '250px' }}>
                                <div style={{ 
                                    backgroundColor: style.bg, 
                                    color: style.color, 
                                    border: `1px solid ${style.border}`, 
                                    padding: '8px 12px', 
                                    borderRadius: '8px', 
                                    fontWeight: 700, 
                                    fontSize: '0.85rem',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '6px',
                                    justifyContent: 'center'
                                }}>
                                    {ref.status === 'REWARD_CLAIMED' && <CheckCircle2 size={16} />}
                                    {style.label}
                                </div>
                            </div>

                            {/* Payout Action button */}
                            <div style={{ width: '180px', display: 'flex', justifyContent: 'flex-end' }}>
                                {isEligible ? (
                                    <button 
                                        onClick={() => handleIssueCredit(ref.id)}
                                        style={{ backgroundColor: '#E11D48', color: 'white', border: 'none', borderRadius: '8px', padding: '10px 16px', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.9rem', width: '100%', justifyContent: 'center', boxShadow: '0 2px 4px rgba(225, 29, 72, 0.2)' }}
                                    >
                                        <DollarSign size={16} /> Issue $500 Credit
                                    </button>
                                ) : (
                                    <button disabled style={{ backgroundColor: '#F1F5F9', color: '#94A3B8', border: '1px solid #E2E8F0', borderRadius: '8px', padding: '10px 16px', fontWeight: 700, cursor: 'not-allowed', width: '100%', fontSize: '0.9rem' }}>
                                        {ref.status === 'REWARD_CLAIMED' ? 'Paid Out' : 'Locked'}
                                    </button>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
        </div>
    );
};
