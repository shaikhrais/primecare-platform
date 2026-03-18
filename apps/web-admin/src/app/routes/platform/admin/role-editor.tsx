import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// Re-export from identity file: T4-RoleEditor.tsx
// removed broken export: export { default } from './T4-RoleEditor';


// --- Merged from list.tsx ---
export function RolesList() {
    return (
        <PageTemplate 
            pageId="PGE-RL" 
            title="✨ Roles List" 
            subtitle="Auto-converted page to use standard sections"
            sectionData={PageSectionRegistry['PGE-RL']}
        />
    );
}

// --- Merged from T4-RoleEditor.tsx ---
// PAGE IDENTITY: T4 · Role Editor
const cols: TableColumn[] = [
    { key: 'name', label: 'Role' }, { key: 'users', label: 'Users' },
    { key: 'permissions', label: 'Permissions' }, { key: 'scope', label: 'Scope' },
    { key: 'status', label: 'Status' },
];

export function RoleEditor() {
    return (
        <PageTemplate pageId="T4" title="🔑 Role Editor" subtitle="Define roles, assign permissions & manage access hierarchies"
            sectionData={PageSectionRegistry['T4']}
        />
    );
}