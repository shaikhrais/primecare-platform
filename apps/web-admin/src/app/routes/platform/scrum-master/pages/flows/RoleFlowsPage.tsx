import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function RoleFlowsPage() {
    const { t } = useTranslation();
    const [selectedRole, setSelectedRole] = useState('admin');

    const roleFlows: Record<string, string[]> = {
        admin: ['Dashboard', 'Users', 'Schedule', 'Earnings', 'Incidents', 'Settings', 'Developer Hub'],
        manager: ['Portfolio Landing', 'Daily Entries', 'Evaluations', 'Service Reviews', 'Category Views'],
        staff: ['Staff Hub', 'Lead Management', 'Schedules', 'Customer Lists', 'Support Tickets'],
        psw: ['Work Schedule', 'Open Shifts', 'My Shifts', 'Earnings', 'Credentials', 'Shift Confirmations'],
        client: ['Family Portal', 'Care Bookings', 'Billing/Invoices', 'Feedback Hub', 'Team Messaging'],
    };

    return (
        <div data-cy="role-flows-page">
            <div style={{ marginBottom: '2.5rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '250px 1fr', gap: '2rem' }}>
                <div className="pc-card" style={{ padding: '1.5rem', height: 'fit-content' }}>
                    <h3 style={{ margin: '0 0 1.5rem 0', fontSize: '1rem' }}>Select Role</h3>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
                        {Object.keys(roleFlows).map(role => (
                            <button
                                key={role}
                                onClick={() => setSelectedRole(role)}
                                style={{
                                    padding: '12px 16px',
                                    textAlign: 'left',
                                    backgroundColor: selectedRole === role ? 'var(--brand-50)' : 'transparent',
                                    color: selectedRole === role ? 'var(--brand-600)' : 'var(--text-300)',
                                    border: 'none',
                                    borderRadius: '8px',
                                    fontWeight: 700,
                                    cursor: 'pointer',
                                    textTransform: 'capitalize',
                                    transition: '0.2s'
                                }}
                            >
                                {role} Portal
                            </button>
                        ))}
                    </div>
                </div>

                <div className="pc-card" style={{ padding: '2rem' }}>
                    <h3 style={{ margin: '0 0 2rem 0', textTransform: 'capitalize' }}>{selectedRole} Navigation Pathway</h3>
                    <div style={{ position: 'relative' }}>
                        {roleFlows[selectedRole].map((step, idx) => (
                            <div key={idx} style={{ display: 'flex', alignItems: 'center', marginBottom: idx === roleFlows[selectedRole].length - 1 ? 0 : '1.5rem' }}>
                                <div style={{
                                    width: '40px',
                                    height: '40px',
                                    borderRadius: '50%',
                                    backgroundColor: 'var(--brand-500)',
                                    color: 'white',
                                    display: 'flex',
                                    alignItems: 'center',
                                    justifyContent: 'center',
                                    fontWeight: 800,
                                    zIndex: 1
                                }}>
                                    {idx + 1}
                                </div>
                                <div style={{ marginLeft: '1.5rem', flex: 1 }}>
                                    <div style={{ fontWeight: 700, color: 'var(--text-100)', fontSize: '1.1rem' }}>{step}</div>
                                    <div style={{ fontSize: '0.85rem', color: 'var(--text-300)', marginTop: '4px' }}>
                                        Mapped to physical component and registry route variable.
                                    </div>
                                </div>
                                {idx < roleFlows[selectedRole].length - 1 && (
                                    <div style={{
                                        position: 'absolute',
                                        left: '19px',
                                        top: '40px',
                                        width: '2px',
                                        height: 'calc(100% - 40px)',
                                        backgroundColor: '#e2e8f0',
                                        zIndex: 0
                                    }}></div>
                                )}
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}
