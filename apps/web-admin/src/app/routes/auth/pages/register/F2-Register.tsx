// ================================================================
// PAGE IDENTITY: F2 � Register
// Type: Form | Owner: auth
// ================================================================
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';
import { STRENGTH_COLORS, STRENGTH_LABELS, calculateStrength, handleRegisterAndLogin } from './registerHelpers';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function Register() {
    const { t } = useTranslation();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const [termsAccepted, setTermsAccepted] = useState(false);
    const navigate = useNavigate();

    const passwordStrength = calculateStrength(password);
    const searchParams = new URLSearchParams(window.location.search);
    const roleParam = searchParams.get('role') || 'client';

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true); setError(null);
        if (password !== confirmPassword) { setError('Passwords do not match'); setLoading(false); return; }
        if (!termsAccepted) { setError('Please accept the Terms & Conditions'); setLoading(false); return; }
        try { await handleRegisterAndLogin(email, password, roleParam, navigate); }
        catch (err: any) { setError(err.message || 'Network error. Please try again.'); }
        finally { setLoading(false); }
    };

    return (
        <div data-cy="page.container" style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', padding: '1rem', paddingBottom: '6rem', backgroundColor: 'var(--bg)', position: 'relative', boxSizing: 'border-box'
        }}>
            <div style={{ position: 'absolute', top: '20px', right: '24px', zIndex: 100 }}>
                <FlagLanguageSwitcher />
            </div>
            <div style={{
                padding: '2.5rem', backgroundColor: 'white', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.08)', width: '100%', maxWidth: '400px', border: '1px solid #f3f4f6'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.png" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }} data-cy="page.title">
                    {t(ContentRegistry.AUTH.REGISTER_TITLE)}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.9rem' }} data-cy="page.subtitle">
                    {t('auth.register_role_subtitle', { role: roleParam, defaultValue: `Create your ${roleParam} account` })}
                </p>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}

                <form data-cy="form-register" onSubmit={handleRegister}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t(ContentRegistry.AUTH.EMAIL_LABEL)}
                        </label>
                        <input
                            data-cy="inp-email"
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t(ContentRegistry.AUTH.PASSWORD_LABEL)}
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                data-cy="inp-password"
                                type={showPassword ? 'text' : 'password'}
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                                minLength={8}
                            />
                            <button data-cy="btn-register-0"
                                type="button"
                                onClick={() => setShowPassword(!showPassword)}
                                style={{ position: 'absolute', right: '0.5rem', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6B7280', padding: '4px' }}
                                tabIndex={-1}
                            >
                                {showPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                        {password.length > 0 && (
                            <div style={{ marginTop: '0.5rem' }}>
                                <div style={{ display: 'flex', gap: '4px', height: '4px', marginBottom: '4px' }}>
                                    {[1, 2, 3, 4].map((level) => (
                                        <div key={level} style={{ flex: 1, backgroundColor: passwordStrength >= level ? STRENGTH_COLORS[passwordStrength] : STRENGTH_COLORS[0], borderRadius: '2px', transition: 'background-color 0.3s' }} />
                                    ))}
                                </div>
                                <div style={{ fontSize: '0.75rem', color: STRENGTH_COLORS[passwordStrength], textAlign: 'right' }}>
                                    {STRENGTH_LABELS[passwordStrength]}
                                </div>
                            </div>
                        )}
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t('auth.confirm_password_label', { defaultValue: 'Confirm Password' })}
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                data-cy="inp-confirm-password"
                                type={showConfirmPassword ? 'text' : 'password'}
                                value={confirmPassword}
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                                minLength={8}
                            />
                            <button data-cy="btn-register-1"
                                type="button"
                                onClick={() => setShowConfirmPassword(!showConfirmPassword)}
                                style={{ position: 'absolute', right: '0.5rem', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6B7280', padding: '4px' }}
                                tabIndex={-1}
                            >
                                {showConfirmPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                    </div>

                    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem', marginBottom: '1.5rem' }}>
                        <input data-cy="input-register-0"
                            type="checkbox"
                            id="terms"
                            checked={termsAccepted}
                            onChange={(e) => setTermsAccepted(e.target.checked)}
                            style={{ accentColor: 'var(--brand-500)', width: '16px', height: '16px', marginTop: '2px', cursor: 'pointer' }}
                        />
                        <label htmlFor="terms" style={{ fontSize: '0.875rem', color: '#4B5563', lineHeight: '1.4' }}>
                            {t('auth.i_agree', { defaultValue: 'I agree to the ' })}
                            <a href="/terms" target="_blank" style={{ color: 'var(--brand-500)', textDecoration: 'none', fontWeight: '500' }}>Terms & Conditions</a>
                            {t('auth.and_privacy', { defaultValue: ' and ' })}
                            <a href="/privacy" target="_blank" style={{ color: 'var(--brand-500)', textDecoration: 'none', fontWeight: '500' }}>Privacy Policy</a>
                        </label>
                    </div>

                    <button
                        data-cy="btn-register-submit"
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? t('auth.registering', { defaultValue: 'Creating account...' }) : t('auth.register_submit', { defaultValue: 'Create Account' })}
                    </button>
                    <div style={{ marginTop: '1rem', textAlign: 'center' }}>
                        <a href={`/login?role=${roleParam}`} style={{ fontSize: '0.875rem', color: '#6b7280', textDecoration: 'none' }}>
                            {t('auth.already_have_account', { defaultValue: 'Already have an account? Login' })}
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
