import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

export default function VisitDetails() {
    return (
        <PageTemplate 
            pageId="PG-190" 
            title="Visit Profile" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-190']}
        />
    );
}
