import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T38-DispatchMap.tsx
// removed broken export: export { default } from './T38-DispatchMap';


// --- Merged from T38-DispatchMap.tsx ---
export function DispatchMap() {
    return (
        <PageTemplate pageId="T38" title="Dispatch Map" subtitle="Real-time field staff locations and active visit tracking"
            sectionData={PageSectionRegistry['T38']}
        />
    );
}