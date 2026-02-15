import React, { memo } from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { useNavigate } from 'react-router-dom';



interface Props {
    data?: any[];
}

export const AssessmentComplianceChart = memo(({ data }: Props) => {
    const navigate = useNavigate();

    const chartData = data || [];

    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Assessment Compliance</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <BarChart
                        layout="vertical"
                        data={chartData}
                        margin={{ top: 20, right: 30, left: 40, bottom: 5 }}
                        onClick={() => navigate('/rn/assessments')}
                        style={{ cursor: 'pointer' }}
                    >
                        <CartesianGrid strokeDasharray="3 3" horizontal={false} stroke="#E5E7EB" />
                        <XAxis type="number" hide />
                        <YAxis
                            dataKey="name"
                            type="category"
                            axisLine={false}
                            tickLine={false}
                            tick={{ fill: '#6B7280', fontSize: 12 }}
                            width={80}
                        />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="overdue" stackId="a" fill="#EF4444" name="Overdue" radius={[0, 4, 4, 0]} />
                        <Bar dataKey="completed" stackId="a" fill="#10B981" name="Completed" radius={[4, 0, 0, 4]} />
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

AssessmentComplianceChart.displayName = 'AssessmentComplianceChart';
