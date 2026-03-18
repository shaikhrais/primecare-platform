import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T29-CarePlanManager.tsx
// removed broken export: export { default } from './T29-CarePlanManager';


// --- Merged from T29-CarePlanManager.tsx ---
export function CarePlanManager() {
    return (
        <PageTemplate pageId="T29" title="Care Plan Manager" subtitle="Create and manage individualized client care plans"
            sectionData={PageSectionRegistry['T29']}
        />
    );
}