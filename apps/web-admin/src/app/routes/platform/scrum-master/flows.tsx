import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';


// --- Merged from RoleFlowsPage.tsx ---
export function RoleFlowsPage() {
    return (
        <PageTemplate 
            pageId="PGE-RFP" 
            title="✨ Role Flows Page" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'RFP.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RFP.empty']: { emptyState: { title: 'Role Flows Page Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from StepAuditModal.tsx ---
export function StepAuditModal() {
    return (
        <PageTemplate 
            pageId="PGE-SAM" 
            title="✨ Step Audit Modal" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'SAM.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'SAM.empty']: { emptyState: { title: 'Step Audit Modal Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}
