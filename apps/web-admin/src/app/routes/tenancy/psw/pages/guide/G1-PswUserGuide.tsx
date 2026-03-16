// ================================================================
// PAGE IDENTITY: G1 · PSW User Guide — In-App Help Center
// Type: Guide | Owner: psw
// Description: Comprehensive user guide explaining how PSWs use PrimeCare
// ================================================================
import React, { useState } from 'react';

/* ──────────────────── GUIDE SECTIONS ──────────────────── */

const guideIndex = [
    { id: 'getting-started', icon: '🚀', title: 'Getting Started', desc: 'Login, setup, and first steps', sections: [
        'How to log in to PrimeCare',
        'Setting up your profile & photo',
        'Enabling push notifications',
        'Understanding your dashboard',
    ]},
    { id: 'dashboard', icon: '🏠', title: 'Your Dashboard', desc: 'Stats, shifts, and daily overview', sections: [
        'Understanding your stats (visits, hours, earnings, streak)',
        'Today\'s shift cards — what each color means',
        'Digital ID badge — your portable credential',
        'Wellness pulse & burnout prevention',
    ]},
    { id: 'schedule', icon: '📅', title: 'Schedule & Shifts', desc: 'View, accept, and manage your shifts', sections: [
        'Viewing your weekly/monthly schedule',
        'Accepting open shifts',
        'Requesting time off & availability',
        'Shift swap with colleagues',
        'Understanding shift status colors',
    ]},
    { id: 'checkin', icon: '📍', title: 'Check-In & Check-Out (EVV)', desc: 'GPS verification and visit tracking', sections: [
        'How GPS check-in works',
        'What is EVV (Electronic Visit Verification)?',
        'Step-by-step: Checking in to a visit',
        'Step-by-step: Checking out of a visit',
        'What to do if GPS isn\'t working',
        'Photo verification requirements',
    ]},
    { id: 'visits', icon: '❤️', title: 'Managing Visits', desc: 'Client care, notes, and documentation', sections: [
        'Viewing visit details & care plan',
        'Recording visit notes',
        'Documenting tasks completed',
        'Uploading photos (wound care, etc.)',
        'Flagging incidents or concerns',
    ]},
    { id: 'earnings', icon: '💰', title: 'Earnings & Payouts', desc: 'Track pay, mileage, and expenses', sections: [
        'Understanding your earnings breakdown',
        'Pay period and payout schedule',
        'Mileage tracking & reimbursement',
        'Submitting expense claims',
        'Viewing payout history',
    ]},
    { id: 'credentials', icon: '📜', title: 'Credentials & Training', desc: 'Certifications, training, and compliance', sections: [
        'Your credential vault',
        'Uploading certifications (CPR, First Aid, etc.)',
        'Mandatory training modules',
        'Certificate expiry alerts',
        'Compliance requirements checklist',
    ]},
    { id: 'communication', icon: '💬', title: 'Communication', desc: 'Messages, alerts, and team updates', sections: [
        'Direct messages with your coordinator',
        'Reading dispatch notifications',
        'Emergency SOS alerts',
        'Peer kudos & recognition',
        'Provider social feed',
    ]},
    { id: 'offline', icon: '📱', title: 'Working Offline', desc: 'What to do when you have no internet', sections: [
        'How offline mode works',
        'Which features work offline',
        'Queued actions & automatic sync',
        'Checking your offline queue',
    ]},
    { id: 'troubleshooting', icon: '🔧', title: 'Troubleshooting', desc: 'Common issues and fixes', sections: [
        'Can\'t check in? — GPS troubleshooting',
        'App is slow or not loading',
        'Forgot password — reset steps',
        'Shift not showing up',
        'Earnings discrepancy — who to contact',
    ]},
];

/* ──────────────────── DETAIL CONTENT ──────────────────── */

const detailContent: Record<string, React.ReactNode> = {
    'getting-started': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>🚀 Getting Started with PrimeCare</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                Welcome to PrimeCare! As a Personal Support Worker (PSW), this platform is your daily companion for managing visits, tracking earnings, and staying connected with your team. Here's how to get set up.
            </p>

            <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '20px' }}>
                <h3 style={{ margin: '0 0 16px', color: 'var(--pc-text-primary)', fontWeight: 700 }}>Step 1: Log In</h3>
                <ol style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px' }}>
                    <li>Open <strong>PrimeCare</strong> in your browser or install the PWA from your home screen</li>
                    <li>Enter your <strong>email address</strong> provided by your coordinator</li>
                    <li>Enter your <strong>temporary password</strong> (sent to your email)</li>
                    <li>Click <strong>"Login to Dashboard"</strong></li>
                    <li>On first login, you'll be asked to <strong>set a new password</strong></li>
                    <li>Optionally enable <strong>Touch ID / Face ID</strong> for faster login</li>
                </ol>
            </div>

            <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '20px' }}>
                <h3 style={{ margin: '0 0 16px', color: 'var(--pc-text-primary)', fontWeight: 700 }}>Step 2: Set Up Your Profile</h3>
                <ol style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px' }}>
                    <li>Go to <strong>Profile → Edit Profile</strong></li>
                    <li>Upload a <strong>clear photo</strong> of yourself (used for your Digital ID Badge)</li>
                    <li>Verify your <strong>phone number</strong> and <strong>emergency contact</strong></li>
                    <li>Set your <strong>default availability</strong> (which days/times you can work)</li>
                    <li>Review your <strong>certifications</strong> — upload any missing ones</li>
                </ol>
            </div>

            <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '20px' }}>
                <h3 style={{ margin: '0 0 16px', color: 'var(--pc-text-primary)', fontWeight: 700 }}>Step 3: Enable Notifications</h3>
                <ol style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px' }}>
                    <li>When prompted, tap <strong>"Allow Notifications"</strong></li>
                    <li>This ensures you receive <strong>shift reminders</strong>, <strong>schedule changes</strong>, and <strong>emergency alerts</strong></li>
                    <li>You can adjust notification preferences in <strong>Settings → Notifications</strong></li>
                </ol>
            </div>

            <div style={{ padding: '16px', borderRadius: '10px', background: 'rgba(5,150,105,0.1)', border: '1px solid var(--pc-success)', marginBottom: '20px' }}>
                <p style={{ margin: 0, color: 'var(--pc-success)', fontWeight: 600, fontSize: '0.85rem' }}>
                    💡 Pro Tip: Install PrimeCare as a PWA (Progressive Web App) — tap "Add to Home Screen" in your browser for instant access, offline support, and push notifications!
                </p>
            </div>
        </div>
    ),

    'dashboard': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>🏠 Your Dashboard</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                Your dashboard is the first thing you see when you log in. It gives you a complete overview of your day at a glance.
            </p>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>📊 Stats Row</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                At the top, you'll see 4 key metrics:
            </p>
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(200px, 1fr))', gap: '12px', marginBottom: '24px' }}>
                {[
                    { icon: '📋', label: "Today's Visits", desc: 'Number of visits assigned to you today' },
                    { icon: '⏱️', label: 'Hours Worked', desc: 'Total hours clocked today via check-in/out' },
                    { icon: '💰', label: 'Earnings', desc: 'Estimated earnings for today' },
                    { icon: '🔥', label: 'Reliability Streak', desc: 'Consecutive days with perfect attendance' },
                ].map((s, i) => (
                    <div key={i} style={{ padding: '16px', borderRadius: '12px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <span style={{ fontSize: '1.5rem' }}>{s.icon}</span>
                        <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)', marginTop: '8px' }}>{s.label}</div>
                        <div style={{ fontSize: '0.75rem', color: 'var(--pc-text-tertiary)', marginTop: '4px' }}>{s.desc}</div>
                    </div>
                ))}
            </div>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>🎯 Shift Status Colors</h3>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', marginBottom: '24px' }}>
                {[
                    { color: 'var(--pc-success)', label: '🟢 Confirmed', desc: 'This visit is confirmed and ready. Arrive on time.' },
                    { color: 'var(--pc-info, #2563EB)', label: '🔵 In Progress', desc: 'You have already checked in. Visit is active.' },
                    { color: 'var(--pc-warning)', label: '🟡 Pending', desc: 'Awaiting coordinator confirmation. Do not travel yet.' },
                    { color: 'var(--pc-error)', label: '🔴 Urgent/Late', desc: 'You are late or this visit needs immediate attention.' },
                    { color: 'var(--pc-text-tertiary)', label: '⚪ Completed', desc: 'Visit finished. Notes submitted.' },
                ].map((s, i) => (
                    <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '12px', padding: '12px 16px', borderRadius: '10px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <span style={{ fontWeight: 700, color: s.color, minWidth: '120px' }}>{s.label}</span>
                        <span style={{ color: 'var(--pc-text-secondary)', fontSize: '0.85rem' }}>{s.desc}</span>
                    </div>
                ))}
            </div>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>🪪 Digital ID Badge</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                Your dashboard includes a <strong>Digital ID Badge</strong> that you can show to clients as proof of identity. It displays your name, photo, employee ID, certifications, and a QR code for verification. Tap the badge to expand it fullscreen.
            </p>
        </div>
    ),

    'checkin': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>📍 Check-In & Check-Out (EVV)</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                <strong>Electronic Visit Verification (EVV)</strong> is required by OHIP/government programs to verify that home care visits actually occurred. PrimeCare makes this easy with GPS-based check-in/check-out.
            </p>

            <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '20px' }}>
                <h3 style={{ margin: '0 0 16px', color: 'var(--pc-success)', fontWeight: 700 }}>✅ How to Check In</h3>
                <ol style={{ color: 'var(--pc-text-secondary)', lineHeight: 2.2, paddingLeft: '20px' }}>
                    <li>Open your <strong>Dashboard</strong> or <strong>Schedule</strong></li>
                    <li>Tap the <strong>visit card</strong> for your current client</li>
                    <li>Tap the <strong>green "Check In" button</strong></li>
                    <li>Allow <strong>location access</strong> when prompted</li>
                    <li>The system will verify your <strong>GPS location</strong> is within 100m of the client's address</li>
                    <li>Once verified, you'll see a ✅ <strong>"Checked In"</strong> confirmation</li>
                    <li>The visit timer starts automatically</li>
                </ol>
            </div>

            <div style={{ padding: '24px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', marginBottom: '20px' }}>
                <h3 style={{ margin: '0 0 16px', color: 'var(--pc-error)', fontWeight: 700 }}>🏁 How to Check Out</h3>
                <ol style={{ color: 'var(--pc-text-secondary)', lineHeight: 2.2, paddingLeft: '20px' }}>
                    <li>When you're finished, tap <strong>"Check Out"</strong> on the active visit</li>
                    <li>Complete the <strong>visit notes</strong> (what you did, client condition)</li>
                    <li>Mark <strong>tasks completed</strong> from the care plan checklist</li>
                    <li>Optionally upload <strong>photos</strong> if required (wound care, medication)</li>
                    <li>The system records your <strong>check-out GPS location</strong> and <strong>time</strong></li>
                    <li>Your <strong>hours and earnings</strong> are automatically calculated</li>
                </ol>
            </div>

            <div style={{ padding: '16px', borderRadius: '10px', background: 'rgba(239,68,68,0.1)', border: '1px solid var(--pc-error)', marginBottom: '20px' }}>
                <h4 style={{ margin: '0 0 8px', color: 'var(--pc-error)', fontWeight: 700, fontSize: '0.85rem' }}>⚠️ GPS Not Working?</h4>
                <ol style={{ margin: 0, color: 'var(--pc-text-secondary)', fontSize: '0.85rem', lineHeight: 1.8, paddingLeft: '20px' }}>
                    <li>Make sure <strong>Location Services</strong> are enabled on your device</li>
                    <li>Go outside or near a window for better GPS signal</li>
                    <li>Try toggling <strong>airplane mode</strong> on and off</li>
                    <li>If still not working, contact your <strong>coordinator</strong> — they can manually override</li>
                </ol>
            </div>
        </div>
    ),

    'earnings': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>💰 Earnings & Payouts</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                Track your earnings in real-time, view payout history, and submit expense claims.
            </p>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>📊 Earnings Breakdown</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                Your <strong>Earnings</strong> page at <code>/platform/psw/earnings</code> shows:
            </p>
            <ul style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px', marginBottom: '20px' }}>
                <li><strong>Today's Earnings</strong> — real-time calculation based on check-in/out</li>
                <li><strong>This Week</strong> — total for the current pay period</li>
                <li><strong>This Month</strong> — running monthly total</li>
                <li><strong>Overtime</strong> — hours above 44h/week (1.5x rate)</li>
                <li><strong>Mileage</strong> — km traveled × reimbursement rate</li>
                <li><strong>Bonuses</strong> — weekend premiums, holiday pay, referral bonuses</li>
            </ul>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>🚗 Mileage Tracking</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                PrimeCare automatically tracks your travel between clients using GPS. You can also manually log mileage at <code>/platform/psw/mileage</code>.
            </p>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>🧾 Expense Claims</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                Submit expense claims for parking, supplies, or other out-of-pocket costs at <code>/platform/psw/expenses</code>. Attach photo receipts and your coordinator will approve within 48 hours.
            </p>
        </div>
    ),

    'schedule': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>📅 Schedule & Shifts</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                Your schedule shows all assigned visits for the week. Open it at <code>/platform/psw/schedule</code>.
            </p>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>📋 Schedule Views</h3>
            <ul style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px', marginBottom: '20px' }}>
                <li><strong>Day View</strong> — detailed timeline of today's visits</li>
                <li><strong>Week View</strong> — 7-day grid with visit blocks</li>
                <li><strong>Month View</strong> — calendar overview</li>
            </ul>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>🙋 Open Shifts</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                Available extra shifts are shown at <code>/platform/psw/open-shifts</code>. You can browse, filter by area/time, and <strong>accept with one tap</strong>. Accepting an open shift earns you bonus gamification points!
            </p>

            <h3 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 12px' }}>📝 Availability</h3>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '16px' }}>
                Set your weekly availability at <code>/platform/psw/availability</code>. Block off times you can't work, and your coordinator will only assign visits during your available hours.
            </p>
        </div>
    ),

    'offline': (
        <div>
            <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 800, margin: '0 0 20px' }}>📱 Working Offline</h2>
            <p style={{ color: 'var(--pc-text-secondary)', lineHeight: 1.7, marginBottom: '24px' }}>
                PrimeCare works even when you don't have internet! Here's what works offline:
            </p>

            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(250px, 1fr))', gap: '12px', marginBottom: '24px' }}>
                {[
                    { icon: '✅', title: 'Works Offline', items: ['View schedule', 'Check in/out (queued)', 'Write visit notes', 'View client info (cached)', 'Submit incidents (queued)'] },
                    { icon: '⏳', title: 'Queued Until Online', items: ['GPS verification', 'Photo uploads', 'Expense submissions', 'Schedule changes', 'Real-time earnings'] },
                ].map((col, i) => (
                    <div key={i} style={{ padding: '20px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)' }}>
                        <div style={{ fontWeight: 700, color: 'var(--pc-text-primary)', marginBottom: '12px' }}>{col.icon} {col.title}</div>
                        <ul style={{ color: 'var(--pc-text-secondary)', lineHeight: 2, paddingLeft: '20px', margin: 0 }}>
                            {col.items.map((item, j) => <li key={j}>{item}</li>)}
                        </ul>
                    </div>
                ))}
            </div>

            <div style={{ padding: '16px', borderRadius: '10px', background: 'rgba(5,150,105,0.1)', border: '1px solid var(--pc-success)' }}>
                <p style={{ margin: 0, color: 'var(--pc-success)', fontWeight: 600, fontSize: '0.85rem' }}>
                    💡 When you go back online, all queued actions sync automatically. You'll see a blue "Syncing..." banner at the top of the screen.
                </p>
            </div>
        </div>
    ),
};

/* ──────────────────── NAV LINKS (Quick Reference) ──────────────────── */

const quickLinks = [
    { icon: '🏠', label: 'Dashboard', path: '/platform/psw' },
    { icon: '📅', label: 'Schedule', path: '/platform/psw/schedule' },
    { icon: '📍', label: 'Check-In', path: '/platform/psw/schedule' },
    { icon: '💰', label: 'Earnings', path: '/platform/psw/earnings' },
    { icon: '🚗', label: 'Mileage', path: '/platform/psw/mileage' },
    { icon: '🧾', label: 'Expenses', path: '/platform/psw/expenses' },
    { icon: '📜', label: 'Credentials', path: '/platform/psw/credentials' },
    { icon: '🙋', label: 'Open Shifts', path: '/platform/psw/open-shifts' },
    { icon: '📅', label: 'Availability', path: '/platform/psw/availability' },
    { icon: '🤝', label: 'Shift Handover', path: '/platform/psw/handover' },
    { icon: '💳', label: 'Payout History', path: '/platform/psw/payouts' },
    { icon: '📰', label: 'Social Feed', path: '/platform/psw/feed' },
];

/* ──────────────────── MAIN COMPONENT ──────────────────── */

export default function PswUserGuide() {
    const [activeSection, setActiveSection] = useState<string | null>(null);

    return (
        <div data-cy="page.container" role="main" aria-label="PSW User Guide" style={{ padding: '24px', maxWidth: '1200px', margin: '0 auto' }}>
            {/* Header */}
            <div style={{ textAlign: 'center', marginBottom: '32px' }}>
                <h1 data-cy="page.title" style={{ fontSize: '2rem', fontWeight: 800, color: 'var(--pc-text-primary)', margin: '0 0 8px' }}>
                    📖 PSW User Guide
                </h1>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.9rem', maxWidth: '600px', margin: '0 auto' }}>
                    Everything you need to know about using PrimeCare as a Personal Support Worker. 
                    Tap any section to learn more.
                </p>
            </div>

            {/* Quick Links */}
            {!activeSection && (
                <>
                    <h2 style={{ fontWeight: 700, color: 'var(--pc-text-primary)', margin: '0 0 16px', fontSize: '1.1rem' }}>🔗 Quick Links — App Navigation</h2>
                    <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(160px, 1fr))', gap: '10px', marginBottom: '32px' }}>
                        {quickLinks.map((link, i) => (
                            <a key={i} href={link.path} style={{
                                display: 'flex', alignItems: 'center', gap: '8px', padding: '12px 16px', borderRadius: '12px',
                                background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                                textDecoration: 'none', cursor: 'pointer', transition: 'transform 0.2s',
                            }}
                                onMouseEnter={e => e.currentTarget.style.transform = 'translateY(-2px)'}
                                onMouseLeave={e => e.currentTarget.style.transform = 'translateY(0)'}>
                                <span style={{ fontSize: '1.3rem' }}>{link.icon}</span>
                                <span style={{ fontWeight: 700, fontSize: '0.8rem', color: 'var(--pc-text-primary)' }}>{link.label}</span>
                            </a>
                        ))}
                    </div>
                </>
            )}

            {/* Back button when viewing a section */}
            {activeSection && (
                <button onClick={() => setActiveSection(null)} style={{
                    display: 'flex', alignItems: 'center', gap: '8px', padding: '8px 16px', borderRadius: '10px',
                    border: '1px solid var(--pc-border-primary)', background: 'var(--pc-bg-secondary)',
                    color: 'var(--pc-text-secondary)', fontWeight: 700, fontSize: '0.85rem', cursor: 'pointer', marginBottom: '24px',
                }}>
                    ← Back to Guide Index
                </button>
            )}

            {/* Guide Index */}
            {!activeSection && (
                <>
                    <h2 style={{ fontWeight: 700, color: 'var(--pc-text-primary)', margin: '0 0 16px', fontSize: '1.1rem' }}>📚 User Guide Sections</h2>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '12px' }}>
                        {guideIndex.map((section) => (
                            <div key={section.id} onClick={() => setActiveSection(section.id)}
                                style={{
                                    padding: '20px', borderRadius: '14px',
                                    background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)',
                                    cursor: 'pointer', transition: 'all 0.2s',
                                }}
                                onMouseEnter={e => { e.currentTarget.style.transform = 'translateX(4px)'; e.currentTarget.style.borderColor = 'var(--pc-primary)'; }}
                                onMouseLeave={e => { e.currentTarget.style.transform = 'translateX(0)'; e.currentTarget.style.borderColor = 'var(--pc-border-primary)'; }}>
                                <div style={{ display: 'flex', gap: '16px', alignItems: 'flex-start' }}>
                                    <span style={{ fontSize: '2rem', lineHeight: 1 }}>{section.icon}</span>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ fontWeight: 700, fontSize: '1rem', color: 'var(--pc-text-primary)', marginBottom: '4px' }}>
                                            {section.title}
                                        </div>
                                        <div style={{ fontSize: '0.8rem', color: 'var(--pc-text-tertiary)', marginBottom: '10px' }}>
                                            {section.desc}
                                        </div>
                                        <div style={{ display: 'flex', gap: '6px', flexWrap: 'wrap' }}>
                                            {section.sections.slice(0, 3).map((sub, j) => (
                                                <span key={j} style={{
                                                    padding: '2px 8px', borderRadius: '6px', fontSize: '0.65rem', fontWeight: 600,
                                                    background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-tertiary)',
                                                }}>{sub}</span>
                                            ))}
                                            {section.sections.length > 3 && (
                                                <span style={{ padding: '2px 8px', borderRadius: '6px', fontSize: '0.65rem', fontWeight: 600, color: 'var(--pc-primary)' }}>
                                                    + {section.sections.length - 3} more
                                                </span>
                                            )}
                                        </div>
                                    </div>
                                    <span style={{ color: 'var(--pc-text-tertiary)', fontSize: '1.2rem' }}>→</span>
                                </div>
                            </div>
                        ))}
                    </div>
                </>
            )}

            {/* Detail Content */}
            {activeSection && detailContent[activeSection] && (
                <div>{detailContent[activeSection]}</div>
            )}

            {/* Section content fallback */}
            {activeSection && !detailContent[activeSection] && (
                <div style={{ padding: '40px', borderRadius: '14px', background: 'var(--pc-surface-card)', border: '1px solid var(--pc-border-primary)', textAlign: 'center' }}>
                    <p style={{ fontSize: '2rem', marginBottom: '12px' }}>
                        {guideIndex.find(s => s.id === activeSection)?.icon}
                    </p>
                    <h2 style={{ color: 'var(--pc-text-primary)', fontWeight: 700, margin: '0 0 16px' }}>
                        {guideIndex.find(s => s.id === activeSection)?.title}
                    </h2>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px', maxWidth: '500px', margin: '0 auto', textAlign: 'left' }}>
                        {guideIndex.find(s => s.id === activeSection)?.sections.map((sub, i) => (
                            <div key={i} style={{
                                padding: '12px 16px', borderRadius: '10px',
                                background: 'var(--pc-bg-secondary)', color: 'var(--pc-text-secondary)',
                                fontSize: '0.85rem', fontWeight: 600,
                            }}>
                                {i + 1}. {sub}
                            </div>
                        ))}
                    </div>
                </div>
            )}

            {/* Footer */}
            <div style={{ marginTop: '48px', padding: '24px', borderRadius: '14px', background: 'var(--pc-bg-secondary)', textAlign: 'center' }}>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.8rem', margin: '0 0 8px' }}>
                    Need more help? Contact your coordinator or call the PrimeCare support line.
                </p>
                <p style={{ color: 'var(--pc-text-tertiary)', fontSize: '0.7rem', margin: 0 }}>
                    📞 1-800-PRIME-CARE &nbsp;|&nbsp; 📧 support@primecare.ca &nbsp;|&nbsp; 💬 In-app chat
                </p>
            </div>
        </div>
    );
}
