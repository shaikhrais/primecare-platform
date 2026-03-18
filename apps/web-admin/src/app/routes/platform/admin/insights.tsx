import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T9-AiInsights.tsx
// removed broken export: export { default } from './T9-AiInsights';


// --- Merged from T9-AiInsights.tsx ---
// PAGE IDENTITY: T9 · AI Insights



export function AiInsights() {
    return (
        <PageTemplate pageId="T9" title="🧠 AI Insights" subtitle="Machine learning model outputs, pattern detection & actionable recommendations"
            sectionData={{
                'T9.stats': { kpiCards: [
                    { label: 'Insights Generated', value: 24, color: '#8B5CF6' },
                    { label: 'Actionable', value: 8, color: 'var(--pc-primary)' },
                    { label: 'Applied', value: 5, color: 'var(--pc-success)' },
                    { label: 'Model Accuracy', value: '94%', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T9.feed': { feed: { title: '🧠 Recent Insights', items: [
                    { icon: '💡', title: 'Staffing: Add 2 PSWs in North York zone — demand ↑ 15% predicted next month', time: '1 hr ago', level: 'info' as const },
                    { icon: '⚠️', title: 'Churn Risk: Client Chen satisfaction declining — recommend PSW assignment review', time: '3 hrs ago', level: 'warning' as const },
                    { icon: '📈', title: 'Efficiency: Route optimization could save 12 hrs/week in Mississauga zone', time: '6 hrs ago', level: 'success' as const },
                    { icon: '🔔', title: 'Compliance: 3 PSW certifications expiring within 30 days', time: '1 day ago', level: 'danger' as const },
                ]}},
            }}
        />
    );
}