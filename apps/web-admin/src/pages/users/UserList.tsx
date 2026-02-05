import React, { useEffect, useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry } = AdminRegistry;
const API_URL = import.meta.env.VITE_API_URL;

interface User {
    id: string;
    email: string;
    role: string;
    profile?: {
        fullName: string;
        isVerified?: boolean;
    };
}

export default function UserList() {
    const [users, setUsers] = useState<User[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        setLoading(true);
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS}`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                const data = await response.json();
                // Map API response to UI model
                const mapped = data.map((u: any) => ({
                    id: u.id,
                    email: u.email,
                    role: u.role,
                    profile: {
                        fullName: u.PswProfile?.fullName || u.ClientProfile?.fullName || 'Untitled User',
                        isVerified: u.status === 'verified'
                    }
                }));
                setUsers(mapped);
            }
        } catch (error) {
            console.error('Failed to fetch users', error);
        } finally {
            setLoading(false);
        }
    };

    const handleApprove = async (id: string) => {
        try {
            const token = localStorage.getItem('token');
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS_VERIFY(id)}`, {
                method: 'POST',
                headers: { 'Authorization': `Bearer ${token}` }
            });
            if (response.ok) {
                setUsers(prev => prev.map(u => u.id === id ? { ...u, profile: { ...u.profile!, isVerified: true } } : u));
            }
        } catch (error) {
            alert(ContentRegistry.USERS.MESSAGES.ERROR_VERIFY);
        }
    };

    const handleInvite = () => {
        const email = prompt(ContentRegistry.USERS.INVITE_PROMPT);
        if (email) alert(ContentRegistry.USERS.INVITE_SUCCESS(email));
    };

    const handleEdit = (user: User) => {
        alert(`Editing profile for ${user.profile?.fullName || user.email}`);
    };

    return (
        <div>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2rem' }}>
                <h2 style={{ fontSize: '1.5rem', fontWeight: 'bold', margin: 0, color: '#111827' }}>{ContentRegistry.USERS.TITLE}</h2>
                <button
                    onClick={handleInvite}
                    style={{ padding: '0.5rem 1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '0.375rem', cursor: 'pointer', fontSize: '0.875rem' }}
                >
                    {ContentRegistry.USERS.INVITE_BTN}
                </button>
            </div>

            <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
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
                                <tr key={user.id} style={{ borderBottom: '1px solid #f3f4f6' }}>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ fontWeight: '600', color: '#111827' }}>{user.profile?.fullName}</div>
                                        <div style={{ fontSize: '0.875rem', color: '#6b7280' }}>{user.email}</div>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <span style={{
                                            padding: '0.25rem 0.625rem', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: '600',
                                            backgroundColor: user.role === 'psw' ? '#e0f2fe' : user.role === 'admin' ? '#fef3c7' : '#f3f4f6',
                                            color: user.role === 'psw' ? '#0369a1' : user.role === 'admin' ? '#92400e' : '#374151'
                                        }}>
                                            {user.role.toUpperCase()}
                                        </span>
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        {user.role === 'psw' ? (
                                            <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                                <span style={{ color: user.profile?.isVerified ? '#059669' : '#d97706', fontSize: '1.2rem' }}>
                                                    {user.profile?.isVerified ? '✅' : '⏳'}
                                                </span>
                                                <span style={{ fontSize: '0.875rem', color: user.profile?.isVerified ? '#059669' : '#d97706', fontWeight: '500' }}>
                                                    {user.profile?.isVerified ? 'Verified' : 'Pending Review'}
                                                </span>
                                            </div>
                                        ) : '-'}
                                    </td>
                                    <td style={{ padding: '1rem' }}>
                                        <div style={{ display: 'flex', gap: '0.75rem' }}>
                                            <button
                                                onClick={() => handleEdit(user)}
                                                style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}
                                            >
                                                {ContentRegistry.USERS.EDIT_BTN}
                                            </button>
                                            {user.role === 'psw' && !user.profile?.isVerified && (
                                                <button
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
        </div>
    );
}
