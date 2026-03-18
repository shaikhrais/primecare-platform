import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

export default function Marketplace() {
    return (
        <PageTemplate 
            pageId="PG-276" 
            title="{ContentRegistry.MARKETPLACE.TITLE}" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-276']}
        />
    );
}
