import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function Login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();
    const searchParams = new URLSearchParams(window.location.search);
    const roleParam = searchParams.get('role');

    const uiText = {
        title: roleParam === 'psw' ? ContentRegistry.AUTH.LOGIN_TITLE_PSW :
            roleParam === 'client' ? ContentRegistry.AUTH.LOGIN_TITLE_CLIENT :
                roleParam === 'staff' ? ContentRegistry.AUTH.LOGIN_TITLE_STAFF :
                    ContentRegistry.AUTH.LOGIN_TITLE,
        button: roleParam === 'psw' ? ContentRegistry.AUTH.BUTTON_PSW :
            roleParam === 'client' ? ContentRegistry.AUTH.BUTTON_CLIENT :
                roleParam === 'staff' ? ContentRegistry.AUTH.BUTTON_STAFF :
                    ContentRegistry.AUTH.BUTTON
    };

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setLoading(true);
        setError(null);

        try {
            // Admin login logic (currently using same endpoint as generic auth but would be role-gated in real world)
            const response = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, password }),
            });

            if (response.ok) {
                const data = await response.json();

                // Save auth state
                localStorage.setItem('token', data.token);
                localStorage.setItem('user', JSON.stringify(data.user));

                // Redirection based on role or query param
                const searchParams = new URLSearchParams(window.location.search);
                const targetRole = searchParams.get('role');

                if (targetRole && data.user.role !== targetRole) {
                    setError(`This account is not registered as a ${targetRole}. Please use your ${data.user.role} credentials.`);
                    setLoading(false);
                    return;
                }

                navigate(RouteRegistry.DASHBOARD);
            } else {
                const data = await response.json();
                setError(data.error || 'Login failed');
            }
        } catch (err) {
            setError('Network error. Please check your connection.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <div style={{
            display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: '#f0f2f5'
        }}>
            <div style={{
                padding: '2.5rem', backgroundColor: 'white', borderRadius: '12px', boxShadow: '0 4px 20px rgba(0,0,0,0.08)', width: '100%', maxWidth: '400px', border: '1px solid #f3f4f6'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.png" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }}>
                    {uiText.title}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.9rem' }}>
                    Sign in to access your dashboard
                </p>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}

                <form onSubmit={handleLogin}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {ContentRegistry.AUTH.EMAIL_LABEL}
                        </label>
                        <input
                            type="email"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {ContentRegistry.AUTH.PASSWORD_LABEL}
                        </label>
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
                            required
                        />
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'flex-end', marginBottom: '1.5rem' }}>
                        <a href="/forgot-password" style={{ fontSize: '0.875rem', color: '#059669', textDecoration: 'none' }}>
                            Forgot password?
                        </a>
                    </div>
                    <button
                        type="submit"
                        disabled={loading}
                        style={{
                            width: '100%', padding: '0.75rem', backgroundColor: '#059669', color: 'white', border: 'none', borderRadius: '4px', fontWeight: '500', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? 'Loading...' : uiText.button}
                    </button>
                </form>
            </div>
        </div>
    );
}
