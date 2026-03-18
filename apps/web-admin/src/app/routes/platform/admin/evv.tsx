import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from D4-EvvDashboard.tsx ---
// PAGE IDENTITY: D4 · EVV Dashboard

export function EvvDashboard() {
    return (
        <PageTemplate pageId="D4" title="📍 EVV Dashboard" subtitle="Electronic Visit Verification — real-time GPS, clock-in/out & compliance"
            isLive
            sectionData={PageSectionRegistry['D4']}
        />
    );
}

// --- Merged from L22-EvvExceptions.tsx ---
// PAGE IDENTITY: L22 · EVV Exceptions
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'date', label: 'Date' }, { key: 'psw', label: 'PSW' },
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Exception Type' },
    { key: 'detail', label: 'Detail' }, { key: 'status', label: 'Status' },
];

export function EvvExceptions() {
    return (
        <PageTemplate pageId="L22" title="⚠️ EVV Exceptions" subtitle="GPS mismatches, missing clock-ins & duration discrepancies"
            sectionData={PageSectionRegistry['L22']}
        />
    );
}

// --- Merged from R8-EvvExport.tsx ---
// PAGE IDENTITY: R8 · EVV Export

export function EvvExport() {
    return (
        <PageTemplate pageId="R8" title="📥 EVV Export" subtitle="Export EVV data for billing, compliance & payer submissions"
            sectionData={PageSectionRegistry['R8']}
        />
    );
}
