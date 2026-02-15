import React from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Legend } from 'recharts';

interface Series {
    key: string;
    name?: string;
    color: string;
    strokeWidth?: number;
    strokeDasharray?: string;
    activeDot?: boolean | object;
}

interface CoreLineChartProps {
    data: any[];
    xKey: string;
    series: Series[];
    height?: number | string;
    yAxisFormatter?: (value: number) => string;
    xAxisFormatter?: (value: any) => string;
    onLineClick?: (data: any) => void;
    showLegend?: boolean;
}

export const CoreLineChart: React.FC<CoreLineChartProps> = ({
    data,
    xKey,
    series,
    height = '100%',
    yAxisFormatter,
    xAxisFormatter,
    onLineClick,
    showLegend = true
}) => {
    return (
        <ResponsiveContainer width="100%" height={height}>
            <LineChart
                data={data}
                onClick={onLineClick}
                style={{ cursor: onLineClick ? 'pointer' : 'default' }}
            >
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis
                    dataKey={xKey}
                    axisLine={false}
                    tickLine={false}
                    tickFormatter={xAxisFormatter}
                />
                <YAxis
                    axisLine={false}
                    tickLine={false}
                    tickFormatter={yAxisFormatter}
                />
                <Tooltip
                    cursor={{ fill: '#f3f4f6' }}
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                />
                {showLegend && <Legend />}
                {series.map((s) => (
                    <Line
                        key={s.key}
                        type="monotone"
                        dataKey={s.key}
                        name={s.name || s.key}
                        stroke={s.color}
                        strokeWidth={s.strokeWidth || 2}
                        strokeDasharray={s.strokeDasharray}
                        activeDot={s.activeDot ? (typeof s.activeDot === 'object' ? s.activeDot : { r: 8 }) : undefined}
                        dot={false}
                    />
                ))}
            </LineChart>
        </ResponsiveContainer>
    );
};
