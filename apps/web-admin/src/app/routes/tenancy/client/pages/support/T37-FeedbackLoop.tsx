import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function FeedbackLoop() {
    return (
        <PageTemplate pageId="T37" title="Feedback Loop" subtitle="Submit and track feedback on care quality and services"
            sectionData={{
                'T37.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}