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

    const handleOnboard = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

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
            display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight: '100vh', backgroundColor: 'var(--bg)', padding: '2rem', position: 'relative'
        }}>
            <div style={{ position: 'absolute', top: '20px', right: '24px', zIndex: 100 }}>
                <FlagLanguageSwitcher />
            </div>
            <div style={{
                padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '12px', border: '1px solid var(--line)', width: '100%', maxWidth: '450px', boxShadow: 'var(--shadow-lg)'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.svg" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
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
                        <div style={{ display: 'flex', alignItems: 'center', border: '1px solid var(--line)', borderRadius: '6px', overflow: 'hidden' }}>
                            <span style={{ padding: '0.75rem', backgroundColor: '#F3F4F6', color: '#6B7280', borderRight: '1px solid var(--line)', fontSize: '0.875rem' }}>pc.ca/</span>
                            <input
                                type="text"
                                placeholder="my-business"
                                value={tenantSlug}
                                onChange={(e) => setTenantSlug(e.target.value)}
                                style={{ width: '100%', padding: '0.75rem', border: 'none', boxSizing: 'border-box', outline: 'none' }}
                                required
                            />
                        </div>
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
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                            required
                            minLength={8}
                        />
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
