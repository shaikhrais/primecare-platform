// ================================================================
// PAGE IDENTITY: H21 · Document Signing Center — e-Signatures
// Type: Hub | Owner: manager
// Feature Flag: document-signing
// ================================================================
import React, { useState } from 'react';

const documents = [
    { id: 'doc-001', name: 'Employment Contract — Priya Sharma', type: 'Contract', status: 'pending', signers: [{ name: 'Priya Sharma', signed: false }, { name: 'HR Director', signed: true }], created: '2 hrs ago', expiresIn: '7 days' },
    { id: 'doc-002', name: 'HIPAA Compliance Agreement 2026', type: 'Compliance', status: 'completed', signers: [{ name: 'David Chen', signed: true }, { name: 'Compliance Officer', signed: true }], created: '1 day ago', expiresIn: '—' },
    { id: 'doc-003', name: 'Client Care Plan — Margaret Chen', type: 'Care Plan', status: 'pending', signers: [{ name: 'Margaret Chen', signed: false }, { name: 'Dr. Williams', signed: true }, { name: 'Case Manager', signed: false }], created: '3 hrs ago', expiresIn: '14 days' },
    { id: 'doc-004', name: 'Incident Report #IR-2026-087', type: 'Incident', status: 'expired', signers: [{ name: 'Kevin O\'Brien', signed: true }, { name: 'Supervisor', signed: false }], created: '15 days ago', expiresIn: 'Expired' },
    { id: 'doc-005', name: 'NDA — PrimeCare × MedTech Inc.', type: 'NDA', status: 'pending', signers: [{ name: 'CEO', signed: true }, { name: 'MedTech Rep', signed: false }], created: '5 hrs ago', expiresIn: '30 days' },
    { id: 'doc-006', name: 'Training Acknowledgment — Fall Prevention', type: 'Training', status: 'completed', signers: [{ name: 'James Wright', signed: true }], created: '2 days ago', expiresIn: '—' },
];

const templates = [
    { icon: '📋', name: 'Employment Contract', uses: 45 },
    { icon: '🔒', name: 'HIPAA Agreement', uses: 120 },
    { icon: '❤️', name: 'Care Plan Consent', uses: 89 },
    { icon: '📝', name: 'Incident Report', uses: 34 },
    { icon: '🤐', name: 'Non-Disclosure Agreement', uses: 12 },
    { icon: '📚', name: 'Training Acknowledgment', uses: 67 },
];

export default function DocumentSigningCenter() {
    const [filter, setFilter] = useState<'all' | 'pending' | 'completed' | 'expired'>('all');
    const statusColor = (s: string) => s === 'completed' ? 'var(--pc-success)' : s === 'pending' ? 'var(--pc-warning)' : 'var(--pc-error)';
    const filtered = filter === 'all' ? documents : documents.filter(d => d.status === filter);

    return (
        <div data-cy="page.container" role="main" aria-label="Document Signing" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                        ✍️ Document Signing Center
                    </h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                        Digital signatures, audit trails & compliance documents
                    </p>
                </div>
                <button style={{
                    padding: '10px 24px', borderRadius: '10px', border: 'none',
                    background: 'var(--pc-primary)', color: 'white', fontWeight: 700, cursor: 'pointer',
                }}>➕ New Document</button>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Total Documents', value: '247', color: 'var(--pc-primary)' },
                    { label: 'Pending Signatures', value: '12', color: 'var(--pc-warning)' },
                    { label: 'Completed This Month', value: '38', color: 'var(--pc-success)' },
                    { label: 'Expired', value: '3', color: 'var(--pc-error)' },
                ].map((s, i) => (
                    <div key={i} style={{
                        flex: '1 1 150px', padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                    }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '6px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Filter + Templates row */}
            <div style={{ display: 'flex', gap: '16px', marginBottom: '24px', flexWrap: 'wrap' }}>
                <div style={{ display: 'flex', gap: '4px' }}>
                    {['all', 'pending', 'completed', 'expired'].map(f => (
                        <button key={f} onClick={() => setFilter(f as any)}
                            style={{
                                padding: '8px 16px', borderRadius: '10px', border: 'none',
                                background: filter === f ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                                color: filter === f ? 'white' : 'var(--pc-text-secondary)',
                                fontWeight: 700, fontSize: '0.8rem', cursor: 'pointer', textTransform: 'capitalize',
                            }}>{f}</button>
                    ))}
                </div>
            </div>

            {/* Documents List */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '12px', marginBottom: '32px' }}>
                {filtered.map((doc) => (
                    <div key={doc.id} style={{
                        padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                        cursor: 'pointer', transition: 'transform 0.15s',
                    }}
                        onMouseEnter={e => e.currentTarget.style.transform = 'translateX(4px)'}
                        onMouseLeave={e => e.currentTarget.style.transform = 'translateX(0)'}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', gap: '12px', flexWrap: 'wrap' }}>
                            <div style={{ flex: 1 }}>
                                <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>
                                    📄 {doc.name}
                                </div>
                                <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', display: 'flex', gap: '12px', flexWrap: 'wrap' }}>
                                    <span>🏷️ {doc.type}</span>
                                    <span>🕐 {doc.created}</span>
                                    <span>⏰ {doc.expiresIn}</span>
                                </div>
                            </div>
                            <span style={{
                                padding: '4px 12px', borderRadius: '10px', fontSize: '0.7rem', fontWeight: 700,
                                color: statusColor(doc.status), background: `${statusColor(doc.status)}15`,
                            }}>{doc.status.toUpperCase()}</span>
                        </div>
                        {/* Signers */}
                        <div style={{ display: 'flex', gap: '8px', marginTop: '12px', flexWrap: 'wrap' }}>
                            {doc.signers.map((s, i) => (
                                <span key={i} style={{
                                    padding: '3px 10px', borderRadius: '8px', fontSize: '0.7rem', fontWeight: 600,
                                    background: s.signed ? 'rgba(5,150,105,0.1)' : 'var(--pc-bg-secondary)',
                                    color: s.signed ? 'var(--pc-success)' : 'var(--pc-text-tertiary)',
                                }}>
                                    {s.signed ? '✅' : '⏳'} {s.name}
                                </span>
                            ))}
                        </div>
                    </div>
                ))}
            </div>

            {/* Templates */}
            <h3 style={{ fontWeight: 700, color: 'var(--pc-text-primary)', margin: '0 0 16px' }}>📁 Document Templates</h3>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(180px, 1fr))', gap: '12px' }}>
                {templates.map((t, i) => (
                    <div key={i} style={{
                        padding: '20px', borderRadius: '14px', textAlign: 'center',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                        cursor: 'pointer', transition: 'transform 0.2s',
                    }}
                        onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                        onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                        <div style={{ fontSize: '1.8rem', marginBottom: '8px' }}>{t.icon}</div>
                        <div style={{ fontWeight: 700, fontSize: '0.8rem', color: 'var(--pc-text-primary)' }}>{t.name}</div>
                        <div style={{ fontSize: '0.65rem', color: 'var(--pc-text-tertiary)', marginTop: '4px' }}>{t.uses} uses</div>
                    </div>
                ))}
            </div>
        </div>
    );
}
