import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell } from 'recharts';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;



interface Props {
    data?: any[];
}

export const RevenueChart = React.memo(({ data }: Props) => {
    const navigate = useNavigate();

    // Transform API data (month, actual, projected) to Chart data (name, revenue)
    const chartData = (data || []).map((d: any) => ({
        name: d.month,
        revenue: d.actual
    }));

    const handleClick = (data: any) => {
        if (data && data.activePayload && data.activePayload.length > 0) {
            // Drill down to earnings for that month (mock filter)
            navigate(`${RouteRegistry.EARNINGS}?tab=Overview&month=${data.activeLabel}`);
        }
    };

    return (
        <div style={{ width: '100%', height: 300, backgroundColor: 'white', padding: '1rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
            <h3 style={{ margin: '0 0 1rem 0', color: '#374151' }}>Revenue Trends (Click to Drill Down)</h3>
            <ResponsiveContainer width="100%" height="100%">
                <BarChart data={chartData} onClick={handleClick} style={{ cursor: 'pointer' }}>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" axisLine={false} tickLine={false} />
                    <YAxis axisLine={false} tickLine={false} tickFormatter={(value: number) => `$${value}`} />
                    <Tooltip
                        cursor={{ fill: '#f3f4f6' }}
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                    />
                    <Bar dataKey="revenue" fill="#00875A" radius={[4, 4, 0, 0]}>
                        {(chartData || []).map((entry: any, index: number) => (
                            <Cell key={`cell-${index}`} fill={index === (chartData || []).length - 1 ? '#006644' : '#00875A'} />
                        ))}
                    </Bar>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
});
