import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "..\shared\PageSectionRegistry";

// --- Extracted from dashboard.tsx ---
export function FamilyDashboard() {
    return (
        <PageTemplate pageId="FAM" title="Family Dashboard" subtitle="Manage family care plans"
            sectionData={PageSectionRegistry['FAM']}
        />
    );
}
