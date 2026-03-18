import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ThemeCoreCenter.tsx ---
export function ThemeCoreCenter() {
    return (
        <PageTemplate 
            pageId="PG-423" 
            title="🎨Theme Core Center" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-423']}
        />
    );
}
