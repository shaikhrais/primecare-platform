// PAGE IDENTITY: T13 · Device Management
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const devices = [
    { name: 'iPhone 14 Pro', user: 'Kevin Chen (PSW)', os: 'iOS 17.4', lastSeen: 'Today 14:23', status: '✅ Active', trust: 'Trusted' },
    { name: 'Samsung Galaxy S24', user: 'Maria Santos (PSW)', os: 'Android 14', lastSeen: 'Today 13:45', status: '✅ Active', trust: 'Trusted' },
    { name: 'iPad Air (5th)', user: 'Sarah Manager', os: 'iPadOS 17.4', lastSeen: 'Today 10:00', status: '✅ Active', trust: 'Trusted' },
    { name: 'Chrome — Windows', user: 'admin@primecare.ca', os: 'Win 11', lastSeen: 'Today 14:30', status: '✅ Active', trust: 'Trusted' },
    { name: 'Unknown Android', user: 'lisa.park@primecare.ca', os: 'Android 13', lastSeen: 'Mar 10', status: '⚠️ Stale', trust: 'Untrusted' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Device' }, { key: 'user', label: 'User' },
    { key: 'os', label: 'OS' }, { key: 'lastSeen', label: 'Last Seen' },
    { key: 'status', label: 'Status' }, { key: 'trust', label: 'Trust' },
];

export default function DeviceManagement() {
    return (
        <PageTemplate pageId="T13" title="📱 Device Management" subtitle="Registered devices, trust levels, remote wipe & session management"
            sectionData={{
                'T13.stats': { kpiCards: [
                    { label: 'Registered', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 4, color: 'var(--pc-success)' },
                    { label: 'Untrusted', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Max per User', value: 3, color: 'var(--pc-info, #2563EB)' },
                ]},
                'T13.table': { table: { columns: cols, rows: devices } },
            }}
        />
    );
}
