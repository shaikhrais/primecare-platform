import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface User {
    id: string;
    email: string;
    roles: string[];
    profile?: {
        fullName: string;
        isVerified?: boolean;
    };
}

interface UserTableProps {
    users: User[];
    loading: boolean;
    onEdit: (user: User) => void;
    onApprove: (id: string) => void;
    onSelectUser: (user: User) => void;
}

export function UserTable({ users, loading, onEdit, onApprove, onSelectUser }: UserTableProps) {
    const { t } = useTranslation();

    return (
        <div style={{ backgroundColor: 'white', borderRadius: '0.75rem', boxShadow: '0 1px 3px rgba(0,0,0,0.1)', overflow: 'hidden' }}>
            <table style={{ width: '100%', borderCollapse: 'collapse', textAlign: 'left' }} data-cy="tbl.users">
                <thead style={{ backgroundColor: '#f9fafb', borderBottom: '1px solid #e5e7eb' }}>
                    <tr>
                        <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{t(ContentRegistry.USERS.TITLE)}</th>
                        <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{t(ContentRegistry.USERS.ROLE)}</th>
                        <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{t(ContentRegistry.USERS.ID_VERIFICATION)}</th>
                        <th style={{ padding: '1rem', fontSize: '0.75rem', fontWeight: 'bold', color: '#6b7280', textTransform: 'uppercase' }}>{t(ContentRegistry.USERS.ACTIONS)}</th>
                    </tr>
                </thead>
                <tbody style={{ backgroundColor: 'white' }}>
                    {loading ? (
                        <tr><td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{t(ContentRegistry.USERS.MESSAGES.LOADING)}</td></tr>
                    ) : (
                        users.map(user => (
                            <tr key={user.id} data-cy={`user-row-${user.id}`} style={{ borderBottom: '1px solid #f3f4f6', cursor: 'pointer', transition: 'background-color 0.2s' }}
                                onClick={() => onSelectUser(user)}
                                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                            >
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
                                                {user.profile?.isVerified ? t(ContentRegistry.USERS.VERIFIED) : t(ContentRegistry.USERS.PENDING)}
                                            </span>
                                        </div>
                                    ) : '-'}
                                </td>
                                <td style={{ padding: '1rem' }}>
                                    <div style={{ display: 'flex', gap: '0.75rem' }}>
                                        <button
                                            data-cy="btn-edit-user"
                                            onClick={(e) => { e.stopPropagation(); onEdit(user); }}
                                            style={{ color: '#004d40', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '500' }}
                                        >
                                            {t(ContentRegistry.USERS.EDIT_BTN)}
                                        </button>
                                        {user.roles.includes('psw') && !user.profile?.isVerified && (
                                            <button
                                                data-cy="btn.user.verify"
                                                onClick={(e) => { e.stopPropagation(); onApprove(user.id); }}
                                                style={{ color: '#2563eb', background: 'none', border: 'none', cursor: 'pointer', fontSize: '0.875rem', fontWeight: '600' }}
                                            >
                                                {t(ContentRegistry.USERS.VERIFY_BTN)}
                                            </button>
                                        )}
                                    </div>
                                </td>
                            </tr>
                        ))
                    )}
                    {users.length === 0 && !loading && (
                        <tr><td colSpan={4} style={{ padding: '3rem', textAlign: 'center', color: '#6b7280' }}>{t(ContentRegistry.USERS.MESSAGES.EMPTY)}</td></tr>
                    )}
                </tbody>
            </table>
        </div>
    );
}
