import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';
import { useTranslation } from 'react-i18next';

const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function ForgotPassword() {
    const { t } = useTranslation();
    const [email, setEmail] = useState('');
    const [message, setMessage] = useState<string | null>(null);
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);
        setMessage(null);

        try {
            const response = await fetch(`${API_URL}/v1/auth/forgot-password`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
                body: JSON.stringify({ email }),
            });

            const data = await response.json();

            if (response.ok) {
                setMessage(t('auth.forgot_password_success', { defaultValue: data.message || 'Reset link sent to your email.' }));
                if (data.debug_token) {
                    console.log('DEBUG: Reset token:', data.debug_token);
                }
            } else {
                setError(data.error || t('auth.request_failed', { defaultValue: 'Request failed' }));
            }
        } catch (err) {
            setError(t('auth.network_error', { defaultValue: 'Network error. Please check your connection.' }));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: 'var(--bg)', position: 'relative'
        }} data-cy="forgot-password-page">
            <div style={{ position: 'absolute', top: '20px', right: '24px', zIndex: 100 }}>
                <FlagLanguageSwitcher />
            </div>
            <div style={{
                padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '12px', border: '1px solid var(--line)', boxShadow: 'var(--shadow-md)', width: '100%', maxWidth: '400px'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.png" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }} data-cy="page.title">
                    {t('auth.forgot_password_title', { defaultValue: 'Reset Password' })}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem' }} data-cy="page.subtitle">
                    {t('auth.forgot_password_subtitle', { defaultValue: 'Enter your email to receive a reset link.' })}
                </p>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}
                {message && <div style={{ marginBottom: '1rem', color: '#059669', fontSize: '0.875rem', textAlign: 'center' }}>{message}</div>}

                <form onSubmit={handleSubmit}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t(ContentRegistry.AUTH.EMAIL_LABEL || 'auth.email', { defaultValue: 'Email Address' })}
                        </label>
                        <input
                            data-cy="inp-forgot-email"
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <button
                        data-cy="btn-forgot-submit"
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? t('auth.sending', { defaultValue: 'Sending...' }) : t('auth.forgot_password_submit', { defaultValue: 'Send Reset Link' })}
                    </button>
                    <div style={{ marginTop: '1rem', textAlign: 'center' }}>
                        <a href="/login" style={{ fontSize: '0.875rem', color: '#6b7280', textDecoration: 'none' }}>
                            {t('auth.back_to_login', { defaultValue: 'Back to Login' })}
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
