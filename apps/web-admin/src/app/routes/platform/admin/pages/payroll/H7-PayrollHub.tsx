// ================================================================
// PAGE IDENTITY: H7 · Payroll Hub
// Type: Hub | Owner: admin | Registry: H7
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const payrollRuns = [
    { period: 'Week 11 (Mar 10-16)', employees: 82, grossPay: '$147,250', deductions: '$38,285', netPay: '$108,965', status: 'Processing' },
    { period: 'Week 10 (Mar 3-9)', employees: 81, grossPay: '$144,800', deductions: '$37,648', netPay: '$107,152', status: 'Paid' },
    { period: 'Week 9 (Feb 24-Mar 2)', employees: 80, grossPay: '$143,200', deductions: '$37,232', netPay: '$105,968', status: 'Paid' },
];

const payrollCols: TableColumn[] = [
    { key: 'period', label: 'Period' }, { key: 'employees', label: 'Employees' },
    { key: 'grossPay', label: 'Gross Pay' }, { key: 'deductions', label: 'Deductions' },
    { key: 'netPay', label: 'Net Pay' }, { key: 'status', label: 'Status' },
];

export default function PayrollHub() {
    return (
        <PageTemplate
            pageId="H7"
            title="💵 Payroll Hub"
            subtitle="Payroll processing, deductions, tax withholding & direct deposit management"
            actionPageId="admin.payroll"
            sectionData={{
                'H7.stats': { kpiCards: [
                    { label: 'Payroll MTD', value: '$147K', color: 'var(--pc-primary)' },
                    { label: 'Employees', value: 82, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Hourly', value: '$24.50', color: 'var(--pc-success)' },
                    { label: 'OT Hours', value: 124, color: 'var(--pc-warning)' },
                ]},
                'H7.runs': { table: { columns: payrollCols, rows: payrollRuns } },
                'H7.trend': { chart: { title: 'Weekly Payroll (Last 8 Weeks)', type: 'bar', data: [
                    { label: 'W4', value: 138 }, { label: 'W5', value: 141 }, { label: 'W6', value: 140 },
                    { label: 'W7', value: 142 }, { label: 'W8', value: 139 }, { label: 'W9', value: 143 },
                    { label: 'W10', value: 145 }, { label: 'W11', value: 147 },
                ]}},
            }}
        />
    );
}
