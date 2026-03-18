import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T8-ClinicalAssistant.tsx
// removed broken export: export { default } from './T8-ClinicalAssistant';


// --- Merged from T8-ClinicalAssistant.tsx ---
// ================================================================
// PAGE IDENTITY: T8 · Clinical Assistant
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================

export function ClinicalAssistant() {
    return (
        <PageTemplate
            pageId="T8"
            title="🩺 Clinical Assistant"
            subtitle="AI-powered clinical decision support, care planning & outcome tracking"
            actionPageId="admin.clinical-assistant"
            sectionData={PageSectionRegistry['T8']}
        />
    );
}