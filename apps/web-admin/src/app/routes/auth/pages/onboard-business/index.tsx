import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';
import { useTranslation } from 'react-i18next';
import { useAuth } from '@/shared/context/AuthContext';

const { ApiRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function OnboardBusiness() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const { login } = useAuth();

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [tenantName, setTenantName] = useState('');
    const [tenantSlug, setTenantSlug] = useState('');

    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const [showPassword, setShowPassword] = useState(false);
    const [termsAccepted, setTermsAccepted] = useState(false);
    const [slugAvailable, setSlugAvailable] = useState<boolean | null>(null);
    const [checkingSlug, setCheckingSlug] = useState(false);
    const typingTimeoutRef = React.useRef<ReturnType<typeof setTimeout> | null>(null);

    // Password strength logic
    const calculateStrength = (pass: string) => {
        let score = 0;
        if (pass.length >= 8) score += 1;
        if (/[A-Z]/.test(pass)) score += 1;
        if (/[0-9]/.test(pass)) score += 1;
        if (/[^A-Za-z0-9]/.test(pass)) score += 1;
        return score; // 0 to 4
    };
    const passwordStrength = calculateStrength(password);
    const strengthColors = ['#e5e7eb', '#ef4444', '#f59e0b', '#3b82f6', '#10b981'];
    const strengthLabels = ['Too Short', 'Weak', 'Fair', 'Good', 'Strong'];

    const handleSlugChange = (val: string) => {
        setTenantSlug(val);
        setSlugAvailable(null);
        if (val.length < 3) return;

        setCheckingSlug(true);
        if (typingTimeoutRef.current) clearTimeout(typingTimeoutRef.current);

        typingTimeoutRef.current = setTimeout(() => {
            // Mock API validation delay
            setSlugAvailable(val !== 'admin' && val !== 'primecare' && val !== 'test');
            setCheckingSlug(false);
        }, 600);
    };

    const handleOnboard = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        if (!termsAccepted) {
            setError('Please accept the Terms & Conditions to proceed.');
            setLoading(false);
            return;
        }

        if (slugAvailable === false) {
            setError('The selected portal slug is not available.');
            setLoading(false);
            return;
        }

        try {
            const response = await fetch(`${API_URL}/v1/auth/onboard-business`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
                body: JSON.stringify({ email, password, tenantName, tenantSlug }),
                credentials: 'include'
            });

            if (response.ok) {
                const data = await response.json();
                login({ ...data.user, activeRole: 'admin' }, data.token);
                navigate(RouteRegistry.ADMIN.SETUP_WIZARD);
            } else {
                const data = await response.json();
                setError(data.error || t('auth.onboarding_failed', { defaultValue: 'Onboarding failed' }));
            }
        } catch (err) {
            setError(t('auth.network_error', { defaultValue: 'Network error. Please try again.' }));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', backgroundColor: 'var(--bg)', padding: '1rem', paddingBottom: '6rem', position: 'relative', boxSizing: 'border-box'
        }}>
            <div style={{ position: 'absolute', top: '20px', right: '24px', zIndex: 100 }}>
                <FlagLanguageSwitcher />
            </div>
            <div style={{
                padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '12px', border: '1px solid var(--line)', width: '100%', maxWidth: '450px', boxShadow: 'var(--shadow-lg)'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.png" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>

                <h1 style={{ fontSize: '1.75rem', fontWeight: 'bold', marginBottom: '0.5rem', textAlign: 'center', color: '#111827' }}>
                    {t('auth.start_your_business', { defaultValue: 'Start Your Care Business' })}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.95rem' }}>
                    {t('auth.start_business_subtitle', { defaultValue: 'Create your organization and launch your platform in minutes.' })}
                </p>

                {error && <div style={{ marginBottom: '1.5rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center', backgroundColor: '#fee2e2', padding: '0.75rem', borderRadius: '6px' }}>{error}</div>}

                <form onSubmit={handleOnboard}>
                    <div style={{ marginBottom: '1.25rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>
                            {t('auth.business_name', { defaultValue: 'Business Name' })}
                        </label>
                        <input
                            type="text"
                            placeholder="e.g. PrimeCare North"
                            value={tenantName}
                            onChange={(e) => {
                                setTenantName(e.target.value);
                                if (!tenantSlug) setTenantSlug(e.target.value.toLowerCase().replace(/ /g, '-').replace(/[^\w-]/g, ''));
                            }}
                            style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>

                    <div style={{ marginBottom: '1.25rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>
                            {t('auth.portal_slug', { defaultValue: 'Portal Slug (URL)' })}
                        </label>
                        <div style={{ display: 'flex', alignItems: 'center', border: slugAvailable === false ? '1px solid #dc2626' : slugAvailable === true ? '1px solid #10b981' : '1px solid var(--line)', borderRadius: '6px', overflow: 'hidden', position: 'relative' }}>
                            <span style={{ padding: '0.75rem', backgroundColor: '#F3F4F6', color: '#6B7280', borderRight: '1px solid var(--line)', fontSize: '0.875rem' }}>pc.ca/</span>
                            <input
                                type="text"
                                placeholder="my-business"
                                value={tenantSlug}
                                onChange={(e) => handleSlugChange(e.target.value)}
                                style={{ width: '100%', padding: '0.75rem', border: 'none', boxSizing: 'border-box', outline: 'none' }}
                                required
                            />
                            <div style={{ position: 'absolute', right: '12px', display: 'flex', alignItems: 'center' }}>
                                {checkingSlug && <span style={{ width: '16px', height: '16px', border: '2px solid #e5e7eb', borderTopColor: 'var(--brand-500)', borderRadius: '50%', animation: 'spin 1s linear infinite' }}></span>}
                                {!checkingSlug && slugAvailable === true && <span style={{ color: '#10b981', fontSize: '1.2rem', fontWeight: 'bold' }}>✓</span>}
                                {!checkingSlug && slugAvailable === false && <span style={{ color: '#dc2626', fontSize: '1.2rem', fontWeight: 'bold' }}>✗</span>}
                            </div>
                        </div>
                        {!checkingSlug && slugAvailable === false && (
                            <div style={{ marginTop: '0.25rem', fontSize: '0.75rem', color: '#dc2626' }}>Slug is already taken.</div>
                        )}
                        {!checkingSlug && slugAvailable === true && (
                            <div style={{ marginTop: '0.25rem', fontSize: '0.75rem', color: '#10b981' }}>Slug is available!</div>
                        )}
                        <style>{`@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }`}</style>
                    </div>

                    <hr style={{ margin: '2rem 0', border: 'none', borderTop: '1px solid var(--line)' }} />

                    <div style={{ marginBottom: '1.25rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>
                            {t('auth.admin_email', { defaultValue: 'Admin Email' })}
                        </label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>
                            {t('auth.admin_password', { defaultValue: 'Admin Password' })}
                        </label>
                        <div style={{ position: 'relative' }}>
                            <input
                                type={showPassword ? 'text' : 'password'}
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                                required
                                minLength={8}
                            />
                            <button
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
                                        <div key={level} style={{ flex: 1, backgroundColor: passwordStrength >= level ? strengthColors[passwordStrength] : strengthColors[0], borderRadius: '2px', transition: 'background-color 0.3s' }} />
                                    ))}
                                </div>
                                <div style={{ fontSize: '0.75rem', color: strengthColors[passwordStrength], textAlign: 'right' }}>
                                    {strengthLabels[passwordStrength]}
                                </div>
                            </div>
                        )}
                    </div>

                    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem', marginBottom: '1.5rem' }}>
                        <input
                            type="checkbox"
                            id="terms_onboard"
                            checked={termsAccepted}
                            onChange={(e) => setTermsAccepted(e.target.checked)}
                            style={{ accentColor: 'var(--brand-500)', width: '16px', height: '16px', marginTop: '2px', cursor: 'pointer' }}
                        />
                        <label htmlFor="terms_onboard" style={{ fontSize: '0.875rem', color: '#4B5563', lineHeight: '1.4' }}>
                            {t('auth.i_agree', { defaultValue: 'I agree to the ' })}
                            <a href="/terms" target="_blank" style={{ color: 'var(--brand-500)', textDecoration: 'none', fontWeight: '500' }}>Terms of Service</a>
                            {t('auth.and_privacy', { defaultValue: ' and ' })}
                            <a href="/saas-agreement" target="_blank" style={{ color: 'var(--brand-500)', textDecoration: 'none', fontWeight: '500' }}>SaaS Agreement</a>
                        </label>
                    </div>

                    <button
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.875rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '6px', fontWeight: 'bold', fontSize: '1rem', cursor: loading ? 'not-allowed' : 'pointer', transition: 'background-color 0.2s'
                        }}
                    >
                        {loading ? t('auth.creating', { defaultValue: 'Creating Workspace...' }) : t('auth.create_workspace', { defaultValue: 'Create Workspace' })}
                    </button>

                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>
                            {t('auth.already_have_tenant', { defaultValue: 'Already have a workspace?' })}
                        </span>
                        <a href="/login" style={{ fontSize: '0.875rem', color: 'var(--brand-500)', textDecoration: 'none', fontWeight: '500', marginLeft: '0.5rem' }}>
                            {t('auth.sign_in', { defaultValue: 'Sign in' })}
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
