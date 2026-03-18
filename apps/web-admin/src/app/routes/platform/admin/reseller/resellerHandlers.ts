// ResellerDashboard: fetch/provision handlers extracted
import { AdminRegistry } from 'prime-care-shared';
const { ApiRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:4000';

export const FALLBACK_CHILDREN = [
    { id: 't1', name: 'West Coast HomeCare', slug: 'west-coast', usersCount: 24, status: 'active', revenue: '$12,400' },
    { id: 't2', name: 'Ontario Senior Support', slug: 'ontario-senior', usersCount: 12, status: 'pending', revenue: '$0' },
];

export async function fetchChildAgencies(): Promise<any[]> {
    try {
        const token = localStorage.getItem('token');
        const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.RESELLER.DASHBOARD}`, { headers: { 'Authorization': `Bearer ${token}` } });
        if (res.ok) { const data = await res.json(); return data.children || FALLBACK_CHILDREN; }
        return FALLBACK_CHILDREN;
    } catch { return FALLBACK_CHILDREN; }
}

export async function provisionAgency(tenant: { name: string; slug: string; adminEmail: string; adminPassword: string }): Promise<void> {
    const token = localStorage.getItem('token');
    const res = await fetch(`${API_URL}${ApiRegistry.ADMIN.RESELLER.PROVISION}`, { method: 'POST', headers: { 'Content-Type': 'application/json', 'Authorization': `Bearer ${token}` }, body: JSON.stringify(tenant) });
    if (!res.ok) { const err = await res.json(); throw new Error(err.error || 'Failed to provision'); }
}
