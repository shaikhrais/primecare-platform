import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H20-IoTMonitoring.tsx ---
// ================================================================
// PAGE IDENTITY: H20 · IoT & Wearable Monitoring — Smart Care
// Type: Hub | Owner: manager | Registry: H26
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';

const devices = [
    { id: 'iot-001', client: 'Margaret Chen', device: 'Fall Sensor', battery: '87%', status: 'ACTIVE', signal: 'strong', lastPing: '2 min ago', alerts: '0' },
    { id: 'iot-002', client: 'Robert Davies', device: 'BP Monitor', battery: '62%', status: 'ACTIVE', signal: 'good', lastPing: '8 min ago', alerts: '1' },
    { id: 'iot-003', client: 'Helen Kowalski', device: 'Glucose Monitor', battery: '45%', status: 'WARNING', signal: 'weak', lastPing: '23 min ago', alerts: '2' },
    { id: 'iot-004', client: 'James Morrison', device: 'Motion Sensor', battery: '92%', status: 'ACTIVE', signal: 'strong', lastPing: '1 min ago', alerts: '0' },
    { id: 'iot-005', client: 'Yuki Tanaka', device: 'Med Dispenser', battery: '15%', status: 'CRITICAL', signal: 'weak', lastPing: '45 min ago', alerts: '3' },
    { id: 'iot-006', client: 'Sarah O\'Malley', device: 'Smart Bed', battery: '78%', status: 'ACTIVE', signal: 'good', lastPing: '5 min ago', alerts: '0' },
];

const deviceCols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'device', label: 'Device' },
    { key: 'status', label: 'Status' }, { key: 'battery', label: 'Battery' },
    { key: 'signal', label: 'Signal' }, { key: 'lastPing', label: 'Last Ping' },
    { key: 'alerts', label: 'Alerts' },
];

export function IoTMonitoring() {
    const [tab, setTab] = useState('overview');

    return (
        <PageTemplate
            pageId="H26"
            title="📡 IoT & Wearable Monitoring"
            subtitle="Real-time health device monitoring, alerts & predictive insights"
            actionPageId="manager.iot-monitoring"
            sectionData={{
                'H26.device-stats': { kpiCards: [
                    { label: 'Connected Devices', value: 6, icon: '📱', color: 'var(--pc-primary)' },
                    { label: 'Events Today', value: 142, icon: '📊', color: 'var(--pc-info, #2563EB)' },
                    { label: 'Active Alerts', value: 6, icon: '🔔', color: 'var(--pc-error, #ef4444)' },
                    { label: 'Avg Battery', value: '63%', icon: '🔋', color: 'var(--pc-warning)' },
                    { label: 'Uptime', value: '99.2%', icon: '✅', color: 'var(--pc-success)' },
                ]},
                'H26.device-table': { table: { columns: deviceCols, rows: devices } },
                'H26.alert-panel': { alerts: [
                    { level: 'danger' as const, message: 'Glucose: 210 mg/dL — high alert (Helen Kowalski)', time: '10:25 AM' },
                    { level: 'danger' as const, message: 'Dose missed — 10:00 AM Metformin (Yuki Tanaka)', time: '10:15 AM' },
                    { level: 'warning' as const, message: 'BP reading: 142/88 — elevated (Robert Davies)', time: '10:38 AM' },
                    { level: 'warning' as const, message: 'BP reading: 138/85 — borderline (Robert Davies)', time: '9:30 AM' },
                    { level: 'info' as const, message: 'Motion detected — normal activity (Margaret Chen)', time: '10:42 AM' },
                    { level: 'info' as const, message: 'Sleep quality: 7.2/10 — good (Sarah O\'Malley)', time: '10:10 AM' },
                ]},
            }}
        />
    );
}
