import React, { useEffect, useState } from 'react';
import { AdminRegistry } from '@primecare/shared';

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
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.ADMIN.USERS}`);
            if (response.ok) {
                const data = await response.json();
                setUsers(data);
            }
        } catch (error) {
            console.error('Failed to fetch users', error);
        } finally {
            setLoading(false);
        }
    };

    const handleApprove = async (id: string) => {
        try {
            await fetch(`${API_URL}${ApiRegistry.ADMIN.PSW_APPROVE(id)}`, { method: 'POST' });
            fetchUsers(); // Refresh list
            alert('PSW Approved');
        } catch (error) {
            alert('Failed to approve');
        }
    };

    return (
        <div style={{ maxWidth: '1200px', margin: '2rem auto', padding: '0 2rem' }}>
            <h2 style={{ fontSize: '1.5rem', marginBottom: '1.5rem' }}>{ContentRegistry.USERS.TITLE}</h2>

            <div style={{ backgroundColor: 'white', borderRadius: '8px', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
                <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }}>
                    <thead style={{ backgroundColor: '#f9fafb' }}>
                        <tr>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '500', color: '#6b7280' }}>Email</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '500', color: '#6b7280' }}>Role</th>
                            <th style={{ padding: '1rem', fontSize: '0.875rem', fontWeight: '500', color: '#6b7280' }}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {users.map(user => (
                            <tr key={user.id} style={{ borderTop: '1px solid #e5e7eb' }}>
                                <td style={{ padding: '1rem' }}>{user.email}</td>
                                <td style={{ padding: '1rem' }}>
                                    <span style={{
                                        padding: '0.25rem 0.5rem', borderRadius: '9999px', fontSize: '0.75rem', fontWeight: '500',
                                        backgroundColor: user.role === 'psw' ? '#e0e7ff' : '#d1fae5',
                                        color: user.role === 'psw' ? '#3730a3' : '#065f46'
                                    }}>
                                        {user.role}
                                    </span>
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    {user.role === 'psw' && (
                                        <button
                                            onClick={() => handleApprove(user.id)}
                                            style={{
                                                padding: '0.5rem 1rem', backgroundColor: '#2563eb', color: 'white', border: 'none', borderRadius: '4px', cursor: 'pointer', fontSize: '0.875rem'
                                            }}
                                        >
                                            {ContentRegistry.USERS.APPROVE_BTN}
                                        </button>
                                    )}
                                </td>
                            </tr>
                        ))}
                        {users.length === 0 && !loading && (
                            <tr><td colSpan={3} style={{ padding: '2rem', textAlign: 'center', color: '#6b7280' }}>No users found.</td></tr>
                        )}
                    </tbody>
                </table>
            </div>
        </div>
    );
}
