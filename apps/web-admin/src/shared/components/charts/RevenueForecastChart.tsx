import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { month: 'Jan', actual: 4000, projected: 2400 },
    { month: 'Feb', actual: 3000, projected: 1398 },
    { month: 'Mar', actual: 2000, projected: 9800 },
    { month: 'Apr', actual: 2780, projected: 3908 },
    { month: 'May', actual: 1890, projected: 4800 },
    { month: 'Jun', actual: 2390, projected: 3800 },
];

export const RevenueForecastChart = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Revenue Forecast</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        data={data}
                        margin={{ top: 20, right: 30, left: 20, bottom: 5 }}
                        onClick={() => navigate('/finance/revenue')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" vertical={false} stroke="#E5E7EB" />
                        <XAxis
                            dataKey="month"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            dy={10}
                        />
                        <YAxis
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            tickFormatter={(value) => `$${value}`}
                        />
                        <Tooltip formatter={(value) => [`$${value}`, undefined]} cursor={{ fill: '#F3F4F6' }} />
                        <Legend />
                        <Bar dataKey="actual" fill="#10B981" name="Actual Revenue" radius={[4, 4, 0, 0]} />
                        <Bar dataKey="projected" fill="#6B7280" name="Projected" radius={[4, 4, 0, 0]} />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

RevenueForecastChart.displayName = 'RevenueForecastChart';
