// ================================================================
// PAGE IDENTITY: L15 · Performance Reviews
// Type: List | Owner: manager
// Models: PerformanceReview
// ================================================================
import React, { useState } from 'react';

const reviews = [
    { id: 'pr-001', psw: 'Priya Sharma', period: 'Q1 2026', overall: 4.8, scores: { quality: 5.0, punctuality: 4.9, communication: 4.7, documentation: 4.5, clientFeedback: 5.0 }, status: 'completed', reviewer: 'Sarah Manager', date: 'Mar 12' },
    { id: 'pr-002', psw: 'David Chen', period: 'Q1 2026', overall: 4.5, scores: { quality: 4.6, punctuality: 4.8, communication: 4.3, documentation: 4.2, clientFeedback: 4.6 }, status: 'completed', reviewer: 'Sarah Manager', date: 'Mar 11' },
    { id: 'pr-003', psw: 'Maria Santos', period: 'Q1 2026', overall: 4.2, scores: { quality: 4.5, punctuality: 4.0, communication: 4.3, documentation: 3.8, clientFeedback: 4.5 }, status: 'pending-review', reviewer: 'Tom Supervisor', date: 'Mar 15' },
    { id: 'pr-004', psw: 'James Wright', period: 'Q1 2026', overall: 3.6, scores: { quality: 3.8, punctuality: 3.2, communication: 3.5, documentation: 3.4, clientFeedback: 4.0 }, status: 'needs-improvement', reviewer: 'Sarah Manager', date: 'Mar 14' },
    { id: 'pr-005', psw: 'Kevin O\'Brien', period: 'Q1 2026', overall: 0, scores: { quality: 0, punctuality: 0, communication: 0, documentation: 0, clientFeedback: 0 }, status: 'not-started', reviewer: 'Tom Supervisor', date: '—' },
];

const scoreColor = (s: number) => s >= 4.5 ? 'var(--pc-success)' : s >= 3.5 ? 'var(--pc-warning)' : s > 0 ? 'var(--pc-error)' : 'var(--pc-text-tertiary)';
const statusLabel = (s: string) => ({ completed: '✅ Completed', 'pending-review': '⏳ Pending Review', 'needs-improvement': '⚠️ Needs Improvement', 'not-started': '📝 Not Started' }[s] || s);
const statusColor = (s: string) => ({ completed: 'var(--pc-success)', 'pending-review': 'var(--pc-warning)', 'needs-improvement': 'var(--pc-error)', 'not-started': 'var(--pc-text-tertiary)' }[s] || 'var(--pc-text-secondary)');

export default function PerformanceReviews() {
    const [selected, setSelected] = useState<string | null>(null);
    const selectedReview = reviews.find(r => r.id === selected);

    return (
        <div data-cy="page.container" role="main" aria-label="Performance Reviews" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>📊 Performance Reviews</h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>Q1 2026 — PSW performance evaluations</p>
                </div>
                <button style={{ padding: '10px 24px', borderRadius: '10px', border: 'none', background: 'var(--pc-primary)', color: 'white', fontWeight: 700, cursor: 'pointer' }}>➕ New Review Cycle</button>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Total Reviews', value: '5', color: 'var(--pc-primary)' },
                    { label: 'Completed', value: '2', color: 'var(--pc-success)' },
                    { label: 'Pending', value: '1', color: 'var(--pc-warning)' },
                    { label: 'Avg Score', value: '4.3', color: 'var(--pc-success)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 140px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.6rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            <div style={{ display: 'flex', gap: '24px', flexWrap: 'wrap' }}>
                {/* List */}
                <div style={{ flex: '1 1 400px' }}>
                    {reviews.map(r => (
                        <div key={r.id} onClick={() => setSelected(r.id === selected ? null : r.id)}
                            style={{
                                padding: '16px 20px', marginBottom: '8px', borderRadius: '14px', cursor: 'pointer',
                                background: selected === r.id ? 'var(--pc-bg-secondary)' : 'var(--pc-surface-card)',
                                border: `1px solid ${selected === r.id ? 'var(--pc-primary)' : 'var(--pc-border-primary)'}`,
                                transition: 'all 0.15s',
                            }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                <div>
                                    <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>{r.psw}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '2px' }}>
                                        Reviewer: {r.reviewer} • {r.date}
                                    </div>
                                </div>
                                <div style={{ textAlign: 'right' }}>
                                    <div style={{ fontSize: '1.5rem', fontWeight: 800, color: scoreColor(r.overall) }}>
                                        {r.overall > 0 ? r.overall.toFixed(1) : '—'}
                                    </div>
                                    <span style={{ fontSize: '0.6rem', fontWeight: 700, color: statusColor(r.status) }}>
                                        {statusLabel(r.status)}
                                    </span>
                                </div>
                            </div>
                        </div>
                    ))}
                </div>

                {/* Detail Panel */}
                {selectedReview && selectedReview.overall > 0 && (
                    <div style={{ flex: '0 0 340px', padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', alignSelf: 'flex-start' }}>
                        <h3 style={{ margin: '0 0 4px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>{selectedReview.psw}</h3>
                        <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.8rem', margin: '0 0 20px' }}>{selectedReview.period}</p>

                        <div style={{ textAlign: 'center', marginBottom: '24px' }}>
                            <svg width="120" height="120" viewBox="0 0 120 120">
                                <circle cx="60" cy="60" r="50" fill="none" stroke="var(--pc-bg-secondary)" strokeWidth="8" />
                                <circle cx="60" cy="60" r="50" fill="none" stroke={scoreColor(selectedReview.overall)} strokeWidth="8"
                                    strokeDasharray={`${(selectedReview.overall / 5) * 314} 314`}
                                    strokeLinecap="round" transform="rotate(-90 60 60)"
                                    style={{ transition: 'stroke-dasharray 0.8s ease' }} />
                                <text x="60" y="55" textAnchor="middle" style={{ fontSize: '24px', fontWeight: 900, fill: scoreColor(selectedReview.overall) }}>
                                    {selectedReview.overall.toFixed(1)}
                                </text>
                                <text x="60" y="75" textAnchor="middle" style={{ fontSize: '10px', fill: 'var(--pc-text-tertiary)' }}>out of 5.0</text>
                            </svg>
                        </div>

                        {Object.entries(selectedReview.scores).map(([key, val]) => (
                            <div key={key} style={{ marginBottom: '12px' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.75rem', marginBottom: '4px' }}>
                                    <span style={{ fontWeight: 600, color: 'var(--pc-text-secondary)', textTransform: 'capitalize' }}>{key.replace(/([A-Z])/g, ' $1')}</span>
                                    <span style={{ fontWeight: 800, color: scoreColor(val) }}>{val.toFixed(1)}</span>
                                </div>
                                <div style={{ height: '6px', background: 'var(--pc-bg-secondary)', borderRadius: '3px', overflow: 'hidden' }}>
                                    <div style={{ width: `${(val / 5) * 100}%`, height: '100%', borderRadius: '3px', background: scoreColor(val), transition: 'width 0.5s ease' }} />
                                </div>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </div>
    );
}
