import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from '../shared/PageSectionRegistry';

// --- Extracted from pages.tsx ---
// --- Merged from T47-ResponseBotAudit.tsx ---
export function ResponseBotAudit() {
    return (
        <PageTemplate pageId="T47"  
            sectionData={PageSectionRegistry['T47']}
        />
    );
}
