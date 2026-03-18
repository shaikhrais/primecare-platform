import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D12-FinanceRegionalHub.tsx ---
export function FinanceRegionalHub() {
    return (
        <PageTemplate pageId="D12" title="Finance Regional Hub" subtitle="Multi-region financial overview with revenue and expense breakdown"
            sectionData={PageSectionRegistry['D12']}
        />
    );
}
