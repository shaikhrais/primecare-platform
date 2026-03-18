import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T40-FleetManagement.tsx ---
export function FleetManagement() {
    return (
        <PageTemplate pageId="T40" title="Fleet Management" subtitle="Vehicle tracking, maintenance schedules and driver assignments"
            sectionData={PageSectionRegistry['T40']}
        />
    );
}
