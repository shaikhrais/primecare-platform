import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D18-AlliedHealthDashboard.tsx ---
export function AlliedHealthDashboard() {
    return (
        <PageTemplate pageId="D18"  
            sectionData={PageSectionRegistry['D18']}
        />
    );
}


// --- Merged from T42-SignOff.tsx ---
export function SignOff() {
    return (
        <PageTemplate pageId="T42"  
            sectionData={PageSectionRegistry['T42']}
        />
    );
}


// --- Merged from L21-TreatmentList.tsx ---
export function TreatmentList() {
    return (
        <PageTemplate pageId="L21"  
            sectionData={PageSectionRegistry['L21']}
        />
    );
}
