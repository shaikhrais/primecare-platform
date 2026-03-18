// --- Merged from F4-ResetPassword.tsx ---
// ================================================================
// PAGE IDENTITY: F4 � Reset Password
// Type: Form | Owner: auth
// ================================================================
import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { AdminRegistry } from 'prime-care-shared';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';
import { useTranslation } from 'react-i18next';

const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export function ResetPassword() {
    const { t } = useTranslation();
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [message, setMessage] = useState<string | null>(null);
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const searchParams = new URLSearchParams(window.location.search);
    const token = searchParams.get('token');

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);
        setMessage(null);

        if (password !== confirmPassword) {
            setError(t('auth.passwords_do_not_match', { defaultValue: 'Passwords do not match' }));
            setLoading(false);
            return;
        }

        if (!token) {
            setError(t('auth.invalid_reset_token', { defaultValue: 'Invalid or missing reset token' }));
            setLoading(false);
            return;
        }

        try {
            const response = await fetch(`${API_URL}/v1/auth/reset-password`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
                body: JSON.stringify({ token, newPassword: password }),
            });

            const data = await response.json();

            if (response.ok) {
                setMessage(t('auth.password_reset_success', { defaultValue: 'Password reset successfully. Redirecting to login...' }));
                setTimeout(() => {
                    navigate(AdminRegistry.RouteRegistry.LOGIN);
                }, 2000);
            } else {
                setError(data.error || t('auth.reset_failed', { defaultValue: 'Reset failed' }));
            }
        } catch (err) {
            setError(t('auth.network_error', { defaultValue: 'Network error. Please check your connection.' }));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', padding: '1rem', paddingBottom: '5rem', backgroundColor: 'var(--bg)', position: 'relative', boxSizing: 'border-box'
        }} data-cy="page.container" role="main" aria-label="Reset Password">
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
                    {t('auth.set_new_password', { defaultValue: 'Set New Password' })}
                </h1>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}
                {message && <div style={{ marginBottom: '1rem', color: '#059669', fontSize: '0.875rem', textAlign: 'center' }}>{message}</div>}

                <form data-cy="form-reset-password" onSubmit={handleSubmit}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t('auth.new_password', { defaultValue: 'New Password' })}
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                data-cy="inp-reset-password"
                                type={showPassword ? 'text' : 'password'}
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                                minLength={8}
                            />
                            <button data-cy="btn-reset-password-0"
                                type="button"
                                onClick={() => setShowPassword(!showPassword)}
                                style={{ position: 'absolute', right: '0.5rem', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6b7280', padding: '4px' }}
                                tabIndex={-1}
                            >
                                {showPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t('auth.confirm_password_label', { defaultValue: 'Confirm Password' })}
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                data-cy="inp-reset-confirm"
                                type={showConfirmPassword ? 'text' : 'password'}
                                value={confirmPassword}
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                                minLength={8}
                            />
                            <button data-cy="btn-reset-password-1"
                                type="button"
                                onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                                style={{ position: 'absolute', right: '0.5rem', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6b7280', padding: '4px' }}
                                tabIndex={-1}
                            >
                                {showConfirmPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                    </div>
                    <button
                        data-cy="btn-reset-submit"
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? t('auth.resetting', { defaultValue: 'Resetting...' }) : t('auth.reset_password_submit', { defaultValue: 'Reset Password' })}
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

export default ResetPassword;
