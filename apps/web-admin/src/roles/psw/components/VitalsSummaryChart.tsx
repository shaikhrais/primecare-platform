import React from 'react';

export const VitalsSummaryChart: React.FC = () => {
    // Mock data for visualization
    const data = [72, 75, 71, 78, 74, 76, 73];
    const max = Math.max(...data);
    const min = Math.min(...data);
    const range = max - min;

    return (
        <div
            data-cy="vitals-chart"
            style={{
                padding: '20px',
                backgroundColor: '#FFFFFF',
                border: '1px solid #E5E7EB',
                borderRadius: '16px'
            }}
        >
            <h4 style={{ margin: '0 0 16px 0', fontSize: '0.9rem', fontWeight: 800, textTransform: 'uppercase', color: '#6B7280' }}>
                Vitals Trend (Heart Rate)
            </h4>
            <div style={{ height: '120px', display: 'flex', alignItems: 'flex-end', gap: '8px', paddingBottom: '20px', borderBottom: '1px solid #F3F4F6' }}>
                {data.map((val, i) => {
                    const height = ((val - min) / (range || 1)) * 100 + 20;
                    return (
                        <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '8px' }}>
                            <div
                                style={{
                                    width: '100%',
                                    height: `${height}%`,
                                    backgroundColor: '#00875A',
                                    borderRadius: '4px 4px 0 0',
                                    transition: 'height 0.3s ease'
                                }}
                            />
                            <span style={{ fontSize: '0.65rem', fontWeight: 700, color: '#9CA3AF' }}>Day {i + 1}</span>
                        </div>
                    );
                })}
            </div>
            <div style={{ marginTop: '16px', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                    <span style={{ display: 'block', fontSize: '0.65rem', color: '#6B7280', fontWeight: 700 }}>AVG RATE</span>
                    <span style={{ fontSize: '1.1rem', fontWeight: 800, color: '#000000' }}>74 BPM</span>
                </div>
                <div style={{ textAlign: 'right' }}>
                    <span style={{ display: 'block', fontSize: '0.65rem', color: '#6B7280', fontWeight: 700 }}>STATUS</span>
                    <span style={{ fontSize: '0.75rem', fontWeight: 800, color: '#00875A', background: '#E6F4EF', padding: '2px 8px', borderRadius: '4px' }}>STABLE</span>
                </div>
            </div>
        </div>
    );
};
