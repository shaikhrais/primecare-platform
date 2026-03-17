// ================================================================
// PAGE IDENTITY: T54 · Visit Optimization
// Type: Tool | Owner: admin | Registry: T54
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const optimizationSuggestions = [
    { icon: '🗺️', title: 'Route Clustering — North York', subtitle: '3 visits can be grouped → save 45 min drive time' },
    { icon: '⏰', title: 'Schedule Gap — PSW Chen', subtitle: '2 hr gap between visits on Wed. Suggest backfill.' },
    { icon: '📍', title: 'Distance Alert — PSW Williams', subtitle: 'Visit #4 is 38km from #3. Suggest reassign.' },
    { icon: '✅', title: 'Optimal Match — Client Park', subtitle: 'PSW Santos best fit: 98% compatibility score' },
];

export default function VisitOptimization() {
    return (
        <PageTemplate
            pageId="T54"
            title="🗺️ Visit Optimization"
            subtitle="AI-powered route clustering, schedule optimization & PSW-client matching"
            actionPageId="admin.visit-optimization"
            sectionData={{
                'T54.stats': { kpiCards: [
                    { label: 'Routes Optimized', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Time Saved', value: '4.2 hrs', color: 'var(--pc-success)' },
                    { label: 'Fuel Saved', value: '$142', color: '#10B981' },
                    { label: 'Suggestions', value: 4, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T54.suggestions': { cardGrid: { items: optimizationSuggestions, columns: 2 } },
                'T54.efficiency': { chart: { title: 'Weekly Efficiency Gains', type: 'bar', data: [
                    { label: 'Mon', value: 35, color: '#10B981' }, { label: 'Tue', value: 42, color: '#10B981' },
                    { label: 'Wed', value: 28, color: '#10B981' }, { label: 'Thu', value: 51, color: '#10B981' },
                    { label: 'Fri', value: 38, color: '#10B981' },
                ]}},
            }}
        />
    );
}
