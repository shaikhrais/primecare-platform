import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from AssetPermissionMatrix.tsx ---
export function AssetPermissionMatrix() {
    return (
        <PageTemplate 
            pageId="PGE-APM" 
            title="✨ Asset Permission Matrix" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'APM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'APM.empty']: { emptyState: { title: 'Asset Permission Matrix Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from GlobalDigitalKillSwitch.tsx ---
export function GlobalDigitalKillSwitch() {
    return (
        <PageTemplate 
            pageId="PGE-GDK" 
            title="✨ Global Digital Kill Switch" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'GDK.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'GDK.empty']: { emptyState: { title: 'Global Digital Kill Switch Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
