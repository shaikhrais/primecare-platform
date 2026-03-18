import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D18-AlliedHealthDashboard.tsx ---
export function AlliedHealthDashboard() {
    return (
        <PageTemplate pageId="D18" title="Allied Health Dashboard" subtitle="Allied health team coordination and treatment tracking"
            sectionData={PageSectionRegistry['D18']}
        />
    );
}


// --- Merged from T42-SignOff.tsx ---
export function SignOff() {
    return (
        <PageTemplate pageId="T42" title="Clinical Sign-Off" subtitle="Review and sign off on completed clinical documentation"
            sectionData={PageSectionRegistry['T42']}
        />
    );
}


// --- Merged from L21-TreatmentList.tsx ---
export function TreatmentList() {
    return (
        <PageTemplate pageId="L21" title="Treatment List" subtitle="Active treatments, therapy sessions and progress tracking"
            sectionData={PageSectionRegistry['L21']}
        />
    );
}
