import React, { useState, useEffect } from 'react';
import { AlertTriangle, MessageCircle, X } from 'lucide-react';

/* ─────────────────────────────────────────────────────────────────────────────
 * ConfirmModal — Lightweight two-button confirm dialog.
 * Replaces native window.confirm() with a styled, accessible modal.
 * ────────────────────────────────────────────────────────────────────────── */

interface ConfirmModalProps {
    isOpen: boolean;
    title: string;
    message: string;
    confirmLabel?: string;
    cancelLabel?: string;
    variant?: 'danger' | 'warning' | 'info';
    onConfirm: () => void;
    onCancel: () => void;
}

const VARIANT_STYLES = {
    danger:  { accent: '#ef4444', bg: '#fee2e2', icon: AlertTriangle },
    warning: { accent: '#f59e0b', bg: '#fef3c7', icon: AlertTriangle },
    info:    { accent: '#3b82f6', bg: '#dbeafe', icon: MessageCircle },
};

export const ConfirmModal: React.FC<ConfirmModalProps> = ({
    isOpen, title, message, confirmLabel, cancelLabel,
    variant = 'danger', onConfirm, onCancel
}) => {
    // Close on Escape key
    useEffect(() => {
        if (!isOpen) return;
        const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onCancel(); };
        window.addEventListener('keydown', handler);
        return () => window.removeEventListener('keydown', handler);
    }, [isOpen, onCancel]);

    if (!isOpen) return null;

    const v = VARIANT_STYLES[variant];
    const Icon = v.icon;

    return (
        <div
            style={{
                position: 'fixed', inset: 0, backgroundColor: 'rgba(15,23,42,0.6)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                zIndex: 99999, backdropFilter: 'blur(4px)',
                animation: 'confirmFadeIn 0.15s ease-out'
            }}
            data-cy="modal-confirm"
            role="dialog"
            aria-modal="true"
            aria-labelledby="confirm-modal-title"
            onClick={(e) => { if (e.target === e.currentTarget) onCancel(); }}
        >
            <div style={{
                backgroundColor: 'white', padding: '24px', borderRadius: '12px',
                maxWidth: '440px', width: '90%', borderTop: `5px solid ${v.accent}`,
                boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25)',
                animation: 'confirmSlideUp 0.2s cubic-bezier(0.175,0.885,0.32,1.275)'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <div style={{ backgroundColor: v.bg, padding: '10px', borderRadius: '50%', color: v.accent }}>
                            <Icon size={22} />
                        </div>
                        <h3 data-cy="h3-shared.confirm-modal-0" id="confirm-modal-title" style={{ margin: 0, fontSize: '1.15rem', fontWeight: 700, color: '#0f172a' }}>
                            {title}
                        </h3>
                    </div>
                    <button
                        onClick={onCancel}
                        data-cy="confirm-modal-close"
                        style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '4px', color: '#94a3b8' }}
                    >
                        <X size={18} />
                    </button>
                </div>

                <p style={{ margin: '0 0 24px 0', fontSize: '0.95rem', color: '#475569', lineHeight: '1.6' }}>
                    {message}
                </p>

                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                    <button
                        onClick={onCancel}
                        data-cy="confirm-modal-cancel"
                        style={{
                            padding: '10px 18px', borderRadius: '8px', border: '1px solid #e2e8f0',
                            backgroundColor: 'white', color: '#475569', fontWeight: 600,
                            cursor: 'pointer', fontSize: '0.9rem', transition: 'all 0.15s'
                        }}
                    >
                        {cancelLabel || 'Cancel'}
                    </button>
                    <button
                        onClick={onConfirm}
                        data-cy="confirm-modal-confirm"
                        style={{
                            padding: '10px 18px', borderRadius: '8px', border: 'none',
                            backgroundColor: v.accent, color: 'white', fontWeight: 600,
                            cursor: 'pointer', fontSize: '0.9rem', transition: 'all 0.15s'
                        }}
                    >
                        {confirmLabel || 'Confirm'}
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes confirmFadeIn { from { opacity: 0; } to { opacity: 1; } }
                @keyframes confirmSlideUp { from { transform: translateY(8px) scale(0.97); opacity: 0; } to { transform: translateY(0) scale(1); opacity: 1; } }
            `}</style>
        </div>
    );
};

export default ConfirmModal;
