// ================================================================
// PAGE IDENTITY: T7 · AutoPilot Dashboard
// Type: Tool | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const automations = [
    { name: '🔄 Compliance Sweep', trigger: 'Cron: Daily 06:00', runs: 365, lastRun: 'Today 06:00', status: '✅ Active' },
    { name: '📧 Training Reminders', trigger: 'Cron: Daily 08:00', runs: 365, lastRun: 'Today 08:00', status: '✅ Active' },
    { name: '⏰ Auth Exhaustion Alert', trigger: 'Cron: M/W/F 07:00', runs: 156, lastRun: 'Today 07:00', status: '✅ Active' },
    { name: '📋 Shift Auto-Assign', trigger: 'Event: New Booking', runs: 2847, lastRun: '14:23', status: '✅ Active' },
    { name: '🔔 Visit Reminder SMS', trigger: 'Event: 1hr before visit', runs: 12450, lastRun: '14:15', status: '✅ Active' },
    { name: '📊 Weekly Report Gen', trigger: 'Cron: Mon 09:00', runs: 52, lastRun: 'Mar 11', status: '✅ Active' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Automation' }, { key: 'trigger', label: 'Trigger' },
    { key: 'runs', label: 'Total Runs' }, { key: 'lastRun', label: 'Last Run' },
    { key: 'status', label: 'Status' },
];

export default function AutoPilotDashboard() {
    return (
        <PageTemplate
            pageId="T7"
            title="🤖 AutoPilot Dashboard"
            subtitle="Workflow automations, event triggers, scheduled tasks & notification rules"
            actionPageId="admin.autopilot"
            sectionData={{
                'T7.stats': { kpiCards: [
                    { label: 'Active Automations', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Runs Today', value: 847, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Success Rate', value: '99.8%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 2, color: 'var(--pc-error, #ef4444)' },
                ]},
                'T7.table': { table: { columns: cols, rows: automations } },
            }}
        />
    );
}
