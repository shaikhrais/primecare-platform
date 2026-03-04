import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';

const { ButtonRegistry } = AdminRegistry;

export default function SovereignWallet() {
    const { showToast } = useNotification();
    const [credentials] = useState([
        { id: '1', type: 'Clinical Summary', issuer: 'Hospital General', date: '2026-01-15', verified: true },
        { id: '2', type: 'Vaccination Proof', issuer: 'Health Canada', date: '2025-11-20', verified: true },
        { id: '3', type: 'Insurance Eligibility', issuer: 'SunLife', date: '2026-02-01', verified: true },
    ]);

    const [isSharing, setIsSharing] = useState(false);

    const handleShare = () => {
        setIsSharing(true);
        setTimeout(() => {
            showToast('ZKP Shared Successfully', 'success');
            setIsSharing(false);
        }, 1500);
    };

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ fontSize: '1.875rem', fontWeight: 'bold' }}>Sovereign Health Wallet</h1>
                    <p style={{ color: '#6b7280' }}>Decentralized Identity (DID) & Verifiable Credentials.</p>
                </div>
                <div style={{ backgroundColor: '#f3e8ff', color: '#7e22ce', padding: '0.5rem 1rem', borderRadius: '1rem', fontSize: '0.75rem', fontWeight: 'bold' }}>
                    W3C DID / VC COMPLIANT
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '2rem' }}>
                <div className="pc-card">
                    <div className="pc-card-h">My Verified Vault</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '1rem' }}>
                            {credentials.map(c => (
                                <div key={c.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '1rem', border: '1px solid #e5e7eb', borderRadius: '0.75rem', background: '#ffffff' }}>
                                    <div>
                                        <div style={{ fontWeight: 'bold', fontSize: '0.9375rem' }}>{c.type}</div>
                                        <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>{c.issuer} • {c.date}</div>
                                    </div>
                                    <span style={{ color: '#059669', fontSize: '0.75rem', fontWeight: 'bold' }}>✓ VERIFIED</span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>

                <div className="pc-card" style={{ background: '#111827', color: '#ffffff' }}>
                    <div className="pc-card-h" style={{ borderBottom: '1px solid #374151' }}>Authorize Private Access</div>
                    <div className="pc-card-b">
                        <p style={{ fontSize: '0.875rem', opacity: 0.8, marginBottom: '2rem' }}>
                            Share a Zero-Knowledge Proof (ZKP) with PrimeCare North to verify your status without exposing private data.
                        </p>
                        <button
                            className="btn primary"
                            style={{ width: '100%', background: '#7c3aed', padding: '1rem' }}
                            onClick={handleShare}
                            disabled={isSharing}
                            data-cy="btn-wallet-did-verify"
                        >
                            {isSharing ? 'Sharing Proof...' : (ButtonRegistry.find((b: any) => b.id === 'btn-wallet-did-verify')?.label || 'Authorize Secure Access')}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}
