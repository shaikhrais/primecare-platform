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
                position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.6)',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                zIndex: 9999, backdropFilter: 'blur(4px)'
            }}
            data-cy="modal-danger"
            role="dialog"
            aria-modal="true"
            aria-labelledby="danger-modal-title"
        >
            <div style={{
                backgroundColor: 'white', padding: '24px', borderRadius: '12px',
                maxWidth: '480px', width: '90%', borderTop: '6px solid #ef4444',
                boxShadow: '0 25px 50px -12px rgba(0, 0, 0, 0.25)'
            }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '16px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
                        <div style={{ backgroundColor: '#fee2e2', padding: '10px', borderRadius: '50%', color: '#ef4444' }}>
                            <AlertTriangle size={24} />
                        </div>
                        <h3 data-cy="h3-shared.danger-modal-0" id="danger-modal-title" style={{ margin: 0, fontSize: '1.25rem', fontWeight: 'bold', color: '#111827' }}>
                            {title}
                        </h3>
                    </div>
                    <button data-cy="btn-shared.danger-modal-0" onClick={onClose} style={{ background: 'none', border: 'none', cursor: 'pointer', padding: '4px', color: '#6b7280' }}>
                        <X size={20} />
                    </button>
                </div>

                <p style={{ margin: '0 0 16px 0', fontSize: '0.95rem', color: '#4b5563', lineHeight: '1.5' }}>
                    {description}
                </p>

                <div style={{ backgroundColor: '#f9fafb', padding: '16px', borderRadius: '8px', marginBottom: '20px', border: '1px solid #e5e7eb' }}>
                    <label style={{ display: 'block', marginBottom: '8px', fontSize: '0.875rem', fontWeight: 600, color: '#374151' }}>
                        {t('common.type_to_confirm', 'To confirm, type')} <strong style={{ userSelect: 'none', background: '#e5e7eb', padding: '2px 6px', borderRadius: '4px' }}>{targetName}</strong> {t('common.below', 'below:')}
                    </label>
                    <input
                        type="text"
                        value={inputValue}
                        onChange={handleInputChange}
                        data-cy="danger-modal-input"
                        placeholder={targetName}
                        style={{
                            width: '100%', padding: '10px 12px', borderRadius: '6px',
                            border: '1px solid #d1d5db', fontSize: '1rem', boxSizing: 'border-box',
                            outline: 'none', transition: 'border-color 0.15s ease-in-out',
                            ...(inputValue && !isMatch ? { borderColor: '#ef4444' } : {}),
                            ...(isMatch ? { borderColor: '#10b981', backgroundColor: '#ecfdf5' } : {})
                        }}
                    />
                </div>

                <div style={{ display: 'flex', gap: '12px', justifyContent: 'flex-end' }}>
                    <button data-cy="btn-shared.danger-modal-1"
                        type="button"
                        onClick={onClose}
                        style={{
                            padding: '10px 16px', borderRadius: '6px', border: '1px solid #d1d5db',
                            backgroundColor: 'white', color: '#374151', fontWeight: 600, cursor: 'pointer'
                        }}
                    >
                        {t('common.cancel', 'Cancel')}
                    </button>
                    <button data-cy="btn-shared.danger-modal-2"
                        type="button"
                        onClick={() => { if (isMatch) onConfirm(); }}
                        disabled={!isMatch}
                        data-cy="danger-modal-confirm"
                        style={{
                            padding: '10px 16px', borderRadius: '6px', border: 'none',
                            backgroundColor: '#ef4444', color: 'white', fontWeight: 600,
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
