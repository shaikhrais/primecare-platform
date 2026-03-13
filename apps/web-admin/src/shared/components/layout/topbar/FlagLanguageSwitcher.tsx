import React, { useState, useRef, useEffect } from 'react';
import { useTranslation } from 'react-i18next';

const LANGUAGES = [
    { code: 'en', label: 'English', flag: '🇺🇸' },
    { code: 'fr', label: 'Français', flag: '🇫🇷' },
];

export default function FlagLanguageSwitcher() {
    const { i18n } = useTranslation();
    const [open, setOpen] = useState(false);
    const ref = useRef<HTMLDivElement>(null);

    const current = LANGUAGES.find(l => l.code === i18n.language) || LANGUAGES[0];

    useEffect(() => {
        const close = (e: MouseEvent) => {
            if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
        };
        document.addEventListener('mousedown', close);
        return () => document.removeEventListener('mousedown', close);
    }, []);

    const handleSelect = (code: string) => {
        i18n.changeLanguage(code);
        setOpen(false);
    };

    return (
        <div data-cy="page.container" ref={ref} style={{ position: 'relative' }}>
            {/* Trigger Button */}
            <button data-cy="btn-shared.flag-language-switcher-0"
                onClick={() => setOpen(!open)}
                aria-label="Change language"
                aria-expanded={open}
                style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '6px',
                    padding: '6px 14px',
                    borderRadius: '10px',
                    border: '1px solid #E5E7EB',
                    backgroundColor: open ? '#F3F4F6' : '#FFFFFF',
                    cursor: 'pointer',
                    fontSize: '0.85rem',
                    fontWeight: '700',
                    color: '#374151',
                    transition: 'all 0.15s ease',
                    boxShadow: open ? 'inset 0 1px 3px rgba(0,0,0,0.06)' : '0 1px 3px rgba(0,0,0,0.04)',
                }}
            >
                <span style={{ fontSize: '1.2rem', lineHeight: 1 }}>{current.flag}</span>
                <span>{current.code.toUpperCase()}</span>
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5"
                    style={{ transform: open ? 'rotate(180deg)' : 'rotate(0)', transition: 'transform 0.2s ease' }}>
                    <path d="M6 9l6 6 6-6" />
                </svg>
            </button>

            {/* Dropdown */}
            {open && (
                <div style={{
                    position: 'absolute',
                    top: 'calc(100% + 6px)',
                    right: 0,
                    minWidth: '180px',
                    backgroundColor: '#FFFFFF',
                    borderRadius: '12px',
                    border: '1px solid #E5E7EB',
                    boxShadow: '0 12px 32px rgba(0,0,0,0.12), 0 2px 6px rgba(0,0,0,0.04)',
                    zIndex: 9999,
                    overflow: 'hidden',
                    animation: 'fadeSlideDown 0.15s ease',
                }}>
                    <div style={{ padding: '6px' }}>
                        {LANGUAGES.map(lang => (
                            <button data-cy="btn-shared.flag-language-switcher-1"
                                key={lang.code}
                                onClick={() => handleSelect(lang.code)}
                                style={{
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '10px',
                                    width: '100%',
                                    padding: '10px 14px',
                                    border: 'none',
                                    borderRadius: '8px',
                                    backgroundColor: lang.code === current.code ? '#F0F9FF' : 'transparent',
                                    cursor: 'pointer',
                                    fontSize: '0.9rem',
                                    fontWeight: lang.code === current.code ? '700' : '500',
                                    color: lang.code === current.code ? '#0369A1' : '#374151',
                                    transition: 'background-color 0.1s ease',
                                }}
                                onMouseEnter={e => {
                                    if (lang.code !== current.code)
                                        (e.target as HTMLButtonElement).style.backgroundColor = '#F9FAFB';
                                }}
                                onMouseLeave={e => {
                                    if (lang.code !== current.code)
                                        (e.target as HTMLButtonElement).style.backgroundColor = 'transparent';
                                }}
                            >
                                <span style={{ fontSize: '1.4rem', lineHeight: 1 }}>{lang.flag}</span>
                                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-start' }}>
                                    <span>{lang.label}</span>
                                    <span style={{ fontSize: '0.7rem', color: '#9CA3AF', fontWeight: '400' }}>
                                        {lang.code.toUpperCase()}
                                    </span>
                                </div>
                                {lang.code === current.code && (
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#0369A1" strokeWidth="3"
                                        style={{ marginLeft: 'auto' }}>
                                        <path d="M20 6L9 17l-5-5" />
                                    </svg>
                                )}
                            </button>
                        ))}
                    </div>
                </div>
            )}

            <style>{`
                @keyframes fadeSlideDown {
                    from { opacity: 0; transform: translateY(-4px); }
                    to { opacity: 1; transform: translateY(0); }
                }
            `}</style>
        </div>
    );
}
