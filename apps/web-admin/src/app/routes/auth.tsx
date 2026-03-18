import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { AdminRegistry } from 'prime-care-shared';
import { PageSectionRegistry } from "./shared";
import { useNavigate, useSearchParams } from 'react-router-dom';
import { useAuthStore } from '@/shared/stores';

const { RouteRegistry, ApiRegistry, ContentRegistry, ThemeRegistry, PageRegistry, FormRegistry } = AdminRegistry;

// --- Merged from components.tsx ---

// --- Merged from BiometricLogin.tsx ---
export function BiometricLogin() {
    return (
        <PageTemplate 
            pageId="PGE-BiometricLogin" 
            
            sectionData={PageSectionRegistry['BiometricLogin']}
        />
    );
}



// --- Auth Layout Wrapper ---
const AuthLayout = ({ children, title, subtitle }: { children: React.ReactNode, title: string, subtitle: string }) => (
    <div className="min-h-screen flex items-center justify-center bg-slate-900 p-4">
        <div className="max-w-md w-full bg-slate-800 rounded-xl shadow-2xl overflow-hidden border border-slate-700">
            <div className="p-8 text-center border-b border-slate-700 bg-slate-800/50">
                <div className="inline-flex items-center justify-center w-12 h-12 rounded-full bg-sky-500/10 text-sky-400 mb-4">
                    <svg className="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                    </svg>
                </div>
                <h1 className="text-2xl font-bold text-white tracking-tight">{title}</h1>
                <p className="text-slate-400 mt-2 text-sm">{subtitle}</p>
            </div>
            <div className="p-8">
                {children}
            </div>
        </div>
    </div>
);

// --- Merged from forgot-password.tsx ---
export function ForgotPassword() {
    const [email, setEmail] = useState('');
    const [status, setStatus] = useState('');

    return (
        <AuthLayout title="Reset Password" subtitle="We'll send you recovery instructions">
            <form onSubmit={e => { e.preventDefault(); setStatus('Recovery link sent to ' + email); }} className="space-y-4">
                <div>
                    <label className="block text-sm font-medium text-slate-300 mb-1">Email Address</label>
                    <input type="email" required value={email} onChange={e => setEmail(e.target.value)} className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-sky-500 focus:border-transparent transition-all" placeholder="name@primecare.ca" />
                </div>
                {status && <div className="p-3 bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 rounded-lg text-sm">{status}</div>}
                <button type="submit" className="w-full bg-sky-500 hover:bg-sky-600 text-white font-medium py-2.5 rounded-lg transition-colors">Send Recovery Link</button>
            </form>
        </AuthLayout>
    );
}

// --- Merged from login.tsx ---
export function Login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        const { ok, data, error: errStr } = await performLogin(email, password) as any;
        setLoading(false);
        if (ok) {
            localStorage.setItem('token', data.token);
            localStorage.setItem('user', JSON.stringify(data.user));
            navigate(RouteRegistry.ADMIN.DASHBOARD || '/admin');
        } else {
            setError(errStr || 'Failed to successfully authenticate.');
        }
    };

    return (
        <AuthLayout title="Platform Login" subtitle="Enter your credentials to access the PrimeCare suite.">
            <form onSubmit={handleSubmit} className="space-y-5">
                <div>
                    <label className="block text-sm font-medium text-slate-300 mb-1">Corporate Email</label>
                    <input type="email" required value={email} onChange={e => setEmail(e.target.value)} className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-sky-500 transition-all" placeholder="user@primecare.ca" />
                </div>
                <div>
                    <div className="flex items-center justify-between mb-1">
                        <label className="block text-sm font-medium text-slate-300">Password</label>
                        <a href="#/forgot-password" className="text-xs text-sky-400 hover:text-sky-300 transition-colors">Forgot password?</a>
                    </div>
                    <input type="password" required value={password} onChange={e => setPassword(e.target.value)} className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-sky-500 transition-all" placeholder="••••••••" />
                </div>
                {error && <div className="p-3 bg-rose-500/10 border border-rose-500/20 text-rose-400 rounded-lg text-sm">{error}</div>}
                <button type="submit" disabled={loading} className="w-full bg-sky-500 hover:bg-sky-600 disabled:opacity-50 text-white font-medium py-2.5 rounded-lg transition-colors flex justify-center items-center">
                    {loading ? <span className="block w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin"></span> : 'Authenticate'}
                </button>
            </form>
        </AuthLayout>
    );
}




// --- Merged from loginHandler.ts ---
// F1-Login: authentication handler hooks extracted
const API_URL = import.meta.env.VITE_API_URL || '/api';

export async function performLogin(
    email: string,
    password: string,
): Promise<{ ok: true; data: any } | { ok: false; error: string }> {
    try {
        const response = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
            body: JSON.stringify({ email, password }),
            credentials: 'include',
        });

        if (response.ok) {
            return { ok: true, data: await response.json() };
        } else {
            const data = await response.json();
            const errorMessage = typeof data.error === 'object'
                ? JSON.stringify(data.error)
                : data.error || 'Login failed';
            return { ok: false, error: errorMessage };
        }
    } catch (err) {
        return { ok: false, error: 'Network error. Please check your connection.' };
    }
}



// --- Merged from onboard-business.tsx ---

export function BusinessOnboard() {
    return (
        <PageTemplate 
            pageId="PGE-BusinessOnboard" 
            
            sectionData={PageSectionRegistry['BusinessOnboard']}
        />
    );
}




// --- Merged from onboarding.tsx ---


// --- Merged from VrHoardingSimulator.tsx ---
export function VrHoardingSimulator() {
    return (
        <PageTemplate 
            pageId="PGE-VrHoardingSimulator" 
            
            sectionData={PageSectionRegistry['VrHoardingSimulator']}
        />
    );
}



// --- Merged from register.tsx ---
export function Register() {
    const [searchParams] = useSearchParams();
    const prefillRole = searchParams.get('role') || 'staff';
    
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        try {
            await handleRegisterAndLogin(email, password, prefillRole, navigate);
        } catch (err: any) {
            setError(err.message || 'Registration failed');
        }
        setLoading(false);
    };

    return (
        <AuthLayout title="Register Identity" subtitle={`Provisioning a new ${prefillRole.replace('_', ' ')}`}>
            <form onSubmit={handleSubmit} className="space-y-5">
                <div>
                    <label className="block text-sm font-medium text-slate-300 mb-1">Corporate Email</label>
                    <input type="email" required value={email} onChange={e => setEmail(e.target.value)} className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 transition-all" placeholder="recruit@primecare.ca" />
                </div>
                <div>
                    <label className="block text-sm font-medium text-slate-300 mb-1">Secure Password</label>
                    <input type="password" required value={password} onChange={e => setPassword(e.target.value)} className="w-full bg-slate-900 border border-slate-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:ring-2 focus:ring-emerald-500 transition-all" placeholder="••••••••" />
                </div>
                {error && <div className="p-3 bg-rose-500/10 border border-rose-500/20 text-rose-400 rounded-lg text-sm">{error}</div>}
                <button type="submit" disabled={loading} className="w-full bg-emerald-500 hover:bg-emerald-600 disabled:opacity-50 text-white font-medium py-2.5 rounded-lg transition-colors flex justify-center items-center">
                    {loading ? <span className="block w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin"></span> : 'Complete Registration'}
                </button>
            </form>
        </AuthLayout>
    );
}




// --- Merged from registerHelpers.ts ---
// F2-Register: password strength logic + register handler + constants extracted

export const STRENGTH_COLORS = ['#e5e7eb', '#ef4444', '#f59e0b', '#3b82f6', '#10b981'];
export const STRENGTH_LABELS = ['Too Short', 'Weak', 'Fair', 'Good', 'Strong'];

export function calculateStrength(pass: string): number {
    let score = 0;
    if (pass.length >= 8) score += 1;
    if (/[A-Z]/.test(pass)) score += 1;
    if (/[0-9]/.test(pass)) score += 1;
    if (/[^A-Za-z0-9]/.test(pass)) score += 1;
    return score;
}

export async function handleRegisterAndLogin(
    email: string, password: string, roleParam: string,
    navigate: (path: string) => void
): Promise<void> {
    const registerRes = await fetch(`${API_URL}${ApiRegistry.AUTH.REGISTER}`, { method: 'POST', headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' }, body: JSON.stringify({ email, password, role: roleParam }) });
    if (!registerRes.ok) { const data = await registerRes.json(); throw new Error(data.error || 'Registration failed'); }
    const loginRes = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, { method: 'POST', headers: { 'Content-Type': 'application/json', 'X-Requested-With': 'XMLHttpRequest' }, body: JSON.stringify({ email, password }) });
    if (loginRes.ok) { const data = await loginRes.json(); localStorage.setItem('token', data.token); localStorage.setItem('user', JSON.stringify(data.user)); navigate(RouteRegistry.ADMIN.DASHBOARD); }
    else { navigate(`${RouteRegistry.LOGIN}?role=${roleParam}`); }
}



// --- Merged from reset-password.tsx ---

export function ResetPassword() {
    return (
        <PageTemplate 
            pageId="PGE-ResetPassword" 
            
            sectionData={PageSectionRegistry['ResetPassword']}
        />
    );
}


