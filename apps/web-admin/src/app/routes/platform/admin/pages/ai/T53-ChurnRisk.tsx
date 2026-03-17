// ================================================================
// PAGE IDENTITY: T53 · Churn Risk
// Type: Tool | Owner: admin | Registry: T53
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const churnClients = [
    { client: '🔴 Margaret Chen', riskScore: '87%', factors: 'Missed 3 visits, satisfaction ↓', days: 14, action: 'Call scheduled' },
    { client: '🟠 Robert Williams', riskScore: '72%', factors: 'Auth exhausting (92%)', days: 21, action: 'Renewal pending' },
    { client: '🟡 Susan Park', riskScore: '58%', factors: 'PSW turnover (3 changes)', days: 45, action: 'Assign stable PSW' },
    { client: '🟡 James Brown', riskScore: '52%', factors: 'Missed medication 2x', days: 30, action: 'RN follow-up' },
    { client: '🟢 Helen Taylor', riskScore: '23%', factors: 'Stable – no flags', days: 90, action: 'Monitor' },
];

const churnCols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'riskScore', label: 'Risk' },
    { key: 'factors', label: 'Contributing Factors' }, { key: 'days', label: 'Days Active' },
    { key: 'action', label: 'Recommended Action' },
];

export default function ChurnRisk() {
    return (
        <PageTemplate
            pageId="T53"
            title="⚠️ Churn Risk Analysis"
            subtitle="AI-predicted client attrition risk with actionable intervention recommendations"
            actionPageId="admin.churn-risk"
            sectionData={{
                'T53.stats': { kpiCards: [
                    { label: 'At-Risk Clients', value: 4, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Risk Score', value: '58.4%', color: 'var(--pc-warning)' },
                    { label: 'Interventions Active', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Retention Rate', value: '94.1%', color: 'var(--pc-success)' },
                ]},
                'T53.churn-table': { table: { columns: churnCols, rows: churnClients } },
                'T53.trend': { chart: { title: 'Churn Risk Trend (6 Months)', type: 'bar', data: [
                    { label: 'Oct', value: 8 }, { label: 'Nov', value: 6 },
                    { label: 'Dec', value: 5 }, { label: 'Jan', value: 7 },
                    { label: 'Feb', value: 4 }, { label: 'Mar', value: 4 },
                ]}},
            }}
        />
    );
}
