import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../shared/PageSectionRegistry";

export function Dashboard() {
    return (
        <PageTemplate 
            pageId="PG-419" 
            title="{t(ContentRegistry.PLATFORM_DASHBOARD.TITLE)}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-419']}
        />
    );
}
