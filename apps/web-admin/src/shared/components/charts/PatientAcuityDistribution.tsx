import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, Cell } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { name: 'Low', count: 45 },
    { name: 'Medium', count: 30 },
    { name: 'High', count: 15 },
    { name: 'Critical', count: 5 },
];

const COLORS = ['#10B981', '#F59E0B', '#EF4444', '#7F1D1D'];

export const PatientAcuityDistribution = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Patient Acuity Distribution</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        data={data}
                        margin={{ top: 20, right: 30, left: 20, bottom: 5 }}
                        onClick={() => navigate('/rn/patients')}
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
                        <Tooltip cursor={{ fill: '#F3F4F6' }} />
                        <Bar dataKey="count" fill="#8884d8" radius={[4, 4, 0, 0]}>
                            {data.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                            ))}
                        </Bar>
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

PatientAcuityDistribution.displayName = 'PatientAcuityDistribution';
