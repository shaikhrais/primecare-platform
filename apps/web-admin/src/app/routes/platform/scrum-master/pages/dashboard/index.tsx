// ================================================================
// Scrum Master Dashboard
// Converted: components/ deleted → PageTemplate + shared sections
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';

export default function ScrumMasterDashboard() {
    return (
        <PageTemplate pageId="SM" title="🏗️ Platform Health Center" subtitle="System health, endpoint coverage, technical governance & platform intelligence"
            sectionData={{
                'SM.stats': { kpiCards: [
                    { label: 'API Uptime', value: '99.97%', color: 'var(--pc-success)' },
                    { label: 'Active Endpoints', value: 142, color: 'var(--pc-primary)' },
                    { label: 'Error Rate', value: '0.3%', color: 'var(--pc-warning)' },
                    { label: 'Deploy #', value: 39, color: '#8B5CF6' },
                ]},
                'SM.health': { statusCards: { items: [
                    { label: 'worker-api', value: 'Healthy', description: '142 endpoints, 0 errors', color: 'green' },
                    { label: 'web-admin', value: 'Healthy', description: '94 pages, 18 section types', color: 'green' },
                    { label: 'Database', value: 'Active', description: 'Supabase — 47 models', color: 'green' },
                    { label: 'Auth', value: 'Operational', description: 'Firebase — Deadlock patched', color: 'green' },
                ]} },
                'SM.roadmap': { table: { columns: [
                    { key: 'sprint', label: 'Sprint' }, { key: 'feature', label: 'Feature' },
                    { key: 'status', label: 'Status' }, { key: 'owner', label: 'Owner' },
                ], rows: [
                    { sprint: 'S12', feature: 'Section-based PageTemplate', status: '✅ Complete', owner: 'Platform' },
                    { sprint: 'S12', feature: 'Old sub-file cleanup', status: '✅ Complete', owner: 'Platform' },
                    { sprint: 'S13', feature: 'Multi-currency ledger', status: '🟡 In Progress', owner: 'Finance' },
                    { sprint: 'S13', feature: 'Mobile PWA offline', status: '🔲 Planned', owner: 'Mobile' },
                ]}},
            }}
        />
    );
}
