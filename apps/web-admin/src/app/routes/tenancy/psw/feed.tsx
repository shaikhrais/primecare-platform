import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T27-ProviderSocial.tsx ---
export function ProviderSocial() {
    return (
        <PageTemplate pageId="T27" title="Provider Social" subtitle="Team social feed, announcements and peer recognition"
            sectionData={PageSectionRegistry['T27']}
        />
    );
}
