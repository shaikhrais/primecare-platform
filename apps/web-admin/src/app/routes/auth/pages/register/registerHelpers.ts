// F2-Register: password strength logic + register handler + constants extracted
import { AdminRegistry } from 'prime-care-shared';
const { ApiRegistry, RouteRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

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
