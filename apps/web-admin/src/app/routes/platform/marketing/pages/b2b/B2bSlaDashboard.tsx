import React, { useState } from 'react';
import { Timer, AlertOctagon, TrendingDown, CheckSquare, Clock } from 'lucide-react';

interface SlaRecord {
    id: string;
    hospitalName: string;
    caseManager: string;
    patientInitials: string;
    timeReceived: Date;
    timeAcknowledged: Date | null;
    slaStatus: 'MET' | 'BREACHED' | 'PENDING';
}

export const B2bSlaDashboard: React.FC = () => {
    // 30 Minute SLA SLA Rules
    const SLA_LIMIT_MINUTES = 30;
    
    const [referrals, setReferrals] = useState<SlaRecord[]>([
        { id: 'ref_A', hospitalName: 'St. Jude Regional', caseManager: 'Sarah Jenkins', patientInitials: 'M.S.', timeReceived: new Date(Date.now() - 45 * 60000), timeAcknowledged: new Date(Date.now() - 32 * 60000), slaStatus: 'MET' }, // 13 mins
        { id: 'ref_B', hospitalName: 'Downtown Rehab', caseManager: 'Dr. Emily Chen', patientInitials: 'R.W.', timeReceived: new Date(Date.now() - 120 * 60000), timeAcknowledged: new Date(Date.now() - 10 * 60000), slaStatus: 'BREACHED' }, // 110 mins
        { id: 'ref_C', hospitalName: 'General Hospital', caseManager: 'Marcus Cole', patientInitials: 'J.L.', timeReceived: new Date(Date.now() - 15 * 60000), timeAcknowledged: null, slaStatus: 'PENDING' }
    ]);

    const getElapsedMinutes = (start: Date, end: Date | null) => {
        const endTime = end || new Date();
        return Math.floor((endTime.getTime() - start.getTime()) / 60000);
    };

    const handleAcknowledge = (id: string) => {
        setReferrals(referrals.map(r => {
            if (r.id === id) {
                const elapsed = getElapsedMinutes(r.timeReceived, new Date());
                return { ...r, timeAcknowledged: new Date(), slaStatus: elapsed > SLA_LIMIT_MINUTES ? 'BREACHED' : 'MET' };
            }
            return r;
        }));
    };

    const totalReferrals = referrals.length;
    const breachedSlas = referrals.filter(r => r.slaStatus === 'BREACHED').length;
    const complianceRate = (((totalReferrals - breachedSlas) / totalReferrals) * 100).toFixed(1);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px' }}>
                        <Timer size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>B2B Service Level Agreement (SLA) Tracker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Enforcing the 30-minute Referral Response Guarantee for Hospital Partners.</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '16px' }}>
                     <div style={{ padding: '8px 16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', textAlign: 'right' }}>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Current Compliance</div>
                        <div style={{ fontSize: '1.4rem', fontWeight: 900, color: Number(complianceRate) > 95 ? '#10B981' : '#F59E0B' }}>{complianceRate}%</div>
                    </div>
                </div>
            </div>

            <table style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Referring Partner</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Intake Arrival</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Action Taken</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>SLA Status ({SLA_LIMIT_MINUTES}m)</th>
                    </tr>
                </thead>
                <tbody>
                    {referrals.map(ref => {
                        const elapsedMins = getElapsedMinutes(ref.timeReceived, ref.timeAcknowledged);
                        const isNearingBreach = ref.slaStatus === 'PENDING' && elapsedMins > (SLA_LIMIT_MINUTES - 10);
                        
                        return (
                             <tr key={ref.id} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isNearingBreach ? '#FFFBEB' : 'transparent' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                    <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.05rem' }}>{ref.hospitalName}</div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px', marginTop: '4px' }}>
                                         Patient: {ref.patientInitials} • CM: {ref.caseManager}
                                    </div>
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                    <div style={{ color: '#334155', display: 'flex', alignItems: 'center', gap: '6px' }}><Clock size={16}/> {ref.timeReceived.toLocaleTimeString()}</div>
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                    {ref.slaStatus === 'PENDING' ? (
                                        <button 
                                            onClick={() => handleAcknowledge(ref.id)}
                                            style={{ backgroundColor: '#0369A1', color: 'white', border: 'none', borderRadius: '6px', padding: '8px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}
                                        >
                                            <CheckSquare size={16} /> Mark Acknowledged
                                        </button>
                                    ) : (
                                        <span style={{ color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                            <TrendingDown size={14}/> Handled at {ref.timeAcknowledged?.toLocaleTimeString()}
                                        </span>
                                    )}
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                        <div style={{ fontWeight: 900, fontSize: '1.2rem', color: ref.slaStatus === 'BREACHED' || isNearingBreach ? '#DC2626' : (ref.slaStatus === 'MET' ? '#10B981' : '#0F172A') }}>
                                            {elapsedMins} mins
                                        </div>
                                        {ref.slaStatus === 'BREACHED' && (
                                            <span style={{ backgroundColor: '#FEF2F2', border: '1px solid #FECACA', color: '#DC2626', padding: '2px 8px', borderRadius: '4px', fontSize: '0.75rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}>
                                                <AlertOctagon size={12} /> SLA BREACH
                                            </span>
                                        )}
                                        {ref.slaStatus === 'MET' && (
                                            <span style={{ color: '#10B981', fontSize: '0.75rem', fontWeight: 800 }}>COMPLIANT</span>
                                        )}
                                        {isNearingBreach && (
                                            <span style={{ color: '#D97706', fontSize: '0.75rem', fontWeight: 800 }} className="animate-pulse">URGENT</span>
                                        )}
                                    </div>
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};
