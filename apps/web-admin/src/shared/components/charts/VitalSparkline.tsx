import React from 'react';

interface VitalSparklineProps {
    data: number[]; // Array of readings (e.g., Systolic BP)
    color?: string;
    width?: number;
    height?: number;
    label?: string;
    currentValue?: string | number;
    unit?: string;
}

export const VitalSparkline: React.FC<VitalSparklineProps> = ({
    data,
    color = '#3B82F6',
    width = 100,
    height = 30,
    label,
    currentValue,
    unit
}) => {
    if (!data || data.length === 0) return null;

    const min = Math.min(...data);
    const max = Math.max(...data);
    const range = max - min || 1; // Prevent division by zero

    const points = data.map((val, i) => {
        const x = (i / (data.length - 1)) * width;
        const y = height - ((val - min) / range) * height;
        return `${x},${y}`;
    }).join(' L ');

    return (
        <div style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '8px 12px', backgroundColor: '#F8FAFC', borderRadius: '8px', border: '1px solid #E2E8F0', width: 'fit-content' }}>
            <div>
                {label && <div style={{ fontSize: '0.7rem', fontWeight: 800, color: '#64748B', textTransform: 'uppercase', marginBottom: '2px' }}>{label}</div>}
                {currentValue && <div style={{ fontSize: '1.2rem', fontWeight: 800, color: '#0F172A', lineHeight: 1 }}>{currentValue} <span style={{ fontSize: '0.8rem', color: '#94A3B8' }}>{unit}</span></div>}
            </div>

            <svg width={width} height={height} viewBox={`-2 -2 ${width + 4} ${height + 4}`} style={{ overflow: 'visible' }}>
                <defs>
                    <linearGradient id={`gradient-${label}`} x1="0" x2="0" y1="0" y2="1">
                        <stop offset="0%" stopColor={color} stopOpacity={0.2} />
                        <stop offset="100%" stopColor={color} stopOpacity={0} />
                    </linearGradient>
                </defs>

                {/* Area Fill */}
                <path
                    d={`M 0,${height} L ${points} L ${width},${height} Z`}
                    fill={`url(#gradient-${label})`}
                />

                {/* Line String */}
                <path
                    d={`M ${points}`}
                    fill="none"
                    stroke={color}
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                />

                {/* Final Data Point Marker */}
                <circle
                    cx={width}
                    cy={height - ((data[data.length - 1] - min) / range) * height}
                    r="4"
                    fill="#FFFFFF"
                    stroke={color}
                    strokeWidth="2"
                />
            </svg>
        </div>
    );
};
