import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useTranslation } from 'react-i18next';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function Register() {
    const { t } = useTranslation();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const [showConfirmPassword, setShowConfirmPassword] = useState(false);
    const navigate = useNavigate();
    const searchParams = new URLSearchParams(window.location.search);
    const roleParam = searchParams.get('role') || 'client'; // Default to client

    const handleRegister = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        if (password !== confirmPassword) {
            setError('Passwords do not match');
            setLoading(false);
            return;
        }

        try {
            // 1. Register
            const registerResponse = await fetch(`${API_URL}${ApiRegistry.AUTH.REGISTER}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
                body: JSON.stringify({ email, password, role: roleParam }),
            });

            if (!registerResponse.ok) {
                const data = await registerResponse.json();
                throw new Error(data.error || 'Registration failed');
            }

            // 2. Auto-Login
            const loginResponse = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
                body: JSON.stringify({ email, password }),
            });

            if (loginResponse.ok) {
                const data = await loginResponse.json();
                localStorage.setItem('token', data.token);
                localStorage.setItem('user', JSON.stringify(data.user));
                navigate(RouteRegistry.ADMIN.DASHBOARD);
            } else {
                // If auto-login fails, redirect to login page
                navigate(`${RouteRegistry.LOGIN}?role=${roleParam}`);
            }

        } catch (err: any) {
            setError(err.message || 'Network error. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: 'var(--bg)', position: 'relative'
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
                    Create your {roleParam} account
                </p>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}

                <form onSubmit={handleRegister}>
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
                                style={{ width: '100%', padding: '0.5rem', paddingRight: '2.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                            />
                            <button type="button" data-cy="btn-toggle-password" onClick={() => setShowPassword(!showPassword)} style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6B7280', padding: '4px' }} tabIndex={-1}>
                                {showPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            Confirm Password
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                data-cy="inp-confirm-password"
                                name="confirmPassword"
                                type={showConfirmPassword ? 'text' : 'password'}
                                value={confirmPassword}
                                onChange={(e) => setConfirmPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.5rem', paddingRight: '2.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                                required
                            />
                            <button type="button" data-cy="btn-toggle-confirm" onClick={() => setShowConfirmPassword(!showConfirmPassword)} style={{ position: 'absolute', right: '8px', top: '50%', transform: 'translateY(-50%)', background: 'none', border: 'none', cursor: 'pointer', fontSize: '1.1rem', color: '#6B7280', padding: '4px' }} tabIndex={-1}>
                                {showConfirmPassword ? '🙈' : '👁️'}
                            </button>
                        </div>
                    </div>

                    <button
                        data-cy="btn-register"
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '4px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? 'Creating Account...' : t(ContentRegistry.AUTH.BUTTON_REGISTER)}
                    </button>

                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <a href={`${RouteRegistry.LOGIN}?role=${roleParam}`} style={{ fontSize: '0.875rem', color: 'var(--brand-500)', textDecoration: 'none' }}>
                            Already have an account? Sign in
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
