// PAGE IDENTITY: L1 · Schedule
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function Schedule() {
    return (
        <PageTemplate pageId="L1" title="📅 Schedule Management" subtitle="Shift scheduling, coverage tracking & calendar overview"
            sectionData={{
                'L1.stats': { kpiCards: [
                    { label: 'Shifts Today', value: 23, color: 'var(--pc-primary)' },
                    { label: 'Coverage', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Open Shifts', value: 2, color: 'var(--pc-warning)' },
                    { label: 'OT Hours', value: 8, color: '#F59E0B' },
                ]},
                'L1.calendar': { calendar: {
                    events: [
                        { date: '2026-03-16', title: 'PSW Santos → Chen', color: '#3B82F6' },
                        { date: '2026-03-16', title: 'RN Johnson → Williams', color: '#10B981' },
                        { date: '2026-03-17', title: 'PSW Brown → Taylor', color: '#3B82F6' },
                        { date: '2026-03-18', title: 'OT Martinez → Brown', color: '#8B5CF6' },
                        { date: '2026-03-20', title: 'PSW Santos → Park', color: '#3B82F6' },
                    ],
                }},
            }}
        />
    );
}
