/**
 * useToast — Unified toast notification hook (backed by Zustand UIStore)
 *
 * Drop-in replacement for the legacy `useNotification()` from NotificationContext.
 * Provides the same `showToast(message, type)` API so consumers migrate with
 * a single import change and zero logic changes.
 *
 * Also exposes the richer Zustand `addToast` API for new code that wants
 * to set a title + message separately.
 *
 * @example
 *   const { showToast } = useToast();
 *   showToast('Saved successfully', 'success');
 */
import { useCallback } from 'react';
import { useUIStore } from '@/shared/stores';

type ToastType = 'success' | 'error' | 'info' | 'warning';

export function useToast() {
    const addToast = useUIStore((s) => s.addToast);
    const removeToast = useUIStore((s) => s.removeToast);
    const clearToasts = useUIStore((s) => s.clearToasts);

    /**
     * Show a toast notification.
     * API-compatible with the legacy `useNotification().showToast`.
     */
    const showToast = useCallback(
        (message: string, type: ToastType = 'info') => {
            addToast({ type, title: message });
        },
        [addToast]
    );

    return { showToast, addToast, removeToast, clearToasts };
}
