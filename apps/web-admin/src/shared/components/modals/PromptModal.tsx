import React, { useState, useEffect, useRef } from 'react';
import { Edit3, X } from 'lucide-react';

/* ─────────────────────────────────────────────────────────────────────────────
 * PromptModal — Modal with a text input field + Cancel/Submit buttons.
 * Replaces native window.prompt() with a styled, accessible modal.
 * ────────────────────────────────────────────────────────────────────────── */

interface PromptModalProps {
    isOpen: boolean;
    title: string;
    message: string;
    placeholder?: string;
    defaultValue?: string;
    submitLabel?: string;
    cancelLabel?: string;
    onSubmit: (value: string) => void;
    onCancel: () => void;
}

export const PromptModal: React.FC<PromptModalProps> = ({
    isOpen, title, message, placeholder, defaultValue,
    submitLabel, cancelLabel, onSubmit, onCancel
}) => {
    const [inputValue, setInputValue] = useState(defaultValue || '');
    const inputRef = useRef<HTMLInputElement>(null);

    useEffect(() => {
        if (isOpen) {
            setInputValue(defaultValue || '');
            setTimeout(() => inputRef.current?.focus(), 100);
        }
    }, [isOpen, defaultValue]);

    useEffect(() => {
        if (!isOpen) return;
        const handler = (e: KeyboardEvent) => { if (e.key === 'Escape') onCancel(); };
        window.addEventListener('keydown', handler);
        return () => window.removeEventListener('keydown', handler);
    }, [isOpen, onCancel]);

    if (!isOpen) return null;

    const handleSubmit = () => {
        if (inputValue.trim()) onSubmit(inputValue.trim());
    };

    return (
        <div
            style={{
                position: 'fixed', inset: 0, backgroundColor: 'rgba(15,23,42,0.6)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                zIndex: 99999, backdropFilter: 'blur(4px)',
                animation: 'promptFadeIn 0.15s ease-out'
            }}
            data-cy="modal-prompt"
            role="dialog"
            aria-modal="true"
            aria-labelledby="prompt-modal-title"
            onClick={(e) => { if (e.target === e.currentTarget) onCancel(); }}
        >
            <div style={{
                backgroundColor: 'white', padding: '24px', borderRadius: '12px',
                maxWidth: '440px', width: '90%', borderTop: '5px solid #3b82f6',
                boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25)',
                animation: 'promptSlideUp 0.2s cubic-bezier(0.175,0.885,0.32,1.275)'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <div style={{ backgroundColor: '#dbeafe', padding: '10px', borderRadius: '50%', color: '#3b82f6' }}>
                            <Edit3 size={22} />
                        </div>
                        <h3 id="prompt-modal-title" style={{ margin: 0, fontSize: '1.15rem', fontWeight: 700, color: '#0f172a' }}>
                            {title}
                        </h3>
                    </div>
                    <button
                        onClick={onCancel}
                        data-cy="prompt-modal-close"
                        style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '4px', color: '#94a3b8' }}
                    >
                        <X size={18} />
                    </button>
                </div>

                <p style={{ margin: '0 0 16px 0', fontSize: '0.95rem', color: '#475569', lineHeight: '1.6' }}>
                    {message}
                </p>

                <input
                    ref={inputRef}
                    type="text"
                    value={inputValue}
                    onChange={(e) => setInputValue(e.target.value)}
                    onKeyDown={(e) => { if (e.key === 'Enter') handleSubmit(); }}
                    placeholder={placeholder || 'Enter value...'}
                    data-cy="prompt-modal-input"
                    style={{
                        width: '100%', padding: '12px', borderRadius: '8px',
                        border: '2px solid #e2e8f0', fontSize: '1rem', boxSizing: 'border-box',
                        outline: 'none', marginBottom: '20px',
                        transition: 'border-color 0.15s ease',
                    }}
                    onFocus={(e) => { e.target.style.borderColor = '#3b82f6'; }}
                    onBlur={(e) => { e.target.style.borderColor = '#e2e8f0'; }}
                />

                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                    <button
                        onClick={onCancel}
                        data-cy="prompt-modal-cancel"
                        style={{
                            padding: '10px 18px', borderRadius: '8px', border: '1px solid #e2e8f0',
                            backgroundColor: 'white', color: '#475569', fontWeight: 600,
                            cursor: 'pointer', fontSize: '0.9rem'
                        }}
                    >
                        {cancelLabel || 'Cancel'}
                    </button>
                    <button
                        onClick={handleSubmit}
                        disabled={!inputValue.trim()}
                        data-cy="prompt-modal-submit"
                        style={{
                            padding: '10px 18px', borderRadius: '8px', border: 'none',
                            backgroundColor: inputValue.trim() ? '#3b82f6' : '#cbd5e1',
                            color: 'white', fontWeight: 600,
                            cursor: inputValue.trim() ? 'pointer' : 'not-allowed',
                            fontSize: '0.9rem', transition: 'all 0.15s'
                        }}
                    >
                        {submitLabel || 'Submit'}
                    </button>
                </div>
            </div>

            <style>{`
                @keyframes promptFadeIn { from { opacity: 0; } to { opacity: 1; } }
                @keyframes promptSlideUp { from { transform: translateY(8px) scale(0.97); opacity: 0; } to { transform: translateY(0) scale(1); opacity: 1; } }
            `}</style>
        </div>
    );
};

export default PromptModal;
