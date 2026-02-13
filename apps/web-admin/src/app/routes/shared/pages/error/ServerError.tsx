import React from 'react';
import { useNavigate } from 'react-router-dom';

export default function ServerError() {
    const navigate = useNavigate();

    return (
        <div style={{
            minHeight: '100vh',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            padding: '2rem',
            backgroundColor: '#FFFFFF',
            textAlign: 'center',
            fontFamily: 'system-ui, -apple-system, sans-serif'
        }}>
            <div style={{ marginBottom: '2rem' }}>
                <img src="/logo.png" alt="PrimeCare" style={{ height: '48px', width: 'auto' }} />
            </div>

            <div style={{ fontSize: '120px', fontWeight: 900, color: '#DBEAFE', lineHeight: 1, marginBottom: '1rem' }}>500</div>

            <h1 style={{ fontSize: '2.5rem', fontWeight: 900, color: '#111827', margin: '0 0 1rem 0' }}>Something went wrong</h1>
            <p style={{ fontSize: '1.125rem', color: '#6B7280', maxWidth: '400px', margin: '0 0 2.5rem 0', lineHeight: 1.6 }}>
                Our server encountered an internal error. We've been notified and are working to fix it.
            </p>

            <div style={{ display: 'flex', gap: '1rem' }}>
                <button
                    onClick={() => window.location.reload()}
                    style={{
                        padding: '12px 24px',
                        backgroundColor: '#F3F4F6',
                        color: '#111827',
                        border: 'none',
                        borderRadius: '12px',
                        fontWeight: 700,
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'all 0.2s'
                    }}
                >
                    🔄 Try Again
                </button>
                <button
                    onClick={() => navigate('/')}
                    style={{
                        padding: '12px 24px',
                        backgroundColor: '#00875A',
                        color: '#FFFFFF',
                        border: 'none',
                        borderRadius: '12px',
                        fontWeight: 700,
                        fontSize: '1rem',
                        cursor: 'pointer',
                        transition: 'all 0.2s',
                        boxShadow: '0 4px 14px 0 rgba(0, 135, 90, 0.3)'
                    }}
                >
                    Go Home
                </button>
            </div>

            <style>{`
                button:hover {
                    transform: translateY(-2px);
                    filter: brightness(0.95);
                }
                button:active {
                    transform: translateY(0);
                }
            `}</style>
        </div>
    );
}
