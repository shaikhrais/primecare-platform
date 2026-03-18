import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H22-SMSHub.tsx ---
// PAGE IDENTITY: H22 · SMS Hub
import type { TableColumn } from '@/shared/components/sections';

const smsLogs = [
    { to: '+1 (416) 555-0123', template: 'Visit Reminder', sent: '14:15', status: '✅ Delivered', cost: '$0.015' },
    { to: '+1 (647) 555-0456', template: 'Shift Confirmation', sent: '13:45', status: '✅ Delivered', cost: '$0.015' },
    { to: '+1 (905) 555-0789', template: 'Schedule Change', sent: '12:30', status: '⏳ Pending', cost: '$0.015' },
    { to: '+1 (416) 555-0321', template: 'Auth Exhaustion Alert', sent: '11:00', status: '❌ Failed', cost: '$0.00' },
];

const cols: TableColumn[] = [
    { key: 'to', label: 'Recipient' }, { key: 'template', label: 'Template' },
    { key: 'sent', label: 'Sent' }, { key: 'status', label: 'Status' },
    { key: 'cost', label: 'Cost' },
];

export function SMSHub() {
    return (
        <PageTemplate pageId="H22" title="📱 SMS & Notifications Hub" subtitle="Twilio-powered SMS delivery, templates & delivery analytics"
            sectionData={{
                'H22.stats': { kpiCards: [
                    { label: 'Sent Today', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Delivered', value: '96%', color: 'var(--pc-success)' },
                    { label: 'Failed', value: 3, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Cost MTD', value: '$48.30', color: 'var(--pc-info, #2563EB)' },
                ]},
                'H22.table': { table: { columns: cols, rows: smsLogs } },
            }}
        />
    );
}
