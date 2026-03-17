import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T22-SurveyManager.tsx
// removed broken export: export { default } from './T22-SurveyManager';


// --- Merged from T22-SurveyManager.tsx ---
export function SurveyManager() {
    return (
        <PageTemplate pageId="T22" title="Survey Manager" subtitle="Create, distribute and analyze satisfaction surveys"
            sectionData={{
                'T22.stats': { kpiCards: [
                    { label: 'Active Surveys', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Responses (MTD)', value: 128, color: 'var(--pc-success)' },
                    { label: 'Avg Satisfaction', value: '4.2/5', color: '#8B5CF6' },
                    { label: 'Completion Rate', value: '76%', color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}