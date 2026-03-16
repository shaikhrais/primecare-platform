// ================================================================
// PAGE IDENTITY: H24 · Training Academy — Staff Development
// Type: Hub | Owner: manager
// Models: TrainingModule, Certificate
// ================================================================
import React, { useState } from 'react';

const courses = [
    { id: 'c-001', name: 'Fall Prevention & Response', category: 'Safety', duration: '45 min', enrolled: 42, completed: 38, rating: 4.8, mandatory: true, status: 'active' },
    { id: 'c-002', name: 'HIPAA Compliance 2026', category: 'Compliance', duration: '30 min', enrolled: 48, completed: 48, rating: 4.2, mandatory: true, status: 'active' },
    { id: 'c-003', name: 'Dementia Care Best Practices', category: 'Clinical', duration: '60 min', enrolled: 35, completed: 28, rating: 4.9, mandatory: false, status: 'active' },
    { id: 'c-004', name: 'Medication Administration', category: 'Clinical', duration: '90 min', enrolled: 40, completed: 32, rating: 4.7, mandatory: true, status: 'active' },
    { id: 'c-005', name: 'Cultural Sensitivity Training', category: 'Professional', duration: '30 min', enrolled: 30, completed: 25, rating: 4.5, mandatory: false, status: 'active' },
    { id: 'c-006', name: 'PrimeCare App Training', category: 'Technical', duration: '20 min', enrolled: 48, completed: 45, rating: 4.3, mandatory: true, status: 'active' },
    { id: 'c-007', name: 'Infection Control & PPE', category: 'Safety', duration: '40 min', enrolled: 44, completed: 40, rating: 4.6, mandatory: true, status: 'active' },
    { id: 'c-008', name: 'Mental Health First Aid', category: 'Professional', duration: '120 min', enrolled: 0, completed: 0, rating: 0, mandatory: false, status: 'draft' },
];

const certifications = [
    { psw: 'Priya Sharma', certs: ['Fall Prevention', 'HIPAA', 'Medication Admin', 'Infection Control', 'App Training'], expiring: 0 },
    { psw: 'David Chen', certs: ['Fall Prevention', 'HIPAA', 'Infection Control', 'App Training'], expiring: 1 },
    { psw: 'Maria Santos', certs: ['HIPAA', 'Medication Admin', 'App Training'], expiring: 0 },
    { psw: 'James Wright', certs: ['HIPAA', 'App Training'], expiring: 2 },
];

export default function TrainingAcademy() {
    const [tab, setTab] = useState<'courses' | 'progress' | 'certs'>('courses');
    const catColor = (c: string) => ({ Safety: 'var(--pc-error)', Compliance: 'var(--pc-warning)', Clinical: 'var(--pc-success)', Professional: '#7C3AED', Technical: 'var(--pc-info, #2563EB)' }[c] || 'var(--pc-text-secondary)');

    return (
        <div data-cy="page.container" role="main" aria-label="Training Academy" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>🎓 Training Academy</h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>Courses, certifications & staff development tracking</p>
                </div>
                <button style={{ padding: '10px 24px', borderRadius: '10px', border: 'none', background: 'var(--pc-primary)', color: 'white', fontWeight: 700, cursor: 'pointer' }}>➕ New Course</button>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Active Courses', value: '7', color: 'var(--pc-primary)' },
                    { label: 'Total Enrollments', value: '287', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Completion Rate', value: '86%', color: 'var(--pc-success)' },
                    { label: 'Expiring Certs', value: '3', color: 'var(--pc-warning)' },
                    { label: 'Avg Rating', value: '4.6 ⭐', color: 'var(--pc-success)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 140px', padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.5rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[{ id: 'courses' as const, l: '📚 Courses' }, { id: 'progress' as const, l: '📊 Progress' }, { id: 'certs' as const, l: '🏆 Certifications' }].map(t => (
                    <button key={t.id} onClick={() => setTab(t.id)} style={{
                        padding: '10px 20px', borderRadius: '10px', border: 'none',
                        background: tab === t.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                        color: tab === t.id ? 'white' : 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                    }}>{t.l}</button>
                ))}
            </div>

            {/* Courses */}
            {tab === 'courses' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                    {courses.filter(c => c.status === 'active').map(c => {
                        const pct = c.enrolled > 0 ? Math.round((c.completed / c.enrolled) * 100) : 0;
                        return (
                            <div key={c.id} style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', cursor: 'pointer', transition: 'transform 0.2s' }}
                                onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                                onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
                                    <span style={{ padding: '3px 10px', borderRadius: '8px', fontSize: '0.65rem', fontWeight: 700, color: catColor(c.category), background: `${catColor(c.category)}15` }}>{c.category}</span>
                                    {c.mandatory && <span style={{ fontSize: '0.6rem', fontWeight: 700, color: 'var(--pc-error)' }}>MANDATORY</span>}
                                </div>
                                <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)', marginBottom: '4px' }}>{c.name}</div>
                                <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '12px' }}>⏱️ {c.duration} • ⭐ {c.rating}</div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', fontSize: '0.7rem', marginBottom: '6px' }}>
                                    <span style={{ color: 'var(--pc-text-secondary)' }}>{c.completed}/{c.enrolled} completed</span>
                                    <span style={{ fontWeight: 700, color: pct >= 90 ? 'var(--pc-success)' : 'var(--pc-warning)' }}>{pct}%</span>
                                </div>
                                <div style={{ height: '4px', background: 'var(--pc-bg-secondary)', borderRadius: '2px', overflow: 'hidden' }}>
                                    <div style={{ width: `${pct}%`, height: '100%', borderRadius: '2px', background: pct >= 90 ? 'var(--pc-success)' : 'var(--pc-warning)' }} />
                                </div>
                            </div>
                        );
                    })}
                </div>
            )}

            {/* Progress */}
            {tab === 'progress' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead><tr>{['Course', 'Category', 'Enrolled', 'Completed', '%', 'Rating'].map(h => (
                            <th key={h} style={{ padding: '12px 16px', textAlign: h === 'Course' ? 'left' : 'center', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase', borderBottom: '2px solid var(--pc-border-primary)' }}>{h}</th>
                        ))}</tr></thead>
                        <tbody>{courses.filter(c => c.status === 'active').map(c => {
                            const pct = Math.round((c.completed / c.enrolled) * 100);
                            return (
                                <tr key={c.id} style={{ background: 'var(--pc-surface-card)' }}>
                                    <td style={{ padding: '12px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{c.name}</td>
                                    <td style={{ padding: '12px 16px', textAlign: 'center', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        <span style={{ padding: '2px 8px', borderRadius: '8px', fontSize: '0.6rem', fontWeight: 700, color: catColor(c.category), background: `${catColor(c.category)}15` }}>{c.category}</span>
                                    </td>
                                    <td style={{ padding: '12px 16px', textAlign: 'center', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>{c.enrolled}</td>
                                    <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 700, color: 'var(--pc-success)', borderBottom: '1px solid var(--pc-border-primary)' }}>{c.completed}</td>
                                    <td style={{ padding: '12px 16px', textAlign: 'center', fontWeight: 800, color: pct >= 90 ? 'var(--pc-success)' : 'var(--pc-warning)', borderBottom: '1px solid var(--pc-border-primary)' }}>{pct}%</td>
                                    <td style={{ padding: '12px 16px', textAlign: 'center', color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>⭐ {c.rating}</td>
                                </tr>
                            );
                        })}</tbody>
                    </table>
                </div>
            )}

            {/* Certs */}
            {tab === 'certs' && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {certifications.map((c, i) => (
                        <div key={i} style={{ padding: '18px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px' }}>
                                <span style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>👤 {c.psw}</span>
                                {c.expiring > 0 && <span style={{ padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700, color: 'var(--pc-warning)', background: 'rgba(245,158,11,0.1)' }}>⚠ {c.expiring} expiring</span>}
                            </div>
                            <div style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
                                {c.certs.map((cert, j) => (
                                    <span key={j} style={{ padding: '3px 10px', borderRadius: '8px', fontSize: '0.7rem', fontWeight: 600, background: 'rgba(5,150,105,0.1)', color: 'var(--pc-success)' }}>✅ {cert}</span>
                                ))}
                            </div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
