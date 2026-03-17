import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function TrainingAcademy() {
    return (
        <PageTemplate pageId="H11" title="Training Academy" subtitle="Staff training programs, certifications and compliance tracking"
            sectionData={{
                'H11.stats': { kpiCards: [
                    { label: 'Active Courses', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Completed (MTD)', value: 34, color: 'var(--pc-success)' },
                    { label: 'Overdue', value: 2, color: 'var(--pc-error, #EF4444)' },
                    { label: 'Avg Score', value: '87%', color: '#8B5CF6' },
                ]},
            }}
        />
    );
}
