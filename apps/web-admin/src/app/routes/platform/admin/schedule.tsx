import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: L1-Schedule.tsx
// removed broken export: export { default } from './L1-Schedule';


// --- Merged from L1-Schedule.tsx ---
// PAGE IDENTITY: L1 · Schedule



export function Schedule() {
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
                        { id: `evt-${Math.random()}`, date: '2026-03-16', title: 'PSW Santos → Chen', color: '#3B82F6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-16', title: 'RN Johnson → Williams', color: '#10B981' },
                        { id: `evt-${Math.random()}`, date: '2026-03-17', title: 'PSW Brown → Taylor', color: '#3B82F6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-18', title: 'OT Martinez → Brown', color: '#8B5CF6' },
                        { id: `evt-${Math.random()}`, date: '2026-03-20', title: 'PSW Santos → Park', color: '#3B82F6' },
                    ],
                }},
            }}
        />
    );
}