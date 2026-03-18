import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T36-TeamRoster.tsx ---
export function TeamRoster() {
    return (
        <PageTemplate pageId="T36" title="Team Roster" subtitle="Your care team members and contact information"
            sectionData={PageSectionRegistry['T36']}
        />
    );
}
