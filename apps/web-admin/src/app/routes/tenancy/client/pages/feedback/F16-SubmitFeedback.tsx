import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function FeedbackForm() {
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