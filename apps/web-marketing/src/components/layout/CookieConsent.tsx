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
            backgroundColor: 'rgba(255, 255, 255, 0.95)',
            backdropFilter: 'blur(8px)',
            padding: '1.25rem',
            borderRadius: '16px',
            boxShadow: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
            border: '1px solid rgba(229, 231, 235, 0.5)',
            display: 'flex',
            flexDirection: 'column',
            gap: '1rem',
            zIndex: 1000,
            maxWidth: '450px',
            margin: '0 auto',
            animation: 'slideUp 0.5s ease-out'
        }}>
            <style>
                {`
          @keyframes slideUp {
            from { transform: translateY(100%); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
          }
        `}
            </style>
            <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.75rem' }}>
                <div style={{
                    backgroundColor: '#059669',
                    color: 'white',
                    padding: '0.4rem',
                    borderRadius: '10px',
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center'
                }}>
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M12 2a10 10 0 1 0 10 10 4 4 0 0 1-5-5 4 4 0 0 1-5-5" />
                        <circle cx="8.5" cy="8.5" r="1.5" fill="currentColor" />
                        <circle cx="15.5" cy="15.5" r="1.5" fill="currentColor" />
                        <circle cx="12" cy="12" r="1" fill="currentColor" />
                        <circle cx="11" cy="17" r="1" fill="currentColor" />
                        <circle cx="7" cy="14" r="1" fill="currentColor" />
                    </svg>
                </div>
                <div>
                    <h3 style={{ margin: 0, fontSize: '0.95rem', fontWeight: 600, color: '#111827' }}>Privacy & Cookies</h3>
                    <p style={{ margin: '0.2rem 0 0', fontSize: '0.825rem', color: '#4b5563', lineHeight: 1.4 }}>
                        We use cookies to improve your experience on our site. By clicking "Accept All", you agree to our use of cookies.
                    </p>
                </div>
            </div>
            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '0.5rem' }}>
                <button
                    data-cy="btn-cookie-essential"
                    onClick={() => handleAccept('essential')}
                    style={{
                        padding: '0.4rem 0.8rem',
                        fontSize: '0.75rem',
                        fontWeight: 600,
                        color: '#6b7280',
                        backgroundColor: '#f3f4f6',
                        border: 'none',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        transition: 'background-color 0.2s'
                    }}
                >
                    Essential Only
                </button>
                <button
                    data-cy="btn-cookie-accept"
                    onClick={() => handleAccept('all')}
                    style={{
                        padding: '0.4rem 0.8rem',
                        fontSize: '0.75rem',
                        fontWeight: 600,
                        color: 'white',
                        backgroundColor: '#059669',
                        border: 'none',
                        borderRadius: '8px',
                        cursor: 'pointer',
                        transition: 'opacity 0.2s'
                    }}
                >
                    Accept All
                </button>
            </div>
        </div>
    );
};

export default CookieConsent;
