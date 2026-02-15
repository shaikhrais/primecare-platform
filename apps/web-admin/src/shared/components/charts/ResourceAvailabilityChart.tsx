import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { hour: '08:00', available: 12, busy: 18 },
    { hour: '10:00', available: 8, busy: 22 },
    { hour: '12:00', available: 15, busy: 15 },
    { hour: '14:00', available: 5, busy: 25 },
    { hour: '16:00', available: 10, busy: 20 },
];

export const ResourceAvailabilityChart = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Resource Availability</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        data={data}
                        margin={{ top: 20, right: 30, left: 20, bottom: 5 }}
                        onClick={() => navigate('/schedule')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                        <XAxis
                            dataKey="hour"
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
                        <Legend />
                        <Bar dataKey="busy" stackId="a" fill="#EF4444" name="Busy" />
                        <Bar dataKey="available" stackId="a" fill="#10B981" name="Available" />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

ResourceAvailabilityChart.displayName = 'ResourceAvailabilityChart';
