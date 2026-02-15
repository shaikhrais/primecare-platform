import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';



interface Props {
    data?: any[];
}

export const TravelTimeAnalysis = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Travel vs Service Time</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        layout="vertical"
                        data={chartData}
                        margin={{ top: 20, right: 30, left: 40, bottom: 5 }}
                        onClick={() => navigate('/schedule/logistics')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" horizontal={false} stroke="#E5E7EB" />
                        <XAxis type="number" hide />
                        <YAxis
                            dataKey="zone"
                            type="category"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            width={60}
                        />
                        <Tooltip cursor={{ fill: '#F3F4F6' }} />
                        <Legend />
                        <Bar dataKey="travel" stackId="a" fill="#EF4444" name="Travel Time (min)" radius={[0, 0, 0, 4]} />
                        <Bar dataKey="service" stackId="a" fill="#10B981" name="Service Time (min)" radius={[0, 4, 4, 0]} />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

TravelTimeAnalysis.displayName = 'TravelTimeAnalysis';
