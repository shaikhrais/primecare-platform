// PAGE IDENTITY: L11 · Webhook List
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const webhooks = [
    { id: 'WH-01', name: 'Slack Notifications', url: 'https://hooks.slack.com/...', events: 'visit.created, incident.*', status: '✅ Active', lastDelivery: '14:23' },
    { id: 'WH-02', name: 'Billing Sync', url: 'https://billing.example.com/hooks', events: 'claim.submitted, payment.*', status: '✅ Active', lastDelivery: '13:45' },
    { id: 'WH-03', name: 'EMR Integration', url: 'https://emr.example.com/api/events', events: 'patient.*, assessment.*', status: '⚠️ Failing', lastDelivery: 'Mar 14' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Webhook' }, { key: 'url', label: 'URL' },
    { key: 'events', label: 'Events' }, { key: 'status', label: 'Status' },
    { key: 'lastDelivery', label: 'Last Delivery' },
];

export default function WebhookList() {
    return (
        <PageTemplate pageId="L11" title="🔗 Webhooks" subtitle="Outbound webhook endpoints, event subscriptions & delivery logs"
            sectionData={{
                'L11.stats': { kpiCards: [
                    { label: 'Endpoints', value: 3, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 2, color: 'var(--pc-success)' },
                    { label: 'Failing', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Deliveries Today', value: 142, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L11.table': { table: { columns: cols, rows: webhooks } },
            }}
        />
    );
}
