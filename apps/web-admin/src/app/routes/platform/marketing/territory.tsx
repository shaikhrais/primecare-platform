import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from SalesTerritoryMap.tsx ---
export function SalesTerritoryMap() {
    return (
        <PageTemplate 
            pageId="PGE-STM" 
            title="✨ Sales Territory Map" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'STM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'STM.empty']: { emptyState: { title: 'Sales Territory Map Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
