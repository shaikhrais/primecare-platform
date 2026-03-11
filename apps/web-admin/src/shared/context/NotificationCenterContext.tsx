import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;

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

    // Fetch live persistence data
    useEffect(() => {
        const fetchNotifications = async () => {
            try {
                const token = localStorage.getItem('token');
                const apiUrl = import.meta.env.VITE_API_URL || 'http://localhost:4000';
                
                const response = await fetch(`${apiUrl}${ApiRegistry.PLATFORM.ADMIN.SYSTEM_DATA.NOTIFICATIONS}`, {
                    headers: { 'Authorization': `Bearer ${token}` }
                });

                if (response.ok) {
                    const data = await response.json();
                    setNotifications(data);
                }
            } catch (error) {
                console.error('Failed to load system notifications:', error);
            }
        };

        fetchNotifications();
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
