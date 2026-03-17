// PAGE IDENTITY: F10 · Incident Entry
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function IncidentEntry() {
    return (
        <PageTemplate pageId="F10" title="🚨 Incident Report" subtitle="Submit workplace incidents, near-misses & safety concerns"
            sectionData={{
                'F10.stats': { kpiCards: [
                    { label: 'Open Incidents', value: 2, color: 'var(--pc-warning)' },
                    { label: 'This Month', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Avg Resolution', value: '3 days', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Severity Avg', value: 'Low', color: 'var(--pc-success)' },
                ]},
                'F10.form': { cardGrid: { items: [
                    { icon: '📋', title: 'Incident Details', subtitle: 'Date, time, location & description' },
                    { icon: '👤', title: 'Involved Parties', subtitle: 'Client, PSW, witnesses & supervisor' },
                    { icon: '🏥', title: 'Injury Assessment', subtitle: 'Type, severity & treatment administered' },
                    { icon: '📊', title: 'Root Cause Analysis', subtitle: 'Contributing factors & prevention plan' },
                ], columns: 2 } },
            }}
        />
    );
}
