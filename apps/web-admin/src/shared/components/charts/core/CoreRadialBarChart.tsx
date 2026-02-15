import React from 'react';
import { RadialBarChart, RadialBar, Legend, ResponsiveContainer, Tooltip } from 'recharts';

interface CoreRadialBarChartProps {
    data: any[];
    dataKey: string;
    nameKey?: string;
    colors?: string[]; // Not always used in single bar gauges but good to have
    height?: number | string;
    innerRadius?: string | number;
    outerRadius?: string | number;
    startAngle?: number;
    endAngle?: number;
    barSize?: number;
    onBarClick?: (data: any) => void;
    showLegend?: boolean;
    legendStyle?: React.CSSProperties;
    showTooltip?: boolean;
    background?: boolean;
}

const defaultLegendStyle = {
    top: '50%',
    right: 0,
    transform: 'translate(0, -50%)',
    lineHeight: '24px',
};

export const CoreRadialBarChart: React.FC<CoreRadialBarChartProps> = ({
    data,
    dataKey,
    nameKey,
    colors,
    height = '100%',
    innerRadius = '10%',
    outerRadius = '80%',
    startAngle = 90,
    endAngle = -270,
    barSize = 20,
    onBarClick,
    showLegend = true,
    legendStyle = defaultLegendStyle,
    showTooltip = true,
    background = true
}) => {
    return (
        <ResponsiveContainer width="100%" height={height}>
            <RadialBarChart
                cx="50%"
                cy="50%"
                innerRadius={innerRadius}
                outerRadius={outerRadius}
                barSize={barSize}
                data={data}
                startAngle={startAngle}
                endAngle={endAngle}
            >
                <RadialBar
                    minAngle={15}
                    label={{ position: 'insideStart', fill: '#fff' }}
                    background={background ? { fill: '#eee' } : undefined}
                    clockWise
                    dataKey={dataKey}
                    onClick={onBarClick}
                    style={{ cursor: onBarClick ? 'pointer' : 'default' }}
                />
                {showLegend && (
                    <Legend
                        iconSize={10}
                        layout="vertical"
                        verticalAlign="middle"
                        wrapperStyle={legendStyle}
                    />
                )}
                {showTooltip && <Tooltip />}
            </RadialBarChart>
        </ResponsiveContainer>
    );
};
