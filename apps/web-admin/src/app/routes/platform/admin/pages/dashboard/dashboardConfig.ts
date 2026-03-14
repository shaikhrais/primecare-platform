// Shared config for D2-RegistrySummary and RegistrySummaryDashboard
import { apiClient } from '@/shared/utils/apiClient';

export interface StatsData {
    totalUsers: number; pendingVisits: number; totalVisits: number; totalLeads: number;
    modelScore: number; MTD_REVENUE: string;
    healthAlerts: { complianceRisk: number; coverageGap: number; pipelineStagnation: number; };
    syncedAt: string; error?: string;
}

export interface RegistryItem { id: string; key: string; value: string; category: string; section: string; updatedAt: string; }

export const KPI_CARDS = [
    { key: 'totalUsers', label: 'Total Users', icon: '👥', route: '/platform/admin/users', color: '#0d9488' },
    { key: 'totalLeads', label: 'New Inquiries', icon: '📥', route: '/platform/admin/leads', color: '#7c3aed' },
    { key: 'pendingVisits', label: 'Pending Visits', icon: '📝', route: '/platform/admin/visits', color: '#ea580c' },
    { key: 'totalVisits', label: 'Total Visits', icon: '📋', route: '/platform/admin/visits', color: '#2563eb' },
    { key: 'MTD_REVENUE', label: 'MTD Revenue', icon: '💰', prefix: '$', color: '#059669' },
    { key: 'modelScore', label: 'Business Score', icon: '🏢', suffix: '%', color: '#d97706' },
];

export const ALERT_CARDS = [
    { key: 'complianceRisk', label: 'Compliance Risk', icon: '⚠️', color: '#dc2626' },
    { key: 'coverageGap', label: 'Coverage Gaps', icon: '📍', color: '#ea580c' },
    { key: 'pipelineStagnation', label: 'Stale Leads', icon: '⏳', color: '#9333ea' },
];

export function getValue(stats: StatsData | null, key: string) {
    if (!stats) return '—';
    if (key === 'MTD_REVENUE') return stats.MTD_REVENUE ?? '0.00';
    return (stats as any)[key] ?? 0;
}

export function getAlertValue(stats: StatsData | null, key: string) {
    if (!stats?.healthAlerts) return 0;
    return (stats.healthAlerts as any)[key] ?? 0;
}

export async function fetchDashboardStats(): Promise<{ stats: StatsData | null; registryCount: number; registrySections: Record<string, number>; error: string | null; lastSynced: string | null }> {
    let stats: StatsData | null = null, registryCount = 0, registrySections: Record<string, number> = {}, error: string | null = null, lastSynced: string | null = null;
    try {
        const [statsRes, regRes] = await Promise.all([apiClient.get('/v1/public/stats'), apiClient.get('/v1/public/registries')]);
        if (statsRes.ok) { const d = await statsRes.json(); stats = d; lastSynced = d.syncedAt ? new Date(d.syncedAt).toLocaleString() : new Date().toLocaleString(); if (d.error) error = `Stats partial: ${d.error}`; } else error = `Stats API: ${statsRes.status}`;
        if (regRes.ok) { const rd = await regRes.json(); registryCount = rd.total || 0; for (const item of (rd.items || [])) { const s = item.section || 'general'; registrySections[s] = (registrySections[s] || 0) + 1; } }
    } catch (e: any) { error = e.message || 'Network error'; }
    return { stats, registryCount, registrySections, error, lastSynced };
}
