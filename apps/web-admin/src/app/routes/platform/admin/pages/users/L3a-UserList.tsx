// ================================================================
// PAGE IDENTITY: L3a � User List
// Type: List | Owner: admin
// ================================================================
import React, { useEffect, useState, useMemo } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useToast as useNotification } from '@/shared/hooks/useToast';
import { UserQuickViewModal } from '@/shared/components/modals/UserQuickViewModal';
import { useTranslation } from 'react-i18next';
import { UserTable } from './components/UserTable';
import { UserInviteModal } from './components/UserInviteModal';
import { type User, fetchUsers as apiFetchUsers, approveUser, inviteUser } from './userHandlers';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function UserList() {
    const { t } = useTranslation();
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const { showToast } = useNotification();
    const [users, setUsers] = useState<User[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    // Quick View State
    const [selectedUser, setSelectedUser] = useState<User | null>(null);
    const [quickViewOpen, setQuickViewOpen] = useState(false);

    const filteredUsers = useMemo(() => {
        const roleFilter = searchParams.get('role');
        const statusFilter = searchParams.get('status');

        return users.filter(user => {
            if (roleFilter && !user.roles.includes(roleFilter)) return false;
            if (statusFilter === 'verified' && !user.profile?.isVerified) return false;
            if (statusFilter === 'pending' && user.profile?.isVerified) return false;
            return true;
        });
    }, [users, searchParams]);

    useEffect(() => {
        loadUsers();
    }, []);

    const loadUsers = async () => {
        setLoading(true);
        try {
            const mapped = await apiFetchUsers(t, t(ContentRegistry.COMMON.FALLBACKS.REGISTRY_NODE));
            setUsers(mapped);
        } catch (error) {
            showToast(t(ContentRegistry.USERS.MESSAGES.ERROR_LOAD), 'error');
        } finally { setLoading(false); }
    };

    const handleApprove = async (id: string) => {
        try {
            if (await approveUser(id)) {
                setUsers(prev => prev.map(u => u.id === id ? { ...u, profile: { ...u.profile!, isVerified: true } } : u));
                showToast(t(ContentRegistry.USERS.MESSAGES.SUCCESS_VERIFY), 'success');
            }
        } catch (error) { showToast(t(ContentRegistry.USERS.MESSAGES.ERROR_VERIFY), 'error'); }
    };

    const handleInvite = async (email: string) => {
        setSubmitting(true);
        try {
            await inviteUser(email);
            showToast(ContentRegistry.USERS.INVITE_SUCCESS(email), 'success');
            setIsModalOpen(false);
        } catch (error: any) {
            showToast(error?.message || t(ContentRegistry.USERS.MESSAGES.ERROR_ACTION), 'error');
        } finally { setSubmitting(false); }
    };

    const handleEdit = (user: User) => {
        navigate(RouteRegistry.ADMIN.USERS_EDIT(user.id));
    };

    return (
        <div data-cy="page.container" role="main" aria-label="User List">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{t(ContentRegistry.USERS.TITLE)}</h2>
                <div style={{ display: 'flex', gap: '8px' }}>
                    <button data-cy="btn-admin.l3a-user-list-0"
                        onClick={() => setIsModalOpen(true)}
                        style={{ padding: '0.5rem 1rem', backgroundColor: '#f3f4f6', color: '#374151', border: '1px solid #d1d5db', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                    >
                        {t(ContentRegistry.USERS.INVITE_BTN)}
                    </button>
                    <button
                        data-cy="btn.user.add"
                        onClick={() => navigate(RouteRegistry.ADMIN.USERS_NEW)}
                        style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                    >
                        {t(ContentRegistry.USERS.ADD_BTN)}
                    </button>
                </div>
            </div>

            <div style={{ display: 'flex', gap: '1rem', marginBottom: '1.5rem', alignItems: 'center', backgroundColor: '#f9fafb', padding: '1rem', borderRadius: '0.5rem', border: '1px solid #e5e7eb' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: 500, color: '#374151' }}>Role:</label>
                    <select data-cy="select-admin.l3a-user-list-0"
                        value={searchParams.get('role') || ''}
                        onChange={(e) => {
                            const newParams = new URLSearchParams(searchParams);
                            if (e.target.value) newParams.set('role', e.target.value);
                            else newParams.delete('role');
                            navigate({ search: newParams.toString() });
                        }}
                        style={{ padding: '0.375rem 0.75rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', fontSize: '0.875rem' }}
                    >
                        <option value="">All Roles</option>
                        <option value="admin">Admin</option>
                        <option value="manager">Manager</option>
                        <option value="psw">PSW</option>
                        <option value="rn">RN</option>
                        <option value="client">Client</option>
                    </select>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <label style={{ fontSize: '0.875rem', fontWeight: 500, color: '#374151' }}>Status:</label>
                    <select data-cy="select-admin.l3a-user-list-1"
                        value={searchParams.get('status') || ''}
                        onChange={(e) => {
                            const newParams = new URLSearchParams(searchParams);
                            if (e.target.value) newParams.set('status', e.target.value);
                            else newParams.delete('status');
                            navigate({ search: newParams.toString() });
                        }}
                        style={{ padding: '0.375rem 0.75rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', fontSize: '0.875rem' }}
                    >
                        <option value="">All Statuses</option>
                        <option value="verified">Verified</option>
                        <option value="pending">Pending</option>
                    </select>
                </div>
            </div>

            {(searchParams.get('role') || searchParams.get('status')) && (
                <div style={{ marginBottom: '1rem', display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                    <span style={{ fontSize: '0.875rem', color: '#6b7280' }}>{t(ContentRegistry.USERS.ACTIVE_FILTERS)}</span>
                    {searchParams.get('role') && (
                        <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#e0f2fe', color: '#0369a1', borderRadius: '9999px', fontSize: '0.875rem' }}>
                            {t(ContentRegistry.USERS.ROLE)}: {searchParams.get('role')}
                        </span>
                    )}
                    {searchParams.get('status') && (
                        <span style={{ padding: '0.25rem 0.75rem', backgroundColor: '#ecfdf5', color: '#065f46', borderRadius: '9999px', fontSize: '0.875rem' }}>
                            {t(ContentRegistry.USERS.STATUS as any)}: {searchParams.get('status')}
                        </span>
                    )}
                    <button data-cy="btn-admin.l3a-user-list-1" onClick={() => navigate(RouteRegistry.ADMIN.USERS)} style={{ border: 'none', background: 'none', color: '#ef4444', cursor: 'pointer', fontSize: '0.875rem' }}>
                        {t(ContentRegistry.USERS.CLEAR_FILTERS)}
                    </button>
                </div>
            )}

            <UserTable
                users={filteredUsers}
                loading={loading}
                onEdit={handleEdit}
                onApprove={handleApprove}
                onSelectUser={(user) => { setSelectedUser(user); setQuickViewOpen(true); }}
            />

            <UserInviteModal
                isOpen={isModalOpen}
                onClose={() => setIsModalOpen(false)}
                onSubmit={handleInvite}
                submitting={submitting}
            />

            <UserQuickViewModal
                isOpen={quickViewOpen}
                onClose={() => setQuickViewOpen(false)}
                user={selectedUser}
            />
        </div>
    );
}
