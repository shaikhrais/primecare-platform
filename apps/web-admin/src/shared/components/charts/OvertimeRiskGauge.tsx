import React, { memo } from 'react';
import { RadialBarChart, RadialBar, Legend, ResponsiveContainer, Tooltip } from 'recharts';
import { useNavigate } from 'react-router-dom';



const style = {
    top: '50%',
    right: 0,
    transform: 'translate(0, -50%)',
    lineHeight: '24px',
};

interface Props {
    data?: any[];
}

export const OvertimeRiskGauge = memo(({ data }: Props) => {
    const navigate = useNavigate();
    const chartData = data || [];
    return (
        <div style={{ padding: '24px', backgroundColor: 'white', borderRadius: '16px', border: '1px solid #E5E7EB', height: '400px', display: 'flex', flexDirection: 'column' }}>
            <h3 style={{ margin: '0 0 20px 0', fontSize: '18px', fontWeight: 700, color: '#111827' }}>Overtime Risk Monitor</h3>
            <div style={{ flex: 1, width: '100%', minHeight: 0 }}>
                <ResponsiveContainer width="100%" height="100%">
                    <RadialBarChart cx="50%" cy="50%" innerRadius="10%" outerRadius="80%" barSize={20} data={chartData}>
                        <RadialBar
                            minAngle={15}
                            label={{ position: 'insideStart', fill: '#fff' }}
                            background
                            clockWise
                            dataKey="count"
                            onClick={() => navigate('/staff/overtime')}
                            style={{ cursor: 'pointer' }}
                        />
                        <Legend iconSize={10} layout="vertical" verticalAlign="middle" wrapperStyle={style} />
                        <Tooltip />
                    </RadialBarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
});

OvertimeRiskGauge.displayName = 'OvertimeRiskGauge';
