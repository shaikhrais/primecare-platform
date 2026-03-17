import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ExpenseReportForm() {
    return (
        <PageTemplate pageId="F14" title="Expense Claim" subtitle="Submit expense claims with receipt upload and approval tracking"
            sectionData={{
                'F14.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}