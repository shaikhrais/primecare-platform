import React from 'react';

interface VitalHistoryTooltipProps {
    vitals: {
        date: string;
        value: string;
    }[];
    label: string;
}

export const VitalHistoryTooltip: React.FC<VitalHistoryTooltipProps> = ({ vitals, label }) => {
    return (
        <div style={{
            position: 'absolute',
            bottom: '100%',
            left: '50%',
            transform: 'translateX(-50%)',
            backgroundColor: '#1E293B',
            color: 'white',
            padding: '12px',
            borderRadius: '8px',
            width: 'max-content',
            minWidth: '200px',
            boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.4)',
            zIndex: 100,
            pointerEvents: 'none',
            marginBottom: '8px'
        }}>
            <h4 style={{ margin: '0 0 8px 0', fontSize: '0.8rem', color: '#94A3B8', textTransform: 'uppercase', letterSpacing: '0.5px' }}>
                {label} History
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                {vitals.map((v, i) => (
                    <div key={i} style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.9rem' }}>
                        <span style={{ color: '#CBD5E1' }}>{v.date}</span>
                        <span style={{ fontWeight: 600 }}>{v.value}</span>
                    </div>
                ))}
            </div>
            <div style={{
                position: 'absolute',
                top: '100%',
                left: '50%',
                transform: 'translateX(-50%)',
                borderWidth: '6px',
                borderStyle: 'solid',
                borderColor: '#1E293B transparent transparent transparent'
            }} />
        </div>
    );
};
