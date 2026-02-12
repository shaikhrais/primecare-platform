import React, { useState, useEffect } from 'react';
import { apiClient } from '@/shared/utils/apiClient';

interface Notification {
    id: string;
    title: string;
    message: string;
    type: string;
    isRead: boolean;
    createdAt: string;
}

export default function NotificationHub() {
    const [notifications, setNotifications] = useState<Notification[]>([]);
    const [isOpen, setIsOpen] = useState(false);
    const [loading, setLoading] = useState(false);

    const fetchNotifications = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get('/v1/notifications');
            if (response.ok) {
                const data = await response.json();
                setNotifications(data);
            }
        } catch (err) {
            console.error('Error fetching notifications:', err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => {
        fetchNotifications();
        const interval = setInterval(fetchNotifications, 60000); // Poll every minute
        return () => clearInterval(interval);
    }, []);

    const markAsRead = async (id: string) => {
        try {
            await apiClient.patch(`/v1/notifications/${id}/read`);
            setNotifications(notifications.map((n: Notification) => n.id === id ? { ...n, isRead: true } : n));
        } catch (err) {
            console.error('Error marking as read:', err);
        }
    };

    const unreadCount = notifications.filter((n: Notification) => !n.isRead).length;

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
                    transition: 'all 0.2s'
                }}
            >
                <span style={{ fontSize: '1.2rem' }}>🔔</span>
                {unreadCount > 0 && (
                    <span style={{
                        position: 'absolute',
                        top: '8px',
                        right: '8px',
                        background: '#ef4444',
                        color: 'white',
                        fontSize: '10px',
                        fontWeight: 900,
                        padding: '2px 4px',
                        borderRadius: '4px',
                        border: '2px solid var(--bg-elev)',
                        minWidth: '16px'
                    }}>
                        {unreadCount}
                    </span>
                )}
            </button>

            {isOpen && (
                <div style={{
                    position: 'absolute',
                    top: '52px',
                    right: 0,
                    width: '320px',
                    maxHeight: '400px',
                    background: 'rgba(255, 255, 255, 0.05)',
                    backdropFilter: 'blur(16px)',
                    WebkitBackdropFilter: 'blur(16px)',
                    borderRadius: '16px',
                    border: '1px solid rgba(255, 255, 255, 0.1)',
                    boxShadow: '0 10px 40px rgba(0,0,0,0.3)',
                    zIndex: 1000,
                    overflow: 'hidden',
                    display: 'flex',
                    flexDirection: 'column'
                }}>
                    <div style={{ padding: '16px', borderBottom: '1px solid rgba(255,255,255,0.05)', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <span style={{ fontWeight: 800, fontSize: '14px', textTransform: 'uppercase', letterSpacing: '1px' }}>Notifications</span>
                        {loading && <span style={{ fontSize: '10px', opacity: 0.5 }}>Syncing...</span>}
                    </div>

                    <div style={{ overflowY: 'auto', flex: 1 }} data-cy="notification-list">
                        {notifications.length === 0 ? (
                            <div style={{ padding: '32px', textAlign: 'center', opacity: 0.5, fontSize: '13px' }}>
                                All caught up!
                            </div>
                        ) : (
                            notifications.map((n: Notification) => (
                                <div
                                    key={n.id}
                                    onClick={() => markAsRead(n.id)}
                                    style={{
                                        padding: '12px 16px',
                                        borderBottom: '1px solid rgba(255,255,255,0.03)',
                                        cursor: 'pointer',
                                        background: n.isRead ? 'transparent' : 'rgba(5, 150, 105, 0.05)',
                                        transition: 'all 0.2s'
                                    }}
                                >
                                    <div style={{ display: 'flex', gap: '8px', marginBottom: '4px' }}>
                                        <div style={{
                                            width: '8px', height: '8px', borderRadius: '50%',
                                            background: n.type === 'error' ? '#ef4444' : n.type === 'warning' ? '#f59e0b' : 'var(--brand-500)',
                                            marginTop: '4px',
                                            opacity: n.isRead ? 0.3 : 1
                                        }} />
                                        <div style={{ flex: 1 }}>
                                            <div style={{ fontSize: '13px', fontWeight: 700, color: n.isRead ? 'var(--text-400)' : 'var(--text)' }}>
                                                {n.title}
                                            </div>
                                            <div style={{ fontSize: '12px', opacity: 0.7, marginTop: '2px', lineHeight: 1.4 }}>
                                                {n.message}
                                            </div>
                                            <div style={{ fontSize: '10px', opacity: 0.4, marginTop: '6px' }}>
                                                {new Date(n.createdAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            ))
                        )}
                    </div>
                </div>
            )}
        </div>
    );
}
