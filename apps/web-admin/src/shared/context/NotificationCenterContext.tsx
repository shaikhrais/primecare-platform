import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';

export interface AppNotification {
    id: string;
    title: string;
    message: string;
    type: 'info' | 'success' | 'warning' | 'error';
    isRead: boolean;
    createdAt: string;
    link?: string; // Optional link to drill down
}

interface NotificationCenterContextType {
    notifications: AppNotification[];
    unreadCount: number;
    addNotification: (notification: Omit<AppNotification, 'id' | 'createdAt' | 'isRead'>) => void;
    markAsRead: (id: string) => void;
    markAllAsRead: () => void;
    removeNotification: (id: string) => void;
}

const NotificationCenterContext = createContext<NotificationCenterContextType | undefined>(undefined);

export const NotificationCenterProvider = ({ children }: { children: ReactNode }) => {
    const [notifications, setNotifications] = useState<AppNotification[]>([]);

    // Load initial mock data
    useEffect(() => {
        const mockData: AppNotification[] = [
            {
                id: '1',
                title: 'New Incident Reported',
                message: 'Fall detected at Room 304 (Client: John Doe)',
                type: 'error',
                isRead: false,
                createdAt: new Date(Date.now() - 1000 * 60 * 5).toISOString(), // 5 mins ago
                link: '/admin/incidents'
            },
            {
                id: '2',
                title: 'Shift Request',
                message: 'Sarah Jones requested next Friday off.',
                type: 'warning',
                isRead: false,
                createdAt: new Date(Date.now() - 1000 * 60 * 60).toISOString(), // 1 hour ago
                link: '/admin/schedule'
            },
            {
                id: '3',
                title: 'System Update',
                message: 'Platform maintenance scheduled for Sunday 2 AM.',
                type: 'info',
                isRead: true,
                createdAt: new Date(Date.now() - 1000 * 60 * 60 * 24).toISOString(), // 1 day ago
            }
        ];
        setNotifications(mockData);
    }, []);

    const unreadCount = notifications.filter(n => !n.isRead).length;

    const addNotification = (notification: Omit<AppNotification, 'id' | 'createdAt' | 'isRead'>) => {
        const newNotification: AppNotification = {
            ...notification,
            id: Math.random().toString(36).substr(2, 9),
            createdAt: new Date().toISOString(),
            isRead: false
        };
        setNotifications(prev => [newNotification, ...prev]);
    };

    const markAsRead = (id: string) => {
        setNotifications(prev => prev.map(n => n.id === id ? { ...n, isRead: true } : n));
    };

    const markAllAsRead = () => {
        setNotifications(prev => prev.map(n => ({ ...n, isRead: true })));
    };

    const removeNotification = (id: string) => {
        setNotifications(prev => prev.filter(n => n.id !== id));
    };

    const value = React.useMemo(() => ({
        notifications,
        unreadCount,
        addNotification,
        markAsRead,
        markAllAsRead,
        removeNotification
    }), [notifications, unreadCount]);

    return (
        <NotificationCenterContext.Provider value={value}>
            {children}
        </NotificationCenterContext.Provider>
    );
};

export const useNotificationCenter = () => {
    const context = useContext(NotificationCenterContext);
    if (!context) {
        throw new Error('useNotificationCenter must be used within a NotificationCenterProvider');
    }
    return context;
};
