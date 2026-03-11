import React, { useState } from 'react';
import { LineChart, AlertTriangle, ArrowDownRight, PhoneCall, History, TrendingDown } from 'lucide-react';

interface ChurnRiskPatient {
    id: string;
    name: string;
    contractStartDate: string;
    historicalWeeklyAvgHours: number;
    currentWeeklyHours: number;
    hoursDropPercentage: number;
    riskLevel: 'CRITICAL' | 'HIGH' | 'MODERATE';
    assignedRn: string;
}

export const ChurnRiskPredictor: React.FC = () => {
    const [patients] = useState<ChurnRiskPatient[]>([
        { id: '1', name: 'James W.', contractStartDate: '2022-04-15', historicalWeeklyAvgHours: 120, currentWeeklyHours: 40, hoursDropPercentage: 66, riskLevel: 'CRITICAL', assignedRn: 'Sarah J.' },
        { id: '2', name: 'Eleanor F.', contractStartDate: '2023-01-10', historicalWeeklyAvgHours: 40, currentWeeklyHours: 20, hoursDropPercentage: 50, riskLevel: 'HIGH', assignedRn: 'Marcus C.' },
        { id: '3', name: 'Robert M.', contractStartDate: '2023-08-22', historicalWeeklyAvgHours: 24, currentWeeklyHours: 16, hoursDropPercentage: 33, riskLevel: 'MODERATE', assignedRn: 'Elena R.' }
    ]);

    const getRiskColor = (level: ChurnRiskPatient['riskLevel']) => {
        switch(level) {
            case 'CRITICAL': return '#DC2626';
            case 'HIGH': return '#F59E0B';
            case 'MODERATE': return '#3B82F6';
            default: return '#64748B';
        }
    };

    const getRiskBg = (level: ChurnRiskPatient['riskLevel']) => {
        switch(level) {
            case 'CRITICAL': return '#FEF2F2';
            case 'HIGH': return '#FFFBEB';
            case 'MODERATE': return '#EFF6FF';
            default: return '#F8FAFC';
        }
    };

    const criticalCount = patients.filter(p => p.riskLevel === 'CRITICAL').length;

    return (
        <div style={{ backgroundColor: 'white', border: '1px solid #E2E8F0', borderRadius: '12px', padding: '24px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                    <div style={{ backgroundColor: '#FEF2F2', padding: '12px', borderRadius: '8px', border: '1px solid #FECACA' }}>
                        <LineChart size={28} color="#DC2626" />
                    </div>
                    <div>
                        <h3 style={{ margin: 0, fontSize: '1.4rem', color: '#0F172A', fontWeight: 800 }}>Algorithmic Churn Risk Predictor</h3>
                        <p style={{ margin: '4px 0 0 0', color: '#64748B', fontSize: '0.9rem' }}>Detects patients quietly scaling back their care hours before they officially cancel the contract.</p>
                    </div>
                </div>

                <div style={{ padding: '8px 16px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', display: 'flex', alignItems: 'center', gap: '12px' }}>
                     <AlertTriangle size={20} color="#DC2626" />
                     <div>
                        <div style={{ fontSize: '0.75rem', color: '#991B1B', fontWeight: 700, textTransform: 'uppercase' }}>Critical Churn Risks</div>
                        <div style={{ fontSize: '1.1rem', fontWeight: 900, color: '#DC2626' }}>{criticalCount} Patients</div>
                     </div>
                </div>
            </div>

            <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                {patients.map(patient => (
                    <div key={patient.id} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', padding: '20px', backgroundColor: getRiskBg(patient.riskLevel), border: `1px solid ${getRiskColor(patient.riskLevel)}40`, borderRadius: '12px' }}>
                        
                        <div style={{ flex: '1 1 250px' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}>
                                <h4 style={{ margin: 0, fontSize: '1.2rem', color: '#0F172A', fontWeight: 900 }}>{patient.name}</h4>
                                <span style={{ backgroundColor: getRiskColor(patient.riskLevel), color: 'white', padding: '2px 8px', borderRadius: '4px', fontSize: '0.7rem', fontWeight: 800 }}>{patient.riskLevel} RISK</span>
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                <History size={14}/> Active since: {patient.contractStartDate}
                            </div>
                            <div style={{ fontSize: '0.85rem', color: '#475569', display: 'flex', alignItems: 'center', gap: '6px', marginTop: '4px' }}>
                                Supervising RN: <strong>{patient.assignedRn}</strong>
                            </div>
                        </div>

                        <div style={{ flex: '2 1 400px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '24px' }}>
                            <div style={{ textAlign: 'center' }}>
                                <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Historical Avg</div>
                                <div style={{ fontSize: '1.4rem', fontWeight: 800, color: '#334155' }}>{patient.historicalWeeklyAvgHours} <span style={{ fontSize: '0.8rem', fontWeight: 600 }}>hrs/wk</span></div>
                            </div>
                            
                            <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', color: getRiskColor(patient.riskLevel), fontWeight: 800 }}>
                                <ArrowDownRight size={24} />
                                <span style={{ fontSize: '0.85rem' }}>-{patient.hoursDropPercentage}%</span>
                            </div>

                            <div style={{ textAlign: 'center' }}>
                                <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 700, textTransform: 'uppercase' }}>Past 30 Days</div>
                                <div style={{ fontSize: '1.4rem', fontWeight: 900, color: getRiskColor(patient.riskLevel) }}>{patient.currentWeeklyHours} <span style={{ fontSize: '0.8rem', fontWeight: 600 }}>hrs/wk</span></div>
                            </div>
                        </div>

                        <div style={{ flex: '0 0 auto', display: 'flex', flexDirection: 'column', gap: '8px', borderLeft: `1px solid ${getRiskColor(patient.riskLevel)}40`, paddingLeft: '24px' }}>
                            <button style={{ backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '6px', padding: '10px 16px', fontSize: '0.85rem', fontWeight: 800, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <PhoneCall size={16}/> Log Intervention Call
                            </button>
                             <button style={{ backgroundColor: 'white', color: '#0F172A', border: '1px solid #CBD5E1', borderRadius: '6px', padding: '10px 16px', fontSize: '0.85rem', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <TrendingDown size={16}/> Downgrade Contract
                            </button>
                        </div>

                    </div>
                ))}
            </div>
            
             <div style={{ marginTop: '24px', padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px dashed #CBD5E1', fontSize: '0.85rem', color: '#475569' }}>
                <strong>Behavioral Insight:</strong> Families rarely call to abruptly cancel a $15,000/mo contract. Instead, they slowly reduce hours (e.g., "Cancel Thursdays", "Let's only do half-days this week"). This algorithm mathematically detects that downward velocity, alerting the CMO to step in and save the relationship *before* the revenue hits zero.
            </div>
        </div>
    );
};
