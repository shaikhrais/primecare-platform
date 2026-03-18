import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from SystemHealthMonitor.tsx ---
export function SystemHealthMonitor() {
    return (
        <PageTemplate 
            pageId="PGE-SHM" 
            title="✨ System Health Monitor" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-SHM']}
        />
    );
}
