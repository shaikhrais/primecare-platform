/**
 * ToastContainer — Renders floating toast notifications from useUIStore
 *
 * Automatically picks up toasts from the Zustand store and renders them
 * as stacked, animated notifications in the bottom-right corner.
 *
 * Usage: Place <ToastContainer /> once in App.tsx
 */
import React from 'react';
import { useUIStore } from '@/shared/stores';

const TYPE_STYLES = {
    success: { bg: '#ECFDF5', border: '#10B981', icon: '✓', color: '#065F46' },
    error: { bg: '#FEF2F2', border: '#EF4444', icon: '✕', color: '#991B1B' },
    warning: { bg: '#FFFBEB', border: '#F59E0B', icon: '⚠', color: '#92400E' },
    info: { bg: '#EFF6FF', border: '#3B82F6', icon: 'ℹ', color: '#1E40AF' },
};

export const ToastContainer: React.FC = () => {
    const toasts = useUIStore((s) => s.toasts);
    const removeToast = useUIStore((s) => s.removeToast);

    if (toasts.length === 0) return null;

    return (
        <div
            style={{
                position: 'fixed', bottom: '1.5rem', right: '1.5rem',
                display: 'flex', flexDirection: 'column-reverse', gap: '0.75rem',
                zIndex: 9999, maxWidth: '400px', width: '100%',
                pointerEvents: 'none',
            }}
            data-cy="toast-container"
        >
            {toasts.map((toast) => {
                const typeStyle = TYPE_STYLES[toast.type];
                return (
                    <div
                        key={toast.id}
                        data-cy={`toast-${toast.type}`}
                        style={{
                            display: 'flex', alignItems: 'flex-start', gap: '0.75rem',
                            padding: '0.875rem 1rem',
                            backgroundColor: typeStyle.bg,
                            borderLeft: `4px solid ${typeStyle.border}`,
                            borderRadius: '0.5rem',
                            boxShadow: '0 4px 12px rgba(0,0,0,0.12)',
                            animation: 'primecare-toast-in 0.3s ease-out',
                            pointerEvents: 'auto',
                            fontFamily: "'Inter', system-ui, sans-serif",
                        }}
                    >
                        <span style={{
                            fontSize: '1rem', lineHeight: 1,
                            color: typeStyle.border, fontWeight: 700, flexShrink: 0,
                            width: '1.25rem', height: '1.25rem', display: 'flex',
                            alignItems: 'center', justifyContent: 'center',
                        }}>
                            {typeStyle.icon}
                        </span>
                        <div style={{ flex: 1, minWidth: 0 }}>
                            <div style={{ fontSize: '0.875rem', fontWeight: 600, color: typeStyle.color }}>
                                {toast.title}
                            </div>
                            {toast.message && (
                                <div style={{ fontSize: '0.8125rem', color: typeStyle.color, opacity: 0.8, marginTop: '0.25rem' }}>
                                    {toast.message}
                                </div>
                            )}
                        </div>
                        <button
                            onClick={() => removeToast(toast.id)}
                            data-cy="toast-dismiss"
                            style={{
                                background: 'none', border: 'none',
                                fontSize: '1rem', cursor: 'pointer',
                                color: typeStyle.color, opacity: 0.5,
                                padding: '0', lineHeight: 1, flexShrink: 0,
                            }}
                        >×</button>
                    </div>
                );
            })}
            <style>{`
                @keyframes primecare-toast-in {
                    from { opacity: 0; transform: translateX(100%); }
                    to { opacity: 1; transform: translateX(0); }
                }
            `}</style>
        </div>
    );
};

export default ToastContainer;
