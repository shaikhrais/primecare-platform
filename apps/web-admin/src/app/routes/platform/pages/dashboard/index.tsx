import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export function Dashboard() {
    return (
        <PageTemplate 
            pageId="PG-419" 
            title="{t(ContentRegistry.PLATFORM_DASHBOARD.TITLE)}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={{
                'PG-419.stats': { kpiCards: [
                    { label: 'System Health', value: 'Excellent', color: 'var(--pc-success)' },
                    { label: 'Active Sessions', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Pending Updates', value: 3, color: 'var(--pc-warning)' },
                ]},
                'PG-419.body': { emptyState: { 
                    title: 'Module Under Configuration', 
                    description: 'This module is currently being configured within the section registry.' 
                }},
            }}
        />
    );
}
