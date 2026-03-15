// ================================================================
// PAGE IDENTITY: H16 — Supervision Hub
// Type: Hub | Owner: rn
// ================================================================
import React from 'react';
import { AdminRegistry } from 'prime-care-shared';
import { useRegistryQuery } from '@/shared/hooks/useRegistryQuery';
import './SupervisionHub.css';

const { ContentRegistry, ApiRegistry } = AdminRegistry;

interface Caregiver {
    id: string;
    fullName: string;
    role: string;
    stats?: {
        visitsCount: number;
        qualityScore: number;
    };
    complianceStatus: string;
    riskLevel: string;
}

export const SupervisionHub: React.FC = () => {
    // TanStack Query: auto-cached supervision roster
    const { data: providers = [], isLoading: loading } = useRegistryQuery<Caregiver[]>(ApiRegistry.TENANCY.RN.SUPERVISION_ROSTER, {
        queryKey: ['rn', 'supervision', 'roster'],
        staleTime: 30_000,
    });

    const getInitials = (name: string) => name.split(' ').map(n => n[0]).join('').toUpperCase();

    if (loading) {
        return (
            <div data-cy="page.container" role="main" aria-label="Supervision Hub" className="supervision-loading">
                <p>Synchronizing Clinical Oversight...</p>
            </div>
        );
    }

    return (
        <div className="supervision-container" data-cy="supervision-hub">
            <header className="assess-header">
                <h1 data-cy="page-title">{ContentRegistry.RN_SUPERVISION.TITLE}</h1>
                <p data-cy="page-subtitle">{ContentRegistry.RN_SUPERVISION.SUBTITLE}</p>
            </header>

            <div className="bento-grid">
                <div className="bento-item">
                    <span className="pill mobility">Performance</span>
                    <h3 data-cy="h3-rn.supervision-hub-0" className="assess-card-title">Avg Quality Score</h3>
                    <div className="score-badge" style={{ fontSize: '2.5rem', marginTop: '0.5rem' }}>92%</div>
                    <p className="assess-card-desc">Branch average across 24 supervised caregivers.</p>
                </div>

                <div className="bento-item">
                    <span className="pill vital">Compliance</span>
                    <h3 data-cy="h3-rn.supervision-hub-1" className="assess-card-title">Certs at Risk</h3>
                    <div className="score-badge" style={{ fontSize: '2.5rem', marginTop: '0.5rem', color: '#ff9800' }}>3</div>
                    <p className="assess-card-desc">Providers with expiring clinical certifications.</p>
                </div>

                <div className="bento-item">
                    <span className="pill adl">Operational</span>
                    <h3 data-cy="h3-rn.supervision-hub-2" className="assess-card-title">Pending Audits</h3>
                    <div className="score-badge" style={{ fontSize: '2.5rem', marginTop: '0.5rem' }}>8</div>
                    <p className="assess-card-desc">Required field supervisions due this week.</p>
                </div>
            </div>

            <section className="roster-card">
                <div className="roster-header">
                    <h2 data-cy="h2-rn.supervision-hub-0" style={{ fontSize: '1.2rem', fontWeight: 800 }}>{ContentRegistry.RN_SUPERVISION.TITLE}</h2>
                    <button data-cy="btn-rn.supervision-hub-0" className="btn btn-ghost" style={{ fontSize: '12px' }}>View All Providers</button>
                </div>

                <table className="roster-table" data-cy="caregiver-roster">
                    <thead>
                        <tr>
                            <th>Provider</th>
                            <th style={{ textAlign: 'center' }}>Visits (30d)</th>
                            <th style={{ textAlign: 'center' }}>Quality</th>
                            <th>Compliance</th>
                            <th>Risk</th>
                            <th style={{ textAlign: 'right' }}>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        {providers.length > 0 ? (
                            providers.map((p) => (
                                <tr key={p.id} data-cy={`provider-row-${p.id}`}>
                                    <td>
                                        <div className="provider-info">
                                            <div className="provider-avatar">{getInitials(p.fullName)}</div>
                                            <div style={{ fontWeight: 700 }}>{p.fullName}</div>
                                        </div>
                                    </td>
                                    <td style={{ textAlign: 'center' }}>{p.stats?.visitsCount || 0}</td>
                                    <td style={{ textAlign: 'center' }}>
                                        <div className="score-badge">{p.stats?.qualityScore || 0}%</div>
                                    </td>
                                    <td>
                                        <span className={`pill ${p.complianceStatus === 'Compliant' ? 'adl' : 'vital'}`}>
                                            {p.complianceStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <span className={`risk-label ${p.riskLevel?.toLowerCase() || 'low'}`}>
                                            {p.riskLevel || 'Low'}
                                        </span>
                                    </td>
                                    <td style={{ textAlign: 'right' }}>
                                        <button className="btn-premium" style={{ padding: '8px 16px', fontSize: '12px' }} data-cy={`btn-supervise-${p.id}`}>
                                            {ContentRegistry.RN_SUPERVISION.LOG_TITLE ? 'Supervise' : 'Action'}
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan={6} style={{ textAlign: 'center', padding: '60px', color: 'var(--text-400)' }}>
                                    No caregivers assigned for clinical supervision.
                                </td>
                            </tr>
                        )}
                    </tbody>
                </table>
            </section>

            <section className="audit-stack">
                <h3 data-cy="h3-rn.supervision-hub-3" className="form-label" style={{ marginBottom: '1.5rem' }}>Required Field Audits</h3>
                <div className="audit-item" data-cy="audit-item-1">
                    <div className="provider-info">
                        <div className="provider-avatar" style={{ background: '#eee', color: '#666' }}>JD</div>
                        <div>
                            <div style={{ fontWeight: 700 }}>John Davis</div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--text-400)' }}>Complex wound care assessment</div>
                        </div>
                    </div>
                    <div className="next-review">Due in <b>2 days</b></div>
                </div>
            </section>
        </div>
    );
};

export default SupervisionHub;
