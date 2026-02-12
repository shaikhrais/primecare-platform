import React, { useState, useEffect } from 'react';

const CookieConsent: React.FC = () => {
    const [isVisible, setIsVisible] = useState(false);

    useEffect(() => {
        const consent = localStorage.getItem('cookie-consent');
        if (!consent) {
            setIsVisible(true);
        }
    }, []);

    const handleAccept = (type: 'all' | 'essential') => {
        localStorage.setItem('cookie-consent', type);
        setIsVisible(false);
    };

    if (!isVisible) return null;

    return (
        <div data-cy="cookie-consent-bar" style={{
            position: 'fixed',
            bottom: '1.5rem',
            right: '1.5rem',
            left: '1.5rem',
            backgroundColor: 'white',
            padding: '1.5rem',
            borderRadius: '12px',
            boxShadow: '0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1)',
            border: '1px solid #e5e7eb',
            display: 'flex',
            flexDirection: 'column',
            gap: '1rem',
            zIndex: 1000,
            maxWidth: '500px',
            margin: '0 auto'
        }}>
            <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.75rem' }}>
                <div style={{
                    backgroundColor: '#ecfdf5',
                    color: '#059669',
                    padding: '0.5rem',
                    borderRadius: '50%',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                }}>
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M12 2a10 10 0 1 0 10 10 4 4 0 0 1-5-5 4 4 0 0 1-5-5" />
                        <path d="M8.5 8.5v.01" />
                        <path d="M16 15.5v.01" />
                        <path d="M12 12v.01" />
                        <path d="M11 17v.01" />
                        <path d="M7 14v.01" />
                    </svg>
                </div>
                <div>
                    <h3 style={{ margin: 0, fontSize: '1rem', fontWeight: 600, color: '#111827' }}>Cookie Consent</h3>
                    <p style={{ margin: '0.25rem 0 0', fontSize: '0.875rem', color: '#4b5563', lineHeight: 1.5 }}>
                        We use cookies to enhance your experience, serve personalized content, and analyze our traffic. Please choose your preferences.
                    </p>
                </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '0.75rem' }}>
                <button
                    data-cy="btn-cookie-essential"
                    onClick={() => handleAccept('essential')}
                    style={{
                        padding: '0.5rem 1rem',
                        fontSize: '0.875rem',
                        fontWeight: 500,
                        color: '#4b5563',
                        backgroundColor: 'transparent',
                        border: '1px solid #d1d5db',
                        borderRadius: '6px',
                        cursor: 'pointer'
                    }}
                >
                    Essential Only
                </button>
                <button
                    data-cy="btn-cookie-accept"
                    onClick={() => handleAccept('all')}
                    style={{
                        padding: '0.5rem 1rem',
                        fontSize: '0.875rem',
                        fontWeight: 500,
                        color: 'white',
                        backgroundColor: '#059669',
                        border: 'none',
                        borderRadius: '6px',
                        cursor: 'pointer'
                    }}
                >
                    Accept All
                </button>
            </div>
        </div>
    );
};

export default CookieConsent;
