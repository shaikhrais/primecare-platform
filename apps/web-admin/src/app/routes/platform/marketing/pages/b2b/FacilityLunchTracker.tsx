import React, { useState } from 'react';
import { Coffee, DollarSign, TrendingUp, Users, AlertTriangle } from 'lucide-react';

interface LunchExpense {
    id: string;
    date: string;
    facilityName: string;
    repName: string;
    cost: number;
    attendees: number;
    referralsPast30Days: number;
}

export const FacilityLunchTracker: React.FC = () => {
    const [expenses] = useState<LunchExpense[]>([
        { id: '1', date: '2023-11-12', facilityName: 'St. Jude Discharge Dept', repName: 'Sarah Jenkins', cost: 450.00, attendees: 12, referralsPast30Days: 8 },
        { id: '2', date: '2023-11-15', facilityName: 'Valley View Neurology', repName: 'Marcus Cole', cost: 120.00, attendees: 4, referralsPast30Days: 0 },
        { id: '3', date: '2023-11-20', facilityName: 'Downtown Cardiology', repName: 'Elena Rostova', cost: 320.00, attendees: 8, referralsPast30Days: 4 }
    ]);

    const totalSpent = expenses.reduce((sum, e) => sum + e.cost, 0);

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
             <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '24px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FFF7ED', padding: '12px', borderRadius: '8px' }}>
                        <Coffee size={28} color="#EA580C" />
                    </div>
                    <div>
                        <h3 data-cy="h3-facility-lunch-tracker-0" style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>B2B Facility Lunch & Learn Tracker</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Track catering expenses against actual hospital referral volume to calculate ROI.</p>
                    </div>
                </div>

                <div style={{ padding: '12px 24px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', textAlign: 'right' }}>
                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>MTD Catering Spend</div>
                    <div style={{ fontSize: '1.6rem', fontWeight: 900, color: '#0F172A', display: 'flex', alignItems: 'center', justifyContent: 'flex-end' }}>
                        <DollarSign size={20} />{totalSpent.toFixed(2)}
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {expenses.map(exp => {
                    const costPerLead = exp.referralsPast30Days > 0 ? (exp.cost / exp.referralsPast30Days) : 0;
                    const isWaste = exp.referralsPast30Days === 0;

                    return (
                        <div key={exp.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '20px', border: '1px solid #E2E8F0', borderRadius: '12px', backgroundColor: isWaste ? '#FEF2F2' : 'white' }}>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', fontWeight: 700, marginBottom: '4px' }}>{new Date(exp.date).toLocaleDateString()}</div>
                                <div style={{ fontWeight: 800, color: '#0F172A', fontSize: '1.1rem' }}>{exp.facilityName}</div>
                                <div style={{ fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '6px', marginTop: '6px' }}>
                                    <Users size={14} /> Rep: {exp.repName} • {exp.attendees} Attendees
                                </div>
                            </div>

                            <div style={{ width: '150px', textAlign: 'right', paddingRight: '24px', borderRight: '1px solid #E2E8F0' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', textTransform: 'uppercase', fontWeight: 700 }}>Meal Cost</div>
                                <div style={{ fontSize: '1.2rem', fontWeight: 900, color: '#0F172A' }}>${exp.cost.toFixed(2)}</div>
                            </div>

                            <div style={{ width: '150px', paddingLeft: '24px', paddingRight: '24px', borderRight: '1px solid #E2E8F0', textAlign: 'center' }}>
                                <div style={{ fontSize: '0.8rem', color: '#64748B', textTransform: 'uppercase', fontWeight: 700 }}>Recent Referrals</div>
                                <div style={{ fontSize: '1.2rem', fontWeight: 900, color: isWaste ? '#DC2626' : '#10B981' }}>{exp.referralsPast30Days}</div>
                            </div>

                            <div style={{ width: '180px', paddingLeft: '24px' }}>
                                {isWaste ? (
                                    <span style={{ backgroundColor: '#FECACA', color: '#B91C1C', padding: '6px 12px', borderRadius: '6px', fontSize: '0.8rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '6px' }}>
                                        <AlertTriangle size={14} /> ZERO ROI
                                    </span>
                                ) : (
                                    <div>
                                        <div style={{ fontSize: '0.8rem', color: '#64748B', textTransform: 'uppercase', fontWeight: 700 }}>Lunch Cost Per Lead</div>
                                        <div style={{ fontSize: '1.1rem', fontWeight: 800, color: costPerLead > 100 ? '#F59E0B' : '#0F172A' }}>
                                            ${costPerLead.toFixed(2)}
                                        </div>
                                    </div>
                                )}
                            </div>
                        </div>
                    );
                })}
            </div>
            
            <div style={{ marginTop: '24px', backgroundColor: '#F8FAFC', padding: '16px', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Objective:</strong> Track the notoriously loose B2B "Lunch and Learn" expense budget. If a Regional Rep buys $120 worth of Panera Bread for a clinic but they send zero referrals over 30 days, the ledger explicitly flags the event as "ZERO ROI", preventing future waste.
            </div>
        </div>
    );
};
