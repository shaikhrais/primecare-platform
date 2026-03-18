import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T39-SosCenter.tsx
// removed broken export: export { default } from './T39-SosCenter';


// --- Merged from T39-SosCenter.tsx ---
export function SosCenter() {
    return (
        <PageTemplate pageId="T39" title="SOS Center" subtitle="Emergency response coordination and alert management"
            sectionData={PageSectionRegistry['T39']}
        />
    );
}