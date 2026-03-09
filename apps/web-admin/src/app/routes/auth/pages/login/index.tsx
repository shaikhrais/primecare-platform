import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

import { useAuth } from '@/shared/context/AuthContext';
import { useTheme } from '@/shared/context/ThemeContext';
import { useTranslation } from 'react-i18next';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';

export default function Login() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { login } = useAuth();
    const { branding } = useTheme();
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);

    // New Multi-Role States
    const [authStep, setAuthStep] = useState<'login' | 'select-role'>('login');
    const [tempUser, setTempUser] = useState<any>(null);
    const [tempToken, setTempToken] = useState<string | null>(null);

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        try {
            const response = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, password }),
                credentials: 'include'
            });

            if (response.ok) {
                const data = await response.json();

                const roles = data.user.roles || [data.user.role];

                if (roles.length > 1) {
                    setTempUser(data.user);
                    setTempToken(data.token);
                    setAuthStep('select-role');
                    setLoading(false);
                } else {
                    const activeRole = roles[0];
                    finalizeLogin(data.user, activeRole, data.token);
                }
            } else {
                const data = await response.json();
                // Ensure error is a string to avoid React crash #31
                const errorMessage = typeof data.error === 'object'
                    ? JSON.stringify(data.error)
                    : data.error || 'Login failed';
                setError(errorMessage);
            }
        } catch (err) {
            setError('Network error. Please check your connection.');
        } finally {
            setLoading(false);
        }
    };

    const finalizeLogin = (user: any, activeRole: string, token: string) => {
        const userWithActiveRole = { ...user, activeRole };
        login(userWithActiveRole, token);

        const target = RouteRegistry.ROLE_DASHBOARDS[activeRole] || RouteRegistry.ADMIN.DASHBOARD;
        navigate(target);
    };

    if (authStep === 'select-role' && tempUser) {
        return (
            <div style={{
                display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: 'var(--bg)'
            }}>
                <div style={{
                    padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '8px', border: '1px solid var(--line)', width: '100%', maxWidth: '400px', boxShadow: 'var(--shadow-md)'
                }}>
                    <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                        <img src="/logo.png" alt="PrimeCare" style={{ width: '120px', height: 'auto' }} />
                    </div>
                    <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '1rem', textAlign: 'center' }}>
                        Select Your Perspective
                    </h1>
                    <p style={{ textAlign: 'center', color: 'var(--text-300)', marginBottom: '2rem' }}>
                        Your account has multiple roles. How would you like to continue?
                    </p>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                        {tempUser.roles.map((role: string) => (
                            <button
                                key={role}
                                data-cy={`btn-select-role-${role}`}
                                onClick={() => finalizeLogin(tempUser, role, tempToken!)}
                                style={{
                                    padding: '1rem',
                                    borderRadius: '8px',
                                    border: '1px solid var(--line)',
                                    backgroundColor: '#FFFFFF',
                                    cursor: 'pointer',
                                    textAlign: 'left',
                                    fontWeight: '600',
                                    display: 'flex',
                                    justifyContent: 'space-between',
                                    alignItems: 'center',
                                    transition: 'var(--pc-transition)'
                                }}
                                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--bg-800)'}
                                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#FFFFFF'}
                            >
                                <span style={{ textTransform: 'capitalize' }}>{role} Dashboard</span>
                                <span style={{ color: 'var(--brand-500)' }}>→</span>
                            </button>
                        ))}
                    </div>
                </div>
            </div>
        );
    }

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: 'var(--bg)', position: 'relative'
        }}>
            {/* Language Switcher — top-right corner */}
            <div style={{ position: 'absolute', top: '20px', right: '24px', zIndex: 100 }}>
                <FlagLanguageSwitcher />
            </div>
            <div style={{
                padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '8px', border: '1px solid var(--line)', width: '100%', maxWidth: '400px', boxShadow: 'var(--shadow-md)'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src={branding?.logoUrl || "/logo.png"} alt={branding?.name || "PrimeCare"} data-cy="logo" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }} data-cy="page.title">
                    {t(ContentRegistry.AUTH.LOGIN_TITLE)}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.9rem' }} data-cy="page.subtitle">
                    Sign in to access your dashboard
                </p>

                {error && <div data-cy="login-error" style={{ marginBottom: '1.1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center', backgroundColor: '#fee2e2', padding: '0.5rem', borderRadius: '4px' }}>{error}</div>}

                <form onSubmit={handleLogin}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t(ContentRegistry.AUTH.EMAIL_LABEL)}
                        </label>
                        <input
                            data-cy="inp-email"
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.6rem', border: '1px solid var(--line)', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {t(ContentRegistry.AUTH.PASSWORD_LABEL)}
                        </label>
                        <input
                            data-cy="inp-password"
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            style={{ width: '100%', padding: '0.6rem', border: '1px solid var(--line)', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: '1.5rem' }}>
                        <a href="/forgot-password" data-cy="link-forgot-password" style={{ fontSize: '0.875rem', color: 'var(--brand-500)', textDecoration: 'none' }}>
                            Forgot password?
                        </a>
                    </div>
                    <button
                        data-cy="btn-login"
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '4px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? 'Authenticating...' : t(ContentRegistry.AUTH.BUTTON)}
                    </button>

                    <div style={{ marginTop: '1rem', position: 'relative', textAlign: 'center' }}>
                        <div style={{ position: 'absolute', top: '50%', left: 0, right: 0, height: '1px', backgroundColor: 'var(--line)', zIndex: 1 }}></div>
                        <span style={{ position: 'relative', backgroundColor: '#FFFFFF', padding: '0 10px', fontSize: '0.75rem', color: '#6B7280', zIndex: 2 }}>OR</span>
                    </div>

                    <button
                        type="button"
                        onClick={() => window.location.href = `${API_URL}/v1/auth/osm`}
                        data-cy="btn-auth-osm-login"
                        style={{
                            marginTop: '1rem', width: '100%', padding: '0.75rem', backgroundColor: '#FFFFFF', color: '#111827', border: '1px solid var(--line)', borderRadius: '4px', fontWeight: '600', cursor: 'pointer', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '8px'
                        }}
                        onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#F9FAFB'}
                        onMouseLeave={(e) => e.currentTarget.style.backgroundColor = '#FFFFFF'}
                    >
                        <svg width="20" height="20" viewBox="0 0 256 256" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M128 0C57.312 0 0 57.312 0 128s57.312 128 128 128 128-57.312 128-128S198.688 0 128 0zm0 21.333c58.91 0 106.667 47.757 106.667 106.667S186.91 234.667 128 234.667 21.333 186.91 21.333 128 69.09 21.333 128 21.333z" fill="#7EBC6F" />
                            <path d="M128 42.667c47.128 0 85.333 38.205 85.333 85.333S175.128 213.333 128 213.333 42.667 175.128 42.667 128 80.872 42.667 128 42.667z" fill="#7EBC6F" />
                        </svg>
                        Sign in with OpenStreetMap
                    </button>

                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <a href={RouteRegistry.REGISTER} data-cy="link-register" style={{ fontSize: '0.875rem', color: 'var(--brand-500)', textDecoration: 'none' }}>
                            {t(ContentRegistry.AUTH.SIGNUP_LINK)}
                        </a>
                    </div>
                    <div style={{ marginTop: '0.5rem', textAlign: 'center' }}>
                        <a href={RouteRegistry.BUSINESS_ONBOARD} style={{ fontSize: '0.875rem', color: '#6B7280', textDecoration: 'none' }}>
                            Launching a business? <span style={{ color: 'var(--brand-500)', fontWeight: '600' }}>Register as a Provider</span>
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
