import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T23-StaffRanker.tsx ---
export function StaffRanker() {
    return (
        <PageTemplate pageId="T23" title="Staff Ranker" subtitle="Staff performance ranking with reliability and quality scores"
            sectionData={PageSectionRegistry['T23']}
        />
    );
}

// --- Merged sidecars ---
