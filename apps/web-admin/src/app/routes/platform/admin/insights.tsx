import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T9-AiInsights.tsx
// removed broken export: export { default } from './T9-AiInsights';


// --- Merged from T9-AiInsights.tsx ---
// PAGE IDENTITY: T9 · AI Insights



export function AiInsights() {
    return (
        <PageTemplate pageId="T9" title="🧠 AI Insights" subtitle="Machine learning model outputs, pattern detection & actionable recommendations"
            sectionData={PageSectionRegistry['T9']}
        />
    );
}