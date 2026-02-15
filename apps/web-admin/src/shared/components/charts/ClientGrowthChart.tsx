import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer, ReferenceLine } from 'recharts';

const data = [
    { name: 'Jan', newClients: 12, churn: -2 },
    { name: 'Feb', newClients: 19, churn: -1 },
    { name: 'Mar', newClients: 15, churn: -3 },
    { name: 'Apr', newClients: 22, churn: -4 },
    { name: 'May', newClients: 28, churn: -1 },
    { name: 'Jun', newClients: 25, churn: -5 },
];

export const ClientGrowthChart = React.memo(() => {
    return (
        <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', height: '400px' }}>
            <h3 style={{ margin: '0 0 1.5rem 0', color: '#111827' }}>Client Acquisition & Churn</h3>
            <ResponsiveContainer width="100%" height="90%">
                <BarChart
                    data={data}
                    margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                    stackOffset="sign"
                >
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" axisLine={false} tickLine={false} />
                    <YAxis axisLine={false} tickLine={false} />
                    <Tooltip
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                        cursor={{ fill: '#f3f4f6' }}
                    />
                    <Legend />
                    <ReferenceLine y={0} stroke="#000" />
                    <Bar dataKey="newClients" name="New Clients" fill="#00875A" stackId="stack" radius={[4, 4, 0, 0]} barSize={40} />
                    <Bar dataKey="churn" name="Churned" fill="#EF4444" stackId="stack" radius={[0, 0, 4, 4]} barSize={40} />
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
});
