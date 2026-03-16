import React, { useState, useEffect } from 'react';
import { AlertTriangle, X } from 'lucide-react';
import { useTranslation } from 'react-i18next';

interface DangerModalProps {
    isOpen: boolean;
    title: string;
    description: string;
    targetName: string;
    onClose: () => void;
    onConfirm: () => void;
}

export const DangerModal: React.FC<DangerModalProps> = ({
    isOpen,
    title,
    description,
    targetName,
    onClose,
    onConfirm
}) => {
    const { t } = useTranslation();
    const [inputValue, setInputValue] = useState('');
    const [isMatch, setIsMatch] = useState(false);

    useEffect(() => {
        if (!isOpen) {
            setInputValue('');
            setIsMatch(false);
        }
    }, [isOpen]);

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const val = e.target.value;
        setInputValue(val);
        setIsMatch(val === targetName);
    };

    if (!isOpen) return null;

    return (
        <div
            style={{
                position: 'fixed', inset: 0, backgroundColor: 'var(--pc-bg-overlay)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                zIndex: 9999, backdropFilter: 'blur(4px)'
            }}
            data-cy="modal-danger"
            role="dialog"
            aria-modal="true"
            aria-labelledby="danger-modal-title"
        >
            <div style={{
                backgroundColor: 'var(--pc-surface-card)', padding: '24px', borderRadius: 'var(--pc-radius-lg)',
                maxWidth: '480px', width: '90%', borderTop: '6px solid var(--pc-error)',
                boxShadow: 'var(--pc-shadow-xl)'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <div style={{ backgroundColor: 'var(--pc-error-bg)', padding: '10px', borderRadius: '50%', color: 'var(--pc-error)' }}>
                            <AlertTriangle size={24} />
                        </div>
                        <h3 data-cy="h3-shared.danger-modal-0" id="danger-modal-title" style={{ margin: 0, fontSize: '1.25rem', fontWeight: 'bold', color: 'var(--pc-text-primary)' }}>
                            {title}
                        </h3>
                    </div>
                    <button data-cy="btn-shared.danger-modal-0" onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '4px', color: 'var(--pc-text-tertiary)' }}>
                        <X size={20} />
                    </button>
                </div>

                <p style={{ margin: '0 0 16px 0', fontSize: '0.95rem', color: 'var(--pc-text-secondary)', lineHeight: '1.5' }}>
                    {description}
                </p>

                <div style={{ backgroundColor: 'var(--pc-bg-secondary)', padding: '16px', borderRadius: 'var(--pc-radius-md)', marginBottom: '20px', border: '1px solid var(--pc-border-primary)' }}>
                    <label style={{ display: 'block', marginBottom: '8px', fontSize: '0.875rem', fontWeight: 600, color: 'var(--pc-text-primary)' }}>
                        {t('common.type_to_confirm', 'To confirm, type')} <strong style={{ userSelect: 'none', background: 'var(--pc-bg-tertiary)', padding: '2px 6px', borderRadius: '4px' }}>{targetName}</strong> {t('common.below', 'below:')}
                    </label>
                    <input
                        type="text"
                        value={inputValue}
                        onChange={handleInputChange}
                        data-cy="danger-modal-input"
                        placeholder={targetName}
                        style={{
                            width: '100%', padding: '10px 12px', borderRadius: '6px',
                            border: '1px solid var(--pc-border-secondary)', fontSize: '1rem', boxSizing: 'border-box',
                            outline: 'none', transition: 'border-color 0.15s ease-in-out',
                            backgroundColor: 'var(--pc-surface-card)', color: 'var(--pc-text-primary)',
                            ...(inputValue && !isMatch ? { borderColor: 'var(--pc-error)' } : {}),
                            ...(isMatch ? { borderColor: 'var(--pc-success)', backgroundColor: 'var(--pc-success-bg)' } : {})
                        }}
                    />
                </div>

                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                    <button data-cy="btn-shared.danger-modal-1"
                        type="button"
                        onClick={onClose}
                        style={{
                            padding: '10px 16px', borderRadius: '6px', border: '1px solid var(--pc-border-secondary)',
                            backgroundColor: 'var(--pc-surface-card)', color: 'var(--pc-text-primary)', fontWeight: 600, cursor: 'pointer'
                        }}
                    >
                        {t('common.cancel', 'Cancel')}
                    </button>
                    <button
                        type="button"
                        onClick={() => { if (isMatch) onConfirm(); }}
                        disabled={!isMatch}
                        data-cy="danger-modal-confirm"
                        style={{
                            padding: '10px 16px', borderRadius: '6px', border: 'none',
                            backgroundColor: 'var(--pc-error)', color: 'var(--pc-text-on-primary)', fontWeight: 600,
                            cursor: isMatch ? 'pointer' : 'not-allowed',
                            opacity: isMatch ? 1 : 0.5,
                            transition: 'all 0.15s ease-in-out'
                        }}
                    >
                        {t('common.confirm_delete', 'Confirm Delete')}
                    </button>
                </div>
            </div>
        </div>
    );
};

export default DangerModal;
