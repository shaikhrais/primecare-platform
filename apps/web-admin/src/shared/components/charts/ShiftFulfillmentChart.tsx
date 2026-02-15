import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';

const data = [
    { day: 'Mon', filled: 40, open: 24 },
    { day: 'Tue', filled: 30, open: 13 },
    { day: 'Wed', filled: 20, open: 58 },
    { day: 'Thu', filled: 27, open: 39 },
    { day: 'Fri', filled: 18, open: 48 },
    { day: 'Sat', filled: 23, open: 38 },
    { day: 'Sun', filled: 34, open: 43 },
];

export const ShiftFulfillmentChart = memo(() => {
    const navigate = useNavigate();
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Shift Fulfillment</h3>
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
                            dataKey="day"
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
                        <Bar dataKey="filled" stackId="a" fill="#10B981" name="Filled Shifts" />
                        <Bar dataKey="open" stackId="a" fill="#EF4444" name="Open Shifts" />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

ShiftFulfillmentChart.displayName = 'ShiftFulfillmentChart';
