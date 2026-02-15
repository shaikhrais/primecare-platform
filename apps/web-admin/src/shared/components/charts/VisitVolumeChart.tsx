import React, { memo } from 'react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = AdminRegistry;



interface Props {
    data?: any[];
}

export const VisitVolumeChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    const handleClick = (data: any) => {
        // Drill down to schedule
        navigate(`${RouteRegistry.SCHEDULE}?view=week`);
    };

    return (
        <div style={{ width: '100%', height: 300, backgroundColor: 'white', padding: '1rem', borderRadius: '1rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)' }}>
            <h3 style={{ margin: '0 0 1rem 0', color: '#374151' }}>Visit Volume (Last 7 Days)</h3>
            <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={chartData} onClick={handleClick} style={{ cursor: 'pointer' }}>
                    <defs>
                        <linearGradient id="colorVisits" x1="0" y1="0" x2="0" y2="1">
                            <stop offset="5%" stopColor="#3B82F6" stopOpacity={0.8} />
                            <stop offset="95%" stopColor="#3B82F6" stopOpacity={0} />
                        </linearGradient>
                    </defs>
                    <CartesianGrid strokeDasharray="3 3" vertical={false} />
                    <XAxis dataKey="name" axisLine={false} tickLine={false} />
                    <YAxis axisLine={false} tickLine={false} />
                    <Tooltip
                        contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                    />
                    <Area type="monotone" dataKey="visits" stroke="#3B82F6" fillOpacity={1} fill="url(#colorVisits)" />
                </AreaChart>
            </ResponsiveContainer>
        </div>
    );
});
