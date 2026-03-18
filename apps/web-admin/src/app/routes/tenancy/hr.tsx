import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H13-HrRecruitmentPortal.tsx ---
export function HrRecruitmentPortal() {
    return (
        <PageTemplate pageId="H13"  
            sectionData={PageSectionRegistry['H13']}
        />
    );
}
