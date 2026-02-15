import React from 'react';
import { Radar, RadarChart, PolarGrid, PolarAngleAxis, PolarRadiusAxis, ResponsiveContainer, Tooltip } from 'recharts';

interface CoreRadarChartProps {
    data: any[];
    angleKey: string;
    radiusKey: string; // The data key for the value
    radarName: string;
    color?: string;
    height?: number | string;
    onRadarClick?: (data: any) => void;
}

export const CoreRadarChart: React.FC<CoreRadarChartProps> = ({
    data,
    angleKey,
    radiusKey,
    radarName,
    color = '#8884d8',
    height = '100%',
    onRadarClick
}) => {
    return (
        <ResponsiveContainer width="100%" height={height} minWidth={0}>
            <RadarChart cx="50%" cy="50%" outerRadius="80%" data={data}>
                <PolarGrid />
                <PolarAngleAxis dataKey={angleKey} tick={{ fill: '#6B7280', fontSize: 12 }} />
                <PolarRadiusAxis />
                <Radar
                    name={radarName}
                    dataKey={radiusKey}
                    stroke={color}
                    fill={color}
                    fillOpacity={0.6}
                    onClick={onRadarClick}
                    style={{ cursor: onRadarClick ? 'pointer' : 'default' }}
                />
                <Tooltip />
            </RadarChart>
        </ResponsiveContainer>
    );
};
