import { AdminRegistry } from 'prime-care-shared';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from PrivateMarketplace.tsx ---
export function PrivateMarketplace() {
    return (
        <PageTemplate 
            pageId="PG-131" 
            title="Private Marketplace" 
            subtitle="Platform configuration, management, and insights"
            sectionData={{
                'PG-131.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-131.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}

// --- Merged from ResellerDashboard.tsx ---
export function ResellerDashboard() {
    return (
        <PageTemplate 
            pageId="PG-390" 
            title="White-Label Reseller Hub" 
            subtitle="Platform configuration, management, and insights"
            sectionData={{
                'PG-390.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-390.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}

// --- Merged sidecars ---

/* Merged from resellerHandlers.ts */
// ResellerDashboard: fetch/provision handlers extracted

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

