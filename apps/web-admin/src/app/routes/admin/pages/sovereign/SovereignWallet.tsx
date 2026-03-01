import React, { useState } from 'react';

export default function SovereignWallet() {
    const [credentials, setCredentials] = useState([
        { id: '1', type: 'Clinical Summary', issuer: 'Hospital General', date: '2026-01-15', verified: true },
        { id: '2', type: 'Vaccination Proof', issuer: 'Health Canada', date: '2025-11-20', verified: true },
        { id: '3', type: 'Insurance Eligibility', issuer: 'SunLife', date: '2026-02-01', verified: true },
    ]);

    const [isSharing, setIsSharing] = useState(false);

    const handleShare = () => {
        setIsSharing(true);
        setTimeout(() => {
            alert('Cryptographic proof shared successfully with PrimeCare North.');
            setIsSharing(false);
        }, 2000);
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1000px', margin: '0 auto' }}>
            <div style={{ marginBottom: '32px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Sovereign Health Wallet</h1>
                    <p style={{ color: '#6B7280' }}>Decentralized Identity (DID) storage. You own your data. You control the keys.</p>
                </div>
                <div style={{ backgroundColor: '#F5F3FF', color: '#7C3AED', padding: '8px 16px', borderRadius: '20px', fontSize: '12px', fontWeight: '700', border: '1px solid #DDD6FE' }}>
                    W3C DID / VC Compatible
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '32px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">My Verifiable Credentials</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '16px' }}>
                            {credentials.map(c => (
                                <div key={c.id} style={{
                                    padding: '16px',
                                    borderRadius: '12px',
                                    border: '1px solid var(--line)',
                                    display: 'flex',
                                    justifyContent: 'space-between',
                                    alignItems: 'center',
                                    background: 'linear-gradient(to right, #FFFFFF, #F9FAFB)'
                                }}>
                                    <div>
                                        <div style={{ fontWeight: '800', fontSize: '15px' }}>{c.type}</div>
                                        <div style={{ fontSize: '12px', color: '#6B7280' }}>Issued by: {c.issuer} • {c.date}</div>
                                    </div>
                                    <div style={{ color: '#10B981', fontWeight: '700', fontSize: '12px', display: 'flex', alignItems: 'center', gap: '4px' }}>
                                        <span>✓</span> Verified
                                    </div>
                                </div>
                            ))}
                        </div>
                        <button className="btn" style={{ width: '100%', marginTop: '24px', borderStyle: 'dashed' }}>+ Request New Credential</button>
                    </div>
                </div>

                <div className="pc-card" style={{ background: '#111827', color: 'white', border: 'none' }}>
                    <div className="pc-card-h" style={{ borderBottom: '1px solid rgba(255,255,255,0.1)' }}>Share Access</div>
                    <div className="pc-card-b">
                        <p style={{ fontSize: '14px', opacity: 0.8, marginBottom: '24px' }}>
                            Providing a zero-knowledge proof (ZKP) allows agencies to verify your eligibility without seeing your raw private data.
                        </p>

                        <div style={{ backgroundColor: 'rgba(255,255,255,0.05)', padding: '20px', borderRadius: '12px', marginBottom: '24px' }}>
                            <div style={{ fontSize: '12px', opacity: 0.6, marginBottom: '8px' }}>TRUSTED REQUESTER</div>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                                <img src="/logo-icon.png" alt="PrimeCare" style={{ width: '32px', filter: 'brightness(0) invert(1)' }} />
                                <div style={{ fontWeight: '700' }}>PrimeCare North Agency</div>
                            </div>
                        </div>

                        <button
                            className="btn btn-primary"
                            style={{ width: '100%', padding: '16px', background: '#7C3AED', border: 'none' }}
                            onClick={handleShare}
                            disabled={isSharing}
                        >
                            {isSharing ? 'Sharing Proof...' : 'Authorize Secure Access'}
                        </button>
                    </div>
                </div>
            </div>

            <div style={{ marginTop: '40px', padding: '32px', backgroundColor: '#EEF2FF', borderRadius: '16px', textAlign: 'center' }}>
                <h3 style={{ fontWeight: '800', color: '#4F46E5', marginBottom: '12px' }}>Phase 9: The Autonomous Agency</h3>
                <p style={{ color: '#4338CA', maxWidth: '600px', margin: '0 auto', lineHeight: '1.6' }}>
                    We are building the first care platform that manages itself. Auto-scheduling based on clinical scores, real-time payroll triggering upon shift completion, and AI-driven billing cycles.
                </p>
            </div>
        </div>
    );
}
