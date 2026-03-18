import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D12-FinanceRegionalHub.tsx ---
export function FinanceRegionalHub() {
    return (
        <PageTemplate pageId="D12"  
            sectionData={PageSectionRegistry['D12']}
        />
    );
}
