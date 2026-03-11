import React, { useState } from 'react';
import { Presentation, TrendingDown, Users, Target, ShieldCheck } from 'lucide-react';

interface HospitalStats {
    id: string;
    hospitalName: string;
    patientsAccepted: number;
    thirtyDayReadmits: number;
}

export const PostDischargeSuccess: React.FC = () => {
    const STATE_MEDIAN_READMISSION_RATE = 15.2; // 15.2% of seniors bounce back to hospital in 30 days usually

    const [stats] = useState<HospitalStats[]>([
        { id: '1', hospitalName: 'Downtown Cardiology (Congestive Heart Failure)', patientsAccepted: 142, thirtyDayReadmits: 8 },
        { id: '2', hospitalName: 'St. Jude Joint Replacement (Ortho)', patientsAccepted: 88, thirtyDayReadmits: 2 },
        { id: '3', hospitalName: 'Valley View Stroke Center (Neurology)', patientsAccepted: 45, thirtyDayReadmits: 3 }
    ]);

    const totalPatients = stats.reduce((sum, s) => sum + s.patientsAccepted, 0);
    const totalReadmits = stats.reduce((sum, s) => sum + s.thirtyDayReadmits, 0);
    const primecareOverallRate = totalPatients > 0 ? ((totalReadmits / totalPatients) * 100) : 0;
    
    // Penalties avoided based on Medicare Readmission Reduction Program (HRRP)
    const estimatedFinesAvoided = (totalPatients * (STATE_MEDIAN_READMISSION_RATE - primecareOverallRate) / 100) * 12500; 

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '32px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F5F3FF', padding: '12px', borderRadius: '12px' }}>
                        <Presentation size={32} color="#7C3AED" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.6rem', color: '#0F172A', fontWeight: 900 }}>B2B Executive Pitch Deck: Post-Discharge Clinical Success</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.95rem' }}>A presentation-ready view proving PrimeCare reduces hospital Medicare fines via world-class home care.</p>
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '24px', marginBottom: '32px' }}>
                <div style={{ flex: 1, backgroundColor: '#F8FAFC', padding: '24px', borderRadius: '12px', border: '1px solid #E2E8F0', display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center' }}>
                    <div style={{ backgroundColor: '#F1F5F9', padding: '12px', borderRadius: '50%', marginBottom: '16px' }}><Users size={24} color="#64748B" /></div>
                    <div style={{ fontSize: '0.85rem', color: '#475569', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px' }}>Total Discharges Managed</div>
                    <div style={{ fontSize: '2.5rem', fontWeight: 900, color: '#0F172A' }}>{totalPatients}</div>
                    <div style={{ fontSize: '0.8rem', color: '#64748B' }}>YTD 2023</div>
                </div>

                <div style={{ flex: 1, backgroundColor: '#FEF2F2', padding: '24px', borderRadius: '12px', border: '1px solid #FECACA', display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center' }}>
                    <div style={{ backgroundColor: '#FEE2E2', padding: '12px', borderRadius: '50%', marginBottom: '16px' }}><Target size={24} color="#DC2626" /></div>
                    <div style={{ fontSize: '0.85rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '1px' }}>State Median Readmission</div>
                    <div style={{ fontSize: '2.5rem', fontWeight: 900, color: '#DC2626' }}>{STATE_MEDIAN_READMISSION_RATE}%</div>
                    <div style={{ fontSize: '0.8rem', color: '#B91C1C' }}>Average Hospital</div>
                </div>

                <div style={{ flex: 1, backgroundColor: '#F0FDF4', padding: '24px', borderRadius: '12px', border: '2px solid #22C55E', display: 'flex', flexDirection: 'column', alignItems: 'center', textAlign: 'center', boxShadow: '0 10px 15px -3px rgba(34, 197, 94, 0.1)' }}>
                    <div style={{ backgroundColor: '#DCFCE7', padding: '12px', borderRadius: '50%', marginBottom: '16px' }}><TrendingDown size={24} color="#16A34A" /></div>
                    <div style={{ fontSize: '0.85rem', color: '#166534', fontWeight: 800, textTransform: 'uppercase', letterSpacing: '1px' }}>PrimeCare Readmission Rate</div>
                    <div style={{ fontSize: '3rem', fontWeight: 900, color: '#15803D' }}>{primecareOverallRate.toFixed(1)}%</div>
                    <div style={{ fontSize: '0.85rem', color: '#16A34A', fontWeight: 700 }}>Outperforming State by {(STATE_MEDIAN_READMISSION_RATE - primecareOverallRate).toFixed(1)}%</div>
                </div>
            </div>

            <div style={{ backgroundColor: '#EFF6FF', border: '1px solid #BFDBFE', borderRadius: '12px', padding: '32px', textAlign: 'center' }}>
                <ShieldCheck size={48} color="#2563EB" style={{ margin: '0 auto 16px auto' }} />
                <h4 style={{ margin: '0 0 8px 0', fontSize: '1.4rem', color: '#1E3A8A', fontWeight: 800 }}>Medicare Fines Avoided for Hospital Partners</h4>
                <p style={{ margin: '0 0 16px 0', color: '#3B82F6', fontSize: '1.1rem' }}>By trusting PrimeCare with your post-discharge patients, our dedicated 24/7 nursing team has prevented costly bounce-backs, simulating an estimated savings of:</p>
                <div style={{ fontSize: '3.5rem', fontWeight: 900, color: '#1D4ED8', textShadow: '0 2px 4px rgba(0,0,0,0.1)' }}>
                    ${(estimatedFinesAvoided).toLocaleString(undefined, { maximumFractionDigits: 0 })}
                </div>
            </div>
            
             <table style={{ width: '100%', marginTop: '32px', borderCollapse: 'collapse' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Partner / Specialty Cohort</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>N Evaluated</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Readmissions</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Cohort Rate</th>
                    </tr>
                </thead>
                <tbody>
                    {stats.map(s => {
                        const rate = ((s.thirtyDayReadmits / s.patientsAccepted) * 100);
                        return (
                            <tr key={s.id} style={{ borderBottom: '1px solid #E2E8F0' }}>
                                <td style={{ padding: '16px 12px', fontWeight: 700, color: '#334155' }}>{s.hospitalName}</td>
                                <td style={{ padding: '16px 12px', textAlign: 'center', fontWeight: 800 }}>{s.patientsAccepted}</td>
                                <td style={{ padding: '16px 12px', textAlign: 'center', color: '#DC2626', fontWeight: 800 }}>{s.thirtyDayReadmits}</td>
                                <td style={{ padding: '16px 12px', textAlign: 'center' }}>
                                    <span style={{ backgroundColor: rate < 5 ? '#DCFCE7' : '#FEF2F2', color: rate < 5 ? '#16A34A' : '#DC2626', padding: '4px 12px', borderRadius: '16px', fontWeight: 800, fontSize: '0.9rem' }}>
                                        {rate.toFixed(1)}%
                                    </span>
                                </td>
                            </tr>
                        );
                    })}
                </tbody>
            </table>
        </div>
    );
};
