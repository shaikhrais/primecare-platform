import React, { useState, useEffect } from 'react';
import { Sparkles, ArrowRight, Bot, X } from 'lucide-react';

interface AmendmentProps {
    patientId: string;
}

export const CarePlanEvolution: React.FC<AmendmentProps> = ({ patientId }) => {
    const [loading, setLoading] = useState(true);
    const [suggestion, setSuggestion] = useState<any | null>(null);

    useEffect(() => {
        // Simulated API fetch polling the new backend logic
        setTimeout(() => {
            setSuggestion({
                id: 'amd_901',
                triggerCondition: "Pattern Detected: 'Lower back pain (6/10)' mentioned in 4 of the last 5 PSW Daily Notes.",
                recommendation: "Add 'Physiotherapy Consult' to Active Interventions.",
                confidence: 0.92
            });
            setLoading(false);
        }, 1500);
    }, [patientId]);

    if (loading) {
        return (
            <div style={{ padding: '16px', backgroundColor: '#F8FAFC', borderRadius: '12px', border: '1px dashed #CBD5E1', display: 'flex', alignItems: 'center', gap: '12px' }}>
                <Bot size={20} color="#94A3B8" className="pulse-icon" />
                <span style={{ color: '#64748B', fontSize: '0.9rem' }}>Analyzing past 30 days of field notes for pattern deviations...</span>
                <style>{`@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.5; } } .pulse-icon { animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite; }`}</style>
            </div>
        );
    }

    if (!suggestion) return null;

    return (
        <div style={{ backgroundColor: '#EEF2FF', border: '1px solid #C7D2FE', borderRadius: '12px', padding: '16px', marginBottom: '24px', position: 'relative' }}>
            <button style={{ position: 'absolute', top: '12px', right: '12px', background: 'none', border: 'none', color: '#818CF8', cursor: 'pointer' }} onClick={() => setSuggestion(null)}>
                <X size={18} />
            </button>
            
            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '12px' }}>
                <div style={{ backgroundColor: '#4F46E5', borderRadius: '50%', padding: '6px' }}>
                    <Sparkles size={16} color="white" />
                </div>
                <h3 style={{ margin: 0, fontSize: '1rem', fontWeight: 800, color: '#3730A3' }}>AI Care Plan Amendment Suggested</h3>
                <span style={{ backgroundColor: '#C7D2FE', color: '#3730A3', fontSize: '0.75rem', fontWeight: 800, padding: '2px 8px', borderRadius: '12px' }}>
                    {(suggestion.confidence * 100).toFixed(0)}% Match
                </span>
            </div>

            <div style={{ color: '#4338CA', fontSize: '0.9rem', marginBottom: '16px' }}>
                <strong>Trigger:</strong> {suggestion.triggerCondition}
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '8px', padding: '12px', border: '1px solid #E0E7FF', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <span style={{ fontWeight: 600, color: '#1E293B', fontSize: '0.95rem' }}>{suggestion.recommendation}</span>
                <button style={{ backgroundColor: '#4F46E5', color: 'white', border: 'none', padding: '8px 16px', borderRadius: '6px', fontWeight: 700, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    Apply to Chart <ArrowRight size={16} />
                </button>
            </div>
        </div>
    );
};
