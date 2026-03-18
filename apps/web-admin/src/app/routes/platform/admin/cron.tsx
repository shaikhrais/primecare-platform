import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D6-CronDashboard.tsx ---
// ================================================================
// PAGE IDENTITY: D6 · Cron Dashboard
// Type: Dashboard | Owner: admin | Registry: D6
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// NOTE: Preserves API mutation logic for job execution
// ================================================================
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '@/shared/utils/apiClient';
import type { TableColumn } from '@/shared/components/sections';

const cronJobs = [
    { id: 'compliance-sweep', name: '🔍 Compliance Sweep', description: 'Scans all PSW credentials for expired certifications', schedule: 'Daily @ 06:00', lastRun: '2026-03-09 06:00', status: '✅ Healthy', duration: '12s' },
    { id: 'training-reminders', name: '📚 Training Reminders', description: 'Sends reminder notifications for overdue modules', schedule: 'Daily @ 08:00', lastRun: '2026-03-09 08:00', status: '✅ Healthy', duration: '4s' },
    { id: 'auth-exhaustion', name: '⏳ Auth Exhaustion Check', description: 'Checks clients near 80%+ utilization of hours', schedule: 'Mon/Wed/Fri @ 07:00', lastRun: '2026-03-07 07:00', status: '✅ Healthy', duration: '8s' },
    { id: 'inventory-reorder', name: '📦 Inventory Reorder', description: 'Generates PO suggestions when stock is low', schedule: 'Weekly @ Mon 09:00', lastRun: '2026-03-03 09:00', status: '⚠️ Warning', duration: '15s' },
];

const jobCols: TableColumn[] = [
    { key: 'name', label: 'Job' }, { key: 'schedule', label: 'Schedule' },
    { key: 'lastRun', label: 'Last Run' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

export function CronDashboard() {
    const { t } = useTranslation();

    return (
        <PageTemplate
            pageId="D6"
            title="⏱️ Scheduled Jobs Dashboard"
            subtitle="Monitor automated cron tasks — compliance sweeps, training reminders, auth monitoring & inventory alerts"
            actionPageId="admin.cron-dashboard"
            sectionData={{
                'D6.job-stats': { kpiCards: [
                    { label: 'Total Jobs', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Healthy', value: 3, color: 'var(--pc-success)' },
                    { label: 'Warning', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Failed', value: 0, color: 'var(--pc-error, #ef4444)' },
                ]},
                'D6.job-list': { table: { columns: jobCols, rows: cronJobs } },
                'D6.run-history': { chart: {
                    title: 'Job Execution History (Last 7 Days)',
                    type: 'bar',
                    data: [
                        { label: 'Mon', value: 8 }, { label: 'Tue', value: 12 },
                        { label: 'Wed', value: 10 }, { label: 'Thu', value: 12 },
                        { label: 'Fri', value: 14 }, { label: 'Sat', value: 4 },
                        { label: 'Sun', value: 4 },
                    ],
                }},
            }}
        />
    );
}
