import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T42-SignOff.tsx ---
export function SignOff() {
    return (
        <PageTemplate pageId="T42" title="Clinical Sign-Off" subtitle="Review and sign off on completed clinical documentation"
            sectionData={PageSectionRegistry['T42']}
        />
    );
}
