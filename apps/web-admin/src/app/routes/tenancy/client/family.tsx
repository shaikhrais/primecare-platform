import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from P1-FamilyPortal.tsx ---
export function FamilyPortal() {
    return (
        <PageTemplate pageId="P1" title="Family Portal" subtitle="Family member access to care updates, schedule and billing"
            sectionData={PageSectionRegistry['P1']}
        />
    );
}
