// ================================================================
// Wound Care Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function WoundCareDashboard() {
    return (
        <PageTemplate pageId="WC" title="🩹 Wound Care" subtitle="Track wound assessments, healing progress & treatment protocols"
            sectionData={{
                'WC.stats': { kpiCards: [
                    { label: 'Active Wounds', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Healing On Track', value: 6, color: 'var(--pc-success)' },
                    { label: 'Needs Attention', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Assessments Due', value: 4, color: '#8B5CF6' },
                ]},
                'WC.wounds': { table: { columns: [
                    { key: 'client', label: 'Client' }, { key: 'type', label: 'Wound Type' },
                    { key: 'location', label: 'Location' }, { key: 'stage', label: 'Stage' },
                    { key: 'progress', label: 'Progress' },
                ], rows: [
                    { client: 'A. Chen', type: 'Pressure Ulcer', location: 'Sacrum', stage: 'Stage II', progress: '🟢 Healing' },
                    { client: 'M. Garcia', type: 'Surgical', location: 'L Knee', stage: 'Post-Op', progress: '🟢 On Track' },
                    { client: 'J. Williams', type: 'Diabetic Ulcer', location: 'R Foot', stage: 'Stage III', progress: '🟡 Slow' },
                ]}},
            }}
        />
    );
}


// --- Merged from D17-WoundCareDashboard.tsx ---
export function WoundCareDashboard_OLD() {
    return (
        <PageTemplate pageId="D17" title="Wound Care Dashboard" subtitle="Active wound assessments, healing progress and treatment protocols"
            sectionData={{
                'D17.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}

// --- Merged from T32-WoundCareClient.tsx ---
export function WoundCareClient() {
    return (
        <PageTemplate pageId="T32" title="Wound Care Client" subtitle="Document wound assessments, measurements and treatment progress"
            sectionData={{
                'T32.stats': { kpiCards: [
                    { label: 'Total', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 0, color: 'var(--pc-success)' },
                    { label: 'Pending', value: 0, color: 'var(--pc-warning)' },
                ]},
            }}
        />
    );
}