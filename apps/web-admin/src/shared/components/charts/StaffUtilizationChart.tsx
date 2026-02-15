import React from 'react';
import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer } from 'recharts';



const COLORS = ['#00875A', '#F59E0B', '#EF4444'];

interface Props {
    data?: any[];
}

export const StaffUtilizationChart = React.memo(({ data }: Props) => {
    const chartData = data || [];
    return (
        <div style={{ backgroundColor: 'white', padding: '1.5rem', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', height: '400px' }}>
            <h3 style={{ margin: '0 0 1.5rem 0', color: '#111827' }}>Staff Time Utilization</h3>
            <ResponsiveContainer width="100%" height="90%">
                <PieChart>
                    <Pie
                        data={chartData}
                        cx="50%"
                        cy="50%"
                        innerRadius={60}
                        outerRadius={100}
                        fill="#8884d8"
                        paddingAngle={5}
                        dataKey="value"
                    >
                        {chartData.map((entry, index) => (
                            <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                        ))}
                    </Pie>
                    <Tooltip contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }} />
                    <Legend />
                </PieChart>
            </ResponsiveContainer>
        </div>
    );
});
