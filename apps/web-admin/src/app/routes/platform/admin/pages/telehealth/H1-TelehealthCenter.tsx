// ================================================================
// PAGE IDENTITY: H1 · Telehealth Center
// Type: Hub | Owner: admin | Registry: H1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const sessionData = [
    { patient: 'Margaret Chen', type: 'Video Consult', provider: 'Dr. Smith', status: 'In-Progress', time: '14:30' },
    { patient: 'Robert Williams', type: 'RPM Review', provider: 'RN Johnson', status: 'Scheduled', time: '15:00' },
    { patient: 'Susan Park', type: 'Follow-up', provider: 'Dr. Martinez', status: 'In-Progress', time: '14:45' },
];

const sessionCols: TableColumn[] = [
    { key: 'patient', label: 'Patient' }, { key: 'type', label: 'Type' },
    { key: 'provider', label: 'Provider' }, { key: 'status', label: 'Status' },
    { key: 'time', label: 'Time' },
];

const rpmAlerts = [
    { id: '1', severity: 'danger' as const, title: '🔴 Margaret Chen — BP 185/110 — Critical High', time: '2 min ago' },
    { id: '2', severity: 'warning' as const, title: '🟡 Robert Williams — HR 112 bpm — Elevated', time: '8 min ago' },
    { id: '3', severity: 'info' as const, title: '🟢 Susan Park — SpO2 97% — Normal range', time: '15 min ago' },
    { id: '4', severity: 'info' as const, title: '🟢 James Brown — Glucose 108 mg/dL — Normal', time: '22 min ago' },
];

export default function TelehealthCenter() {
    return (
        <PageTemplate
            pageId="H1"
            title="🩺 Telehealth & RPM Center"
            subtitle="Encrypted video consultations and live remote patient monitoring"
            actionPageId="admin.telehealth"
            isLive
            sectionData={{
                'H1.session-stats': { kpiCards: [
                    { label: 'Active Sessions', value: 2, color: 'var(--pc-primary)' },
                    { label: 'Scheduled Today', value: 8, color: 'var(--pc-info, #2563EB)' },
                    { label: 'RPM Devices', value: 34, color: 'var(--pc-success)' },
                    { label: 'Critical Alerts', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H1.active-sessions': { table: { columns: sessionCols, rows: sessionData } },
                'H1.alerts': { alerts: rpmAlerts },
            }}
        />
    );
}
