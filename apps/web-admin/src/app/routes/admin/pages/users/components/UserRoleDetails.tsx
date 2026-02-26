import React from 'react';

interface UserRoleDetailsProps {
    roles: string[];
    sin: string;
    billingAccount: string;
    address: string;
    onChange: (field: string, value: string) => void;
}

export const UserRoleDetails: React.FC<UserRoleDetailsProps> = ({ roles, sin, billingAccount, address, onChange }) => {
    return (
        <>
            {/* Role-Specific: PSW */}
            {roles.includes('psw') && (
                <div style={{ gridColumn: 'span 2' }}>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>SIN (Social Insurance Number)</label>
                    <input
                        data-cy="form.user.sin"
                        type="password"
                        value={sin}
                        onChange={(e) => onChange('sin', e.target.value)}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    />
                </div>
            )}

            {/* Role-Specific: Client */}
            {roles.includes('client') && (
                <div style={{ gridColumn: 'span 2' }}>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Billing Account #</label>
                    <input
                        data-cy="form.user.billingAccount"
                        type="text"
                        value={billingAccount}
                        onChange={(e) => onChange('billingAccount', e.target.value)}
                        style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db' }}
                    />
                </div>
            )}

            <div style={{ gridColumn: 'span 2' }}>
                <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 500 }}>Physical Address</label>
                <textarea
                    data-cy="form.user.address"
                    value={address}
                    onChange={(e) => onChange('address', e.target.value)}
                    style={{ width: '100%', padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #d1d5db', minHeight: '80px' }}
                />
            </div>
        </>
    );
};
