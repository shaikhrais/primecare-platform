// PAGE IDENTITY: R1 · Report Center
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

const reportModules = [
    { icon: '📊', title: 'Financial Reports', subtitle: 'P&L, balance sheet, cash flow, aged receivables' },
    { icon: '👥', title: 'HR & Staffing', subtitle: 'Headcount, turnover, overtime, certification status' },
    { icon: '🏥', title: 'Clinical Reports', subtitle: 'Care plan outcomes, incident trends, med errors' },
    { icon: '📋', title: 'Compliance Reports', subtitle: 'HIPAA, PIPEDA, credential audits, training completion' },
    { icon: '📈', title: 'Operations Reports', subtitle: 'Visit volume, utilization, SLA adherence' },
    { icon: '🔍', title: 'Custom Builder', subtitle: 'Build ad-hoc reports with drag-and-drop fields' },
];

export default function ReportCenter() {
    return (
        <PageTemplate pageId="R1" title="📊 Report Center" subtitle="Comprehensive reporting suite — financial, clinical, HR, compliance & custom"
            sectionData={{
                'R1.stats': { kpiCards: [
                    { label: 'Report Types', value: 24, color: 'var(--pc-primary)' },
                    { label: 'Scheduled', value: 6, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Generated Today', value: 3, color: 'var(--pc-success)' },
                    { label: 'Exports', value: 15, color: '#7C3AED' },
                ]},
                'R1.modules': { cardGrid: { items: reportModules, columns: 3 } },
            }}
        />
    );
}
