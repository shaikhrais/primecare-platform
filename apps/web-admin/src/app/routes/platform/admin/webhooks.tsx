import type { TableColumn } from '@/shared/components/sections';
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from L11-WebhookList.tsx ---
// PAGE IDENTITY: L11 · Webhook List
const cols_1: TableColumn[] = [
    { key: 'name', label: 'Webhook' }, { key: 'url', label: 'URL' },
    { key: 'events', label: 'Events' }, { key: 'status', label: 'Status' },
    { key: 'lastDelivery', label: 'Last Delivery' },
];

export function WebhookList() {
    return (
        <PageTemplate pageId="L11" title="🔗 Webhooks" subtitle="Outbound webhook endpoints, event subscriptions & delivery logs"
            sectionData={PageSectionRegistry['L11']}
        />
    );
}

// --- Merged from T51-WebhookDeliveries.tsx ---
// PAGE IDENTITY: T51 · Webhook Deliveries
const cols_2: TableColumn[] = [
    { key: 'time', label: 'Time' }, { key: 'webhook', label: 'Webhook' },
    { key: 'event', label: 'Event' }, { key: 'status', label: 'Status' },
    { key: 'duration', label: 'Duration' },
];

export function WebhookDeliveries() {
    return (
        <PageTemplate pageId="T51" title="📡 Webhook Deliveries" subtitle="Delivery logs, retry status & failure analysis"
            sectionData={PageSectionRegistry['T51']}
        />
    );
}
