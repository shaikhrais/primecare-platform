import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from L8-ConsentList.tsx ---
// PAGE IDENTITY: L8 · Consent List
import type { TableColumn } from '@/shared/components/sections';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";
const cols: TableColumn[] = [
    { key: 'client', label: 'Client' }, { key: 'type', label: 'Consent Type' },
    { key: 'signed', label: 'Signed' }, { key: 'expires', label: 'Expires' },
    { key: 'status', label: 'Status' },
];

export function ConsentList() {
    return (
        <PageTemplate pageId="L8" title="📝 Consent Management" subtitle="Track signed consents, expirations & renewal requirements"
            sectionData={PageSectionRegistry['L8']}
        />
    );
}

// --- Merged from R7-ConsentExpiring.tsx ---
// PAGE IDENTITY: R7 · Consent Expiring Report

export function ConsentExpiring() {
    return (
        <PageTemplate pageId="R7" title="⏰ Consent Expiration Report" subtitle="Consents expiring within 30/60/90 days, renewal reminders"
            sectionData={PageSectionRegistry['R7']}
        />
    );
}

// --- Merged from T50-ConsentTemplates.tsx ---
// PAGE IDENTITY: T50 · Consent Templates

export function ConsentTemplates() {
    return (
        <PageTemplate pageId="T50" title="📄 Consent Templates" subtitle="Manage consent form templates, versions & digital signature workflows"
            sectionData={PageSectionRegistry['T50']}
        />
    );
}
