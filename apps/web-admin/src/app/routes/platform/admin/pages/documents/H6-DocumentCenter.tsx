// ================================================================
// PAGE IDENTITY: H6 · Document Center
// Type: Hub | Owner: admin
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const documents = [
    { provider: 'Kevin Chen (PSW)', docType: 'CPR Certification', status: '✅ Approved', uploaded: 'Mar 14', expires: 'Mar 2028' },
    { provider: 'Sarah Williams (RN)', docType: 'RN License', status: '✅ Approved', uploaded: 'Feb 28', expires: 'Dec 2026' },
    { provider: 'Maria Santos (PSW)', docType: 'VSS (Vulnerable Sector)', status: '⏳ Pending Review', uploaded: 'Mar 15', expires: 'Mar 2029' },
    { provider: 'James Park (PSW)', docType: 'First Aid Certificate', status: '✅ Approved', uploaded: 'Jan 20', expires: 'Jan 2029' },
    { provider: 'Lisa Brown (PSW)', docType: 'TB Test Results', status: '❌ Rejected', uploaded: 'Mar 10', expires: '—' },
];

const cols: TableColumn[] = [
    { key: 'provider', label: 'Provider' }, { key: 'docType', label: 'Document Type' },
    { key: 'status', label: 'Status' }, { key: 'uploaded', label: 'Uploaded' },
    { key: 'expires', label: 'Expires' },
];

export default function DocumentCenter() {
    return (
        <PageTemplate pageId="H6" title="📁 Document Management Center" subtitle="Upload, verify & manage PSW credentials, certifications & compliance documents"
            actionPageId="admin.documents"
            sectionData={{
                'H6.stats': { kpiCards: [
                    { label: 'Total Documents', value: 5, color: 'var(--pc-primary)' },
                    { label: 'Pending Review', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Approved', value: 3, color: 'var(--pc-success)' },
                    { label: 'Rejected', value: 1, color: 'var(--pc-error, #ef4444)' },
                ]},
                'H6.table': { table: { columns: cols, rows: documents } },
            }}
        />
    );
}
