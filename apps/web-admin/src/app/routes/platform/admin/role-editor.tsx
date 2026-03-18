import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
// Re-export from identity file: T4-RoleEditor.tsx
// removed broken export: export { default } from './T4-RoleEditor';


// --- Merged from list.tsx ---
export function RolesList() {
    return (
        <PageTemplate 
            pageId="PGE-RL" 
            title="✨ Roles List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={{
                ['PGE-' + 'RL.stats']: { kpiCards: [
                    { label: 'Total Views', value: 0, color: 'var(--pc-primary)' },
                    { label: 'Active Users', value: 24, color: 'var(--pc-info, #2563EB)' },
                    { label: 'System Health', value: '100%', color: 'var(--pc-success)' },
                ]},
                ['PGE-' + 'RL.empty']: { emptyState: { title: 'Roles List Data', description: 'This section is currently using template placeholders.' } }
            }}
        />
    );
}

// --- Merged from T4-RoleEditor.tsx ---
// PAGE IDENTITY: T4 · Role Editor




const roles = [
    { name: '🔑 Super Admin', users: 1, permissions: 'Full Access', scope: 'Global', status: '🔒 System' },
    { name: '👤 Admin', users: 2, permissions: '95% Access', scope: 'Tenant', status: '✅ Active' },
    { name: '📊 Manager', users: 5, permissions: 'Team + Reports', scope: 'Team', status: '✅ Active' },
    { name: '🏥 PSW', users: 82, permissions: 'Basic + EVV + Docs', scope: 'Self + Clients', status: '✅ Active' },
    { name: '🩺 RN', users: 4, permissions: 'Clinical + Meds', scope: 'Self + Clients', status: '✅ Active' },
    { name: '💰 Finance', users: 2, permissions: 'Billing + Reports', scope: 'Financial', status: '✅ Active' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'scope', label: 'Scope' },
    { key: 'status', label: 'Status' },
];

export function RoleEditor() {
    return (
        <PageTemplate pageId="T4" title="🔑 Role Editor" subtitle="Define roles, assign permissions & manage access hierarchies"
            sectionData={{
                'T4.stats': { kpiCards: [
                    { label: 'Roles', value: 6, color: 'var(--pc-primary)' },
                    { label: 'Users', value: 96, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Permissions', value: 142, color: '#7C3AED' },
                    { label: 'Custom Roles', value: 0, color: 'var(--pc-success)' },
                ]},
                'T4.table': { table: { columns: cols, rows: roles } },
            }}
        />
    );
}