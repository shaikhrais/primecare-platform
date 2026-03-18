import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from H17-FamilyCareHub.tsx ---
export function FamilyCareHub() {
    return (
        <PageTemplate pageId="H17" title="Family Care Hub" subtitle="Family member access, care updates and communication center"
            sectionData={PageSectionRegistry['H17']}
        />
    );
}
