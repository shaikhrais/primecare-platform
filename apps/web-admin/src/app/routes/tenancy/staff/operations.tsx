import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from T45-IncidentPortal.tsx ---
export function IncidentPortal() {
    return (
        <PageTemplate pageId="T45" title="Incident Portal" subtitle="Report, track and resolve workplace incidents"
            sectionData={PageSectionRegistry['T45']}
        />
    );
}

// --- Merged from T46-ComplianceMonitor.tsx ---
export function ComplianceMonitor() {
    return (
        <PageTemplate pageId="T46" title="Compliance Monitor" subtitle="Monitor regulatory compliance status across all departments"
            sectionData={PageSectionRegistry['T46']}
        />
    );
}
