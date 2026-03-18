import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T20-DailyEntry.tsx
// removed broken export: export { default } from './T20-DailyEntry';


// --- Merged from T20-DailyEntry.tsx ---
// ================================================================
// PAGE IDENTITY: T20 — Daily Entry
// Type: Tool | Owner: manager
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================



export function DailyEntry() {
    return (
        <PageTemplate pageId="T20" title="📝 Daily Entry" subtitle="Record ADLs, vitals & wellness observations for client visits"
            sectionData={PageSectionRegistry['T20']}
        />
    );
}