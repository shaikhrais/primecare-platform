import React, { memo } from 'react';
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer, Tooltip } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { subject: 'Reliability', A: 120, fullMark: 150 },
    { subject: 'Communication', A: 98, fullMark: 150 },
    { subject: 'Care Quality', A: 140, fullMark: 150 },
    { subject: 'Responsiveness', A: 110, fullMark: 150 },
    { subject: 'Safety', A: 135, fullMark: 150 },
];

export const ClientSatisfactionRadar = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Client Satisfaction Metrics</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <RadarChart cx="50%" cy="50%" outerRadius="80%" data={data}>
                        <PolarGrid />
                        <PolarAngleAxis dataKey="subject" tick={{ fill: '#6B7280', fontSize: 12 }} />
                        <PolarRadiusAxis />
                        <Radar
                            name="Satisfaction"
                            dataKey="A"
                            stroke="#8884d8"
                            fill="#8884d8"
                            fillOpacity={0.6}
                            onClick={() => navigate('/surveys/results')}
                            style={{ cursor: 'pointer' }}
                        />
                        <Tooltip />
                    </RadarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

ClientSatisfactionRadar.displayName = 'ClientSatisfactionRadar';
