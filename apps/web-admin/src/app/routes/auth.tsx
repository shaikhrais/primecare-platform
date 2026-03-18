import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { AdminRegistry } from 'prime-care-shared';



// --- Merged from components.tsx ---

// --- Merged from BiometricLogin.tsx ---
export function BiometricLogin() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_0']}
        />
    );
}



// --- Merged from forgot-password.tsx ---

export function ForgotPassword() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_1']}
        />
    );
}




// --- Merged from login.tsx ---

export function Login() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_2']}
        />
    );
}




// --- Merged from loginHandler.ts ---
// F1-Login: authentication handler hooks extracted

const { ApiRegistry } = AdminRegistry;
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
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_3']}
        />
    );
}




// --- Merged from onboarding.tsx ---


// --- Merged from VrHoardingSimulator.tsx ---
export function VrHoardingSimulator() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_4']}
        />
    );
}



// --- Merged from register.tsx ---

export function Register() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_5']}
        />
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
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
             
            
            sectionData={PageSectionRegistry['COMPLEX_KEY_6']}
        />
    );
}


