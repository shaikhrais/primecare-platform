import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T28-MileageTracker.tsx ---
export function MileageTracker() {
    return (
        <PageTemplate pageId="T28" title="Mileage Tracker" subtitle="Log travel mileage between client visits for reimbursement"
            sectionData={PageSectionRegistry['T28']}
        />
    );
}
