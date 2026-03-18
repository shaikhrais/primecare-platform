import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Barrel re-export — identity file: F6-ClientAdmission.tsx
// removed broken export: export { default } from './F6-ClientAdmission';


// --- Merged from F6-ClientAdmission.tsx ---
// PAGE IDENTITY: F6 · Client Admission

export function ClientAdmission() {
    return (
        <PageTemplate pageId="F6" title="📋 Client Admission" subtitle="New client intake workflow — referral, demographics, assessment & service plan"
            sectionData={PageSectionRegistry['F6']}
        />
    );
}