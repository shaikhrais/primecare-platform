import React, { useState, useEffect } from 'react';

interface TenantRisk {
    tenantId: string;
    name: string;
    slug: string;
    userCount: number;
    visitCount: number;
    riskScore: number;
    riskLevel: 'Critical' | 'Warning' | 'Low';
    riskFactors: string[];
}

export default function RiskSurveillanceDashboard() {
    const [risks, setRisks] = useState<TenantRisk[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const fetchRisks = async () => {
            try {
                const token = localStorage.getItem('token');
                const res = await fetch(`${import.meta.env.VITE_API_URL}/v1/admin/system/risk-surveillance`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });
                const json = await res.json();
                if (json.data) setRisks(json.data);
            } catch (err) {
                console.error('Failed to load risk data:', err);
            } finally {
                setLoading(false);
            }
        };
        fetchRisks();
    }, []);

    const getRiskBadge = (level: string) => {
        if (level === 'Critical') return <span style={{ backgroundColor: '#FEE2E2', color: '#B91C1C', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>🔴 Critical Risk</span>;
        if (level === 'Warning') return <span style={{ backgroundColor: '#FFEDD5', color: '#C2410C', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>🟠 Warning</span>;
        return <span style={{ backgroundColor: '#ECFDF5', color: '#047857', padding: '4px 8px', borderRadius: '4px', fontSize: '12px', fontWeight: '600' }}>🟢 Low Risk</span>;
    };

    const overviewStats = {
        criticals: risks.filter(r => r.riskLevel === 'Critical').length,
        warnings: risks.filter(r => r.riskLevel === 'Warning').length,
        totalTenants: risks.length,
        avgScore: risks.length ? Math.round(risks.reduce((acc, r) => acc + r.riskScore, 0) / risks.length) : 0
    };

    return (
        <div data-cy="page.container" style={{ padding: '24px' }}>
            <div style={{ marginBottom: '32px', display: 'flex', alignItems: 'center', gap: '16px' }}>
                <div style={{ backgroundColor: '#EFF6FF', padding: '12px', borderRadius: '12px', color: '#2563EB', fontSize: '32px' }}>
                    🛡️
                </div>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '28px', fontWeight: '800', margin: '0' }}>Platform Risk Surveillance</h1>
                    <p style={{ color: '#6B7280', margin: '4px 0 0 0' }}>Global oversight of tenant compliance and operational health.</p>
                </div>
                <div style={{ marginLeft: 'auto' }}>
                    <button
                        data-cy="btn-superuser-risk-scan"
                        style={{ padding: '12px 24px', backgroundColor: '#DC2626', color: 'white', borderRadius: '12px', fontWeight: '800', border: 'none', cursor: 'pointer', boxShadow: '0 4px 12px rgba(220, 38, 38, 0.2)' }}
                    >
                        🚀 START NETWORK SWEEP
                    </button>
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: '24px', marginBottom: '32px' }}>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <p style={{ color: '#6B7280', fontSize: '14px', fontWeight: '600', margin: '0 0 8px 0' }}>Critical Action Required</p>
                    <div style={{ fontSize: '36px', fontWeight: '800', color: '#DC2626' }}>{loading ? '-' : overviewStats.criticals}</div>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <p style={{ color: '#6B7280', fontSize: '14px', fontWeight: '600', margin: '0 0 8px 0' }}>Warning Status</p>
                    <div style={{ fontSize: '36px', fontWeight: '800', color: '#D97706' }}>{loading ? '-' : overviewStats.warnings}</div>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <p style={{ color: '#6B7280', fontSize: '14px', fontWeight: '600', margin: '0 0 8px 0' }}>Average Network Risk Score</p>
                    <div style={{ fontSize: '36px', fontWeight: '800', color: '#111827' }}>{loading ? '-' : overviewStats.avgScore}<span style={{ fontSize: '16px', color: '#9CA3AF' }}>/100</span></div>
                </div>
                <div className="pc-card" style={{ padding: '24px' }}>
                    <p style={{ color: '#6B7280', fontSize: '14px', fontWeight: '600', margin: '0 0 8px 0' }}>Monitored Tenants</p>
                    <div style={{ fontSize: '36px', fontWeight: '800', color: '#111827' }}>{loading ? '-' : overviewStats.totalTenants}</div>
                </div>
            </div>

            <div className="pc-card" style={{ borderTop: '4px solid #1E3A8A' }}>
                <div className="pc-card-h">
                    <h2 style={{ fontSize: '18px', margin: 0 }}>Tenant Risk Registry</h2>
                </div>
                <div className="pc-card-b" style={{ padding: 0 }}>
                    {loading ? (
                        <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>Scanning network...</div>
                    ) : risks.length === 0 ? (
                        <div style={{ padding: '48px', textAlign: 'center', color: '#9CA3AF' }}>No risk data available.</div>
                    ) : (
                        <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left', fontSize: '14px' }}>
                            <thead style={{ backgroundColor: '#F9FAFB', borderBottom: '1px solid #E5E7EB' }}>
                                <tr>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563' }}>Tenant</th>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563' }}>Volume</th>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563' }}>Risk Score</th>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563' }}>Status</th>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563', width: '30%' }}>Detected Anomalies</th>
                                    <th style={{ padding: '16px', fontWeight: '600', color: '#4B5563', textAlign: 'right' }}>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {risks.map((t) => (
                                    <tr key={t.tenantId} style={{ borderBottom: '1px solid #F3F4F6' }}>
                                        <td style={{ padding: '16px', fontWeight: '600' }}>
                                            {t.name}
                                            <div style={{ fontSize: '12px', color: '#6B7280', fontWeight: '400' }}>/{t.slug}</div>
                                        </td>
                                        <td style={{ padding: '16px' }}>
                                            <div style={{ display: 'flex', gap: '12px', color: '#4B5563', fontSize: '12px' }}>
                                                <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>👥 {t.userCount}</div>
                                                <div style={{ display: 'flex', alignItems: 'center', gap: '4px' }}>📈 {t.visitCount}</div>
                                            </div>
                                        </td>
                                        <td style={{ padding: '16px' }}>
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                                <span style={{ fontWeight: '700', fontSize: '16px', color: t.riskScore >= 70 ? '#DC2626' : t.riskScore >= 40 ? '#D97706' : '#10B981' }}>
                                                    {t.riskScore}
                                                </span>
                                            </div>
                                        </td>
                                        <td style={{ padding: '16px' }}>{getRiskBadge(t.riskLevel)}</td>
                                        <td style={{ padding: '16px' }}>
                                            <div style={{ display: 'flex', flexDirection: 'column', gap: '6px' }}>
                                                {t.riskFactors.map((f, i) => (
                                                    <span key={i} style={{ fontSize: '12px', color: '#4B5563', backgroundColor: '#F3F4F6', padding: '4px 8px', borderRadius: '4px', width: 'fit-content', border: '1px solid #E5E7EB' }}>
                                                        {f}
                                                    </span>
                                                ))}
                                                {t.riskFactors.length === 0 && <span style={{ fontSize: '12px', color: '#9CA3AF', fontStyle: 'italic' }}>System operating nominally</span>}
                                            </div>
                                        </td>
                                        <td style={{ padding: '16px', textAlign: 'right' }}>
                                            <button style={{
                                                padding: '6px 12px',
                                                backgroundColor: '#EFF6FF',
                                                color: '#2563EB',
                                                border: '1px solid #BFDBFE',
                                                borderRadius: '6px',
                                                fontSize: '13px',
                                                fontWeight: '600',
                                                cursor: 'pointer',
                                                display: 'inline-flex',
                                                alignItems: 'center',
                                                gap: '6px'
                                            }}>
                                                👁️ Inspect
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    )}
                </div>
            </div>
        </div>
    );
}
