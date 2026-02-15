import React from 'react';
import { ScatterChart, Scatter, XAxis, YAxis, ZAxis, CartesianGrid, Tooltip, ResponsiveContainer } from 'recharts';

interface CoreScatterChartProps {
    data: any[];
    xAxis: {
        dataKey: string;
        name?: string;
        unit?: string;
        type?: 'number' | 'category';
        domain?: any[];
        tickCount?: number;
        tickFormatter?: (value: any) => string;
    };
    yAxis: {
        dataKey: string;
        name?: string;
        unit?: string;
        type?: 'number' | 'category';
        domain?: any[];
        tickCount?: number;
        tickFormatter?: (value: any) => string;
    };
    zAxis?: {
        dataKey: string;
        range?: number[];
        name?: string;
    };
    scatterName: string;
    fillColor?: string;
    height?: number | string;
    onScatterClick?: (data: any) => void;
}

export const CoreScatterChart: React.FC<CoreScatterChartProps> = ({
    data,
    xAxis,
    yAxis,
    zAxis,
    scatterName,
    fillColor = '#8884d8',
    height = '100%',
    onScatterClick
}) => {
    return (
        <ResponsiveContainer width="100%" height={height} minWidth={0} debounce={200}>
            <ScatterChart
                margin={{ top: 20, right: 20, bottom: 20, left: 20 }}
                onClick={onScatterClick && (() => onScatterClick(null))} // This might be tricky, usually onClick is on Scatter or Chart
                style={{ cursor: onScatterClick ? 'pointer' : 'default' }}
            >
                <CartesianGrid />
                <XAxis
                    type={xAxis.type || "number"}
                    dataKey={xAxis.dataKey}
                    name={xAxis.name}
                    tickFormatter={xAxis.tickFormatter}
                    domain={xAxis.domain}
                    tickCount={xAxis.tickCount}
                />
                <YAxis
                    type={yAxis.type || "number"}
                    dataKey={yAxis.dataKey}
                    name={yAxis.name}
                    unit={yAxis.unit}
                    domain={yAxis.domain}
                    tickCount={yAxis.tickCount}
                    tickFormatter={yAxis.tickFormatter}
                />
                {zAxis && (
                    <ZAxis
                        type="number"
                        dataKey={zAxis.dataKey}
                        range={zAxis.range}
                        name={zAxis.name}
                    />
                )}
                <Tooltip cursor={{ strokeDasharray: '3 3' }} />
                <Scatter
                    name={scatterName}
                    data={data}
                    fill={fillColor}
                    onClick={onScatterClick}
                />
            </ScatterChart>
        </ResponsiveContainer>
    );
};
