// PAGE IDENTITY: T4 · Role Editor
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

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

export default function RoleEditor() {
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
