import React from 'react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, Cell, ReferenceLine } from 'recharts';

interface Series {
    key: string;
    name?: string;
    color: string;
    radius?: [number, number, number, number];
    stackId?: string;
}

interface CoreBarChartProps {
    data: any[];
    xKey: string;
    series: Series[];
    height?: number | string;
    yAxisFormatter?: (value: number) => string;
    xAxisFormatter?: (value: any) => string;
    onBarClick?: (data: any) => void;
    highlightLastBar?: boolean; // Special prop for the Revenue use case
    highlightColor?: string;
    stackOffset?: 'sign' | 'expand' | 'none' | 'wiggle' | 'silhouette';
    referenceLineY?: number;
    layout?: 'horizontal' | 'vertical';
}

export const CoreBarChart: React.FC<CoreBarChartProps> = ({
    data,
    xKey,
    series,
    height = '100%',
    yAxisFormatter,
    xAxisFormatter,
    onBarClick,
    highlightLastBar = false,
    highlightColor,
    stackOffset,
    referenceLineY,
    layout = 'horizontal'
}) => {
    return (
        <ResponsiveContainer width="100%" height={height}>
            <BarChart
                data={data}
                onClick={onBarClick}
                layout={layout}
                stackOffset={stackOffset}
                style={{ cursor: onBarClick ? 'pointer' : 'default' }}
            >
                <CartesianGrid strokeDasharray="3 3" vertical={false} />
                <XAxis
                    type={layout === 'vertical' ? 'number' : 'category'}
                    dataKey={layout === 'vertical' ? undefined : xKey}
                    axisLine={false}
                    tickLine={false}
                    tickFormatter={xAxisFormatter}
                />
                <YAxis
                    type={layout === 'vertical' ? 'category' : 'number'}
                    dataKey={layout === 'vertical' ? xKey : undefined}
                    axisLine={false}
                    tickLine={false}
                    tickFormatter={yAxisFormatter}
                />
                <Tooltip
                    cursor={{ fill: '#f3f4f6' }}
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                />
                {referenceLineY !== undefined && <ReferenceLine y={referenceLineY} stroke="#000" />}
                {series.map((s, i) => (
                    <Bar
                        key={s.key}
                        dataKey={s.key}
                        name={s.name || s.key}
                        fill={s.color}
                        stackId={s.stackId}
                        radius={s.radius || [4, 4, 0, 0]}
                    >
                        {highlightLastBar && highlightColor && data.map((entry, index) => (
                            <Cell
                                key={`cell-${index}`}
                                fill={index === data.length - 1 ? highlightColor : s.color}
                            />
                        ))}
                    </Bar>
                ))}
            </BarChart>
        </ResponsiveContainer>
    );
};
