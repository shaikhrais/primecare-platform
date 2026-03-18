import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L11-WebhookList.tsx ---
// PAGE IDENTITY: L11 · Webhook List


const webhooks = [
    { id: 'WH-01', name: 'Slack Notifications', url: 'https://hooks.slack.com/...', events: 'visit.created, incident.*', status: '✅ Active', lastDelivery: '14:23' },
    { id: 'WH-02', name: 'Billing Sync', url: 'https://billing.example.com/hooks', events: 'claim.submitted, payment.*', status: '✅ Active', lastDelivery: '13:45' },
    { id: 'WH-03', name: 'EMR Integration', url: 'https://emr.example.com/api/events', events: 'patient.*, assessment.*', status: '⚠️ Failing', lastDelivery: 'Mar 14' },
];

const cols_1: TableColumn[] = [
    { key: 'name', label: 'Webhook' }, { key: 'url', label: 'URL' },
    { key: 'events', label: 'Events' }, { key: 'status', label: 'Status' },
    { key: 'lastDelivery', label: 'Last Delivery' },
];

export function WebhookList() {
    return (
        <PageTemplate pageId="L11" title="🔗 Webhooks" subtitle="Outbound webhook endpoints, event subscriptions & delivery logs"
            sectionData={{
                'L11.stats': { kpiCards: [
                    { label: 'Endpoints', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 2, color: 'var(--pc-success)' },
                    { label: 'Failing', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L11.table': { table: { columns: cols_1, rows: webhooks } },
            }}
        />
    );
}

// --- Merged from T51-WebhookDeliveries.tsx ---
// PAGE IDENTITY: T51 · Webhook Deliveries


const deliveries = [
    { time: '14:23:15', webhook: 'Slack Notifications', event: 'visit.created', status: '✅ 200', duration: '120ms' },
    { time: '14:23:14', webhook: 'Billing Sync', event: 'claim.submitted', status: '✅ 200', duration: '340ms' },
    { time: '14:20:08', webhook: 'EMR Integration', event: 'patient.updated', status: '❌ 500', duration: '2100ms' },
    { time: '13:45:22', webhook: 'Billing Sync', event: 'payment.received', status: '✅ 200', duration: '180ms' },
    { time: '13:30:11', webhook: 'EMR Integration', event: 'assessment.completed', status: '❌ Timeout', duration: '30000ms' },
];

const cols_2: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'webhook', label: 'Webhook' },
    { key: 'event', label: 'Event' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

export function WebhookDeliveries() {
    return (
        <PageTemplate pageId="T51" title="📡 Webhook Deliveries" subtitle="Delivery logs, retry status & failure analysis"
            sectionData={{
                'T51.stats': { kpiCards: [
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Success Rate', value: '94%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 8, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Retrying', value: 2, color: 'var(--pc-warning)' },
                ]},
                'T51.table': { table: { columns: cols_2, rows: deliveries } },
            }}
        />
    );
}
