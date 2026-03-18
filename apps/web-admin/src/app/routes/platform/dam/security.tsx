import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from AssetPermissionMatrix.tsx ---
export function AssetPermissionMatrix() {
    return (
        <PageTemplate 
            pageId="PGE-APM" 
            title="✨ Asset Permission Matrix" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-APM']}
        />
    );
}

// --- Merged from GlobalDigitalKillSwitch.tsx ---
export function GlobalDigitalKillSwitch() {
    return (
        <PageTemplate 
            pageId="PGE-GDK" 
            title="✨ Global Digital Kill Switch" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-GDK']}
        />
    );
}
