import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

export default function ForgotPassword() {
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
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email }),
            });

            const data = await response.json();

            if (response.ok) {
                setMessage(data.message);
                if (data.debug_token) {
                    console.log('DEBUG: Reset token:', data.debug_token);
                }
            } else {
                setError(data.error || 'Request failed');
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
        }} data-cy="forgot-password-page">
            <div style={{
                padding: '2rem', backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 4px 6px -1px rgba(0,0,0,0.1)', width: '100%', maxWidth: '400px'
            }}>
                <h1 style={{ fontSize: '1.5rem', fontWeight: 'bold', marginBottom: '0.5rem', marginTop: 0, textAlign: 'center', color: '#111827' }}>
                    Reset Password
                </h1>
                <p style={{ textAlign: 'center', color: '#6b7280', marginBottom: '2rem' }}>
                    Enter your email to receive a reset link.
                </p>

                {error && <div style={{ marginBottom: '1rem', color: '#dc2626', fontSize: '0.875rem', textAlign: 'center' }}>{error}</div>}
                {message && <div style={{ marginBottom: '1rem', color: '#059669', fontSize: '0.875rem', textAlign: 'center' }}>{message}</div>}

                <form onSubmit={handleSubmit}>
                    <div style={{ marginBottom: '1rem' }}>
                        <label style={{ display: 'block', marginBottom: '0.5rem', fontSize: '0.875rem', fontWeight: '500', color: '#374151' }}>
                            Email Address
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
                            width: '100%', padding: '0.75rem', backgroundColor: '#059669', color: 'white', border: 'none', borderRadius: '4px', fontWeight: '500', cursor: loading ? 'not-allowed' : 'pointer'
                        }}
                    >
                        {loading ? 'Sending...' : 'Send Reset Link'}
                    </button>
                    <div style={{ marginTop: '1rem', textAlign: 'center' }}>
                        <a href="/login" style={{ fontSize: '0.875rem', color: '#6b7280', textDecoration: 'none' }}>
                            Back to Login
                        </a>
                    </div>
                </form>
            </div>
        </div>
    );
}
