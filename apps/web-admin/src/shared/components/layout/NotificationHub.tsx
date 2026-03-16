import React, { useState, useMemo } from 'react';
import { useNotificationCenter } from '@/shared/context/NotificationCenterContext';
import { useNavigate } from 'react-router';

/* ── Category Configuration ───────────────────────────────────── */
const CATEGORIES: Record<string, { label: string; icon: string; color: string }> = {
    all: { label: 'All', icon: '📋', color: '#64748B' },
    alerts: { label: 'Alerts', icon: '🚨', color: '#DC2626' },
    visits: { label: 'Visits', icon: '🏠', color: '#2563EB' },
    staff: { label: 'Staff', icon: '👥', color: '#7C3AED' },
    system: { label: 'System', icon: '⚙️', color: '#0369A1' },
};

function categorize(n: any): string {
    const t = n.type || '';
    const title = (n.title || '').toLowerCase();
    if (t === 'error' || t === 'warning' || title.includes('incident') || title.includes('alert') || title.includes('sos')) return 'alerts';
    if (title.includes('visit') || title.includes('shift') || title.includes('check')) return 'visits';
    if (title.includes('staff') || title.includes('psw') || title.includes('caregiver') || title.includes('onboard')) return 'staff';
    return 'system';
}

function timeGroup(dateStr: string): string {
    const d = new Date(dateStr);
    const now = new Date();
    const diffMs = now.getTime() - d.getTime();
    const diffH = diffMs / 3_600_000;
    if (diffH < 1) return 'Just Now';
    if (diffH < 24) return 'Today';
    if (diffH < 48) return 'Yesterday';
    return 'Earlier';
}

export default function NotificationHub() {
    const { notifications, unreadCount, markAsRead, markAllAsRead } = useNotificationCenter();
    const [isOpen, setIsOpen] = useState(false);
    const [activeCategory, setActiveCategory] = useState('all');
    const navigate = useNavigate();

    const filtered = useMemo(() => {
        const list = activeCategory === 'all' ? notifications : notifications.filter((n: any) => categorize(n) === activeCategory);
        // Group by time
        const groups: Record<string, any[]> = {};
        list.forEach((n: any) => {
            const g = timeGroup(n.createdAt);
            (groups[g] ??= []).push(n);
        });
        return groups;
    }, [notifications, activeCategory]);

    const categoryUnreads = useMemo(() => {
        const counts: Record<string, number> = {};
        notifications.filter((n: any) => !n.isRead).forEach((n: any) => {
            const cat = categorize(n);
            counts[cat] = (counts[cat] || 0) + 1;
        });
        return counts;
    }, [notifications]);

    const handleClick = (n: any) => {
        markAsRead(n.id);
        setIsOpen(false);
        if (n.link) navigate(n.link);
    };

    return (
        <div data-cy="page.container" style={{ position: 'relative' }}>
            {/* Bell Button */}
            <button
                data-cy="btn-notifications"
                onClick={() => setIsOpen(!isOpen)}
                className="btn"
                style={{
                    width: '44px', height: '44px', padding: 0, position: 'relative',
                    background: isOpen ? 'var(--brand-500)' : 'var(--bg-elev)',
                    color: isOpen ? 'white' : 'var(--text)',
                    transition: 'all 0.2s', border: 'none', borderRadius: '50%',
                    cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center'
                }}
            >
                <span style={{ fontSize: '1.2rem' }}>🔔</span>
                {unreadCount > 0 && (
                    <span style={{
                        position: 'absolute', top: '-2px', right: '-2px',
                        background: '#ef4444', color: 'white', fontSize: '10px', fontWeight: 900,
                        padding: '2px 5px', borderRadius: '10px', border: '2px solid white',
                        minWidth: '18px', textAlign: 'center',
                        animation: 'pulse 2s infinite',
                    }}>
                        {unreadCount > 99 ? '99+' : unreadCount}
                    </span>
                )}
            </button>

            {isOpen && (
                <>
                    <div style={{ position: 'fixed', inset: 0, zIndex: 999, cursor: 'default' }} onClick={() => setIsOpen(false)} />
                    <div style={{
                        position: 'absolute', top: '52px', right: '-8px', width: '400px', maxHeight: '560px',
                        background: 'var(--card-bg, #FFFFFF)', borderRadius: '16px',
                        border: '1px solid var(--border, #E5E7EB)',
                        boxShadow: '0 20px 25px -5px rgba(0,0,0,0.1), 0 10px 10px -5px rgba(0,0,0,0.04)',
                        zIndex: 1000, overflow: 'hidden', display: 'flex', flexDirection: 'column'
                    }}>
                        {/* Header */}
                        <div style={{ padding: '16px 20px', borderBottom: '1px solid var(--border, #E5E7EB)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <span style={{ fontWeight: 800, fontSize: '1.1rem', color: 'var(--text, #111827)' }}>Notifications</span>
                                {unreadCount > 0 && <span style={{ background: '#ef4444', color: 'white', fontSize: '0.65rem', fontWeight: 700, padding: '2px 8px', borderRadius: '10px' }}>{unreadCount} new</span>}
                            </div>
                            {unreadCount > 0 && (
                                <button data-cy="btn-shared.notification-hub-0" onClick={markAllAsRead}
                                    style={{ fontSize: '0.75rem', color: 'var(--brand-500, #00875A)', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600 }}>
                                    ✓ Mark all read
                                </button>
                            )}
                        </div>

                        {/* Category Tabs */}
                        <div style={{ display: 'flex', gap: '4px', padding: '8px 12px', borderBottom: '1px solid var(--border, #F3F4F6)', overflowX: 'auto' }}>
                            {Object.entries(CATEGORIES).map(([key, cat]) => {
                                const isActive = activeCategory === key;
                                const badge = key === 'all' ? unreadCount : (categoryUnreads[key] || 0);
                                return (
                                    <button key={key} data-cy={`btn-notif-cat-${key}`}
                                        onClick={() => setActiveCategory(key)}
                                        style={{
                                            display: 'flex', alignItems: 'center', gap: '4px',
                                            padding: '5px 10px', borderRadius: '8px', fontSize: '0.7rem', fontWeight: 600,
                                            border: isActive ? `1.5px solid ${cat.color}` : '1px solid transparent',
                                            background: isActive ? `${cat.color}10` : 'transparent',
                                            color: isActive ? cat.color : 'var(--text-muted, #6B7280)',
                                            cursor: 'pointer', whiteSpace: 'nowrap', transition: 'all 0.15s',
                                        }}
                                    >
                                        {cat.icon} {cat.label}
                                        {badge > 0 && <span style={{ background: cat.color, color: 'white', fontSize: '9px', fontWeight: 800, padding: '1px 5px', borderRadius: '8px', marginLeft: '2px' }}>{badge}</span>}
                                    </button>
                                );
                            })}
                        </div>

                        {/* Notification List — grouped by time */}
                        <div style={{ overflowY: 'auto', flex: 1 }} data-cy="notification-list">
                            {Object.keys(filtered).length === 0 ? (
                                <div style={{ padding: '48px 20px', textAlign: 'center', color: 'var(--text-muted, #6B7280)' }}>
                                    <div style={{ fontSize: '2.5rem', marginBottom: '12px', opacity: 0.4 }}>📭</div>
                                    <div style={{ fontSize: '0.9rem', fontWeight: 600 }}>All caught up!</div>
                                    <div style={{ fontSize: '0.75rem', marginTop: '4px', opacity: 0.7 }}>No notifications in this category.</div>
                                </div>
                            ) : (
                                Object.entries(filtered).map(([group, items]) => (
                                    <div key={group}>
                                        <div style={{ padding: '8px 20px 4px', fontSize: '0.65rem', fontWeight: 700, textTransform: 'uppercase', letterSpacing: '0.08em', color: 'var(--text-muted, #9CA3AF)' }}>{group}</div>
                                        {items.map((n: any) => {
                                            const cat = CATEGORIES[categorize(n)] || CATEGORIES.system;
                                            return (
                                                <div key={n.id} onClick={() => handleClick(n)} data-cy={`notification-${n.id}`}
                                                    style={{
                                                        padding: '12px 20px', borderBottom: '1px solid var(--border, #F3F4F6)',
                                                        cursor: 'pointer', transition: 'background 0.15s',
                                                        background: n.isRead ? 'transparent' : 'var(--brand-50, #F0FDF4)',
                                                    }}
                                                    onMouseEnter={(e) => e.currentTarget.style.backgroundColor = n.isRead ? 'var(--bg-elev, #F9FAFB)' : 'var(--brand-100, #DCFCE7)'}
                                                    onMouseLeave={(e) => e.currentTarget.style.backgroundColor = n.isRead ? 'transparent' : 'var(--brand-50, #F0FDF4)'}
                                                >
                                                    <div style={{ display: 'flex', gap: '12px', alignItems: 'flex-start' }}>
                                                        <div style={{
                                                            width: '32px', height: '32px', borderRadius: '8px', flexShrink: 0,
                                                            background: `${cat.color}15`, display: 'flex', alignItems: 'center', justifyContent: 'center',
                                                            fontSize: '0.9rem',
                                                        }}>
                                                            {cat.icon}
                                                        </div>
                                                        <div style={{ flex: 1, minWidth: 0 }}>
                                                            <div style={{ fontSize: '0.85rem', fontWeight: n.isRead ? 500 : 700, color: 'var(--text, #111827)', overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                                                                {n.title}
                                                            </div>
                                                            <div style={{ fontSize: '0.78rem', color: 'var(--text-muted, #6B7280)', marginTop: '2px', lineHeight: 1.4, display: '-webkit-box', WebkitLineClamp: 2, WebkitBoxOrient: 'vertical', overflow: 'hidden' }}>
                                                                {n.message}
                                                            </div>
                                                            <div style={{ fontSize: '0.68rem', color: 'var(--text-muted, #9CA3AF)', marginTop: '4px', display: 'flex', alignItems: 'center', gap: '6px' }}>
                                                                <span>{new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</span>
                                                                <span style={{ opacity: 0.4 }}>•</span>
                                                                <span style={{ color: cat.color, fontWeight: 600 }}>{cat.label}</span>
                                                            </div>
                                                        </div>
                                                        {!n.isRead && <div style={{ width: '8px', height: '8px', borderRadius: '50%', background: cat.color, flexShrink: 0, marginTop: '8px', boxShadow: `0 0 6px ${cat.color}40` }} />}
                                                    </div>
                                                </div>
                                            );
                                        })}
                                    </div>
                                ))
                            )}
                        </div>

                        {/* Footer */}
                        <div style={{ padding: '10px', textAlign: 'center', borderTop: '1px solid var(--border, #E5E7EB)', backgroundColor: 'var(--bg-elev, #F9FAFB)' }}>
                            <button data-cy="btn-shared.notification-hub-1" style={{ fontSize: '0.8rem', color: 'var(--brand-500, #0369A1)', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600 }}>
                                View All Notifications →
                            </button>
                        </div>
                    </div>
                </>
            )}
        </div>
    );
}

// Named export alias for test compatibility
export { NotificationHub };
