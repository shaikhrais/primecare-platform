import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T21-ServiceReview.tsx
// removed broken export: export { default } from './T21-ServiceReview';


// --- Merged from T21-ServiceReview.tsx ---
export function ServiceReview() {
    return (
        <PageTemplate pageId="T21" title="Service Review" subtitle="Service quality reviews and improvement tracking"
            sectionData={PageSectionRegistry['T21']}
        />
    );
}