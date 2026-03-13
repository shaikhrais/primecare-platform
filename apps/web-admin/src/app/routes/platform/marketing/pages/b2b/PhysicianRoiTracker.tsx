import React, { useState } from 'react';
import { Stethoscope, DollarSign, TrendingUp, Gift, Activity, ArrowUpRight } from 'lucide-react';

interface PhysicianRoi {
    npi: string;
    name: string;
    clinicName: string;
    totalReferrals: number;
    activePatients: number;
    lifetimeRevenue: number;
    yoyGrowth: number;
    lastGiftDate: string | null;
}

export const PhysicianRoiTracker: React.FC = () => {
    const [physicians] = useState<PhysicianRoi[]>([
        { npi: '988123', name: 'Dr. Emily Chen', clinicName: 'Downtown Cardiology', totalReferrals: 42, activePatients: 18, lifetimeRevenue: 450000, yoyGrowth: 24, lastGiftDate: '2023-11-15' },
        { npi: '445910', name: 'Dr. Marcus Cole', clinicName: 'Westside Geriatrics', totalReferrals: 115, activePatients: 64, lifetimeRevenue: 1250000, yoyGrowth: 45, lastGiftDate: '2023-10-01' },
        { npi: '772184', name: 'Dr. Sarah Jenkins', clinicName: 'Valley View Neurology', totalReferrals: 8, activePatients: 2, lifetimeRevenue: 45000, yoyGrowth: -12, lastGiftDate: null }
    ]);

    const sortedPhysicians = [...physicians].sort((a, b) => b.lifetimeRevenue - a.lifetimeRevenue);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#F0FDF4', padding: '12px', borderRadius: '8px' }}>
                        <Stethoscope size={28} color="#16A34A" />
                    </div>
                    <div>
                        <h3 data-cy="h3-physician-roi-tracker-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Physician Referral ROI Ledger</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Correlate referring doctors to exact lifetime revenue to identify high-value "Whale" accounts.</p>
                    </div>
                </div>
            </div>

            <table data-cy="table-physician-roi-tracker" style={{ width: '100%', borderCollapse: 'collapse', fontSize: '0.9rem' }}>
                <thead>
                    <tr style={{ backgroundColor: '#F8FAFC', borderBottom: '2px solid #E2E8F0', textAlign: 'left' }}>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700 }}>Referring Physician</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Referral Funnel</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'right' }}>Generated Revenue</th>
                        <th style={{ padding: '12px', color: '#64748B', fontWeight: 700, textAlign: 'center' }}>Relationship Mgmt</th>
                    </tr>
                </thead>
                <tbody>
                    {sortedPhysicians.map((doc, index) => {
                        const isWhale = doc.lifetimeRevenue > 1000000;
                        const needsGifting = isWhale && doc.yoyGrowth > 0;

                        return (
                            <tr key={doc.npi} style={{ borderBottom: '1px solid #E2E8F0', backgroundColor: isWhale ? '#F8FAFC' : 'transparent' }}>
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.05rem' }}>{doc.name}</div>
                                        {isWhale && <span style={{ backgroundColor: '#DBEAFE', color: '#1D4ED8', padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800 }}>⭐ TIER 1 WHALE</span>}
                                    </div>
                                    <div style={{ fontSize: '0.8rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '6px', marginTop: '4px' }}>
                                        NPI: {doc.npi} • {doc.clinicName}
                                    </div>
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    <div style={{ display: 'flex', justifyContent: 'center', gap: '16px' }}>
                                        <div style={{ textAlign: 'center' }}>
                                            <div style={{ fontSize: '1.2rem', fontWeight: 800, color: '#334155' }}>{doc.totalReferrals}</div>
                                            <div style={{ fontSize: '0.75rem', color: '#94A3B8', textTransform: 'uppercase' }}>Sent</div>
                                        </div>
                                        <div style={{ width: '1px', backgroundColor: '#E2E8F0' }}></div>
                                        <div style={{ textAlign: 'center' }}>
                                            <div style={{ fontSize: '1.2rem', fontWeight: 800, color: '#10B981' }}>{doc.activePatients}</div>
                                            <div style={{ fontSize: '0.75rem', color: '#94A3B8', textTransform: 'uppercase' }}>Active</div>
                                        </div>
                                    </div>
                                </td>
                                
                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'right' }}>
                                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '4px' }}>
                                        <div style={{ fontWeight: 900, fontSize: '1.3rem', color: '#0F172A', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                            <DollarSign size={18} />{(doc.lifetimeRevenue / 1000).toFixed(0)}k
                                        </div>
                                        <div style={{ fontSize: '0.85rem', color: doc.yoyGrowth >= 0 ? '#10B981' : '#DC2626', display: 'flex', alignItems: 'center', gap: '4px', fontWeight: 700 }}>
                                            <Activity size={14} /> {doc.yoyGrowth > 0 ? '+' : ''}{doc.yoyGrowth}% YoY
                                        </div>
                                    </div>
                                </td>

                                <td style={{ padding: '16px 12px', verticalAlign: 'middle', textAlign: 'center' }}>
                                    {needsGifting ? (
                                        <button data-cy="btn-physician-roi-tracker-0" style={{ backgroundColor: '#F59E0B', color: 'white', border: 'none', borderRadius: '6px', padding: '8px 16px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px', justifyContent: 'center', margin: '0 auto', boxShadow: '0 2px 4px rgba(245, 158, 11, 0.2)' }}>
                                            <Gift size={16} /> Send Golf Promo
                                        </button>
                                    ) : (
                                        <div style={{ color: '#64748B', fontSize: '0.8rem', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
                                            {doc.lastGiftDate ? `Gifted: ${new Date(doc.lastGiftDate).toLocaleDateString()}` : 'No Action Needed'}
                                        </div>
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
