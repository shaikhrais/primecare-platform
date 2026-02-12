import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminRegistry } from 'prime-care-shared';
import { useNotification } from '@/shared/context/NotificationContext';
import { apiClient } from '@/shared/utils/apiClient';

const { ApiRegistry, ContentRegistry } = AdminRegistry;

interface User {
    id: string;
    email: string;
    roles: string[];
    profile?: {
        fullName: string;
        isVerified?: boolean;
    };
}

export default function UserList() {
    const navigate = useNavigate();
    const { showToast } = useNotification();
    const [users, setUsers] = useState<User[]>([]);
    const [loading, setLoading] = useState(true);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [inviteEmail, setInviteEmail] = useState('');
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);
    const [submitting, setSubmitting] = useState(false);

    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty && isModalOpen) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty, isModalOpen]);

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        setLoading(true);
        try {
            const response = await apiClient.get(ApiRegistry.ADMIN.USERS);
            if (response.ok) {
                const data = await response.json();
                // Map API response to UI model
                const mapped = data.map((u: any) => ({
                    id: u.id,
                    email: u.email,
                    roles: u.roles || (u.role ? [u.role] : []),
                    profile: {
                        fullName: u.pswProfile?.fullName || u.clientProfile?.fullName || u.profile?.fullName || 'Untitled User',
                        isVerified: u.status === 'verified'
                    }
                }));
                setUsers(mapped);
            }
        } catch (error) {
            console.error('Failed to fetch users', error);
            showToast('Failed to load user list', 'error');
        } finally {
            setLoading(false);
        }
    };

    const handleApprove = async (id: string) => {
        try {
            const response = await apiClient.post(ApiRegistry.ADMIN.USERS_VERIFY(id));
            if (response.ok) {
                setUsers(prev => prev.map(u => u.id === id ? { ...u, profile: { ...u.profile!, isVerified: true } } : u));
                showToast('User extracted and verified successfully', 'success');
            }
        } catch (error) {
            showToast(ContentRegistry.USERS.MESSAGES.ERROR_VERIFY, 'error');
        }
    };

    const handleInvite = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!inviteEmail) return;
        setSubmitting(true);
        // Simulate API call
        setTimeout(() => {
            showToast(ContentRegistry.USERS.INVITE_SUCCESS(inviteEmail), 'success');
            setIsModalOpen(false);
            setIsDirty(false);
            setSubmitting(false);
        }, 800);
    };

    const handleEdit = (user: User) => {
        navigate(`/users/${user.id}/edit`);
    };

    return (
        <div data-cy="page.container">
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }} data-cy="page.title">{ContentRegistry.USERS.TITLE}</h2>
                <button
                    data-cy="btn.user.invite"
                    onClick={() => setIsModalOpen(true)}
                    style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                >
                    {ContentRegistry.USERS.INVITE_BTN}
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.users">
                    <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{ContentRegistry.USERS.TITLE}</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{ContentRegistry.USERS.ROLE}</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>ID Verification</th>
                            <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody style={{ backgroundColor: 'white' }}>
                        {loading ? (
                            <tr><td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{ContentRegistry.USERS.MESSAGES.LOADING}</td></tr>
                        ) : (
                            users.map(user => (
                                <tr key={user.id} data-cy={`user-row-${user.id}`} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ fontWeight: '600', color: '#111827' }} data-cy="user-fullname">{user.profile?.fullName}</div>
                                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }} data-cy="user-email">{user.email}</div>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ display: 'flex', gap: '4px', flexWrap: 'wrap' }}>
                                            {user.roles.map(r => (
                                                <span key={r} data-cy="user-role" style={{
                                                    padding: '0.25rem 0.625rem', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: '600',
                                                    backgroundColor: r === 'psw' ? '#e0f2fe' : r === 'admin' ? '#fef3c7' : '#f3f4f6',
                                                    color: r === 'psw' ? '#0369a1' : r === 'admin' ? '#92400e' : '#374151'
                                                }}>
                                                    {r.toUpperCase()}
                                                </span>
                                            ))}
                                        </div>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        {user.roles.includes('psw') ? (
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                                <span data-cy="user-verification-icon" style={{ color: user.profile?.isVerified ? '#059669' : '#d97706', fontSize: '1.2rem' }}>
                                                    {user.profile?.isVerified ? '✅' : '⏳'}
                                                </span>
                                                <span data-cy="user-verification-text" style={{ fontSize: '0.875rem', color: user.profile?.isVerified ? '#059669' : '#d97706', fontWeight: '500' }}>
                                                    {user.profile?.isVerified ? 'Verified' : 'Pending Review'}
                                                </span>
                                            </div>
                                        ) : '-'}
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ display: 'flex', gap: '0.75rem' }}>
                                            <button
                                                data-cy="btn-edit-user"
                                                onClick={() => handleEdit(user)}
                                                style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}
                                            >
                                                {ContentRegistry.USERS.EDIT_BTN}
                                            </button>
                                            {user.roles.includes('psw') && !user.profile?.isVerified && (
                                                <button
                                                    data-cy="btn.user.verify"
                                                    onClick={() => handleApprove(user.id)}
                                                    style={{ color: '#2563eb', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '600' }}
                                                >
                                                    {ContentRegistry.USERS.VERIFY_BTN}
                                                </button>
                                            )}
                                        </div>
                                    </td>
                                </tr>
                            ))
                        )}
                        {users.length === 0 && !loading && (
                            <tr><td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{ContentRegistry.USERS.MESSAGES.EMPTY}</td></tr>
                        )}
                    </tbody>
                </table>
            </div>

            {isModalOpen && (
                <div style={{ position: 'fixed', inset: 0, backgroundColor: 'rgba(0,0,0,0.5)', display: 'flex', alignItems: 'center', justifyContent: 'center', zIndex: 1000 }}>
                    {showGuard && (
                        <div data-cy="guard.unsaved.dialog" style={{ position: 'absolute', inset: 0, backgroundColor: 'rgba(0,0,0,0.8)', zIndex: 1001, display: 'flex', alignItems: 'center', justifyContent: 'center', borderRadius: '0.5rem' }}>
                            <div style={{ background: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '350px', textAlign: 'center' }}>
                                <h4 style={{ margin: '0 0 1rem 0' }}>Discard Invite?</h4>
                                <p style={{ fontSize: '0.9rem', color: '#6b7280', marginBottom: '1.5rem' }}>Are you sure you want to cancel this invitation?</p>
                                <div style={{ display: 'flex', gap: '1rem' }}>
                                    <button data-cy="guard.unsaved.leave" onClick={() => { setIsDirty(false); setShowGuard(false); setIsModalOpen(false); }} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: '1px solid #d1d5db', background: 'transparent', cursor: 'pointer' }}>Discard</button>
                                    <button data-cy="guard.unsaved.stay" onClick={() => setShowGuard(false)} style={{ flex: 1, padding: '0.625rem', borderRadius: '0.375rem', border: 'none', background: '#004d40', color: 'white', cursor: 'pointer', fontWeight: 600 }}>Stay</button>
                                </div>
                            </div>
                        </div>
                    )}
                    <form onSubmit={handleInvite} style={{ backgroundColor: 'white', padding: '2rem', borderRadius: '1rem', maxWidth: '400px', width: '90%', position: 'relative' }} data-cy="modal.user.invite.container">
                        <h3 style={{ marginTop: 0 }}>Invite New User</h3>
                        <div style={{ marginTop: '1.5rem' }}>
                            <label style={{ display: 'block', fontSize: '0.875rem', fontWeight: '500', marginBottom: '0.5rem' }}>Email Address</label>
                            <input
                                data-cy="modal.user.invite.email"
                                type="email"
                                value={inviteEmail}
                                onChange={(e) => { setInviteEmail(e.target.value); setIsDirty(true); }}
                                style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                                required
                                placeholder="Enter user's email..."
                            />
                        </div>
                        <div style={{ display: 'flex', gap: '1rem', marginTop: '2rem' }}>
                            <button
                                type="button"
                                data-cy="modal.user.invite.close"
                                onClick={() => isDirty ? setShowGuard(true) : setIsModalOpen(false)}
                                style={{ flex: 1, padding: '0.75rem', backgroundColor: '#f3f4f6', border: 'none', borderRadius: '0.5rem', cursor: 'pointer' }}
                            >
                                Cancel
                            </button>
                            <button
                                type="submit"
                                data-cy="modal.user.invite.save"
                                disabled={submitting}
                                style={{ flex: 1, padding: '0.75rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.5rem', fontWeight: '600', cursor: 'pointer' }}
                            >
                                {submitting ? 'Sending...' : 'Send Invite'}
                            </button>
                        </div>
                    </form>
                </div>
            )}
        </div>
    );
}
