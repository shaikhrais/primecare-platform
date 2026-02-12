import React, { useEffect, useState } from 'react';

export type ToastType = 'success' | 'error' | 'info' | 'warning';

interface ToastProps {
    message: string;
    type: ToastType;
    onClose: () => void;
    duration?: number;
}

export const Toast: React.FC<ToastProps> = ({ message, type, onClose, duration = 3000 }) => {
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        setIsVisible(true);
        const timer = setTimeout(() => {
            setIsVisible(false);
            setTimeout(onClose, 300); // Wait for exit animation
        }, duration);

        return () => clearTimeout(timer);
    }, [duration, onClose]);

    const getColors = () => {
        switch (type) {
            case 'success': return { bg: 'rgba(16, 185, 129, 0.9)', icon: '✅' };
            case 'error': return { bg: 'rgba(239, 68, 68, 0.9)', icon: '❌' };
            case 'warning': return { bg: 'rgba(245, 158, 11, 0.9)', icon: '⚠️' };
            default: return { bg: 'rgba(59, 130, 246, 0.9)', icon: 'ℹ️' };
        }
    };

    const { bg, icon } = getColors();

    return (
        <div
            data-cy="toast"
            style={{
                position: 'fixed',
                bottom: '24px',
                right: '24px',
                backgroundColor: bg,
                color: 'white',
                padding: '12px 20px',
                borderRadius: '8px',
                boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
                display: 'flex',
                alignItems: 'center',
                gap: '12px',
                zIndex: 9999,
                transition: 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                opacity: isVisible ? 1 : 0,
                transform: isVisible ? 'translateY(0) scale(1)' : 'translateY(20px) scale(0.95)',
                backdropFilter: 'blur(4px)',
                border: '1px solid rgba(255, 255, 255, 0.1)',
                fontFamily: 'var(--font-display, sans-serif)',
                fontWeight: 500
            }}
        >
            <span style={{ fontSize: '1.2em' }}>{icon}</span>
            <span>{message}</span>
            <button
                onClick={() => { setIsVisible(false); setTimeout(onClose, 300); }}
                style={{
                    background: 'none',
                    border: 'none',
                    color: 'white',
                    cursor: 'pointer',
                    opacity: 0.8,
                    fontSize: '1.1em',
                    marginLeft: '8px'
                }}
            >
                ✕
            </button>
        </div>
    );
};
