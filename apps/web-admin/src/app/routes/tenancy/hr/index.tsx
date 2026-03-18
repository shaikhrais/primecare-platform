import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H13-HrRecruitmentPortal.tsx ---
export function HrRecruitmentPortal() {
    return (
        <PageTemplate pageId="H13" title="HR Recruitment Portal" subtitle="Job postings, applicant tracking and onboarding pipeline"
            sectionData={{
                'H13.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}
