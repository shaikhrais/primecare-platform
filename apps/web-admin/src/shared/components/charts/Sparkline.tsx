import React from 'react';

interface SparklineProps {
    data: number[];
    color?: string;
    width?: number;
    height?: number;
}

export const Sparkline: React.FC<SparklineProps> = ({
    data,
    color = '#10b981',
    width = 120,
    height = 30
}) => {
    if (!data || data.length < 2) return null;

    const min = Math.min(...data);
    const max = Math.max(...data);
    const range = max - min || 1;

    // Calculate padding
    const padX = 2;
    const padY = 2;
    const innerWidth = width - padX * 2;
    const innerHeight = height - padY * 2;

    const points = data.map((d, i) => {
        const x = padX + (i / (data.length - 1)) * innerWidth;
        const y = padY + innerHeight - ((d - min) / range) * innerHeight;
        return `${x},${y}`;
    }).join(' ');

    return (
        <svg width={width} height={height} viewBox={`0 0 ${width} ${height}`} style={{ overflow: 'visible' }}>
            <polyline
                fill="none"
                stroke={color}
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                points={points}
            />
            {/* Draw a subtle fill area under the line */}
            <polygon
                fill={`${color}20`}
                points={`${padX},${height} ${points} ${width - padX},${height}`}
            />
        </svg>
    );
};

export default Sparkline;
