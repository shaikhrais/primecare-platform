import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';



// removed re-export: export { UserList, UserEntry };


// --- Merged from F9a-UserEntry.tsx ---
// PAGE IDENTITY: F9a · User Entry



export function UserEntry() {
    return (
        <PageTemplate pageId="F9a" title="➕ New User" subtitle="Create new platform user with role assignment & access configuration"
            sectionData={{
                'F9a.form': { cardGrid: { items: [
                    { icon: '👤', title: 'Personal Information', subtitle: 'Name, email, phone & profile details' },
                    { icon: '🔑', title: 'Role & Permissions', subtitle: 'Assign role, custom permissions & access level' },
                    { icon: '🏥', title: 'Organization', subtitle: 'Department, team, supervisor & location' },
                    { icon: '🔐', title: 'Security', subtitle: 'MFA requirement, password policy & device limits' },
                ], columns: 2 } },
            }}
        />
    );
}

// --- Merged from L3a-UserList.tsx ---
// PAGE IDENTITY: L3a · User List




const users = [
    { name: 'Admin User', email: 'admin@primecare.ca', role: '🔑 Admin', status: '✅ Active', lastLogin: 'Today 14:23' },
    { name: 'Sarah Manager', email: 'sarah.mgr@primecare.ca', role: '👤 Manager', status: '✅ Active', lastLogin: 'Today 13:45' },
    { name: 'Kevin Chen', email: 'kevin.psw@primecare.ca', role: '🏥 PSW', status: '✅ Active', lastLogin: 'Today 12:30' },
    { name: 'Maria Santos', email: 'maria.psw@primecare.ca', role: '🏥 PSW', status: '✅ Active', lastLogin: 'Yesterday' },
    { name: 'Finance User', email: 'finance@primecare.ca', role: '💰 Finance', status: '✅ Active', lastLogin: 'Today 10:00' },
];

const cols: TableColumn[] = [
    { key: 'name', label: 'Name' }, { key: 'email', label: 'Email' },
    { key: 'role', label: 'Role' }, { key: 'status', label: 'Status' },
    { key: 'lastLogin', label: 'Last Login' },
];

export function UserList() {
    return (
        <PageTemplate pageId="L3a" title="👥 User Management" subtitle="All platform users, roles, status & access management"
            sectionData={{
                'L3a.stats': { kpiCards: [
                    { label: 'Total Users', value: 99, color: 'var(--pc-primary)' },
                    { label: 'Active', value: 94, color: 'var(--pc-success)' },
                    { label: 'Inactive', value: 5, color: 'var(--pc-warning)' },
                    { label: 'Roles', value: 6, color: 'var(--pc-info, #2563EB)' },
                ]},
                'L3a.table': { table: { columns: cols, rows: users } },
            }}
        />
    );
}