import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

interface TopBarIdentityProps {
    role: string;
    user: any;
    isMobile: boolean;
}

export const TopBarIdentity: React.FC<TopBarIdentityProps> = ({ role, user, isMobile }) => {
    const getRoleTitle = (role: string) => {
        const r = role.toUpperCase();
        return ContentRegistry.ROLES[r as keyof typeof ContentRegistry.ROLES] || ContentRegistry.ROLES.STAFF;
    };

    return (
        <div style={{ display: 'flex', flexDirection: 'column' }}>
            <span style={{ fontSize: '0.875rem', fontWeight: 900, color: '#111827', textTransform: 'uppercase', letterSpacing: '0.5px', lineHeight: 1 }}>
                {getRoleTitle(role)}
            </span>
            {!isMobile && (
                <span style={{ fontSize: '0.75rem', fontWeight: 600, color: '#6B7280', marginTop: '2px' }}>
                    {ContentRegistry.LAYOUT.LOGGED_IN_AS} <span style={{ color: 'var(--brand-600)' }}>{user.fullName || user.email}</span>
                </span>
            )}
        </div>
    );
};
