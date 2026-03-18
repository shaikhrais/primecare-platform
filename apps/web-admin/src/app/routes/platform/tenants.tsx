import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../shared/PageSectionRegistry";

export default function TenantList() {
    return (
        <PageTemplate 
            pageId="PG-686" 
            title="Tenant Management" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-686']}
        />
    );
}
