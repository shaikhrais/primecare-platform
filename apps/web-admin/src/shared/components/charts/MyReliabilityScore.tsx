import React, { memo } from 'react';
import { RadialBarChart, RadialBar, Legend, ResponsiveContainer, Tooltip } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { name: 'On-Time', count: 95, fill: '#10B981' },
    { name: 'Late', count: 5, fill: '#EF4444' },
];

const style = {
    top: '50%',
    right: 0,
    transform: 'translate(0, -50%)',
    lineHeight: '24px',
};

export const MyReliabilityScore = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>My Reliability Score</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <RadialBarChart cx="50%" cy="50%" innerRadius="10%" outerRadius="80%" barSize={20} data={data}>
                        <RadialBar
                            minAngle={15}
                            label={{ position: 'insideStart', fill: '#fff' }}
                            background
                            clockWise
                            dataKey="count"
                            onClick={() => navigate('/psw/performance')}
                            style={{ cursor: 'pointer' }}
                        />
                        <Legend iconSize={10} layout="vertical" verticalAlign="middle" wrapperStyle={style} />
                        <Tooltip />
                    </RadialBarChart>
                </ResponsiveContainer>
            </div>
            <div style={{ textAlign: 'center', marginTop: '10px', fontSize: '14px', color: '#6B7280' }}>
                Score: 95% (Top 10% of Staff)
            </div>
        </div>
    );
});

MyReliabilityScore.displayName = 'MyReliabilityScore';
