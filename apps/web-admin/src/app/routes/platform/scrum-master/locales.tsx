import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from LocalizationPage.tsx ---
export function LocalizationPage() {
    return (
        <PageTemplate 
            pageId="PG-233" 
            title="Localization Health" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-233']}
        />
    );
}
