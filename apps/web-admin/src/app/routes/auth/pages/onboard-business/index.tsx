import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import FlagLanguageSwitcher from '@/shared/components/layout/topbar/FlagLanguageSwitcher';

const { ApiRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

import { useAuth } from '@/shared/context/AuthContext';

export default function OnboardBusiness() {
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
                setError(data.error || 'Onboarding failed');
            }
        } catch (err) {
            setError('Network error. Please try again.');
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
                    <img src="/logo.png" alt="PrimeCare" style={{ width: '140px', height: 'auto' }} />
                </div>

                <h1 style={{ fontSize: '1.75rem', fontWeight: 'bold', marginBottom: '0.5rem', textAlign: 'center', color: '#111827' }}>
                    Start Your Care Business
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.95rem' }}>
                    Create your organization and launch your platform in minutes.
                </p>

                {error && <div style={{ marginBottom: '1.5rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center', backgroundColor: '#fee2e2', padding: '0.75rem', borderRadius: '6px' }}>{error}</div>}

                <form onSubmit={handleOnboard}>
                    <div style={{ marginBottom: '1.25rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Business Name</label>
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
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Portal Slug (URL)</label>
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
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Admin Email</label>
                        <input
                            type="email"
                            placeholder="you@business.com"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>

                    <div style={{ marginBottom: '2rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '600', color: '#374151' }}>Password</label>
                        <input
                            type="password"
                            placeholder="••••••••"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            style={{ width: '100%', padding: '0.75rem', border: '1px solid var(--line)', borderRadius: '6px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>

                    <button
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.875rem', backgroundColor: 'var(--brand-500)', color: 'white', border: 'none', borderRadius: '6px', fontWeight: '700', cursor: loading ? 'not-allowed' : 'pointer', fontSize: '1rem', transition: 'background-color 0.2s'
                        }}
                        onMouseEnter={(e) => e.currentTarget.style.backgroundColor = 'var(--brand-600)'}
                        onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'var(--brand-500)'}
                    >
                        {loading ? 'Setting up your business...' : 'Launch Business Portal'}
                    </button>

                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <p style={{ fontSize: '0.875rem', color: '#6B7280' }}>
                            Already have an account? <a href={RouteRegistry.LOGIN} style={{ color: '#2563EB', textDecoration: 'none', fontWeight: '600' }}>Sign In</a>
                        </p>
                    </div>
                </form>
            </div>
        </div>
    );
}
