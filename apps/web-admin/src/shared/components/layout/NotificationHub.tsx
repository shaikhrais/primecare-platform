import React, { useState } from 'react';
import { useNotificationCenter } from '@/shared/context/NotificationCenterContext';
import { useNavigate } from 'react-router-dom';

export default function NotificationHub() {
    const { notifications, unreadCount, markAsRead, markAllAsRead } = useNotificationCenter();
    const [isOpen, setIsOpen] = useState(false);
    const navigate = useNavigate();

    const handleNotificationClick = (notification: any) => {
        markAsRead(notification.id);
        setIsOpen(false);
        if (notification.link) {
            navigate(notification.link);
        }
    };

    return (
        <div style={{ position: 'relative' }}>
            <button
                data-cy="btn-notifications"
                onClick={() => setIsOpen(!isOpen)}
                className="btn"
                style={{
                    width: '44px',
                    height: '44px',
                    padding: 0,
                    position: 'relative',
                    background: isOpen ? 'var(--brand-500)' : 'var(--bg-elev)',
                    color: isOpen ? 'white' : 'var(--text)',
                    transition: 'all 0.2s',
                    border: 'none',
                    borderRadius: '50%',
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                }}
            >
                <span style={{ fontSize: '1.2rem' }}>🔔</span>
                {unreadCount > 0 && (
                    <span style={{
                        position: 'absolute',
                        top: '-2px',
                        right: '-2px',
                        background: '#ef4444',
                        color: 'white',
                        fontSize: '10px',
                        fontWeight: 900,
                        padding: '2px 5px',
                        borderRadius: '10px',
                        border: '2px solid white',
                        minWidth: '18px',
                        textAlign: 'center'
                    }}>
                        {unreadCount}
                    </span>
                )}
            </button>

            {isOpen && (
                <>
                    <div
                        style={{ position: 'fixed', inset: 0, zIndex: 999, cursor: 'default' }}
                        onClick={() => setIsOpen(false)}
                    />
                    <div style={{
                        position: 'absolute',
                        top: '52px',
                        right: '-8px',
                        width: '360px',
                        maxHeight: '480px',
                        background: '#FFFFFF',
                        borderRadius: '12px',
                        border: '1px solid #E5E7EB',
                        boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
                        zIndex: 1000,
                        overflow: 'hidden',
                        display: 'flex',
                        flexDirection: 'column'
                    }}>
                        <div style={{ padding: '16px', borderBottom: '1px solid #E5E7EB', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ fontWeight: 700, fontSize: '1.1rem', color: '#111827' }}>Notifications</span>
                            {unreadCount > 0 && (
                                <button
                                    onClick={markAllAsRead}
                                    style={{ fontSize: '0.75rem', color: '#00875A', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 600 }}
                                >
                                    Mark all read
                                </button>
                            )}
                        </div>

                        <div style={{ overflowY: 'auto', flex: 1 }} data-cy="notification-list">
                            {notifications.length === 0 ? (
                                <div style={{ padding: '40px 20px', textAlign: 'center', color: '#6B7280', fontSize: '0.9rem' }}>
                                    <div style={{ fontSize: '2rem', marginBottom: '1rem', opacity: 0.5 }}>📭</div>
                                    All caught up! No new notifications.
                                </div>
                            ) : (
                                notifications.map((n) => (
                                    <div
                                        key={n.id}
                                        onClick={() => handleNotificationClick(n)}
                                        style={{
                                            padding: '16px',
                                            borderBottom: '1px solid #F3F4F6',
                                            cursor: 'pointer',
                                            background: n.isRead ? 'white' : '#F0FDF4',
                                            transition: 'background 0.2s',
                                            position: 'relative'
                                        }}
                                        onMouseEnter={(e) => e.currentTarget.style.backgroundColor = n.isRead ? '#F9FAFB' : '#DCFCE7'}
                                        onMouseLeave={(e) => e.currentTarget.style.backgroundColor = n.isRead ? 'white' : '#F0FDF4'}
                                    >
                                        <div style={{ display: 'flex', gap: '12px' }}>
                                            <div style={{
                                                width: '10px', height: '10px', borderRadius: '50%',
                                                background: n.type === 'error' ? '#EF4444' : n.type === 'warning' ? '#F59E0B' : '#00875A',
                                                marginTop: '6px',
                                                flexShrink: 0,
                                                opacity: n.isRead ? 0.3 : 1
                                            }} />
                                            <div style={{ flex: 1 }}>
                                                <div style={{ fontSize: '0.95rem', fontWeight: n.isRead ? 400 : 600, color: '#111827' }}>
                                                    {n.title}
                                                </div>
                                                <div style={{ fontSize: '0.85rem', color: '#6B7280', marginTop: '4px', lineHeight: 1.4 }}>
                                                    {n.message}
                                                </div>
                                                <div style={{ fontSize: '0.75rem', color: '#9CA3AF', marginTop: '8px' }}>
                                                    {new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })} • {new Date(n.createdAt).toLocaleDateString()}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                ))
                            )}
                        </div>
                        <div style={{ padding: '12px', textAlign: 'center', borderTop: '1px solid #E5E7EB', backgroundColor: '#F9FAFB' }}>
                            <button style={{ fontSize: '0.85rem', color: '#6B7280', background: 'none', border: 'none', cursor: 'pointer', fontWeight: 500 }}>
                                View All History
                            </button>
                        </div>
                    </div>
                </>
            )}
        </div>
    );
}
