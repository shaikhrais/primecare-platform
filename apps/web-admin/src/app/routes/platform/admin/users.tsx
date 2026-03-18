import { AdminRegistry } from 'prime-care-shared';
import { apiClient } from '../../../../shared/utils/apiClient';
import { TableColumn } from '@/shared/components/sections/SectionTable';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import React from 'react';
import { PageSectionRegistry } from "../../shared/PageSectionRegistry";

// removed re-export: export { UserList, UserEntry };


// --- Merged from F9a-UserEntry.tsx ---
// PAGE IDENTITY: F9a · User Entry



export function UserEntry() {
    return (
        <PageTemplate pageId="F9a" title="➕ New User" subtitle="Create new platform user with role assignment & access configuration"
            sectionData={PageSectionRegistry['F9a']}
        />
    );
}

// --- Merged from L3a-UserList.tsx ---
// PAGE IDENTITY: L3a · User List
const cols: TableColumn[] = [
    { key: 'name', label: 'Name' }, { key: 'email', label: 'Email' },
    { key: 'role', label: 'Role' }, { key: 'status', label: 'Status' },
    { key: 'lastLogin', label: 'Last Login' },
];

export function UserList() {
    return (
        <PageTemplate pageId="L3a" title="👥 User Management" subtitle="All platform users, roles, status & access management"
            sectionData={PageSectionRegistry['L3a']}
        />
    );
}
// --- Merged sidecars ---

/* Merged from userHandlers.ts */
// L3a UserList: User interface and API handlers extracted


const { ApiRegistry } = AdminRegistry;

export interface User {
    id: string; email: string; roles: string[];
    profile?: { fullName: string; isVerified?: boolean; };
}

export async function fetchUsers(t: (key: string) => string, fallbackLabel: string): Promise<User[]> {
    try {
        const response = await apiClient.get(ApiRegistry.ADMIN.USERS);
        if (response.ok) {
            const data = await response.json();
            return data.map((u: any) => ({
                id: u.id, email: u.email, roles: u.roles || (u.role ? [u.role] : []),
                profile: { fullName: u.pswProfile?.fullName || u.clientProfile?.fullName || u.profile?.fullName || fallbackLabel, isVerified: u.status === 'verified' }
            }));
        }
    } catch { /* handled by caller */ }
    return [];
}

export async function approveUser(id: string): Promise<boolean> {
    try { const res = await apiClient.post(ApiRegistry.ADMIN.USERS_VERIFY(id)); return res.ok; } catch { return false; }
}

export async function inviteUser(email: string): Promise<void> {
    const res = await apiClient.post('/v1/admin/users/invite', { email });
    if (!res.ok) { const data = await res.json().catch(() => ({})); throw new Error((data as any).error || 'Invite failed'); }
}

