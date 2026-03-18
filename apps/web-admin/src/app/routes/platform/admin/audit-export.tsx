import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from R10-ComplianceExport.tsx ---
// PAGE IDENTITY: R10 · Compliance Export

export function ComplianceExport() {
    return (
        <PageTemplate pageId="R10" title="📋 Compliance Export" subtitle="Generate compliance reports for HIPAA, PIPEDA, OHSA & accreditation"
            sectionData={{
                'R10.stats': { kpiCards: [
                    { label: 'Compliance Score', value: '98.2%', color: 'var(--pc-success)' },
                    { label: 'Last Export', value: 'Today', color: 'var(--pc-primary)' },
                    { label: 'Issues Found', value: 2, color: 'var(--pc-warning)' },
                ]},
                'R10.modules': { cardGrid: { items: [
                    { icon: '🏥', title: 'HIPAA Compliance', subtitle: 'PHI access logs, breach notification status' },
                    { icon: '🇨🇦', title: 'PIPEDA Report', subtitle: 'Privacy impact assessment, consent tracking' },
                    { icon: '⚠️', title: 'OHSA Workplace Safety', subtitle: 'Incident reports, hazard assessments' },
                    { icon: '✅', title: 'Accreditation Prep', subtitle: 'Accreditation Ontario checklist & evidence' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from R13-RegulatoryExport.tsx ---
// PAGE IDENTITY: R13 · Regulatory Export

export function RegulatoryExport() {
    return (
        <PageTemplate pageId="R13" title="🏛️ Regulatory Export" subtitle="Government & regulatory body submissions — CRA, WSIB, MOH, ESA"
            sectionData={{
                'R13.stats': { kpiCards: [
                    { label: 'Reports Due', value: 2, color: 'var(--pc-warning)' },
                    { label: 'Submitted MTD', value: 3, color: 'var(--pc-success)' },
                    { label: 'Next Deadline', value: 'Apr 30', color: 'var(--pc-primary)' },
                ]},
                'R13.modules': { cardGrid: { items: [
                    { icon: '🏛️', title: 'CRA (Revenue Agency)', subtitle: 'T4/T4A, HST filing, payroll remittances' },
                    { icon: '⚙️', title: 'WSIB (Workplace Safety)', subtitle: 'Premium reports, claim submissions' },
                    { icon: '🏥', title: 'MOH (Ministry of Health)', subtitle: 'Service volume, quality indicators' },
                    { icon: '📋', title: 'ESA (Employment Standards)', subtitle: 'Hours of work, overtime, vacation tracking' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from R9-AuditDownload.tsx ---
// PAGE IDENTITY: R9 · Audit Download | R10 · Compliance Export | R13 · Regulatory Export

export function AuditDownload() {
    return (
        <PageTemplate pageId="R9" title="📥 Audit Download" subtitle="Download audit trail exports in CSV, PDF & XBRL formats"
            sectionData={{
                'R9.stats': { kpiCards: [
                    { label: 'Available Exports', value: 12, color: 'var(--pc-primary)' },
                    { label: 'Generated Today', value: 2, color: 'var(--pc-success)' },
                    { label: 'Total Records', value: '45K', color: 'var(--pc-info, #2563EB)' },
                ]},
                'R9.formats': { cardGrid: { items: [
                    { icon: '📄', title: 'CSV Export', subtitle: 'Raw audit data — all fields, filterable' },
                    { icon: '📋', title: 'PDF Report', subtitle: 'Formatted audit summary with charts' },
                    { icon: '🔐', title: 'Encrypted Archive', subtitle: 'HIPAA-compliant encrypted ZIP package' },
                ], columns: 3 } },
            }}
        />
    );
}
