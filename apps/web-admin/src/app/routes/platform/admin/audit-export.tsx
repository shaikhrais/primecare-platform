import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// --- Merged from R10-ComplianceExport.tsx ---
// PAGE IDENTITY: R10 · Compliance Export

export function ComplianceExport() {
    return (
        <PageTemplate pageId="R10" title="📋 Compliance Export" subtitle="Generate compliance reports for HIPAA, PIPEDA, OHSA & accreditation"
            sectionData={PageSectionRegistry['R10']}
        />
    );
}

// --- Merged from R13-RegulatoryExport.tsx ---
// PAGE IDENTITY: R13 · Regulatory Export

export function RegulatoryExport() {
    return (
        <PageTemplate pageId="R13" title="🏛️ Regulatory Export" subtitle="Government & regulatory body submissions — CRA, WSIB, MOH, ESA"
            sectionData={PageSectionRegistry['R13']}
        />
    );
}

// --- Merged from R9-AuditDownload.tsx ---
// PAGE IDENTITY: R9 · Audit Download | R10 · Compliance Export | R13 · Regulatory Export

export function AuditDownload() {
    return (
        <PageTemplate pageId="R9" title="📥 Audit Download" subtitle="Download audit trail exports in CSV, PDF & XBRL formats"
            sectionData={PageSectionRegistry['R9']}
        />
    );
}
