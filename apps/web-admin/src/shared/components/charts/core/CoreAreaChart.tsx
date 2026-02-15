import React, { useId } from 'react';
import { AreaChart, Area, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

interface Series {
    key: string;
    name?: string;
    color: string;
    stackId?: string;
}

interface CoreAreaChartProps {
    data: any[];
    xKey: string;
    series: Series[];
    height?: number | string;
    yAxisFormatter?: (value: number) => string;
    xAxisFormatter?: (value: any) => string;
    unit?: string;
    onGraphicClick?: (data: any) => void;
    showGradient?: boolean;
}

export const CoreAreaChart: React.FC<CoreAreaChartProps> = ({
    data,
    xKey,
    series,
    height = '100%',
    yAxisFormatter,
    xAxisFormatter,
    unit,
    onGraphicClick,
    showGradient = false
}) => {
    // Generate unique IDs for gradients to prevent conflicts if multiple charts are on page
    const gradientIdPrefix = useId().replace(/:/g, '');

    return (
        <ResponsiveContainer width="100%" height={height} minWidth={0}>
            <AreaChart data={data} onClick={onGraphicClick} style={{ cursor: onGraphicClick ? 'pointer' : 'default' }}>
                {showGradient && (
                    <defs>
                        {series.map((s, i) => (
                            <linearGradient key={s.key} id={`${gradientIdPrefix}-${s.key}`} x1="0" y1="0" x2="0" y2="1">
                                <stop offset="5%" stopColor={s.color} stopOpacity={0.8} />
                                <stop offset="95%" stopColor={s.color} stopOpacity={0} />
                            </linearGradient>
                        ))}
                    </defs>
                )}
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
                    unit={unit}
                />
                <Tooltip
                    contentStyle={{ borderRadius: '8px', border: 'none', boxShadow: '0 4px 6px rgba(0,0,0,0.1)' }}
                />
                {series.map((s) => (
                    <Area
                        key={s.key}
                        type="monotone"
                        dataKey={s.key}
                        name={s.name || s.key}
                        stackId={s.stackId}
                        stroke={s.color}
                        fillOpacity={showGradient ? 1 : 0.3}
                        fill={showGradient ? `url(#${gradientIdPrefix}-${s.key})` : s.color}
                    />
                ))}
            </AreaChart>
        </ResponsiveContainer>
    );
};
