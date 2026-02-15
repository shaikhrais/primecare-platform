import React, { memo } from 'react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { name: 'Jan', count: 4 },
    { name: 'Feb', count: 3 },
    { name: 'Mar', count: 2 },
    { name: 'Apr', count: 7 },
    { name: 'May', count: 5 },
    { name: 'Jun', count: 8 },
];

export const IncidentTrendChart = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Incident Trends</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <AreaChart
                        data={data}
                        margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
                        onClick={() => navigate('/incidents')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                        <XAxis
                            dataKey="name"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            dy={10}
                        />
                        <YAxis
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                        />
                        <Tooltip />
                        <Area type="monotone" dataKey="count" stroke="#EF4444" fill="#FCA5A5" />
                    </AreaChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

IncidentTrendChart.displayName = 'IncidentTrendChart';
