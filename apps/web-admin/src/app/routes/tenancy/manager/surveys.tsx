import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T22-SurveyManager.tsx
// removed broken export: export { default } from './T22-SurveyManager';


// --- Merged from T22-SurveyManager.tsx ---
export function SurveyManager() {
    return (
        <PageTemplate pageId="T22" title="Survey Manager" subtitle="Create, distribute and analyze satisfaction surveys"
            sectionData={PageSectionRegistry['T22']}
        />
    );
}