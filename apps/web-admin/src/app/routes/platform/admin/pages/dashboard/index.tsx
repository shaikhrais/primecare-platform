import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Barrel re-export — identity file: D1-AdminDashboard.tsx
// removed broken export: export { default } from './D1-AdminDashboard';


// --- Merged from D1-AdminDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D1 · Admin Dashboard (Main Landing)
// Type: Dashboard | Owner: admin | Registry: D1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================



const quickActions = [
    { icon: '📅', title: 'Schedule', subtitle: 'View & manage today\'s shifts' },
    { icon: '👥', title: 'Staff', subtitle: '82 PSWs, 4 RNs active' },
    { icon: '🏥', title: 'Clients', subtitle: '67 active clients' },
    { icon: '💰', title: 'Revenue', subtitle: '$185K MTD' },
    { icon: '📋', title: 'Compliance', subtitle: '98.2% score' },
    { icon: '🤖', title: 'AI Insights', subtitle: '8 actionable items' },
];

export function AdminDashboard() {
    return (
        <PageTemplate pageId="D1" title="🏠 Admin Dashboard" subtitle="Platform overview — operations, finance, compliance & AI insights"
            actionPageId="admin.dashboard"
            sectionData={{
                'D1.stats': { kpiCards: [
                    { label: 'Active Visits', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Revenue MTD', value: '$185K', color: 'var(--pc-success)' },
                    { label: 'Staff Active', value: 86, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Clients', value: 67, color: '#7C3AED' },
                    { label: 'Compliance', value: '98.2%', color: '#10B981' },
                    { label: 'Incidents', value: 2, color: 'var(--pc-warning)' },
                ]},
                'D1.quick-actions': { cardGrid: { items: quickActions, columns: 3 } },
                'D1.visit-chart': { chart: { title: 'Weekly Visit Volume', type: 'bar', data: [
                    { label: 'Mon', value: 145 }, { label: 'Tue', value: 162 },
                    { label: 'Wed', value: 138 }, { label: 'Thu', value: 155 },
                    { label: 'Fri', value: 170 }, { label: 'Sat', value: 45 },
                    { label: 'Sun', value: 32 },
                ]}},
            }}
        />
    );
}

// --- Merged from D2-RegistrySummary.tsx ---
// PAGE IDENTITY: D2 · Registry Summary



const registryModules = [
    { icon: '📋', title: 'Page Registry', subtitle: '139 pages registered across admin & tenancy' },
    { icon: '🔗', title: 'API Registry', subtitle: '85 endpoints, 12 modules, 4 middleware chains' },
    { icon: '📊', title: 'Section Registry', subtitle: '15 section types, 60+ page configurations' },
    { icon: '🔑', title: 'Role Registry', subtitle: '6 roles, 142 permissions, 5 scopes' },
    { icon: '📡', title: 'Event Registry', subtitle: '24 event types, 6 automation hooks' },
    { icon: '🎨', title: 'Theme Registry', subtitle: '3 themes, 24 CSS variables, dark mode' },
];

export function RegistrySummary() {
    return (
        <PageTemplate pageId="D2" title="📊 Registry Summary" subtitle="Overview of all platform registries — pages, APIs, sections, roles & events"
            sectionData={{
                'D2.stats': { kpiCards: [
                    { label: 'Total Pages', value: 139, color: 'var(--pc-primary)' },
                    { label: 'API Endpoints', value: 85, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Section Types', value: 15, color: '#8B5CF6' },
                    { label: 'Registries', value: 6, color: 'var(--pc-success)' },
                ]},
                'D2.registries': { cardGrid: { items: registryModules, columns: 3 } },
            }}
        />
    );
}