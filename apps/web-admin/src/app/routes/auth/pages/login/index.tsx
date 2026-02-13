import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function Login() {
    const navigate = useNavigate();
    const searchParams = new URLSearchParams(window.location.search);
    const roleParam = searchParams.get('role') || 'client';

    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [selectedRole, setSelectedRole] = useState(roleParam);
    const [error, setError] = useState<string | null>(null);
    const [loading, setLoading] = useState(false);

    const uiText = {
        title: selectedRole === 'psw' ? ContentRegistry.AUTH.LOGIN_TITLE_PSW :
            selectedRole === 'client' ? ContentRegistry.AUTH.LOGIN_TITLE_CLIENT :
                selectedRole === 'staff' ? ContentRegistry.AUTH.LOGIN_TITLE_STAFF :
                    ContentRegistry.AUTH.LOGIN_TITLE,
        button: selectedRole === 'psw' ? ContentRegistry.AUTH.BUTTON_PSW :
            selectedRole === 'client' ? ContentRegistry.AUTH.BUTTON_CLIENT :
                selectedRole === 'staff' ? ContentRegistry.AUTH.BUTTON_STAFF :
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
                credentials: 'include'
            });

            if (response.ok) {
                const data = await response.json();

                // Save auth state
                localStorage.setItem('token', data.token);
                localStorage.setItem('user', JSON.stringify(data.user));

                if (selectedRole && !data.user.roles.includes(selectedRole) && !(selectedRole === 'staff' && (data.user.roles.includes('admin') || data.user.roles.includes('manager')))) {
                    setError(`This account is not registered as a ${selectedRole}. Please use your ${data.user.roles.join(' or ')} credentials.`);
                    setLoading(false);
                    return;
                }

                // Save active role choice
                const userWithActiveRole = { ...data.user, activeRole: selectedRole };
                localStorage.setItem('user', JSON.stringify(userWithActiveRole));

                if (data.user.role === 'manager' || selectedRole === 'manager') {
                    navigate('/manager/dashboard');
                } else if (data.user.role === 'psw') {
                    navigate('/shifts');
                } else if (data.user.role === 'client') {
                    navigate('/bookings');
                } else if (data.user.role === 'rn') {
                    navigate('/rn/dashboard');
                } else {
                    navigate(RouteRegistry.DASHBOARD);
                }
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
            display: 'flex', justifyContent: 'center', alignItems: 'center', height: '100vh', backgroundColor: 'var(--bg)'
        }}>
            <div style={{
                padding: '2.5rem', backgroundColor: '#FFFFFF', borderRadius: '8px', border: '1px solid var(--line)', width: '100%', maxWidth: '400px', boxShadow: 'var(--shadow-md)'
            }}>
                <div style={{ textAlign: 'center', marginBottom: '2rem' }}>
                    <img src="/logo.png" alt="PrimeCare" style={{ width: 'clamp(140px, 50%, 280px)', height: 'auto' }} />
                </div>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }} data-cy="page.title">
                    {uiText.title}
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem', fontSize: '0.9rem' }} data-cy="page.subtitle">
                    Sign in to access your dashboard
                </p>

                {error && <div data-cy="login-error" style={{ marginBottom: '1.1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center', backgroundColor: '#fee2e2', padding: '0.5rem', borderRadius: '4px' }}>{error}</div>}

                <form onSubmit={handleLogin}>
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            I am logging in as:
                        </label>
                        <select
                            data-cy="sel-role"
                            value={selectedRole}
                            onChange={(e) => setSelectedRole(e.target.value)}
                            style={{
                                width: '100%', padding: '0.6rem', border: '1px solid var(--brand-500)', borderRadius: '4px',
                                boxSizing: 'border-box', backgroundColor: '#F9FAFB', fontWeight: '600', color: 'var(--text)'
                            }}
                        >
                            <option value="client">🏠 Family Member / Client</option>
                            <option value="psw">👩‍⚕️ Caregiver / PSW</option>
                            <option value="rn">🩺 Registered Nurse / RN</option>
                            <option value="staff">🏢 Staff Member</option>
                            <option value="admin">🔒 Administrator</option>
                            <option value="manager">📊 Manager / Owner</option>
                        </select>
                    </div>

                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {ContentRegistry.AUTH.EMAIL_LABEL}
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
                    <div style={{ marginBottom: '1.5rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            {ContentRegistry.AUTH.PASSWORD_LABEL}
                        </label>
                        <input
                            data-cy="inp-password"
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            style={{ width: '100%', padding: '0.5rem', border: '1px solid #d1d5db', borderRadius: '4px', boxSizing: 'border-box' }}
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
                        {loading ? 'Loading...' : uiText.button}
                    </button>
                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <a href={`${RouteRegistry.REGISTER}?role=${selectedRole}`} data-cy="link-register" style={{ fontSize: '0.875rem', color: 'var(--brand-500)', textDecoration: 'none' }}>
                            {ContentRegistry.AUTH.SIGNUP_LINK}
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
