import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from GlobalI18nDictionary.tsx ---
export function GlobalI18nDictionary() {
    return (
        <PageTemplate 
            pageId="PGE-GI1" 
            title="✨ Global I18n Dictionary" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-GI1']}
        />
    );
}
