import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H18-CoordinatorHub.tsx ---
export function CoordinatorHub() {
    return (
        <PageTemplate pageId="H18" title="Coordinator Hub" subtitle="Dispatch coordination, team management and scheduling overview"
            sectionData={PageSectionRegistry['H18']}
        />
    );
}
