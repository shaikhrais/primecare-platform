import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T3-TemplateEditor.tsx
// removed broken export: export { default } from './T3-TemplateEditor';


// --- Merged from list.tsx ---
export function TemplatesList() {
    return (
        <PageTemplate 
            pageId="PGE-TL" 
            title="✨ Templates List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-TL']}
        />
    );
}

// --- Merged from T3-TemplateEditor.tsx ---
// PAGE IDENTITY: T3 · Template Editor



export function TemplateEditor() {
    return (
        <PageTemplate pageId="T3" title="🎨 Template Editor" subtitle="Design & manage email, SMS, PDF & form templates"
            sectionData={PageSectionRegistry['T3']}
        />
    );
}