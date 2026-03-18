import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from H1-TelehealthCenter.tsx ---
// ================================================================
// PAGE IDENTITY: H1 · Telehealth Center
// Type: Hub | Owner: admin | Registry: H1
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const sessionCols: TableColumn[] = [
    { key: 'patient', label: 'Patient' }, { key: 'type', label: 'Type' },
    { key: 'provider', label: 'Provider' }, { key: 'status', label: 'Status' },
    { key: 'time', label: 'Time' },
];

const rpmAlerts = [
    { id: '1', status: 'alert' as const, title: '🔴 Margaret Chen — BP 185/110 — Critical High', time: '2 min ago' },
    { id: '2', status: 'warning' as const, title: '🟡 Robert Williams — HR 112 bpm — Elevated', time: '8 min ago' },
    { id: '3', status: 'inactive' as const, title: '🟢 Susan Park — SpO2 97% — Normal range', time: '15 min ago' },
    { id: '4', status: 'inactive' as const, title: '🟢 James Brown — Glucose 108 mg/dL — Normal', time: '22 min ago' },
];

export function TelehealthCenter() {
    return (
        <PageTemplate
            pageId="H1"
            title="🩺 Telehealth & RPM Center"
            subtitle="Encrypted video consultations and live remote patient monitoring"
            actionPageId="admin.telehealth"
            isLive
            sectionData={PageSectionRegistry['H1']}
        />
    );
}
