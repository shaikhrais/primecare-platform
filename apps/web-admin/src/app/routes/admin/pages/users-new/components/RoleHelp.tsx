import React from 'react';

const ROLE_INFO = {
    admin: { label: 'Administrator', info: 'Full system access. Can manage all settings, billing, and system-level roles.' },
    staff: { label: 'Operational Staff', info: 'Manage day-to-day operations: scheduling, leads, and basic user data.' },
    manager: { label: 'Regional Manager', info: 'Access to reporting, audits, and performance metrics for specific teams.' },
    psw: { label: 'Care Worker (PSW/RN)', info: 'Field workers. Access to schedules, visit reports, and earnings.' },
    client: { label: 'Client / Family', info: 'Care recipients. Access to their own bookings, billing, and care hub.' },
};

export const RoleHelp: React.FC = () => {
    return (
        <div style={{ padding: '1.5rem', backgroundColor: '#fff7ed', borderRadius: '1rem', border: '1px solid #ffedd5', height: 'fit-content' }}>
            <h4 style={{ margin: '0 0 1rem 0', color: '#9a3412', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                💡 Admin Staff Guide
            </h4>
            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Administration</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Admin / Staff</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Full system or operational access. Manage users, settings, and daily workflows.</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Management</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Managers / Coordinators</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>Umbrella roles for Marketing, Operations, and Regional oversight. Access to analytics and audits.</div>
                        </div>
                    </div>
                </div>

                <div>
                    <div style={{ fontWeight: 800, fontSize: '0.7rem', color: '#9a3412', textTransform: 'uppercase', marginBottom: '0.5rem' }}>Service Providers</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                        <div>
                            <div style={{ fontWeight: 700, fontSize: '0.85rem', color: '#7c2d12' }}>Caregivers (PSW, RN, RMT, etc.)</div>
                            <div style={{ fontSize: '0.8rem', color: '#9a3412', lineHeight: '1.4' }}>The professional care team. Access to schedules, visit reports, and field tools.</div>
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
