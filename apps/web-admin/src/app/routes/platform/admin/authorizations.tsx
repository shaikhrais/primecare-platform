import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L7-AuthList.tsx ---
// ================================================================
// PAGE IDENTITY: L7 · Authorization List
// Type: List | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'payer', label: 'Payer' },
    { key: 'service', label: 'Service' }, { key: 'approved', label: 'Approved' },
    { key: 'used', label: 'Used' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function AuthList() {
    return (
        <PageTemplate pageId="L7" title="📋 Service Authorizations" subtitle="Track approved hours, utilization & expiration dates"
            actionPageId="admin.authorizations"
            sectionData={PageSectionRegistry['L7']}
        />
    );
}

// --- Merged from R6-AuthUtilization.tsx ---
// PAGE IDENTITY: R6 · Auth Utilization | T49 · Auth Alerts

export function AuthUtilization() {
    return (
        <PageTemplate pageId="R6" title="📊 Authorization Utilization" subtitle="Payer-specific utilization rates, exhaustion forecasts & renewal tracking"
            sectionData={PageSectionRegistry['R6']}
        />
    );
}

// --- Merged from T49-AuthAlerts.tsx ---
// PAGE IDENTITY: T49 · Authorization Alerts

export function AuthAlerts() {
    return (
        <PageTemplate pageId="T49" title="🔔 Authorization Alerts" subtitle="Exhaustion warnings, expiration alerts & renewal notifications"
            sectionData={PageSectionRegistry['T49']}
        />
    );
}
