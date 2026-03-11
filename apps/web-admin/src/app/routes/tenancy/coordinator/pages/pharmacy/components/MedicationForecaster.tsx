import React, { useState, useEffect } from 'react';
import { Pill, Activity, AlertTriangle } from 'lucide-react';

interface ForecasterProps {
    patientId: string;
}

export const MedicationForecaster: React.FC<ForecasterProps> = ({ patientId }) => {
    const [prediction, setPrediction] = useState<any | null>(null);

    useEffect(() => {
 // : Polling backend for pharmacy forecasting
        setTimeout(() => {
            setPrediction({
                medication: "Donepezil (Aricept) 10mg",
                frequency: "BID (Twice Daily)",
                stockRemaining: 14,
                daysRemaining: 7,
                depletionDate: new Date(new Date().getTime() + (7 * 24 * 60 * 60 * 1000)).toLocaleDateString(),
                status: 'WARNING' // OK, WARNING, CRITICAL
            });
        }, 1200);
    }, [patientId]);

    if (!prediction) return <div style={{ height: '80px', backgroundColor: '#F1F5F9', borderRadius: '8px', animation: 'pulse 1.5s infinite' }} />;

    const isUrgent = prediction.daysRemaining <= 7;

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '12px', border: `1px solid ${isUrgent ? '#FCA5A5' : '#E2E8F0'}`, padding: '16px', marginTop: '16px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                    <div style={{ padding: '8px', backgroundColor: isUrgent ? '#FEF2F2' : '#F8FAFC', borderRadius: '8px' }}>
                        <Pill size={20} color={isUrgent ? '#EF4444' : '#64748B'} />
                    </div>
                    <div>
                        <h4 style={{ margin: 0, fontSize: '0.9rem', color: '#1E293B' }}>{prediction.medication}</h4>
                        <span style={{ fontSize: '0.75rem', color: '#64748B' }}>{prediction.frequency}</span>
                    </div>
                </div>
                {isUrgent && (
                    <span style={{ display: 'flex', alignItems: 'center', gap: '4px', fontSize: '0.75rem', fontWeight: 700, color: '#DC2626', backgroundColor: '#FEE2E2', padding: '2px 8px', borderRadius: '12px' }}>
                        <AlertTriangle size={12} /> Action Needed
                    </span>
                )}
            </div>

            <div style={{ display: 'flex', justifyContent: 'space-between', borderTop: '1px solid #F1F5F9', paddingTop: '12px' }}>
                <div>
                    <div style={{ fontSize: '0.75rem', color: '#64748B', fontWeight: 600 }}>Estimated Depletion</div>
                    <div style={{ fontSize: '1rem', fontWeight: 800, color: '#0F172A', display: 'flex', alignItems: 'center', gap: '6px' }}>
                        {prediction.depletionDate}
                        <span style={{ fontSize: '0.75rem', fontWeight: 600, color: isUrgent ? '#EF4444' : '#64748B' }}>
                            ({prediction.daysRemaining} days left)
                        </span>
                    </div>
                </div>
                <button style={{ backgroundColor: isUrgent ? '#DC2626' : '#F1F5F9', color: isUrgent ? 'white' : '#64748B', border: 'none', padding: '0 16px', borderRadius: '6px', fontWeight: 600, fontSize: '0.8rem', cursor: 'pointer' }}>
                    Dispatch Pharmacy Refill
                </button>
            </div>
        </div>
    );
};
