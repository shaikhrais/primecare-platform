import React from 'react';

const PerformancePage: React.FC = () => {
    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <h1 data-cy="page.title">Performance Orchestration</h1>
            <p>Real-time Lighthouse scores and API latency percentiles.</p>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '1rem', marginTop: '2rem' }}>
                <div style={{ padding: '1.5rem', background: '#eff6ff', borderRadius: '12px', border: '1px solid #dbeafe' }}>
                    <h3 style={{ margin: 0, color: '#1e40af' }}>FCP</h3>
                    <p style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0.5rem 0' }}>0.8s</p>
                    <span style={{ color: '#059669', fontSize: '0.875rem' }}>● Healthy</span>
                </div>
                <div style={{ padding: '1.5rem', background: '#eff6ff', borderRadius: '12px', border: '1px solid #dbeafe' }}>
                    <h3 style={{ margin: 0, color: '#1e40af' }}>LCP</h3>
                    <p style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0.5rem 0' }}>1.2s</p>
                    <span style={{ color: '#059669', fontSize: '0.875rem' }}>● Healthy</span>
                </div>
                <div style={{ padding: '1.5rem', background: '#eff6ff', borderRadius: '12px', border: '1px solid #dbeafe' }}>
                    <h3 style={{ margin: 0, color: '#1e40af' }}>CLS</h3>
                    <p style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0.5rem 0' }}>0.02</p>
                    <span style={{ color: '#059669', fontSize: '0.875rem' }}>● Healthy</span>
                </div>
                <div style={{ padding: '1.5rem', background: '#eff6ff', borderRadius: '12px', border: '1px solid #dbeafe' }}>
                    <h3 style={{ margin: 0, color: '#1e40af' }}>API P99</h3>
                    <p style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: '0.5rem 0' }}>142ms</p>
                    <span style={{ color: '#d97706', fontSize: '0.875rem' }}>▲ Monitor</span>
                </div>
            </div>
        </div>
    );
};

export default PerformancePage;
