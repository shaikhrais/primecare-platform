import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ButtonRegistry } = AdminRegistry;

const SecurityScansPage: React.FC = () => {
    const scanBtn = getButtonById('btn-sm-scan-security');

    return (
        <div data-cy="page.container" style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <div>
                    <h1 data-cy="page.title" style={{ margin: 0 }}>Security & Vulnerability Scans</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Continuous SAST auditing and dependency risk assessment.</p>
                </div>
                <button data-cy="btn-security-scans-page-0" className="btn danger">
                    {scanBtn?.label || 'Run Security Scan'}
                </button>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '1.5rem' }}>
                <div style={{ padding: '1.5rem', background: '#fef2f2', border: '1px solid #fee2e2', borderRadius: '12px' }}>
                    <h3 data-cy="h3-security-scans-page-0" style={{ color: '#991b1b', margin: 0 }}>SAST Issues</h3>
                    <p style={{ fontSize: '2rem', margin: '0.5rem 0' }}>0</p>
                    <span style={{ color: '#b91c1c' }}>No critical vulnerabilities</span>
                </div>
                <div style={{ padding: '1.5rem', background: '#fffbeb', border: '1px solid #fef3c7', borderRadius: '12px' }}>
                    <h3 data-cy="h3-security-scans-page-1" style={{ color: '#92400e', margin: 0 }}>Dependency Risk</h3>
                    <p style={{ fontSize: '2rem', margin: '0.5rem 0' }}>3</p>
                    <span style={{ color: '#b45309' }}>Minor updates available</span>
                </div>
                <div className="pc-card" style={{ padding: '1.5rem', borderLeft: '4px solid #111827' }}>
                    <h3 data-cy="h3-security-scans-page-2" style={{ margin: 0 }}>CWE Compliance</h3>
                    <p style={{ fontSize: '2rem', margin: '0.5rem 0' }}>100%</p>
                    <span style={{ color: '#6B7280' }}>Aligned with MITRE CWE-25</span>
                </div>
            </div>

            <div style={{ marginTop: '2.5rem' }} className="pc-card">
                <div className="pc-card-h">Recent Scan History</div>
                <div className="pc-card-b">
                    <div style={{ display: 'grid', gap: '12px' }}>
                        <div style={{ padding: '12px', background: '#F9FAFB', borderRadius: '8px', display: 'flex', justifyContent: 'space-between' }}>
                            <span>Full SAST Sweep</span>
                            <span style={{ color: '#10B981' }}>Passed</span>
                        </div>
                        <div style={{ padding: '12px', background: '#F9FAFB', borderRadius: '8px', display: 'flex', justifyContent: 'space-between' }}>
                            <span>Secret Leakage Check</span>
                            <span style={{ color: '#10B981' }}>Secure</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default SecurityScansPage;
