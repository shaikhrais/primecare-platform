import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from DigitalPropertyManager.tsx ---
export function DigitalPropertyManager() {
    return (
        <PageTemplate 
            pageId="PG-454" 
            title="🏛️ Digital Property Manager" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-454']}
        />
    );
}
