import React from 'react';
import { Flame, BrainCircuit, HeartPulse } from 'lucide-react';

interface BurnoutPredictorProps {
    hoursLoggedThisWeek: number;
    consecutiveDaysWorked: number;
    intensityScore: number; // 0-100
}

export const BurnoutPredictor: React.FC<BurnoutPredictorProps> = ({ hoursLoggedThisWeek, consecutiveDaysWorked, intensityScore }) => {
    let status = 'Healthy';
    let color = '#10B981'; // Green
    let message = "You're pacing yourself well. Keep it up!";

    if (intensityScore > 85 || consecutiveDaysWorked >= 8) {
        status = 'Critical Burnout Risk';
        color = '#EF4444'; // Red
        message = "High risk of burnout detected. Please consider requesting 1-2 days of downtime. Your health matters.";
    } else if (intensityScore > 65 || consecutiveDaysWorked >= 5) {
        status = 'Elevated Fatigue';
        color = '#F59E0B'; // Amber
        message = "You've been working hard consistently. Make sure to hydrate and rest during off-hours.";
    }

    return (
        <div style={{ backgroundColor: '#FFFFFF', borderRadius: '16px', border: '1px solid #E5E7EB', padding: '24px', position: 'relative', overflow: 'hidden' }}>
            <div style={{ position: 'absolute', top: '-20px', right: '-20px', opacity: 0.05, transform: 'scale(2)' }}>
                <BrainCircuit size={150} color={color} />
            </div>

            <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '16px' }}>
                <div style={{ backgroundColor: `${color}20`, padding: '12px', borderRadius: '12px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <HeartPulse size={24} color={color} />
                </div>
                <div>
                    <h3 style={{ margin: '0 0 4px 0', fontSize: '1.2rem', fontWeight: 800, color: '#111827' }}>My Wellness Predictor</h3>
                    <p style={{ margin: 0, fontWeight: 700, color: color, fontSize: '0.95rem' }}>Status: {status}</p>
                </div>
            </div>

            <p style={{ color: '#4B5563', fontSize: '0.95rem', lineHeight: 1.5, marginBottom: '20px', position: 'relative', zIndex: 1 }}>
                {message}
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '12px', marginBottom: '20px' }}>
                <div style={{ backgroundColor: '#F9FAFB', padding: '12px', borderRadius: '8px', border: '1px solid #F3F4F6' }}>
                    <div style={{ color: '#6B7280', fontSize: '0.8rem', fontWeight: 600, textTransform: 'uppercase', marginBottom: '4px' }}>Hours Logged</div>
                    <div style={{ color: '#111827', fontSize: '1.4rem', fontWeight: 800 }}>{hoursLoggedThisWeek}h</div>
                </div>
                <div style={{ backgroundColor: '#F9FAFB', padding: '12px', borderRadius: '8px', border: '1px solid #F3F4F6' }}>
                    <div style={{ color: '#6B7280', fontSize: '0.8rem', fontWeight: 600, textTransform: 'uppercase', marginBottom: '4px' }}>Consecutive Days</div>
                    <div style={{ color: '#111827', fontSize: '1.4rem', fontWeight: 800 }}>{consecutiveDaysWorked}</div>
                </div>
            </div>

            {intensityScore > 65 && (
                <button style={{ width: '100%', padding: '12px', backgroundColor: 'transparent', border: `1px solid ${color}`, color: color, borderRadius: '8px', fontWeight: 700, cursor: 'pointer', transition: 'all 0.2s' }}>
                    Request Downtime Block
                </button>
            )}
        </div>
    );
};
