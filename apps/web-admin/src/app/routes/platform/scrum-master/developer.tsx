import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function DeveloperPortal() {
    return (
        <PageTemplate 
            pageId="PG-695" 
            title="Developer Portal" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-695']}
        />
    );
}
