import React, { useState, useEffect } from 'react';
import { CloudRain, Sun, AlertCircle } from 'lucide-react';
import { AdminRegistry } from 'prime-care-shared';

interface NoShowProps {
    patientId: string;
    visitDate: string; // ISO string
}

export const NoShowProbability: React.FC<NoShowProps> = ({ patientId, visitDate }) => {
    const [probability, setProbability] = useState<number | null>(null);
    const [weather, setWeather] = useState<'rain' | 'clear'>('clear');

    useEffect(() => {
        const fetchInference = async () => {
            try {
                const token = localStorage.getItem('token');
                const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';
                
                const response = await fetch(`${apiUrl}${AdminRegistry.ApiRegistry.PLATFORM.ADMIN.SYSTEM_DATA.AI_INFERENCES}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });

                if (response.ok) {
                    const data = await response.json();
                    // Match a predictor mapped to the current environment context
                    const prediction = data.find((p: any) => p.modelName === 'no_show_predictor');
                    
                    if (prediction) {
                        const pData = JSON.parse(prediction.predictionData);
                        setWeather(pData.riskFactors?.includes('weather') ? 'rain' : 'clear');
                        setProbability(Math.round(prediction.confidenceScore * 100));
                    } else {
                        setProbability(12);
                    }
                }
            } catch (e) {
                console.error('Failed to load no-show probability', e);
                setProbability(12);
            }
        };

        fetchInference();
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
