import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from ScreenReaderContentEditor.tsx ---
export function ScreenReaderContentEditor() {
    return (
        <PageTemplate 
            pageId="PGE-SRC" 
            title="✨ Screen Reader Content Editor" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SRC']}
        />
    );
}
