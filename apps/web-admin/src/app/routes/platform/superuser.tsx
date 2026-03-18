import { PageSectionRegistry } from '../shared/PageSectionRegistry';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from RiskSurveillanceDashboard.tsx ---
export function RiskSurveillanceDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-RSD" 
             
            
            sectionData={PageSectionRegistry['PGE-RSD']}
        />
    );
}


export default function SuperAdminDashboard() {
    return (
        <PageTemplate 
            pageId="PG-599" 
             
            
            sectionData={PageSectionRegistry['PG-599']}
        />
    );
}
