import React from 'react';

const SecurityScansPage: React.FC = () => {
    return (
        <div style={{ padding: '2rem' }}>
            <h1>Security & Vulnerability Scans</h1>
            <p>Continuous SAST auditing and dependency risk assessment.</p>
            <div style={{ marginTop: '2rem', display: 'flex', gap: '1rem' }}>
                <div style={{ flex: 1, padding: '1.5rem', background: '#fef2f2', border: '1px solid #fee2e2', borderRadius: '12px' }}>
                    <h3 style={{ color: '#991b1b', margin: 0 }}>SAST Issues</h3>
                    <p style={{ fontSize: '2rem', margin: '0.5rem 0' }}>0</p>
                    <span style={{ color: '#b91c1c' }}>No critical vulnerabilities</span>
                </div>
                <div style={{ flex: 1, padding: '1.5rem', background: '#fffbeb', border: '1px solid #fef3c7', borderRadius: '12px' }}>
                    <h3 style={{ color: '#92400e', margin: 0 }}>Dependency Risk</h3>
                    <p style={{ fontSize: '2rem', margin: '0.5rem 0' }}>3</p>
                    <span style={{ color: '#b45309' }}>Minor updates available</span>
                </div>
            </div>
        </div>
    );
};

export default SecurityScansPage;
