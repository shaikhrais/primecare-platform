import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const data = [
    { name: 'Week 1', current: 4000, previous: 2400 },
    { name: 'Week 2', current: 3000, previous: 1398 },
    { name: 'Week 3', current: 2000, previous: 9800 },
    { name: 'Week 4', current: 2780, previous: 3908 },
    { name: 'Week 5', current: 1890, previous: 4800 },
    { name: 'Week 6', current: 2390, previous: 3800 },
    { name: 'Week 7', current: 3490, previous: 4300 },
];

export const RevenueTrendChart = React.memo(() => {
    return (
        <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', height: '400px' }}>
            <h3 style={{ margin: '0 0 1.5rem 0', color: '#111827' }}>Revenue Trends</h3>
            <ResponsiveContainer width="100%" height="90%">
                <LineChart
                    data={data}
                    margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                >
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" axisLine={false} tickLine={false} />
                    <YAxis axisLine={false} tickLine={false} tickFormatter={(val: number) => `$${val}`} />
                    <Tooltip
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                        formatter={(val: number) => [`$${val}`, 'Revenue']}
                    />
                    <Legend />
                    <Line type="monotone" dataKey="current" name="Current Period" stroke="#00875A" activeDot={{ r: 8 }} strokeWidth={2} />
                    <Line type="monotone" dataKey="previous" name="Previous Period" stroke="#9CA3AF" strokeDasharray="5 5" strokeWidth={2} />
                </LineChart>
            </ResponsiveContainer>
        </div>
    );
});
