// ================================================================
// PAGE IDENTITY: T57 · Session Monitor
// Type: Tool | Owner: admin | Registry: T57
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const sessions = [
    { user: '🟢 admin@primecare.ca', role: 'Admin', device: 'Chrome / Windows', ip: '198.51.100.23', duration: '2h 15m', location: 'Toronto, ON' },
    { user: '🟢 sarah.mgr@primecare.ca', role: 'Manager', device: 'Safari / macOS', ip: '203.0.113.42', duration: '45m', location: 'North York, ON' },
    { user: '🟢 kevin.psw@primecare.ca', role: 'PSW', device: 'PrimeCare PWA / Android', ip: '72.134.215.90', duration: '1h 30m', location: 'Mississauga, ON' },
    { user: '🟡 finance@primecare.ca', role: 'Finance', device: 'Firefox / Linux', ip: '198.51.100.25', duration: '10m', location: 'Ottawa, ON' },
    { user: '🔴 unknown@test.com', role: '—', device: 'curl/7.88.1', ip: '185.220.101.42', duration: 'Blocked', location: 'TOR Exit Node' },
];

const sessionCols: TableColumn[] = [
    { key: 'user', label: 'User' }, { key: 'role', label: 'Role' },
    { key: 'device', label: 'Device' }, { key: 'ip', label: 'IP' },
    { key: 'duration', label: 'Duration' }, { key: 'location', label: 'Location' },
];

export default function SessionMonitor() {
    return (
        <PageTemplate
            pageId="T57"
            title="📡 Session Monitor"
            subtitle="Real-time active sessions, suspicious activity detection & session management"
            actionPageId="admin.session-monitor"
            isLive
            sectionData={{
                'T57.stats': { kpiCards: [
                    { label: 'Active Sessions', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Blocked', value: 1, color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Duration', value: '1.1 hrs', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Unique IPs', value: 5, color: '#7C3AED' },
                ]},
                'T57.sessions': { table: { columns: sessionCols, rows: sessions } },
            }}
        />
    );
}
