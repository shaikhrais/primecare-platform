// PAGE IDENTITY: T51 · Webhook Deliveries
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const deliveries = [
    { time: '14:23:15', webhook: 'Slack Notifications', event: 'visit.created', status: '✅ 200', duration: '120ms' },
    { time: '14:23:14', webhook: 'Billing Sync', event: 'claim.submitted', status: '✅ 200', duration: '340ms' },
    { time: '14:20:08', webhook: 'EMR Integration', event: 'patient.updated', status: '❌ 500', duration: '2100ms' },
    { time: '13:45:22', webhook: 'Billing Sync', event: 'payment.received', status: '✅ 200', duration: '180ms' },
    { time: '13:30:11', webhook: 'EMR Integration', event: 'assessment.completed', status: '❌ Timeout', duration: '30000ms' },
];

const cols: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'webhook', label: 'Webhook' },
    { key: 'event', label: 'Event' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

export default function WebhookDeliveries() {
    return (
        <PageTemplate pageId="T51" title="📡 Webhook Deliveries" subtitle="Delivery logs, retry status & failure analysis"
            sectionData={{
                'T51.stats': { kpiCards: [
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Success Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 8, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Retrying', value: 2, color: 'var(--pc-warning)' },
                ]},
                'T51.table': { table: { columns: cols, rows: deliveries } },
            }}
        />
    );
}
