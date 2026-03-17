import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function SurveyManager() {
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
