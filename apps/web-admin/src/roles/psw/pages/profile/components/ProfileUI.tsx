import React, { useState } from 'react';

export function InputField({ label, name, value, type = 'text', disabled = false, placeholder = '', onChange, icon }: any) {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
            <label style={{ fontSize: '0.85rem', fontWeight: 800, color: '#374151', display: 'flex', alignItems: 'center', gap: '6px' }}>
                <span style={{ opacity: 0.7 }}>{icon}</span> {label}
            </label>
            <input
                type={type}
                name={name}
                value={value || ''}
                onChange={onChange}
                disabled={disabled}
                placeholder={placeholder}
                style={{
                    padding: '16px 20px',
                    borderRadius: '16px',
                    border: '1px solid #E5E7EB',
                    backgroundColor: disabled ? '#F3F4F6' : '#FFFFFF',
                    color: disabled ? '#6B7280' : '#111827',
                    fontWeight: 700,
                    fontSize: '1rem',
                    cursor: disabled ? 'not-allowed' : 'text',
                    transition: 'all 0.2s',
                    boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.02)'
                }}
            />
        </div>
    );
}

export function ToggleRow({ title, description, initialValue }: any) {
    const [enabled, setEnabled] = useState(initialValue);
    return (
        <div
            onClick={() => setEnabled(!enabled)}
            style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'center',
                padding: '24px',
                borderRadius: '24px',
                backgroundColor: '#F9FAFB',
                border: '1px solid #F3F4F6',
                cursor: 'pointer',
                transition: 'all 0.2s'
            }}
        >
            <div style={{ flex: 1 }}>
                <div style={{ fontWeight: 900, fontSize: '1.1rem', color: '#111827', textTransform: 'capitalize' }}>{title}</div>
                <div style={{ fontSize: '0.9rem', color: '#6B7280', fontWeight: 500 }}>{description}</div>
            </div>
            <div style={{
                width: '56px',
                height: '32px',
                backgroundColor: enabled ? '#00875A' : '#D1D5DB',
                borderRadius: '16px',
                position: 'relative',
                transition: 'all 0.3s cubic-bezier(0.16, 1, 0.3, 1)'
            }}>
                <div style={{
                    width: '24px',
                    height: '24px',
                    backgroundColor: 'white',
                    borderRadius: '50%',
                    position: 'absolute',
                    top: '4px',
                    left: enabled ? '28px' : '4px',
                    transition: 'all 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
                    boxShadow: '0 2px 4px rgba(0,0,0,0.2)'
                }} />
            </div>
        </div>
    );
}

export function DocWell({ title, sub, status, icon }: any) {
    const isExpiring = status === 'Expiring';
    return (
        <div style={{
            display: 'flex',
            flexDirection: 'column',
            gap: '16px',
            padding: '24px',
            backgroundColor: '#FFFFFF',
            border: `1px solid ${isExpiring ? '#FDE68A' : '#F3F4F6'}`,
            borderRadius: '24px',
            boxShadow: '0 4px 6px -1px rgba(0,0,0,0.02)',
            transition: 'all 0.3s ease'
        }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div style={{ fontSize: '2rem' }}>{icon}</div>
                <div style={{
                    padding: '4px 12px',
                    backgroundColor: isExpiring ? '#FFFBEB' : '#E6F4EF',
                    color: isExpiring ? '#92400E' : '#00875A',
                    borderRadius: '12px',
                    fontSize: '0.7rem',
                    fontWeight: 900,
                    textTransform: 'uppercase',
                    letterSpacing: '0.5px'
                }}>
                    {status}
                </div>
            </div>
            <div>
                <div style={{ fontWeight: 900, fontSize: '1rem', color: '#111827' }}>{title}</div>
                <div style={{ fontSize: '0.85rem', color: isExpiring ? '#B45309' : '#6B7280', fontWeight: 600, marginTop: '2px' }}>{sub}</div>
            </div>
        </div>
    );
}

export function PrimaryButton({ text, onClick, disabled }: any) {
    return (
        <button
            onClick={onClick}
            disabled={disabled}
            style={{
                padding: '16px 32px',
                backgroundColor: '#000000',
                color: 'white',
                border: 'none',
                borderRadius: '16px',
                fontWeight: 900,
                fontSize: '1rem',
                cursor: disabled ? 'not-allowed' : 'pointer',
                boxShadow: '0 10px 20px -5px rgba(0, 0, 0, 0.3)',
                transition: 'all 0.3s cubic-bezier(0.16, 1, 0.3, 1)',
                display: 'flex',
                alignItems: 'center',
                gap: '10px',
                opacity: disabled ? 0.7 : 1
            }}
            onMouseEnter={(e) => {
                if (!disabled) {
                    e.currentTarget.style.transform = 'translateY(-2px)';
                    e.currentTarget.style.backgroundColor = '#00875A';
                }
            }}
            onMouseLeave={(e) => {
                if (!disabled) {
                    e.currentTarget.style.transform = 'translateY(0)';
                    e.currentTarget.style.backgroundColor = '#000000';
                }
            }}
        >
            {text}
        </button>
    );
}
