import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T44-MessageCenter.tsx ---
export function MessageCenter() {
    return (
        <PageTemplate pageId="T44" title="Message Center" subtitle="Internal team messaging and communication hub"
            sectionData={PageSectionRegistry['T44']}
        />
    );
}
