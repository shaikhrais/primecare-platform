// ================================================================
// PAGE IDENTITY: T56 · Permission Grid
// Type: Tool | Owner: admin | Registry: T56
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const roleMatrix = [
    { role: '🔑 Admin', users: 3, permissions: 60, level: 'Full Access', lastAudit: 'Mar 15' },
    { role: '👩‍⚕️ RN (Registered Nurse)', users: 8, permissions: 35, level: 'Clinical', lastAudit: 'Mar 14' },
    { role: '👤 Manager', users: 5, permissions: 42, level: 'Operations', lastAudit: 'Mar 14' },
    { role: '🏥 PSW', users: 77, permissions: 12, level: 'Field', lastAudit: 'Mar 13' },
    { role: '📊 Coordinator', users: 4, permissions: 28, level: 'Scheduling', lastAudit: 'Mar 12' },
    { role: '💰 Finance', users: 2, permissions: 18, level: 'Financial', lastAudit: 'Mar 10' },
];

const roleCols: TableColumn[] = [
    { key: 'role', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'level', label: 'Access Level' },
    { key: 'lastAudit', label: 'Last Audit' },
];

export default function PermissionGrid() {
    return (
        <PageTemplate
            pageId="T56"
            title="🔒 Permission Grid"
            subtitle="Role-based access control matrix, permission audits & conflict detection"
            actionPageId="admin.permission-grid"
            sectionData={{
                'T56.stats': { kpiCards: [
                    { label: 'Roles', value: 25, color: 'var(--pc-primary)' },
                    { label: 'Permissions', value: 60, color: '#7C3AED' },
                    { label: 'Users', value: 99, color: 'var(--pc-info, #2563EB)' },
                    { label: 'Conflicts', value: 0, color: 'var(--pc-success)' },
                ]},
                'T56.matrix': { table: { columns: roleCols, rows: roleMatrix } },
                'T56.distribution': { chart: { title: 'Permission Distribution by Role', type: 'donut', data: [
                    { label: 'Admin', value: 60, color: '#EF4444' },
                    { label: 'Manager', value: 42, color: '#F59E0B' },
                    { label: 'RN', value: 35, color: '#3B82F6' },
                    { label: 'Coordinator', value: 28, color: '#8B5CF6' },
                    { label: 'Finance', value: 18, color: '#10B981' },
                    { label: 'PSW', value: 12, color: '#6B7280' },
                ]}},
            }}
        />
    );
}
