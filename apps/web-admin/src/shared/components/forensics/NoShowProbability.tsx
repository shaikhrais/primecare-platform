import React, { useState, useEffect } from 'react';
import { CloudRain, Sun, AlertCircle } from 'lucide-react';

interface NoShowProps {
    patientId: string;
    visitDate: string; // ISO string
}

export const NoShowProbability: React.FC<NoShowProps> = ({ patientId, visitDate }) => {
    const [probability, setProbability] = useState<number | null>(null);
    const [weather, setWeather] = useState<'rain' | 'clear'>('clear');

    useEffect(() => {
        // MOCK: Machine Learning Heuristic Simulation
        // In reality, this would query a backend returning probability based on past attendance and live API weather arrays.
        setTimeout(() => {
            const mockIsRainyDay = Math.random() > 0.5;
            setWeather(mockIsRainyDay ? 'rain' : 'clear');
            
            // Base historical no-show rate for mock patient: 12%
            let calcProb = 12;

            if (mockIsRainyDay) {
                calcProb += 35; // Weather significantly impacts senior attendance
            }

            // High probability cap
            setProbability(Math.min(calcProb, 95));
        }, 800);
    }, [patientId, visitDate]);

    if (probability === null) return <div style={{ height: '32px', width: '120px', backgroundColor: '#F1F5F9', borderRadius: '8px', animation: 'pulse 1.5s infinite' }} />;

    const isHighRisk = probability > 40;

    return (
        <div style={{ 
            display: 'inline-flex', alignItems: 'center', gap: '8px', padding: '6px 12px', borderRadius: '8px',
            backgroundColor: isHighRisk ? '#FEF2F2' : '#F0FDF4',
            border: `1px solid ${isHighRisk ? '#FECACA' : '#BBF7D0'}`,
            fontSize: '0.85rem', fontWeight: 700, color: isHighRisk ? '#991B1B' : '#166534'
        }}>
            {weather === 'rain' ? <CloudRain size={16} /> : <Sun size={16} />}
            
            <div style={{ display: 'flex', flexDirection: 'column' }}>
                <span style={{ lineHeight: '1' }}>{probability}% No-Show Risk</span>
                {isHighRisk && <span style={{ fontSize: '0.65rem', color: '#EF4444', textTransform: 'uppercase', letterSpacing: '0.5px' }}>Action Required</span>}
            </div>

            {isHighRisk && <AlertCircle size={16} color="#DC2626" style={{ marginLeft: '4px' }} />}
        </div>
    );
};
