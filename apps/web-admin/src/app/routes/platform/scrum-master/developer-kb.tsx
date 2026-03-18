import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export function DeveloperKb() {
    return (
        <PageTemplate 
            pageId="PG-880" 
            title="Implementation Specs: {selectedRole.toUpperCase()}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-880']}
        />
    );
}
