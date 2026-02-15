import React, { memo } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { day: 'Mon', mood: 8, energy: 7 },
    { day: 'Tue', mood: 7, energy: 6 },
    { day: 'Wed', mood: 9, energy: 8 },
    { day: 'Thu', mood: 6, energy: 5 },
    { day: 'Fri', mood: 8, energy: 9 },
    { day: 'Sat', mood: 9, energy: 8 },
    { day: 'Sun', mood: 9, energy: 9 },
];

export const WellnessTrendChart = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>My Wellness Trends</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <LineChart
                        data={data}
                        margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                        onClick={() => navigate('/client/wellness')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                        <XAxis
                            dataKey="day"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            dy={10}
                        />
                        <YAxis
                            domain={[0, 10]}
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                        />
                        <Tooltip />
                        <Legend />
                        <Line type="monotone" dataKey="mood" stroke="#8884d8" name="Mood" strokeWidth={2} />
                        <Line type="monotone" dataKey="energy" stroke="#82ca9d" name="Energy" strokeWidth={2} />
                    </LineChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

WellnessTrendChart.displayName = 'WellnessTrendChart';
