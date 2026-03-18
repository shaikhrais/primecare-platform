import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from RiskSurveillanceDashboard.tsx ---
export function RiskSurveillanceDashboard() {
    return (
        <PageTemplate 
            pageId="PGE-RSD" 
            title="✨ Risk Surveillance Dashboard" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RSD']}
        />
    );
}


export default function SuperAdminDashboard() {
    return (
        <PageTemplate 
            pageId="PG-599" 
            title="SuperAdminDashboard" 
            subtitle="Platform configuration, management, and insights"
            sectionData={PageSectionRegistry['PG-599']}
        />
    );
}
