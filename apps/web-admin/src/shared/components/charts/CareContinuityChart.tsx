import React, { memo } from 'react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';



interface Props {
    data?: any[];
}

export const CareContinuityChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Care Team Consistency</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <AreaChart
                        data={chartData}
                        margin={{ top: 10, right: 30, left: 0, bottom: 0 }}
                        onClick={() => navigate('/client/care-team')}
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
                            unit="%"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                        />
                        <Tooltip />
                        <Area type="monotone" dataKey="primary" stackId="1" stroke="#4F46E5" fill="#C7D2FE" name="Primary Caregiver" />
                        <Area type="monotone" dataKey="relief" stackId="1" stroke="#9CA3AF" fill="#E5E7EB" name="Relief Staff" />
                    </AreaChart>
                </ResponsiveContainer>
            </div>
            <div style={{ textAlign: 'center', marginTop: '10px', fontSize: '14px', color: '#6B7280' }}>
                Goal: 90% Primary Caregiver
            </div>
        </div>
    );
});

CareContinuityChart.displayName = 'CareContinuityChart';
