import React, { useState } from 'react';

const IntegrityVerification: React.FC = () => {
    const [status, setStatus] = useState<'idle' | 'scanning' | 'success' | 'failure'>('idle');
    const [result, setResult] = useState<{
        isValid: boolean;
        totalEvents: number;
        brokenEvents: string[];
        message: string;
    } | null>(null);

    const handleVerify = async () => {
        setStatus('scanning');
        setResult(null);
        try {
            const response = await fetch('/v1/admin/security/verify-integrity', {
                method: 'POST'
            });
            const data = await response.json();
            setResult(data);
            setStatus(data.isValid ? 'success' : 'failure');
        } catch (error) {
            console.error('Verification failed', error);
            setStatus('failure');
        }
    };

    return (
        <div className="pc-page" style={{ padding: '24px', maxWidth: '1000px' }}>
            <header style={{ marginBottom: '32px' }}>
                <h2 style={{ fontSize: '28px', fontWeight: '800', color: '#111827', display: 'flex', alignItems: 'center', gap: '12px' }}>
                    <span style={{ fontSize: '32px' }}>🛡️</span> Cryptographic Integrity Scan
                </h2>
                <p style={{ color: '#6B7280', fontSize: '16px', marginTop: '8px' }}>
                    Bank-level verification of the forensic audit trail. This tool re-computes the SHA-256 chain to prove that no historical records have been altered.
                </p>
            </header>

            <div style={{ display: 'grid', gridTemplateColumns: '1fr 300px', gap: '24px' }}>
                <div className="pc-card" style={{ padding: '32px', textAlign: 'center', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', minHeight: '400px' }}>
                    {status === 'idle' && (
                        <>
                            <div style={{ fontSize: '64px', marginBottom: '24px' }}>🔍</div>
                            <h3 style={{ fontSize: '20px', fontWeight: '600', marginBottom: '12px' }}>Ready for Security Audit</h3>
                            <p style={{ color: '#6B7280', maxWidth: '400px', marginBottom: '32px' }}>
                                The scan will validate every mutation event in the ledger against its cryptographic signature.
                            </p>
                            <button className="pc-button pc-button-primary" onClick={handleVerify} style={{ padding: '12px 32px', fontSize: '16px' }}>
                                Start Full Ledger Scan
                            </button>
                        </>
                    )}

                    {status === 'scanning' && (
                        <>
                            <div className="pc-loader" style={{ marginBottom: '24px', width: '64px', height: '64px', border: '4px solid #E5E7EB', borderTopColor: '#2563EB', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></div>
                            <h3 style={{ fontSize: '20px', fontWeight: '600', marginBottom: '8px' }}>Verifying Hash Chain...</h3>
                            <p style={{ color: '#6B7280' }}>Computing SHA-256 signatures for historical records.</p>
                        </>
                    )}

                    {status === 'success' && result && (
                        <>
                            <div style={{ fontSize: '64px', marginBottom: '24px' }}>✅</div>
                            <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#059669', marginBottom: '12px' }}>Ledger Integrity Verified</h3>
                            <p style={{ color: '#374151', fontSize: '18px', marginBottom: '8px' }}>{result.totalEvents} events checked.</p>
                            <p style={{ color: '#6B7280', maxWidth: '500px' }}>
                                No unauthorized modifications detected. The forensic trail is 100% consistent with the original cryptographic signatures.
                            </p>
                            <button className="pc-button" onClick={handleVerify} style={{ marginTop: '32px', color: '#6B7280' }}>
                                Run Scan Again
                            </button>
                        </>
                    )}

                    {status === 'failure' && result && !result.isValid && (
                        <>
                            <div style={{ fontSize: '64px', marginBottom: '24px' }}>🚨</div>
                            <h3 style={{ fontSize: '24px', fontWeight: '700', color: '#DC2626', marginBottom: '12px' }}>INTEGRITY BREACH DETECTED</h3>
                            <p style={{ color: '#991B1B', fontSize: '18px', fontWeight: '600', marginBottom: '16px' }}>
                                Found {result.brokenEvents.length} tampered records.
                            </p>
                            <div style={{ width: '100%', maxWidth: '600px', background: '#FEF2F2', border: '1px solid #F87171', borderRadius: '8px', padding: '16px', textAlign: 'left' }}>
                                <p style={{ fontWeight: '600', marginBottom: '8px' }}>Broken Event IDs:</p>
                                <div style={{ maxHeight: '150px', overflowY: 'auto', fontSize: '12px', fontFamily: 'monospace', color: '#B91C1C' }}>
                                    {result.brokenEvents.map(id => <div key={id}>{id}</div>)}
                                </div>
                            </div>
                            <p style={{ color: '#6B7280', marginTop: '24px', maxWidth: '500px' }}>
                                Critical security alert. The audit trail has been modified outside of the protected application layer. Immediate investigation is required.
                            </p>
                        </>
                    )}

                    {status === 'failure' && !result && (
                        <>
                            <div style={{ fontSize: '64px', marginBottom: '24px' }}>⚠️</div>
                            <h3 style={{ fontSize: '20px', fontWeight: '600', color: '#D97706', marginBottom: '12px' }}>Scan Interrupted</h3>
                            <p style={{ color: '#6B7280' }}>An error occurred while communicating with the security service.</p>
                            <button className="pc-button" onClick={handleVerify} style={{ marginTop: '24px' }}>Retry Scan</button>
                        </>
                    )}
                </div>

                <div className="pc-card" style={{ padding: '24px' }}>
                    <h4 style={{ fontSize: '14px', fontWeight: '700', color: '#374151', textTransform: 'uppercase', letterSpacing: '0.05em', marginBottom: '16px' }}>
                        Security Protocol
                    </h4>
                    <ul style={{ padding: 0, margin: 0, listStyle: 'none', display: 'flex', flexDirection: 'column', gap: '16px' }}>
                        <li style={{ fontSize: '13px', color: '#4B5563', paddingLeft: '24px', position: 'relative' }}>
                            <span style={{ position: 'absolute', left: 0, color: '#2563EB' }}>◈</span>
                            <strong>SHA-256 Chaining:</strong> Each event hash includes the signature of the previous record.
                        </li>
                        <li style={{ fontSize: '13px', color: '#4B5563', paddingLeft: '24px', position: 'relative' }}>
                            <span style={{ position: 'absolute', left: 0, color: '#2563EB' }}>◈</span>
                            <strong>Immutable Ledger:</strong> Records cannot be deleted or reordered without breaking the chain.
                        </li>
                        <li style={{ fontSize: '13px', color: '#4B5563', paddingLeft: '24px', position: 'relative' }}>
                            <span style={{ position: 'absolute', left: 0, color: '#2563EB' }}>◈</span>
                            <strong>Zero Trust:</strong> Even database administrators cannot bypass the cryptographic proof of audit.
                        </li>
                    </ul>

                    <div style={{ marginTop: '32px', paddingTop: '24px', borderTop: '1px solid #E5E7EB' }}>
                        <h4 style={{ fontSize: '14px', fontWeight: '700', color: '#374151', textTransform: 'uppercase', letterSpacing: '0.05em', marginBottom: '8px' }}>
                            Last Verified
                        </h4>
                        <p style={{ fontSize: '13px', color: '#6B7280' }}>
                            Never scanned in this session.
                        </p>
                    </div>
                </div>
            </div>

            <style>{`
                @keyframes spin {
                    to { transform: rotate(360deg); }
                }
            `}</style>
        </div>
    );
};

export default IntegrityVerification;
