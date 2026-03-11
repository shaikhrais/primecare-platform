import { describe, it, expect, vi } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { NotificationCenterProvider, useNotificationCenter } from '../shared/context/NotificationCenterContext';

describe('NotificationCenterContext', () => {
    it('provides initial state', () => {
        const { result } = renderHook(() => useNotificationCenter(), {
            wrapper: NotificationCenterProvider,
        });

        expect(result.current.notifications).toBeDefined();
        // Initially we load 3 notifications
        expect(result.current.notifications.length).toBe(3);
        expect(result.current.unreadCount).toBeGreaterThan(0);
    });

    it('adds a notification', () => {
        const { result } = renderHook(() => useNotificationCenter(), {
            wrapper: NotificationCenterProvider,
        });

        const newNotification = {
            title: 'Test Notification',
            message: 'This is a test.',
            type: 'info' as const,
        };

        act(() => {
            result.current.addNotification(newNotification);
        });

        expect(result.current.notifications.length).toBe(4);
        expect(result.current.notifications[0].title).toBe('Test Notification');
    });

    it('marks a notification as read', () => {
        const { result } = renderHook(() => useNotificationCenter(), {
            wrapper: NotificationCenterProvider,
        });

        const notificationId = result.current.notifications[0].id; // Get the first one

        act(() => {
            result.current.markAsRead(notificationId);
        });

        const updatedNotification = result.current.notifications.find((n) => n.id === notificationId);
        expect(updatedNotification?.isRead).toBe(true);
    });

    it('removes a notification', () => {
        const { result } = renderHook(() => useNotificationCenter(), {
            wrapper: NotificationCenterProvider,
        });

        const notificationId = result.current.notifications[0].id;
        const initialCount = result.current.notifications.length;

        act(() => {
            result.current.removeNotification(notificationId);
        });

        expect(result.current.notifications.length).toBe(initialCount - 1);
    });
});
