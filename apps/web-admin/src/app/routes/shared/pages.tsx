import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from DevPreview.tsx ---
export function DevPreview() {
    return (
        <PageTemplate 
            pageId="PGE-DP" 
            title="✨ Dev Preview" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'DP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'DP.empty']: { emptyState: { title: 'Dev Preview Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from MarketingShowcase.tsx ---
export function MarketingShowcase() {
    return (
        <PageTemplate 
            pageId="PGE-${Math.floor(Math.random() * 900 + 100)}" 
            title="Marketing Showcase" 
            subtitle="System Module"
            sectionData={{
                'mod.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'System Status', value: '100%', color: 'var(--pc-success)' },
                ]},
                'mod.body': { emptyState: { 
                    title: 'Marketing Showcase', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}

// --- Merged from RoleDashboardPlaceholder.tsx ---
export function RoleDashboardPlaceholder() {
    return (
        <PageTemplate 
            pageId="PG-178" 
            title="RoleDashboardPlaceholder" 
            subtitle="Platform configuration, management, and insights"
            sectionData={{
                'PG-178.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-178.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}
