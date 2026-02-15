import React from 'react';
import { PieChart, Pie, Cell, Tooltip, ResponsiveContainer, Legend } from 'recharts';

interface CorePieChartProps {
    data: any[];
    dataKey: string;
    nameKey: string;
    colors?: string[];
    innerRadius?: number | string;
    outerRadius?: number | string;
    height?: number | string;
    onPieClick?: (data: any) => void;
    showLegend?: boolean;
}

const DEFAULT_COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884d8'];

export const CorePieChart: React.FC<CorePieChartProps> = ({
    data,
    dataKey,
    nameKey,
    colors = DEFAULT_COLORS,
    innerRadius = 0,
    outerRadius = '80%',
    height = '100%',
    onPieClick,
    showLegend = true
}) => {
    return (
        <ResponsiveContainer width="100%" height={height} minWidth={0}>
            <PieChart>
                <Pie
                    data={data}
                    cx="50%"
                    cy="50%"
                    innerRadius={innerRadius}
                    outerRadius={outerRadius}
                    fill="#8884d8"
                    paddingAngle={5}
                    dataKey={dataKey}
                    nameKey={nameKey}
                    onClick={onPieClick}
                    style={{ cursor: onPieClick ? 'pointer' : 'default' }}
                >
                    {data.map((entry, index) => (
                        <Cell key={`cell-${index}`} fill={colors[index % colors.length]} />
                    ))}
                </Pie>
                <Tooltip />
                {showLegend && <Legend />}
            </PieChart>
        </ResponsiveContainer>
    );
};
