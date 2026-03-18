import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Barrel re-export — identity file: F16-SubmitFeedback.tsx
// removed broken export: export { default } from './F16-SubmitFeedback';


// --- Merged from F16-SubmitFeedback.tsx ---
export function FeedbackForm() {
    return (
        <PageTemplate pageId="F16" title="Submit Feedback" subtitle="Share feedback about your care experience"
            sectionData={{
                'F16.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}