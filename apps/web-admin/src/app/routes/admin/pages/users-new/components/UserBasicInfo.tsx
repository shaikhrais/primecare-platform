import React from 'react';

interface UserBasicInfoProps {
    fullName: string;
    email: string;
    status: string;
    onChange: (field: string, value: string) => void;
}

export const UserBasicInfo: React.FC<UserBasicInfoProps> = ({ fullName, email, status, onChange }) => {
    return (
        <>
            <div>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Full Name</label>
                <input
                    data-cy="form.user.fullName"
                    type="text"
                    required
                    value={fullName}
                    onChange={(e) => onChange('fullName', e.target.value)}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
            <div>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Email Address</label>
                <input
                    data-cy="form.user.email"
                    type="email"
                    required
                    value={email}
                    onChange={(e) => onChange('email', e.target.value)}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                />
            </div>
            <div>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Account Status</label>
                <select
                    data-cy="form.user.status"
                    value={status}
                    onChange={(e) => onChange('status', e.target.value)}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                >
                    <option value="active">Active</option>
                    <option value="inactive">Inactive</option>
                    <option value="suspended">Suspended</option>
                </select>
            </div>
        </>
    );
};
