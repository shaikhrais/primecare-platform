// ================================================================
// PAGE IDENTITY: H22 · SMS Notification Hub
// Type: Hub | Owner: admin
// Feature Flag: sms-notifications
// Models: CommunicationLog
// ================================================================
import React, { useState } from 'react';

const campaigns = [
    { id: 'sms-001', name: 'Shift Reminder — Tomorrow', recipients: 24, sent: 24, delivered: 23, failed: 1, openRate: '96%', date: 'Today', status: 'completed' },
    { id: 'sms-002', name: 'Training Session Reminder', recipients: 48, sent: 48, delivered: 46, failed: 2, openRate: '94%', date: 'Yesterday', status: 'completed' },
    { id: 'sms-003', name: 'Weekly Schedule Update', recipients: 52, sent: 0, delivered: 0, failed: 0, openRate: '—', date: 'Scheduled: Mar 17', status: 'scheduled' },
    { id: 'sms-004', name: 'Emergency Weather Alert', recipients: 120, sent: 120, delivered: 118, failed: 2, openRate: '98%', date: 'Mar 10', status: 'completed' },
];

const templates = [
    { icon: '⏰', name: 'Shift Reminder', body: 'Hi {name}, reminder: you have a shift at {time} with {client}. Address: {address}', uses: 340 },
    { icon: '🚨', name: 'Emergency Alert', body: 'URGENT: {message}. Please acknowledge by replying YES.', uses: 12 },
    { icon: '📋', name: 'Schedule Change', body: 'Hi {name}, your schedule has been updated. New shift: {date} {time}. Check app for details.', uses: 89 },
    { icon: '🎓', name: 'Training Notice', body: 'Hi {name}, training "{course}" is on {date} at {location}. Please confirm attendance.', uses: 45 },
    { icon: '💳', name: 'Pay Stub Ready', body: 'Hi {name}, your pay stub for {period} is now available in the PrimeCare app.', uses: 156 },
    { icon: '🎉', name: 'Birthday Greeting', body: 'Happy Birthday {name}! 🎂 The PrimeCare team wishes you a wonderful day!', uses: 24 },
];

export default function SMSHub() {
    const [tab, setTab] = useState<'campaigns' | 'templates' | 'compose'>('campaigns');
    const statusColor = (s: string) => s === 'completed' ? 'var(--pc-success)' : s === 'scheduled' ? 'var(--pc-info, #2563EB)' : 'var(--pc-warning)';

    return (
        <div data-cy="page.container" role="main" aria-label="SMS Hub" style={{ padding: '24px', maxWidth: '1400px', margin: '0 auto' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '24px', flexWrap: 'wrap', gap: '16px' }}>
                <div>
                    <h1 data-cy="page.title" style={{ fontSize: '1.75rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: 0 }}>📱 SMS Notification Hub</h1>
                    <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.85rem', margin: '4px 0 0' }}>Campaigns, templates & delivery analytics</p>
                </div>
                <button style={{ padding: '10px 24px', borderRadius: '10px', border: 'none', background: 'var(--pc-primary)', color: 'white', fontWeight: 700, cursor: 'pointer' }}>✉️ New Campaign</button>
            </div>

            {/* Stats */}
            <div style={{ display: 'flex', gap: '16px', flexWrap: 'wrap', marginBottom: '24px' }}>
                {[
                    { label: 'Sent This Month', value: '192', color: 'var(--pc-primary)' },
                    { label: 'Delivery Rate', value: '97.4%', color: 'var(--pc-success)' },
                    { label: 'Credits Left', value: '1,808', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Open Rate', value: '96%', color: 'var(--pc-success)' },
                ].map((s, i) => (
                    <div key={i} style={{ flex: '1 1 160px', padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-text-tertiary)', textTransform: 'uppercase', marginBottom: '4px' }}>{s.label}</div>
                        <div style={{ fontSize: '1.8rem', fontWeight: 800, color: s.color }}>{s.value}</div>
                    </div>
                ))}
            </div>

            {/* Tabs */}
            <div style={{ display: 'flex', gap: '4px', marginBottom: '24px' }}>
                {[{ id: 'campaigns' as const, l: '📊 Campaigns' }, { id: 'templates' as const, l: '📝 Templates' }, { id: 'compose' as const, l: '✍️ Compose' }].map(t => (
                    <button key={t.id} onClick={() => setTab(t.id)} style={{
                        padding: '10px 20px', borderRadius: '10px', border: 'none',
                        background: tab === t.id ? 'var(--pc-primary)' : 'var(--pc-bg-secondary)',
                        color: tab === t.id ? 'white' : 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer',
                    }}>{t.l}</button>
                ))}
            </div>

            {/* Campaigns */}
            {tab === 'campaigns' && (
                <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                    {campaigns.map(c => (
                        <div key={c.id} style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '10px', flexWrap: 'wrap', gap: '8px' }}>
                                <div>
                                    <span style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>{c.name}</span>
                                    <span style={{ marginLeft: '8px', fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>{c.date}</span>
                                </div>
                                <span style={{ padding: '3px 10px', borderRadius: '10px', fontSize: '0.65rem', fontWeight: 700, color: statusColor(c.status), background: `${statusColor(c.status)}15` }}>{c.status.toUpperCase()}</span>
                            </div>
                            <div style={{ display: 'flex', gap: '20px', flexWrap: 'wrap', fontSize: '0.8rem' }}>
                                <span style={{ color: 'var(--pc-text-secondary)' }}>👥 {c.recipients} recipients</span>
                                <span style={{ color: 'var(--pc-success)' }}>✅ {c.delivered} delivered</span>
                                {c.failed > 0 && <span style={{ color: 'var(--pc-error)' }}>❌ {c.failed} failed</span>}
                                <span style={{ color: 'var(--pc-info, #2563EB)' }}>👁️ {c.openRate} open rate</span>
                            </div>
                        </div>
                    ))}
                </div>
            )}

            {/* Templates */}
            {tab === 'templates' && (
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))', gap: '16px' }}>
                    {templates.map((t, i) => (
                        <div key={i} style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', cursor: 'pointer', transition: 'transform 0.2s' }}
                            onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                            onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '10px' }}>
                                <span style={{ fontSize: '1.5rem' }}>{t.icon}</span>
                                <span style={{ fontWeight: 700, color: 'var(--pc-text-primary)' }}>{t.name}</span>
                            </div>
                            <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-secondary)', lineHeight: 1.6, marginBottom: '10px', fontStyle: 'italic' }}>"{t.body}"</div>
                            <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)' }}>Used {t.uses} times</div>
                        </div>
                    ))}
                </div>
            )}

            {/* Compose */}
            {tab === 'compose' && (
                <div style={{ maxWidth: '600px', padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                    <h3 style={{ margin: '0 0 16px', fontWeight: 700, color: 'var(--pc-text-primary)' }}>✍️ Compose New SMS</h3>
                    <div style={{ marginBottom: '16px' }}>
                        <label style={{ display: 'block', fontSize: '0.75rem', fontWeight: 700, color: 'var(--pc-text-secondary)', marginBottom: '6px' }}>Recipients</label>
                        <select style={{ width: '100%', padding: '10px 12px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontSize: '0.85rem' }}>
                            <option>All PSWs (48)</option>
                            <option>Morning Shift (22)</option>
                            <option>Evening Shift (18)</option>
                            <option>All Clients (67)</option>
                            <option>Custom Selection...</option>
                        </select>
                    </div>
                    <div style={{ marginBottom: '16px' }}>
                        <label style={{ display: 'block', fontSize: '0.75rem', fontWeight: 700, color: 'var(--pc-text-secondary)', marginBottom: '6px' }}>Message</label>
                        <textarea rows={4} placeholder="Type your message here..." style={{ width: '100%', padding: '10px 12px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)', background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-primary)', fontSize: '0.85rem', resize: 'vertical', fontFamily: 'inherit' }} />
                        <div style={{ fontSize: '0.7rem', color: 'var(--pc-text-tertiary)', marginTop: '4px' }}>0/160 characters • 1 SMS credit</div>
                    </div>
                    <div style={{ display: 'flex', gap: '8px' }}>
                        <button style={{ padding: '10px 24px', borderRadius: '10px', border: 'none', background: 'var(--pc-primary)', color: 'white', fontWeight: 700, cursor: 'pointer' }}>📱 Send Now</button>
                        <button style={{ padding: '10px 24px', borderRadius: '10px', border: '1px solid var(--pc-border-primary)', background: 'transparent', color: 'var(--pc-text-secondary)', fontWeight: 700, cursor: 'pointer' }}>⏰ Schedule</button>
                    </div>
                </div>
            )}
        </div>
    );
}
