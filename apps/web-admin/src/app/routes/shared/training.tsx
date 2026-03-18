import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

export function Training() {
    return (
        <PageTemplate 
            pageId="PG-472" 
            title="{module.title}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-472']}
        />
    );
}
