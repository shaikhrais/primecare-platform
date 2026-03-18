import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T43-TaskGrid.tsx ---
export function TaskGrid() {
    return (
        <PageTemplate pageId="T43" title="Task Grid" subtitle="View and manage assigned tasks and action items"
            sectionData={PageSectionRegistry['T43']}
        />
    );
}
