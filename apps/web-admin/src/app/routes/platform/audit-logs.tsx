import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../shared/PageSectionRegistry";

export function AuditLogs() {
    return (
        <PageTemplate 
            pageId="PG-614" 
            title="Global Audit Logs" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-614']}
        />
    );
}
