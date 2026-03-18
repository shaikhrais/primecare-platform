import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T47-ResponseBotAudit.tsx ---
export function ResponseBotAudit() {
    return (
        <PageTemplate pageId="T47" title="Response Bot Audit" subtitle="AI response quality audit trail and accuracy metrics"
            sectionData={PageSectionRegistry['T47']}
        />
    );
}
