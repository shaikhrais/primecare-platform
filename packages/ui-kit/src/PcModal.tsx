import React, { useEffect, useRef, useCallback } from 'react';
import { createPortal } from 'react-dom';

export interface PcModalProps {
    /** Whether the modal is open */
    open: boolean;
    /** Called when the modal should close (ESC, backdrop click, X button) */
    onClose: () => void;
    /** Modal title in the header */
    title?: string;
    /** Modal body content */
    children: React.ReactNode;
    /** Footer content (buttons, actions) */
    footer?: React.ReactNode;
    /** Width preset */
    size?: 'sm' | 'md' | 'lg';
    /** Cypress test attribute */
    'data-cy'?: string;
    /** Whether clicking backdrop closes the modal */
    closeOnBackdrop?: boolean;
}

const SIZE_MAP = {
    sm: '420px',
    md: '560px',
    lg: '720px',
};

export const PcModal: React.FC<PcModalProps> = ({
    open,
    onClose,
    title,
    children,
    footer,
    size = 'md',
    closeOnBackdrop = true,
    ...rest
}) => {
    const dialogRef = useRef<HTMLDivElement>(null);

    const handleKeyDown = useCallback(
        (e: KeyboardEvent) => {
            if (e.key === 'Escape') onClose();
        },
        [onClose]
    );

    useEffect(() => {
        if (open) {
            document.addEventListener('keydown', handleKeyDown);
            document.body.style.overflow = 'hidden';
        }
        return () => {
            document.removeEventListener('keydown', handleKeyDown);
            document.body.style.overflow = '';
        };
    }, [open, handleKeyDown]);

    // Focus trap: focus the dialog when opened
    useEffect(() => {
        if (open && dialogRef.current) {
            dialogRef.current.focus();
        }
    }, [open]);

    if (!open) return null;

    return createPortal(
        <div
            role="dialog"
            aria-modal="true"
            aria-label={title}
            data-cy={rest['data-cy']}
            style={{
                position: 'fixed',
                inset: 0,
                zIndex: 9999,
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                padding: '24px',
            }}
        >
            {/* Backdrop */}
            <div
                onClick={closeOnBackdrop ? onClose : undefined}
                data-cy={rest['data-cy'] ? `${rest['data-cy']}-backdrop` : undefined}
                style={{
                    position: 'absolute',
                    inset: 0,
                    backgroundColor: 'var(--pc-bg-overlay)',
                    transition: 'opacity 0.2s ease',
                }}
            />

            {/* Dialog */}
            <div
                ref={dialogRef}
                tabIndex={-1}
                style={{
                    position: 'relative',
                    width: '100%',
                    maxWidth: SIZE_MAP[size],
                    maxHeight: '90vh',
                    display: 'flex',
                    flexDirection: 'column',
                    backgroundColor: 'var(--pc-surface-card)',
                    borderRadius: 'var(--pc-radius-lg)',
                    border: '1px solid var(--pc-border-primary)',
                    boxShadow: 'var(--pc-shadow-xl)',
                    outline: 'none',
                    animation: 'pcModalIn 0.15s ease-out',
                }}
            >
                {/* Header */}
                {title && (
                    <div
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            justifyContent: 'space-between',
                            padding: '16px 20px',
                            borderBottom: '1px solid var(--pc-border-primary)',
                        }}
                    >
                        <h2
                            style={{
                                margin: 0,
                                fontSize: '16px',
                                fontWeight: 700,
                                color: 'var(--pc-text-primary)',
                                fontFamily: 'var(--pc-font-main)',
                            }}
                        >
                            {title}
                        </h2>
                        <button
                            onClick={onClose}
                            data-cy={rest['data-cy'] ? `${rest['data-cy']}-close` : 'btn-modal-close'}
                            aria-label="Close"
                            style={{
                                background: 'none',
                                border: 'none',
                                cursor: 'pointer',
                                padding: '4px',
                                color: 'var(--pc-text-tertiary)',
                                display: 'flex',
                                alignItems: 'center',
                                justifyContent: 'center',
                                borderRadius: 'var(--pc-radius-sm)',
                                transition: 'var(--pc-transition)',
                            }}
                            onMouseEnter={(e) => (e.currentTarget.style.color = 'var(--pc-text-primary)')}
                            onMouseLeave={(e) => (e.currentTarget.style.color = 'var(--pc-text-tertiary)')}
                        >
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                <line x1="18" y1="6" x2="6" y2="18" />
                                <line x1="6" y1="6" x2="18" y2="18" />
                            </svg>
                        </button>
                    </div>
                )}

                {/* Body */}
                <div
                    style={{
                        flex: 1,
                        overflow: 'auto',
                        padding: '20px',
                        color: 'var(--pc-text-primary)',
                        fontFamily: 'var(--pc-font-main)',
                    }}
                >
                    {children}
                </div>

                {/* Footer */}
                {footer && (
                    <div
                        style={{
                            display: 'flex',
                            justifyContent: 'flex-end',
                            gap: '8px',
                            padding: '12px 20px',
                            borderTop: '1px solid var(--pc-border-primary)',
                        }}
                    >
                        {footer}
                    </div>
                )}
            </div>

            {/* Animation keyframes */}
            <style>{`
                @keyframes pcModalIn {
                    from { opacity: 0; transform: scale(0.95) translateY(8px); }
                    to { opacity: 1; transform: scale(1) translateY(0); }
                }
            `}</style>
        </div>,
        document.body
    );
};

export default PcModal;
