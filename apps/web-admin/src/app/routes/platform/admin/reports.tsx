import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: R1-ReportCenter.tsx
// removed broken export: export { default } from './R1-ReportCenter';


// --- Merged from R1-ReportCenter.tsx ---
// PAGE IDENTITY: R1 · Report Center



const reportModules = [
    { icon: '📊', title: 'Financial Reports', subtitle: 'P&L, balance sheet, cash flow, aged receivables' },
    { icon: '👥', title: 'HR & Staffing', subtitle: 'Headcount, turnover, overtime, certification status' },
    { icon: '🏥', title: 'Clinical Reports', subtitle: 'Care plan outcomes, incident trends, med errors' },
    { icon: '📋', title: 'Compliance Reports', subtitle: 'HIPAA, PIPEDA, credential audits, training completion' },
    { icon: '📈', title: 'Operations Reports', subtitle: 'Visit volume, utilization, SLA adherence' },
    { icon: '🔍', title: 'Custom Builder', subtitle: 'Build ad-hoc reports with drag-and-drop fields' },
];

export function ReportCenter() {
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

// --- Merged from R2-ExportPage.tsx ---
// PAGE IDENTITY: R2 · Export Page



export function ExportPage() {
    return (
        <PageTemplate pageId="R2" title="📥 Data Export" subtitle="Export platform data in CSV, PDF, Excel & JSON formats"
            sectionData={{
                'R2.stats': { kpiCards: [
                    { label: 'Export Types', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Generated Today', value: 3, color: 'var(--pc-success)' },
                    { label: 'Scheduled', value: 2, color: 'var(--pc-info, #2563EB)' },
                ]},
                'R2.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw data tables — clients, visits, timesheets, billing' },
                    { icon: '📋', title: 'PDF Reports', subtitle: 'Formatted reports with charts, summaries & branding' },
                    { icon: '📊', title: 'Excel Workbook', subtitle: 'Multi-sheet workbooks with pivot data & formulas' },
                    { icon: '🔗', title: 'JSON / API', subtitle: 'Machine-readable data for system integrations' },
                ], columns: 2 } },
            }}
        />
    );
}