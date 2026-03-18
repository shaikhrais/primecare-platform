// F1-Login: authentication handler hooks extracted
import { AdminRegistry } from 'prime-care-shared';

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
