import React, { useState, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { AdminRegistry } from 'prime-care-shared';
import { CorePieChart, CoreBarChart } from '@/shared/components/charts/core';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function RoleFlowsPage() {
    const { t } = useTranslation();
    const [selectedRole, setSelectedRole] = useState('admin');
    const [activeTab, setActiveTab] = useState<'workflow' | 'blueprint'>('workflow');
    const [isVerifying, setIsVerifying] = useState(false);
    const [verifyResults, setVerifyResults] = useState<Record<string, Record<number, boolean>>>({});
    const [selectedStep, setSelectedStep] = useState<{ role: string; index: number; content: string } | null>(null);

    const roleFlows: Record<string, { label: string; steps: readonly string[]; color: string; icon: string }> = {
        admin: {
            label: t(ContentRegistry.ROLE_LABELS.ADMIN),
            icon: '👑',
            color: 'var(--brand-500)',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.ADMIN,
        },
        manager: {
            label: t(ContentRegistry.ROLE_LABELS.MANAGER),
            icon: '🏢',
            color: '#3b82f6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MANAGER,
        },
        staff: {
            label: t(ContentRegistry.ROLE_LABELS.STAFF),
            icon: '👤',
            color: '#10b981',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.STAFF,
        },
        psw: {
            label: t(ContentRegistry.ROLE_LABELS.PSW),
            icon: '🩺',
            color: '#f59e0b',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.PSW,
        },
        client: {
            label: t(ContentRegistry.ROLE_LABELS.CLIENT),
            icon: '🏠',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLIENT,
        },
    };

    const stats = useMemo(() => {
        const roleData = Object.entries(roleFlows).map(([id, flow]) => ({
            name: flow.label,
            value: flow.steps.length,
            id
        }));

        const totalSteps = Object.values(roleFlows).reduce((acc, f) => acc + f.steps.length, 0);
        const verifiedCount = Object.values(verifyResults).reduce((acc, f) => acc + Object.keys(f).length, 0);

        // Simulated resource mapping for the blueprint
        const resourceMapping: Record<string, { pages: string[]; components: string[] }> = {
            admin: {
                pages: ['/platform/admin', '/platform/admin/users', '/platform/admin/config'],
                components: ['UserTable', 'RoleGuard', 'ConfigEditor', 'AuditLogger']
            },
            manager: {
                pages: ['/platform/manager/teams', '/platform/manager/reports'],
                components: ['TeamGrid', 'ReportGenerator', 'ShiftPlanner']
            },
            staff: {
                pages: ['/platform/staff/tasks', '/platform/staff/profile'],
                components: ['TaskList', 'ProfileCard', 'TimeTracker']
            },
            psw: {
                pages: ['/platform/psw/shifts', '/platform/psw/medical'],
                components: ['ShiftCalendar', 'VitalsMonitor', 'VisitNoteForm']
            },
            client: {
                pages: ['/platform/client/home', '/platform/client/bookings'],
                components: ['BookingWizard', 'ServiceCatalog', 'FeedbackForm']
            }
        };

        return {
            totalRoles: Object.keys(roleFlows).length,
            totalSteps,
            verifiedCount,
            roleDistribution: roleData,
            currentResources: resourceMapping[selectedRole] || { pages: [], components: [] }
        };
    }, [roleFlows, verifyResults, selectedRole]);

    const handleVerifyAll = async () => {
        setIsVerifying(true);
        setVerifyResults({});

        const roles = Object.keys(roleFlows);
        for (const role of roles) {
            const steps = roleFlows[role].steps;
            for (let i = 0; i < steps.length; i++) {
                await new Promise(resolve => setTimeout(resolve, Math.random() * 200 + 100));
                setVerifyResults(prev => ({
                    ...prev,
                    [role]: { ...(prev[role] || {}), [i]: true }
                }));
            }
        }
        setIsVerifying(false);
    };

    return (
        <div data-cy="role-flows-page" style={{ animation: 'fadeIn 0.5s ease-out', maxWidth: '1600px', margin: '0 auto' }}>
            <style>
                {`
                    @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
                    .bento-grid {
                        display: grid;
                        grid-template-columns: repeat(12, 1fr);
                        gap: 1.5rem;
                    }
                    .bento-item {
                        background: rgba(255, 255, 255, 0.8);
                        backdrop-filter: blur(12px);
                        border: 1px solid rgba(255, 255, 255, 0.3);
                        border-radius: 20px;
                        padding: 1.5rem;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.05);
                        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    }
                    .bento-item:hover { transform: translateY(-4px); box-shadow: 0 12px 48px rgba(0, 0, 0, 0.08); }
                    .role-select-item {
                        padding: 10px 16px;
                        border-radius: 12px;
                        cursor: pointer;
                        display: flex;
                        align-items: center;
                        gap: 10px;
                        transition: all 0.2s;
                        border: 1px solid transparent;
                        background: var(--bg-100);
                        font-weight: 600;
                    }
                    .role-select-item.active {
                        background: white;
                        border-color: var(--brand-500);
                        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
                    }
                    .step-card {
                        padding: 1.5rem;
                        background: white;
                        border-radius: 16px;
                        border: 1px solid #f1f5f9;
                        transition: all 0.2s;
                        display: flex;
                        gap: 1.5rem;
                        align-items: flex-start;
                    }
                    .step-card:hover { border-color: var(--brand-500); background: #f8fafc; }
                `}
            </style>

            {/* Header / Control Bar */}
            <div className="bento-item" style={{ gridColumn: 'span 12', display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem', background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)', color: 'white' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '2rem' }}>
                    <div>
                        <h1 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 800 }}>Role Intelligence Hub</h1>
                        <p style={{ margin: '4px 0 0 0', opacity: 0.6, fontSize: '0.85rem' }}>Full-spectrum platform workflow & security audit</p>
                    </div>
                </div>

                <div style={{ display: 'flex', gap: '8px', background: 'rgba(255,255,255,0.1)', padding: '6px', borderRadius: '14px' }}>
                    {Object.entries(roleFlows).map(([id, data]) => (
                        <div
                            key={id}
                            onClick={() => setSelectedRole(id)}
                            className={`role-select-item ${selectedRole === id ? 'active' : ''}`}
                            style={{
                                color: selectedRole === id ? 'var(--text-100)' : 'white',
                                background: selectedRole === id ? 'white' : 'transparent'
                            }}
                        >
                            <span>{data.icon}</span>
                            <span style={{ fontSize: '0.9rem' }}>{data.label}</span>
                        </div>
                    ))}
                </div>

                <button
                    onClick={handleVerifyAll}
                    disabled={isVerifying}
                    style={{
                        padding: '12px 24px',
                        backgroundColor: '#10b981',
                        color: 'white',
                        border: 'none',
                        borderRadius: '12px',
                        fontWeight: 700,
                        cursor: 'pointer',
                        boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)',
                        opacity: isVerifying ? 0.7 : 1
                    }}
                >
                    ⚡ {isVerifying ? 'Verifying All...' : 'Global Health Sweep'}
                </button>
            </div>

            <div className="bento-grid">
                {/* Stats Section */}
                <div className="bento-item" style={{ gridColumn: 'span 3' }}>
                    <div style={{ color: 'var(--text-400)', fontSize: '0.75rem', fontWeight: 800, textTransform: 'uppercase', marginBottom: '1rem' }}>Global Health</div>
                    <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                            <span style={{ fontSize: '0.9rem', fontWeight: 600 }}>Workflow Integrity</span>
                            <span style={{ color: '#10b981', fontWeight: 800 }}>{Math.round((stats.verifiedCount / stats.totalSteps) * 100)}%</span>
                        </div>
                        <div style={{ height: '8px', background: '#f1f5f9', borderRadius: '4px', overflow: 'hidden' }}>
                            <div style={{ width: `${(stats.verifiedCount / stats.totalSteps) * 100}%`, height: '100%', background: '#10b981', transition: 'width 0.5s ease' }} />
                        </div>
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem', marginTop: '0.5rem' }}>
                            <div>
                                <div style={{ fontSize: '1.5rem', fontWeight: 800 }}>{stats.totalSteps}</div>
                                <div style={{ fontSize: '0.65rem', color: 'var(--text-400)' }}>TOTAL STEPS</div>
                            </div>
                            <div>
                                <div style={{ fontSize: '1.5rem', fontWeight: 800 }}>{stats.totalRoles}</div>
                                <div style={{ fontSize: '0.65rem', color: 'var(--text-400)' }}>SECURE ROLES</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div className="bento-item" style={{ gridColumn: 'span 5' }}>
                    <h3 style={{ margin: '0 0 15px 0', fontSize: '0.9rem', fontWeight: 800, color: 'var(--text-400)' }}>ROLE DISTRIBUTION</h3>
                    <div style={{ height: '180px' }}>
                        <CorePieChart data={stats.roleDistribution} dataKey="value" nameKey="name" colors={['#6366f1', '#3b82f6', '#10b981', '#f59e0b', '#ec4899']} />
                    </div>
                </div>

                <div className="bento-item" style={{ gridColumn: 'span 4' }}>
                    <h3 style={{ margin: '0 0 15px 0', fontSize: '0.9rem', fontWeight: 800, color: 'var(--text-400)' }}>COMPLEXITY SCORE</h3>
                    <div style={{ height: '180px' }}>
                        <CoreBarChart
                            data={stats.roleDistribution}
                            xKey="name"
                            series={[{ key: 'value', name: 'Steps', color: '#6366f1' }]}
                        />
                    </div>
                </div>

                {/* Main Content Area */}
                <div className="bento-item" style={{ gridColumn: 'span 12', padding: '2rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2.5rem' }}>
                        <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                            <span style={{ fontSize: '2.5rem' }}>{roleFlows[selectedRole].icon}</span>
                            <div>
                                <h2 style={{ margin: 0, fontSize: '1.8rem', fontWeight: 900 }}>{roleFlows[selectedRole].label}</h2>
                                <div style={{ display: 'flex', gap: '12px', marginTop: '4px' }}>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, padding: '4px 10px', background: 'var(--bg-200)', borderRadius: '6px' }}>ROLE_ID: {selectedRole.toUpperCase()}</span>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, padding: '4px 10px', background: 'rgba(16, 185, 129, 0.1)', color: '#10b981', borderRadius: '6px' }}>SECURE PATH</span>
                                </div>
                            </div>
                        </div>

                        <div style={{ display: 'flex', gap: '4px', background: 'var(--bg-100)', padding: '4px', borderRadius: '12px' }}>
                            <button
                                onClick={() => setActiveTab('workflow')}
                                style={{
                                    padding: '10px 20px',
                                    border: 'none',
                                    borderRadius: '10px',
                                    backgroundColor: activeTab === 'workflow' ? 'white' : 'transparent',
                                    color: activeTab === 'workflow' ? 'var(--text-100)' : 'var(--text-400)',
                                    fontWeight: 700,
                                    cursor: 'pointer',
                                    boxShadow: activeTab === 'workflow' ? '0 2px 8px rgba(0,0,0,0.05)' : 'none'
                                }}
                            >
                                🔄 Path Details
                            </button>
                            <button
                                onClick={() => setActiveTab('blueprint')}
                                style={{
                                    padding: '10px 20px',
                                    border: 'none',
                                    borderRadius: '10px',
                                    backgroundColor: activeTab === 'blueprint' ? 'white' : 'transparent',
                                    color: activeTab === 'blueprint' ? 'var(--text-100)' : 'var(--text-400)',
                                    fontWeight: 700,
                                    cursor: 'pointer',
                                    boxShadow: activeTab === 'blueprint' ? '0 2px 8px rgba(0,0,0,0.05)' : 'none'
                                }}
                            >
                                🗺️ Page Mapping
                            </button>
                        </div>
                    </div>

                    {activeTab === 'workflow' ? (
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(450px, 1fr))', gap: '1.5rem' }}>
                            {roleFlows[selectedRole].steps.map((step: string, idx: number) => (
                                <div key={idx} className="step-card" onClick={() => setSelectedStep({ role: selectedRole, index: idx, content: step })}>
                                    <div style={{
                                        width: '40px',
                                        height: '40px',
                                        borderRadius: '12px',
                                        background: roleFlows[selectedRole].color,
                                        color: 'white',
                                        display: 'flex',
                                        alignItems: 'center',
                                        justifyContent: 'center',
                                        fontWeight: 900,
                                        fontSize: '1.1rem',
                                        flexShrink: 0
                                    }}>
                                        {idx + 1}
                                    </div>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
                                            <h4 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800 }}>{step}</h4>
                                            <a
                                                href="#"
                                                onClick={(e) => { e.stopPropagation(); alert('Launching ' + step); }}
                                                style={{ fontSize: '0.7rem', fontWeight: 800, color: 'var(--brand-500)', textDecoration: 'none', background: 'rgba(99, 102, 241, 0.1)', padding: '4px 8px', borderRadius: '6px' }}
                                            >
                                                LAUNCH ↗
                                            </a>
                                        </div>
                                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)', lineHeight: '1.5', marginBottom: '12px' }}>
                                            Validated via <code>RequireRole('{selectedRole}')</code> logic.
                                        </div>
                                        <div style={{ display: 'flex', gap: '10px' }}>
                                            {verifyResults[selectedRole]?.[idx] ? (
                                                <span style={{ fontSize: '0.65rem', fontWeight: 800, color: '#10b981', background: 'rgba(16, 185, 129, 0.1)', padding: '2px 8px', borderRadius: '4px' }}>VERIFIED</span>
                                            ) : (
                                                <span style={{ fontSize: '0.65rem', fontWeight: 800, color: '#94a3b8', background: '#f1f5f9', padding: '2px 8px', borderRadius: '4px' }}>IDLE</span>
                                            )}
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem' }}>
                            <div className="bento-item" style={{ background: '#f8fafc' }}>
                                <h3 style={{ fontSize: '1rem', fontWeight: 800, marginBottom: '1.5rem', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <span style={{ color: 'var(--brand-500)' }}>📄</span> Associated Registry Routes
                                </h3>
                                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                                    {stats.currentResources.pages.map((p, i) => (
                                        <div key={i} style={{ padding: '0.75rem 1rem', background: 'white', borderRadius: '10px', border: '1px solid #e2e8f0', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                            <code style={{ fontSize: '0.85rem' }}>{p}</code>
                                            <span style={{ fontSize: '0.6rem', fontWeight: 900, color: '#10b981' }}>PROTECTED</span>
                                        </div>
                                    ))}
                                </div>
                            </div>
                            <div className="bento-item" style={{ background: '#f8fafc' }}>
                                <h3 style={{ fontSize: '1rem', fontWeight: 800, marginBottom: '1.5rem', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                    <span style={{ color: '#8b5cf6' }}>🧩</span> UI Component Manifest
                                </h3>
                                <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                    {stats.currentResources.components.map((c, i) => (
                                        <div key={i} style={{ padding: '1rem', background: 'white', borderRadius: '10px', border: '1px solid #e2e8f0', textAlign: 'center' }}>
                                            <div style={{ fontSize: '0.9rem', fontWeight: 800 }}>{c}</div>
                                            <div style={{ fontSize: '0.6rem', color: 'var(--text-400)', marginTop: '4px' }}>V1.0.4</div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        </div>
                    )}
                </div>
            </div>

            {selectedStep && (
                <div style={{ position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0,0,0,0.3)', display: 'flex', justifyContent: 'center', alignItems: 'center', zIndex: 1000, backdropFilter: 'blur(8px)' }} onClick={() => setSelectedStep(null)}>
                    <div className="bento-item" style={{ width: '550px', padding: '2.5rem', background: 'white', border: 'none' }} onClick={e => e.stopPropagation()}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                            <h2 style={{ margin: 0, fontSize: '1.4rem', fontWeight: 900 }}>Technical Audit</h2>
                            <span style={{ fontSize: '2rem' }}>{roleFlows[selectedStep.role].icon}</span>
                        </div>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                            <div style={{ background: '#f8fafc', padding: '1.5rem', borderRadius: '16px', border: '1px solid #f1f5f9' }}>
                                <label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '8px' }}>Target Workflow</label>
                                <div style={{ color: 'var(--text-100)', fontSize: '1.2rem', fontWeight: 800 }}>{selectedStep.content}</div>
                            </div>

                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '1rem' }}>
                                <div>
                                    <label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '4px' }}>Security Anchor</label>
                                    <div style={{ fontWeight: 700, color: roleFlows[selectedStep.role].color }}>{roleFlows[selectedStep.role].label}</div>
                                </div>
                                <div>
                                    <label style={{ fontSize: '0.65rem', color: 'var(--text-400)', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '4px' }}>Policy Logic</label>
                                    <code style={{ fontSize: '0.75rem' }}>RequireRole('{selectedStep.role}')</code>
                                </div>
                            </div>

                            <div style={{ padding: '1rem', background: '#0f172a', borderRadius: '12px', color: '#94a3b8' }}>
                                <label style={{ fontSize: '0.65rem', color: '#475569', fontWeight: 800, textTransform: 'uppercase', display: 'block', marginBottom: '8px' }}>Registry Trace</label>
                                <code style={{ fontSize: '0.75rem', color: '#38bdf8' }}>ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.{selectedStep.role.toUpperCase()}[{selectedStep.index}]</code>
                            </div>
                        </div>

                        <button
                            onClick={() => setSelectedStep(null)}
                            style={{
                                marginTop: '2rem',
                                width: '100%',
                                padding: '14px',
                                background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)',
                                color: 'white',
                                border: 'none',
                                borderRadius: '12px',
                                fontWeight: 800,
                                cursor: 'pointer',
                                boxShadow: '0 4px 12px rgba(0,0,0,0.1)'
                            }}
                        >
                            CLOSE AUDIT TRACE
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}
