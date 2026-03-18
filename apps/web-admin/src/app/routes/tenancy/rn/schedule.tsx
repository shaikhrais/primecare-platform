import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T63-RnCheckInScreen.tsx ---
export function RnCheckInScreen() {
    return (
        <PageTemplate pageId="T63" title="RN Check-In" subtitle="Nursing visit check-in with clinical assessment triggers"
            sectionData={PageSectionRegistry['T63']}
        />
    );
}
