import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: H16-SupervisionHub.tsx
// removed broken export: export { default } from './H16-SupervisionHub';


// --- Merged from H16-SupervisionHub.tsx ---
export function SupervisionHub() {
    return (
        <PageTemplate pageId="H16" title="Supervision Hub" subtitle="Staff supervision sessions, notes and delegation tracking"
            sectionData={PageSectionRegistry['H16']}
        />
    );
}