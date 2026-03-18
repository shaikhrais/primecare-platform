import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "./PageSectionRegistry";

export default function VisitCompletionForm() {
    return (
        <PageTemplate 
            pageId="PG-330" 
            title="Discard Completion?" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-330']}
        />
    );
}
