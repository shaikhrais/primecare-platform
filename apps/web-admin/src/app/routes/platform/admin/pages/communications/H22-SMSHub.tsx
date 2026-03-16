// ================================================================
// PAGE IDENTITY: H22 · SMS Notification Hub
// Type: Hub | Owner: admin | Registry: H28
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const campaigns = [
    { name: 'Shift Reminder — Tomorrow', recipients: 24, delivered: '23 ✅', failed: '1 ❌', openRate: '96%', date: 'Today', status: 'COMPLETED' },
    { name: 'Training Session Reminder', recipients: 48, delivered: '46 ✅', failed: '2 ❌', openRate: '94%', date: 'Yesterday', status: 'COMPLETED' },
    { name: 'Weekly Schedule Update', recipients: 52, delivered: '—', failed: '—', openRate: '—', date: 'Scheduled: Mar 17', status: 'SCHEDULED' },
    { name: 'Emergency Weather Alert', recipients: 120, delivered: '118 ✅', failed: '2 ❌', openRate: '98%', date: 'Mar 10', status: 'COMPLETED' },
];

const campaignCols: TableColumn[] = [
    { key: 'name', label: 'Campaign' }, { key: 'recipients', label: 'Recipients' },
    { key: 'delivered', label: 'Delivered' }, { key: 'failed', label: 'Failed' },
    { key: 'openRate', label: 'Open Rate' }, { key: 'status', label: 'Status' },
];

const templates = [
    { icon: '⏰', title: 'Shift Reminder', subtitle: '340 uses' },
    { icon: '🚨', title: 'Emergency Alert', subtitle: '12 uses' },
    { icon: '📋', title: 'Schedule Change', subtitle: '89 uses' },
    { icon: '🎓', title: 'Training Notice', subtitle: '45 uses' },
    { icon: '💳', title: 'Pay Stub Ready', subtitle: '156 uses' },
    { icon: '🎉', title: 'Birthday Greeting', subtitle: '24 uses' },
];

export default function SMSHub() {
    const [tab, setTab] = useState('campaigns');

    const tabContent: Record<string, Record<string, any>> = {
        campaigns: { 'H28.campaign-list': { table: { columns: campaignCols, rows: campaigns } } },
        templates: { 'H28.compose': { cardGrid: { items: templates, columns: 3 } } },
    };

    return (
        <PageTemplate
            pageId="H28"
            title="📱 SMS Notification Hub"
            subtitle="Campaigns, templates & delivery analytics"
            actionPageId="manager.sms-hub"
            sectionData={{
                'H28.stats': { kpiCards: [
                    { label: 'Sent This Month', value: 192, color: 'var(--pc-primary)' },
                    { label: 'Delivery Rate', value: '97.4%', color: 'var(--pc-success)' },
                    { label: 'Credits Left', value: '1,808', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Avg Open Rate', value: '96%', color: 'var(--pc-success)' },
                ]},
                'H28.campaign-list': { tabs: {
                    tabs: [
                        { id: 'campaigns', label: '📊 Campaigns', count: 4 },
                        { id: 'templates', label: '📝 Templates', count: 6 },
                    ],
                    activeTab: tab, onTabChange: setTab,
                }},
                ...tabContent[tab],
            }}
        />
    );
}
