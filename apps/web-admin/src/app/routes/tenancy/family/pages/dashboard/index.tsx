// ================================================================
// Family Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function FamilyDashboard() {
    return (
        <PageTemplate pageId="FAM" title="👨‍👩‍👧 Family Portal" subtitle="Stay connected with your loved one's care — updates, schedule & payments"
            sectionData={{
                'FAM.stats': { kpiCards: [
                    { label: 'Next Visit', value: 'Today 2 PM', color: 'var(--pc-primary)' },
                    { label: 'Monthly Hours', value: 38,  color: 'var(--pc-success)' },
                    { label: 'Balance Due', value: '$45.00', color: 'var(--pc-warning)' },
                    { label: 'Care Updates', value: 3,  color: '#8B5CF6' },
                ]},
                'FAM.updates': { table: { columns: [
                    { key: 'date', label: 'Date' }, { key: 'caregiver', label: 'Caregiver' },
                    { key: 'update', label: 'Update' }, { key: 'mood', label: 'Mood' },
                ], rows: [
                    { date: 'Today', caregiver: 'Sarah P.', update: 'Had a great morning walk, ate full breakfast', mood: '😊 Happy' },
                    { date: 'Yesterday', caregiver: 'Mike R.', update: 'Completed physio exercises, watched TV together', mood: '😌 Calm' },
                    { date: 'Mar 14', caregiver: 'Lisa T.', update: 'Slight fatigue, rested after lunch', mood: '😐 Neutral' },
                ]}},
            }}
        />
    );
}
