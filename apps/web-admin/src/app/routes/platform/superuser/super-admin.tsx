import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function SuperAdminDashboard() {
    return (
        <PageTemplate 
            pageId="PG-599" 
            title="SuperAdminDashboard" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-599']}
        />
    );
}
