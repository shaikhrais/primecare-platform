import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T41-ShiftSwap.tsx ---
export function ShiftSwap() {
    return (
        <PageTemplate pageId="T41" title="Shift Swap" subtitle="Request and approve shift swaps between team members"
            sectionData={PageSectionRegistry['T41']}
        />
    );
}
