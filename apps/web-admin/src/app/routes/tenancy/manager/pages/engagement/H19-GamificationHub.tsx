// ================================================================
// PAGE IDENTITY: H19 · Gamification Hub — PSW Engagement & Retention
// Type: Hub | Owner: manager
// Models: GamificationProfile
// Feature Flag: gamification
// ================================================================
import React, { useState } from 'react';

const mockLeaderboard = [
    { rank: 1, name: 'Priya Sharma', badge: '🏆', points: 2847, streak: 45, visits: 312, level: 'Diamond' },
    { rank: 2, name: 'David Chen', badge: '🥈', points: 2610, streak: 38, visits: 289, level: 'Diamond' },
    { rank: 3, name: 'Maria Santos', badge: '🥉', points: 2455, streak: 30, visits: 275, level: 'Platinum' },
    { rank: 4, name: 'James Wright', badge: '⭐', points: 2180, streak: 22, visits: 256, level: 'Platinum' },
    { rank: 5, name: 'Aisha Patel', badge: '⭐', points: 2050, streak: 19, visits: 240, level: 'Gold' },
    { rank: 6, name: 'Kevin O\'Brien', badge: '⭐', points: 1890, streak: 15, visits: 228, level: 'Gold' },
    { rank: 7, name: 'Sarah Kim', badge: '⭐', points: 1750, streak: 12, visits: 210, level: 'Silver' },
    { rank: 8, name: 'Tom Rodriguez', badge: '⭐', points: 1620, streak: 9, visits: 195, level: 'Silver' },
];

const badges = [
    { icon: '🏃', name: 'Visit Streak', desc: '30+ consecutive days with visits', unlockRate: '12%' },
    { icon: '⏰', name: 'Punctuality Pro', desc: '95%+ on-time check-ins', unlockRate: '28%' },
    { icon: '❤️', name: 'Client Favorite', desc: '5★ avg rating from 10+ clients', unlockRate: '18%' },
    { icon: '📚', name: 'Scholar', desc: 'Complete 10 training modules', unlockRate: '34%' },
    { icon: '🦸', name: 'First Responder', desc: 'Filed 3+ incident reports', unlockRate: '45%' },
    { icon: '🌙', name: 'Night Owl', desc: '50+ evening/overnight shifts', unlockRate: '22%' },
    { icon: '🗺️', name: 'Road Warrior', desc: '1000+ km traveled for visits', unlockRate: '15%' },
    { icon: '🤝', name: 'Team Player', desc: 'Cover 5+ shifts for colleagues', unlockRate: '20%' },
];

const challenges = [
    { name: 'March Madness', desc: 'Complete 20 visits this week', progress: 75, reward: '50 pts', deadline: '3 days' },
    { name: 'Zero No-Shows', desc: 'Perfect attendance for 2 weeks', progress: 85, reward: '100 pts', deadline: '4 days' },
    { name: 'Documentation Star', desc: 'Submit all visit notes within 1hr', progress: 60, reward: '30 pts', deadline: '5 days' },
];

export default function GamificationHub() {
    const [activeTab, setActiveTab] = useState<'leaderboard' | 'badges' | 'challenges' | 'rewards'>('leaderboard');

    const tabs = [
        { id: 'leaderboard' as const, label: '🏆 Leaderboard', count: mockLeaderboard.length },
        { id: 'badges' as const, label: '🎖️ Badges', count: badges.length },
        { id: 'challenges' as const, label: '🎯 Challenges', count: challenges.length },
        { id: 'rewards' as const, label: '🎁 Rewards', count: null },
    ];

    const levelColor = (level: string) => {
        const colors: Record<string, string> = {
            Diamond: '#7C3AED', Platinum: '#6366F1', Gold: '#F59E0B', Silver: '#94A3B8', Bronze: '#B45309',
        };
        return colors[level] || 'var(--pc-text-secondary)';
    };

    return (
        <div data-cy="page.container" role="main" aria-label="Gamification Hub" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>
                        🎮 Gamification Hub
                    </h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>
                        PSW engagement, achievements, streaks & rewards
                    </p>
                </div>
            </div>

            {/* Stats Bar */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Active PSWs', value: '48', icon: '👥', color: 'var(--pc-primary)' },
                    { label: 'Avg Score', value: '2,050', icon: '📊', color: 'var(--pc-success)' },
                    { label: 'Badges Issued', value: '156', icon: '🎖️', color: 'var(--pc-warning)' },
                    { label: 'Active Challenges', value: '3', icon: '🎯', color: '#7C3AED' },
                    { label: 'Retention Rate', value: '94%', icon: '💎', color: 'var(--pc-info, #2563EB)' },
                ].map((s, i) => (
                    <div key={i} style={{
                        flex: '1 1 160px', padding: '20px', borderRadius: '14px',
                        background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                    }}>
                        <div style={{ fontSize: '0.7rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '6px' }}>
                            {s.icon} {s.label}
                        </div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {tabs.map(tab => (
                    <button key={tab.id} onClick={() => setActiveTab(tab.id)} data-cy={`tab-gam-${tab.id}`}
                        style={{
                            padding: '10px 20px', borderRadius: '10px', border: 'none',
                            background: activeTab === tab.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                            color: activeTab === tab.id ? 'white' : 'var(--pc-text-secondary)',
                            fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                        }}>
                        {tab.label} {tab.count != null && <span style={{ marginLeft: '4px', opacity: 0.7 }}>({tab.count})</span>}
                    </button>
                ))}
            </div>

            {/* Leaderboard */}
            {activeTab === 'leaderboard' && (
                <div style={{ borderRadius: '14px', border: '1px solid var(--pc-border-primary)', overflow: 'hidden' }}>
                    <table style={{ width: '100%', borderCollapse: 'collapse' }}>
                        <thead>
                            <tr>
                                {['Rank', 'PSW', 'Level', 'Points', 'Streak', 'Visits'].map(h => (
                                    <th key={h} style={{
                                        padding: '12px 16px', textAlign: h === 'Rank' ? 'center' : 'left',
                                        background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                        fontSize: '0.7rem', fontWeight: 700, textTransform: 'uppercase',
                                        borderBottom: '2px solid var(--pc-border-primary)',
                                    }}>{h}</th>
                                ))}
                            </tr>
                        </thead>
                        <tbody>
                            {mockLeaderboard.map((p) => (
                                <tr key={p.rank}
                                    onMouseEnter={e => e.currentTarget.style.background = 'var(--pc-bg-secondary)'}
                                    onMouseLeave={e => e.currentTarget.style.background = 'var(--pc-surface-card)'}
                                    style={{ background: 'var(--pc-surface-card)', cursor: 'pointer' }}>
                                    <td style={{ padding: '14px 16px', textAlign: 'center', fontSize: '1.2rem', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {p.badge}
                                    </td>
                                    <td style={{ padding: '14px 16px', fontWeight: 700, color: 'var(--pc-text-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {p.name}
                                    </td>
                                    <td style={{ padding: '14px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        <span style={{
                                            padding: '3px 10px', borderRadius: '10px', fontSize: '0.7rem', fontWeight: 700,
                                            color: levelColor(p.level), background: `${levelColor(p.level)}15`,
                                        }}>{p.level}</span>
                                    </td>
                                    <td style={{ padding: '14px 16px', fontWeight: 800, color: 'var(--pc-primary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {p.points.toLocaleString()}
                                    </td>
                                    <td style={{ padding: '14px 16px', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        🔥 {p.streak} days
                                    </td>
                                    <td style={{ padding: '14px 16px', color: 'var(--pc-text-secondary)', borderBottom: '1px solid var(--pc-border-primary)' }}>
                                        {p.visits}
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {/* Badges */}
            {activeTab === 'badges' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(220px, 1fr))', gap: '16px' }}>
                    {badges.map((b, i) => (
                        <div key={i} style={{
                            padding: '24px', borderRadius: '14px', textAlign: 'center',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            transition: 'transform 0.2s, box-shadow 0.2s', cursor: 'pointer',
                        }}
                            onMouseEnter={e => { e.currentTarget.style.transform = 'translateY(-4px)'; e.currentTarget.style.boxShadow = '0 8px 30px rgba(0,0,0,0.12)'; }}
                            onMouseLeave={e => { e.currentTarget.style.transform = 'translateY(0)'; e.currentTarget.style.boxShadow = 'none'; }}>
                            <div style={{ fontSize: '2.5rem', marginBottom: '12px' }}>{b.icon}</div>
                            <div style={{ fontWeight: 700, fontSize: '0.95rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>{b.name}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '12px' }}>{b.desc}</div>
                            <div style={{ fontSize: '0.7rem', fontWeight: 700, color: 'var(--pc-success)' }}>{b.unlockRate} unlocked</div>
                        </div>
                    ))}
                </div>
            )}

            {/* Challenges */}
            {activeTab === 'challenges' && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '16px' }}>
                    {challenges.map((c, i) => (
                        <div key={i} style={{
                            padding: '24px', borderRadius: '14px',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                        }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '12px' }}>
                                <div>
                                    <div style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--pc-text-primary)' }}>🎯 {c.name}</div>
                                    <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)', marginTop: '2px' }}>{c.desc}</div>
                                </div>
                                <div style={{ textAlign: 'right' }}>
                                    <div style={{ fontSize: '0.75rem', fontWeight: 700, color: 'var(--pc-success)' }}>Reward: {c.reward}</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--pc-warning)' }}>⏰ {c.deadline} left</div>
                                </div>
                            </div>
                            <div style={{ height: '8px', background: 'var(--pc-bg-secondary)', borderRadius: '4px', overflow: 'hidden' }}>
                                <div style={{
                                    width: `${c.progress}%`, height: '100%', borderRadius: '4px',
                                    background: c.progress >= 75 ? 'var(--pc-success)' : 'var(--pc-primary)',
                                    transition: 'width 1s ease',
                                }} />
                            </div>
                            <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '6px' }}>
                                {c.progress}% complete
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Rewards */}
            {activeTab === 'rewards' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '16px' }}>
                    {[
                        { icon: '☕', name: 'Coffee Card', points: 500, desc: '$10 Tim Hortons gift card' },
                        { icon: '🎬', name: 'Movie Night', points: 1000, desc: '2x Cineplex movie tickets' },
                        { icon: '🛍️', name: 'Shopping Spree', points: 2000, desc: '$50 Amazon gift card' },
                        { icon: '✈️', name: 'PTO Day', points: 3000, desc: 'Extra paid time off day' },
                        { icon: '📱', name: 'Tech Upgrade', points: 5000, desc: 'New tablet or phone case' },
                        { icon: '🌟', name: 'Wall of Fame', points: 100, desc: 'Featured on company wall' },
                    ].map((r, i) => (
                        <div key={i} style={{
                            padding: '24px', borderRadius: '14px', textAlign: 'center',
                            background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                            transition: 'transform 0.2s', cursor: 'pointer',
                        }}
                            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-4px)'}
                            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                            <div style={{ fontSize: '2.5rem', marginBottom: '12px' }}>{r.icon}</div>
                            <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)', marginBottom: '4px' }}>{r.name}</div>
                            <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginBottom: '12px' }}>{r.desc}</div>
                            <div style={{
                                display: 'inline-block', padding: '4px 14px', borderRadius: '10px',
                                background: 'rgba(124,58,237,0.1)', color: '#7C3AED', fontWeight: 700, fontSize: '0.8rem',
                            }}>🎯 {r.points.toLocaleString()} pts</div>
                        </div>
                    ))}
                </div>
            )}
        </div>
    );
}
