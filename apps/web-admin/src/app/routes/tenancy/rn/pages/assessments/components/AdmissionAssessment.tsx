import React, { useState } from 'react';
import { useAutoSaveForm } from '@/shared/hooks/useAutoSaveForm';
import { useNotification } from '@/shared/context/NotificationContext';
import { Save, AlertCircle } from 'lucide-react';

interface AdmissionAssessmentProps {
    patientId: string;
    onComplete: () => void;
}

export const AdmissionAssessment: React.FC<AdmissionAssessmentProps> = ({ patientId, onComplete }) => {
    const { showToast } = useNotification();
    const { data, updateField, lastSaved, isRestored, flushAndClear } = useAutoSaveForm(`admission_${patientId}`, {
        chiefComplaint: '',
        historyOfPresentIllness: '',
        mobilityStatus: 'Independent',
        fallRiskScore: 0,
        notes: ''
    });

    const [submitting, setSubmitting] = useState(false);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setSubmitting(true);
        setTimeout(() => {
            flushAndClear();
            setSubmitting(false);
            showToast('Clinical Assessment committed to master record.', 'success');
            onComplete();
        }, 800);
    };

    return (
        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '24px', height: '100%' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '2px solid #E2E8F0', paddingBottom: '16px' }}>
                <h2 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 800, color: '#0F172A' }}>Initial RN Admission Assessment</h2>
                <div style={{ display: 'flex', gap: '12px', alignItems: 'center' }}>
                    {isRestored && (
                        <span style={{ backgroundColor: '#FEF2F2', color: '#B91C1C', padding: '6px 12px', borderRadius: '20px', fontSize: '0.8rem', fontWeight: 800, display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <AlertCircle size={14} /> Draft Recovered
                        </span>
                    )}
                    {lastSaved && (
                        <span style={{ fontSize: '0.85rem', color: '#64748B', display: 'flex', alignItems: 'center', gap: '4px' }}>
                            <Save size={14} /> Auto-saved {lastSaved.toLocaleTimeString()}
                        </span>
                    )}
                </div>
            </div>

            <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: '20px' }}>
                <div>
                    <label style={{ display: 'block', fontWeight: 700, marginBottom: '8px', color: '#334155' }}>1. Chief Complaint / Reason for Admission</label>
                    <textarea
                        value={data.chiefComplaint}
                        onChange={(e) => updateField('chiefComplaint', e.target.value)}
                        placeholder="Patient presented with..."
                        style={{ width: '100%', minHeight: '80px', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', fontFamily: 'inherit' }}
                    />
                </div>

                <div>
                    <label style={{ display: 'block', fontWeight: 700, marginBottom: '8px', color: '#334155' }}>2. History of Present Illness (HPI)</label>
                    <textarea
                        value={data.historyOfPresentIllness}
                        onChange={(e) => updateField('historyOfPresentIllness', e.target.value)}
                        style={{ width: '100%', minHeight: '120px', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', fontFamily: 'inherit' }}
                    />
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '20px' }}>
                    <div>
                        <label style={{ display: 'block', fontWeight: 700, marginBottom: '8px', color: '#334155' }}>3. Standard Mobility Status</label>
                        <select
                            value={data.mobilityStatus}
                            onChange={(e) => updateField('mobilityStatus', e.target.value)}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem', backgroundColor: 'white' }}
                        >
                            <option value="Independent">Independent (Ambulatory)</option>
                            <option value="1PersonAssist">1-Person Physical Assist</option>
                            <option value="2PersonAssist">2-Person Physical Assist</option>
                            <option value="MechanicalLift">Mechanical Lift Required</option>
                            <option value="Bedbound">Bedbound</option>
                        </select>
                    </div>
                    <div>
                        <label style={{ display: 'block', fontWeight: 700, marginBottom: '8px', color: '#334155' }}>4. Fall Risk Tool Score (Morse)</label>
                        <input
                            type="number"
                            value={data.fallRiskScore}
                            onChange={(e) => updateField('fallRiskScore', parseInt(e.target.value) || 0)}
                            style={{ width: '100%', padding: '12px', borderRadius: '8px', border: '1px solid #CBD5E1', fontSize: '1rem' }}
                        />
                    </div>
                </div>
            </div>

            <div style={{ display: 'flex', justifyContent: 'flex-end', paddingTop: '16px', borderTop: '1px solid #E2E8F0' }}>
                <button
                    type="submit"
                    disabled={submitting}
                    style={{ padding: '14px 28px', backgroundColor: '#0F172A', color: 'white', border: 'none', borderRadius: '8px', fontWeight: 800, fontSize: '1rem', cursor: 'pointer' }}
                >
                    {submitting ? 'Committing...' : 'Sign & Complete Assessment'}
                </button>
            </div>
        </form>
    );
};
