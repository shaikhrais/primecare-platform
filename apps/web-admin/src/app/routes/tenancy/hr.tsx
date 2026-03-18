import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H13-HrRecruitmentPortal.tsx ---
export function HrRecruitmentPortal() {
    return (
        <PageTemplate pageId="H13" title="HR Recruitment Portal" subtitle="Job postings, applicant tracking and onboarding pipeline"
            sectionData={PageSectionRegistry['H13']}
        />
    );
}
