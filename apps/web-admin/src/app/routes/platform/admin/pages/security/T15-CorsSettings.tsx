// ================================================================
// PAGE IDENTITY: T15 · CORS Settings
// Type: Tool | Owner: admin | Registry: T15
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const origins = [
    { origin: '✅ primecare-admin.pages.dev', type: 'Production', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ localhost:5173', type: 'Development', methods: 'GET, POST, PUT, DELETE', status: 'Active' },
    { origin: '✅ primecare-api.workers.dev', type: 'API Worker', methods: 'GET, POST', status: 'Active' },
    { origin: '⚠️ staging.primecare.ca', type: 'Staging', methods: 'GET, POST', status: 'Review' },
];

const corsCols: TableColumn[] = [
    { key: 'origin', label: 'Origin' }, { key: 'type', label: 'Environment' },
    { key: 'methods', label: 'Allowed Methods' }, { key: 'status', label: 'Status' },
];

export default function CorsSettings() {
    return (
        <PageTemplate
            pageId="T15"
            title="🌐 CORS Settings"
            subtitle="Cross-Origin Resource Sharing configuration and allowed origins management"
            actionPageId="admin.cors-settings"
            sectionData={{
                'T15.stats': { kpiCards: [
                    { label: 'Allowed Origins', value: 4, color: 'var(--pc-primary)' },
                    { label: 'Pending Review', value: 1, color: 'var(--pc-warning)' },
                    { label: 'Blocked Today', value: 0, color: 'var(--pc-success)' },
                    { label: 'Max Age', value: '86400s', color: 'var(--pc-info, #2563EB)' },
                ]},
                'T15.origins': { table: { columns: corsCols, rows: origins } },
            }}
        />
    );
}
