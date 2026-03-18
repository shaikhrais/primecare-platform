// L3a UserList: User interface and API handlers extracted
import { apiClient } from '@/shared/utils/apiClient';
import { AdminRegistry } from 'prime-care-shared';
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
