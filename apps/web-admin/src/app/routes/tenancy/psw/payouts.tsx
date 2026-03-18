import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: R4-PayoutHistory.tsx
// removed broken export: export { default } from './R4-PayoutHistory';


// --- Merged from R4-PayoutHistory.tsx ---
export function PayoutHistory() {
    return (
        <PageTemplate pageId="R4" title="Payout History" subtitle="Historical payout records with filtering and export"
            sectionData={PageSectionRegistry['R4']}
        />
    );
}