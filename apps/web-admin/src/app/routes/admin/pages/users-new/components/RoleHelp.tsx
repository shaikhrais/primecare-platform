import React from 'react';

const ROLE_INFO = {
    admin: { label: 'Administrator', info: 'Full system access. Can manage all settings, billing, and system-level roles.' },
    staff: { label: 'Operational Staff (Umbrella)', info: 'Manage day-to-day operations: scheduling, leads, and basic user data.' },
    manager: { label: 'Manager (Umbrella)', info: 'Access to reporting, audits, and performance metrics for specific teams.' },
    psw: { label: 'Service Provider (Umbrella)', info: 'Field workers (PSW, RN, RMT). Access to schedules and reports.' },
    client: { label: 'Client / Family', info: 'Care recipients. Access to their own bookings and billing.' },
};

export const RoleHelp: React.FC = () => {
    return (
        <div style={{ padding: '1.5rem', backgroundColor: '#fff7ed', borderRadius: '1rem', border: '1px solid #ffedd5', height: 'fit-content' }}>
            <h4 style={{ margin: '0 0 1rem 0', color: '#9a3412', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                💡 Umbrella Role Guide
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Administration</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Admin</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Full system access. Manage all settings, billing, and system-level roles.</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Staff (Umbrella)</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Operational Staff / HR / Finance</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Manage day-to-day operations: scheduling, payroll, and compliance.</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Managers (Umbrella)</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.8rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Marketing / Sales Manager</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Focus on client growth, source tracking, and promotional campaigns.</div>
                        </div>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Operations / Clinical Manager</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Quality assurance, nurse oversight, and day-to-day service excellence.</div>
                        </div>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Recruiting / HR Manager</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Onboarding service providers, credential verification, and staff retention.</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Service Providers</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Professional Service Providers (PSW/RN/etc)</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Direct care delivery. Access to schedules and patient documentation.</div>
                        </div>
                    </div>
                </div>
            </div>
            <div style={{ marginTop: '1.5rem', paddingTop: '1rem', borderTop: '1px solid #fed7aa', fontSize: '0.8rem', color: '#7c2d12' }}>
                <strong>Tip:</strong> Users can have multiple roles (e.g., Staff + Manager) to combine permissions.
            </div>
        </div>
    );
};
