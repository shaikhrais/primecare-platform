// ================================================================
// PAGE IDENTITY: T8 · Clinical Assistant
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const clinicalModules = [
    { icon: '🩺', title: 'Care Plan Builder', subtitle: 'Create & manage individualized care plans' },
    { icon: '💊', title: 'Medication Reconciliation', subtitle: 'Cross-check prescriptions, interactions & allergies' },
    { icon: '📋', title: 'Assessment Templates', subtitle: 'RAI-HC, InterRAI, MDS & custom assessments' },
    { icon: '🔬', title: 'Lab Integration', subtitle: 'Lab orders, results tracking & abnormal flags' },
    { icon: '📊', title: 'Outcome Tracking', subtitle: 'Goal progress, clinical indicators & trends' },
    { icon: '🤖', title: 'AI Clinical Suggestions', subtitle: 'Evidence-based care recommendations' },
];

export default function ClinicalAssistant() {
    return (
        <PageTemplate
            pageId="T8"
            title="🩺 Clinical Assistant"
            subtitle="AI-powered clinical decision support, care planning & outcome tracking"
            actionPageId="admin.clinical-assistant"
            sectionData={{
                'T8.stats': { kpiCards: [
                    { label: 'Active Care Plans', value: 67, color: 'var(--pc-primary)' },
                    { label: 'Assessments Due', value: 5, color: 'var(--pc-warning)' },
                    { label: 'AI Suggestions', value: 12, color: '#8B5CF6' },
                    { label: 'Compliance', value: '98%', color: 'var(--pc-success)' },
                ]},
                'T8.modules': { cardGrid: { items: clinicalModules, columns: 3 } },
            }}
        />
    );
}
