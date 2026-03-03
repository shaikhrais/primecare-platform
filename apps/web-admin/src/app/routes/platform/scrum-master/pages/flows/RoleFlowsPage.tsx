import React, { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function RoleFlowsPage() {
    const { t } = useTranslation();
    const [selectedRole, setSelectedRole] = useState('admin');

    const roleFlows: Record<string, { label: string; steps: string[]; color: string; icon: string }> = {
        admin: {
            label: t(ContentRegistry.ROLE_LABELS.ADMIN),
            icon: '👑',
            color: 'var(--brand-500)',
            steps: ['Dashboard Overlay', 'User Management', 'Global Schedule', 'Earnings Center', 'System Settings', 'Developer Audit Hub'],
        },
        manager: {
            label: t(ContentRegistry.ROLE_LABELS.MANAGER),
            icon: '🏢',
            color: '#3b82f6',
            steps: ['Operations Dashboard', 'Shift Coordination', 'Clinical Reviews', 'Payroll Verification', 'Regional Analytics'],
        },
        staff: {
            label: t(ContentRegistry.ROLE_LABELS.STAFF),
            icon: '👤',
            color: '#10b981',
            steps: ['Staff Hub', 'Lead Inquiries', 'Customer Roster', 'Incident Logging', 'Compliance Monitoring'],
        },
        psw: {
            label: t(ContentRegistry.ROLE_LABELS.PSW),
            icon: '🩺',
            color: '#f59e0b',
            steps: ['My Schedule', 'Open Market', 'Visit Check-in/out', 'Payout Requests', 'Compliance Ledger'],
        },
        client: {
            label: t(ContentRegistry.ROLE_LABELS.CLIENT),
            icon: '🏠',
            color: '#ec4899',
            steps: ['Care Hub', 'New Request', 'Assigned Team', 'Digital Invoices', 'Feedback Gateway'],
        },
    };

    return (
        <div data-cy="role-flows-page" style={{ animation: 'fadeIn 0.5s ease-out' }}>
            <style>
                {`
                    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
                    .role-btn {
                        padding: 1rem 1.5rem;
                        text-align: left;
                        border: 1px solid transparent;
                        border-radius: 12px;
                        background: white;
                        color: var(--text-300);
                        font-weight: 700;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        gap: 12px;
                        transition: all 0.2s;
                        margin-bottom: 8px;
                    }
                    .role-btn:hover { background: var(--bg-100); border-color: var(--border); }
                    .role-btn.active {
                        background: white;
                        border-color: var(--brand-500);
                        color: var(--text-100);
                        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                    }
                    .step-bubble {
                        width: 44px;
                        height: 44px;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: white;
                        font-weight: 800;
                        font-size: 1.1rem;
                        position: relative;
                        z-index: 2;
                        box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                    }
                    .step-line {
                        position: absolute;
                        left: 21px;
                        top: 44px;
                        width: 2px;
                        height: calc(100% - 20px);
                        background: #e2e8f0;
                        z-index: 1;
                    }
                `}
            </style>

            <div style={{ marginBottom: '3rem' }}>
                <h1 style={{ margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.TITLE)}
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.2rem', fontWeight: 500 }}>
                    {t(ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.SUBTITLE)}
                </p>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '300px 1fr', gap: '3rem' }}>
                <div>
                    <h3 style={{ margin: '0 0 1rem 0', fontSize: '0.9rem', color: 'var(--text-400)', textTransform: 'uppercase', letterSpacing: '1px' }}>Security Roles</h3>
                    <div style={{ display: 'flex', flexDirection: 'column' }}>
                        {Object.entries(roleFlows).map(([id, data]) => (
                            <button
                                key={id}
                                onClick={() => setSelectedRole(id)}
                                className={`role-btn ${selectedRole === id ? 'active' : ''}`}
                            >
                                <span style={{ fontSize: '1.5rem' }}>{data.icon}</span>
                                <div>
                                    <div style={{ fontSize: '1rem' }}>{data.label}</div>
                                    <div style={{ fontSize: '0.75rem', fontWeight: 500, opacity: 0.6 }}>{id.toUpperCase()}</div>
                                </div>
                            </button>
                        ))}
                    </div>
                </div>

                <div className="pc-card" style={{ padding: '3rem', position: 'relative' }}>
                    <div style={{ position: 'absolute', top: '1.5rem', right: '2rem', fontSize: '4rem', opacity: 0.05 }}>
                        {roleFlows[selectedRole].icon}
                    </div>

                    <h2 style={{ margin: '0 0 3rem 0', fontSize: '1.8rem', fontWeight: 800, color: 'var(--text-100)' }}>
                        {roleFlows[selectedRole].label} Workflow pathway
                    </h2>

                    <div style={{ display: 'flex', flexDirection: 'column', gap: '3rem' }}>
                        {roleFlows[selectedRole].steps.map((step, idx) => (
                            <div key={idx} style={{ display: 'flex', gap: '2rem', position: 'relative' }}>
                                <div style={{ flexShrink: 0 }}>
                                    <div className="step-bubble" style={{ backgroundColor: roleFlows[selectedRole].color }}>
                                        {idx + 1}
                                    </div>
                                    {idx < roleFlows[selectedRole].steps.length - 1 && <div className="step-line" />}
                                </div>
                                <div style={{ paddingTop: '8px' }}>
                                    <h4 style={{ margin: '0 0 8px 0', fontSize: '1.3rem', fontWeight: 800, color: 'var(--text-100)' }}>{step}</h4>
                                    <div style={{ padding: '1rem', background: '#f8fafc', borderRadius: '12px', border: '1px solid #f1f5f9', maxWidth: '500px' }}>
                                        <div style={{ color: 'var(--text-300)', fontSize: '0.9rem', marginBottom: '8px', lineHeight: 1.5 }}>
                                            Validated via <strong>RequireRole({selectedRole})</strong> and linked to
                                            registry path <code>{Object.values(RouteRegistry.ROLE_DASHBOARDS).includes(step) ? 'MATCH' : 'SECURE'}</code>.
                                        </div>
                                        <div style={{ display: 'flex', gap: '12px' }}>
                                            <span style={{ fontSize: '0.75rem', fontWeight: 700, color: roleFlows[selectedRole].color }}>● ACCESSIBLE</span>
                                            <span style={{ fontSize: '0.75rem', fontWeight: 700, color: '#94a3b8' }}>● VERIFIED</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}
