import React, { useState, useMemo } from 'react';
import { useTranslation } from 'react-i18next';
import { CorePieChart, CoreBarChart } from '@/shared/components/charts/core';
import { buildRoleFlows } from './roleFlowsData';
import { resourceMapping } from './resourceMapping';
import { roleFlowsStyles } from './roleFlowsStyles';
import { StepAuditModal, runGlobalHealthSweep } from './StepAuditModal';

export default function RoleFlowsPage() {
    const { t } = useTranslation();
    const [selectedRole, setSelectedRole] = useState('admin');
    const [activeTab, setActiveTab] = useState<'workflow' | 'blueprint'>('workflow');
    const [isVerifying, setIsVerifying] = useState(false);
    const [verifyResults, setVerifyResults] = useState<Record<string, Record<number, boolean>>>({});
    const [selectedStep, setSelectedStep] = useState<{ role: string; index: number; content: string } | null>(null);

    const roleFlows = buildRoleFlows(t);

    const stats = useMemo(() => {
        const roleData = Object.entries(roleFlows).map(([id, flow]) => ({
            name: flow.label, value: flow.steps.length, id
        }));
        const totalSteps = Object.values(roleFlows).reduce((acc, f) => acc + f.steps.length, 0);
        const verifiedCount = Object.values(verifyResults).reduce((acc, f) => acc + Object.keys(f).length, 0);

        const currentBlueprint = resourceMapping[selectedRole] || resourceMapping['admin'];
        const implemented = currentBlueprint.pages.filter(p => p.status === 'implemented');
        const missing = currentBlueprint.pages.filter(p => p.status === 'missing');

        return { totalRoles: Object.keys(roleFlows).length, totalSteps, verifiedCount, roleDistribution: roleData, mission: currentBlueprint.mission, implemented, missing };
    }, [roleFlows, verifyResults, selectedRole]);

    const handleVerifyAll = () => runGlobalHealthSweep(roleFlows, setVerifyResults, setIsVerifying);

    return (
        <div data-cy="role-flows-page" style={{ animation: 'fadeIn 0.5s ease-out', maxWidth: '1600px', margin: '0 auto' }}>
            <style>{roleFlowsStyles}</style>

            {/* Header / Control Bar */}
            <div className="bento-item" style={{ gridColumn: 'span 12', display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem', background: 'linear-gradient(135deg, #1E293B 0%, #0F172A 100%)', color: 'white' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '2rem' }}>
                    <div>
                        <h1 style={{ margin: 0, fontSize: '1.5rem', fontWeight: 800 }}>Role Intelligence Hub</h1>
                        <p style={{ margin: '4px 0 0 0', opacity: 0.6, fontSize: '0.85rem' }}>Full-spectrum platform workflow &amp; security audit</p>
                    </div>
                </div>
                <div style={{ display: 'flex', gap: '8px', background: 'rgba(255,255,255,0.1)', padding: '6px', borderRadius: '14px' }}>
                    {Object.entries(roleFlows).map(([id, data]) => (
                        <div key={id} onClick={() => setSelectedRole(id)} className={`role-select-item ${selectedRole === id ? 'active' : ''}`}
                            style={{ color: selectedRole === id ? 'var(--text-100)' : 'white', background: selectedRole === id ? 'white' : 'transparent' }}>
                            <span>{data.icon}</span>
                            <span style={{ fontSize: '0.9rem' }}>{data.label}</span>
                        </div>
                    ))}
                </div>
                <button data-cy="btn-role-flows-page-0" onClick={handleVerifyAll} disabled={isVerifying}
                    style={{ padding: '12px 24px', backgroundColor: '#10b981', color: 'white', border: 'none', borderRadius: '12px', fontWeight: 700, cursor: 'pointer', boxShadow: '0 4px 12px rgba(16, 185, 129, 0.3)', opacity: isVerifying ? 0.7 : 1 }}>
                    ⚡ {isVerifying ? 'Verifying All...' : 'Global Health Sweep'}
                </button>
            </div>

            <div className="bento-grid">
                {/* Stats */}
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
                            <div><div style={{ fontSize: '1.5rem', fontWeight: 800 }}>{stats.totalSteps}</div><div style={{ fontSize: '0.65rem', color: 'var(--text-400)' }}>TOTAL STEPS</div></div>
                            <div><div style={{ fontSize: '1.5rem', fontWeight: 800 }}>{stats.totalRoles}</div><div style={{ fontSize: '0.65rem', color: 'var(--text-400)' }}>SECURE ROLES</div></div>
                        </div>
                    </div>
                </div>

                <div className="bento-item" style={{ gridColumn: 'span 5' }}>
                    <h3 data-cy="h3-role-flows-page-0" style={{ margin: '0 0 15px 0', fontSize: '0.9rem', fontWeight: 800, color: 'var(--text-400)' }}>ROLE DISTRIBUTION</h3>
                    <div style={{ height: '180px' }}><CorePieChart data={stats.roleDistribution} dataKey="value" nameKey="name" colors={['#6366f1', '#3b82f6', '#10b981', '#f59e0b', '#ec4899']} /></div>
                </div>

                <div className="bento-item" style={{ gridColumn: 'span 4' }}>
                    <h3 data-cy="h3-role-flows-page-1" style={{ margin: '0 0 15px 0', fontSize: '0.9rem', fontWeight: 800, color: 'var(--text-400)' }}>COMPLEXITY SCORE</h3>
                    <div style={{ height: '180px' }}><CoreBarChart data={stats.roleDistribution} xKey="name" series={[{ key: 'value', name: 'Steps', color: '#6366f1' }]} /></div>
                </div>

                {/* Main Content */}
                <div className="bento-item" style={{ gridColumn: 'span 12', padding: '2rem' }}>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '2.5rem' }}>
                        <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                            <span style={{ fontSize: '2.5rem' }}>{roleFlows[selectedRole].icon}</span>
                            <div>
                                <h2 data-cy="h2-role-flows-page-0" style={{ margin: 0, fontSize: '1.8rem', fontWeight: 900 }}>{roleFlows[selectedRole].label}</h2>
                                <div style={{ display: 'flex', gap: '12px', marginTop: '4px' }}>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, padding: '4px 10px', background: 'var(--bg-200)', borderRadius: '6px' }}>ROLE_ID: {selectedRole.toUpperCase()}</span>
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, padding: '4px 10px', background: 'rgba(16, 185, 129, 0.1)', color: '#10b981', borderRadius: '6px' }}>SECURE ACCESS</span>
                                </div>
                            </div>
                        </div>
                        <div style={{ display: 'flex', gap: '4px', background: 'var(--bg-100)', padding: '4px', borderRadius: '12px' }}>
                            {(['workflow', 'blueprint'] as const).map(tab => (
                                <button key={tab} data-cy={`btn-role-flows-page-${tab === 'workflow' ? 1 : 2}`} onClick={() => setActiveTab(tab)}
                                    style={{ padding: '10px 20px', border: 'none', borderRadius: '10px', backgroundColor: activeTab === tab ? 'white' : 'transparent',
                                        color: activeTab === tab ? 'var(--text-100)' : 'var(--text-400)', fontWeight: 700, cursor: 'pointer',
                                        boxShadow: activeTab === tab ? '0 2px 8px rgba(0,0,0,0.05)' : 'none' }}>
                                    {tab === 'workflow' ? '🔄 Journey Paths' : '🗺️ Component Blueprint'}
                                </button>
                            ))}
                        </div>
                    </div>

                    {activeTab === 'workflow' ? (
                        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(450px, 1fr))', gap: '1.5rem' }}>
                            {roleFlows[selectedRole].steps.map((step: string, idx: number) => (
                                <div key={idx} className="step-card" onClick={() => setSelectedStep({ role: selectedRole, index: idx, content: step })}>
                                    <div style={{ width: '40px', height: '40px', borderRadius: '12px', background: roleFlows[selectedRole].color, color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 900, fontSize: '1.1rem', flexShrink: 0 }}>{idx + 1}</div>
                                    <div style={{ flex: 1 }}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '10px' }}>
                                            <h4 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800 }}>{step}</h4>
                                            <span style={{ fontSize: '0.65rem', fontWeight: 800, color: 'var(--brand-500)', background: 'rgba(99, 102, 241, 0.1)', padding: '4px 8px', borderRadius: '6px' }}>AUDIT TRACE</span>
                                        </div>
                                        <div style={{ fontSize: '0.85rem', color: 'var(--text-300)', lineHeight: '1.5', marginBottom: '12px' }}>
                                            Validated via <code>RequireRole('{selectedRole}')</code> navigation logic.
                                        </div>
                                        <div style={{ display: 'flex', gap: '10px' }}>
                                            {verifyResults[selectedRole]?.[idx] ? (
                                                <span style={{ fontSize: '0.65rem', fontWeight: 800, color: '#10b981', background: 'rgba(16, 185, 129, 0.1)', padding: '2px 8px', borderRadius: '4px' }}>HEALTHY</span>
                                            ) : (
                                                <span style={{ fontSize: '0.65rem', fontWeight: 800, color: '#94a3b8', background: '#f1f5f9', padding: '2px 8px', borderRadius: '4px' }}>STANDBY</span>
                                            )}
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <div>
                            <div style={{ marginBottom: '2rem', padding: '2rem', background: 'linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%)', borderRadius: '24px', border: '1px solid #e2e8f0', boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.02)' }}>
                                <div style={{ display: 'flex', gap: '1rem', alignItems: 'center', marginBottom: '1rem' }}>
                                    <span style={{ fontSize: '1.5rem' }}>🎯</span>
                                    <h3 data-cy="h3-role-flows-page-2" style={{ margin: 0, fontSize: '1.1rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '0.05em', color: 'var(--text-400)' }}>Role Mission Statement</h3>
                                </div>
                                <p style={{ margin: 0, color: 'var(--text-100)', fontSize: '1.2rem', fontWeight: 600, lineHeight: '1.6', fontStyle: 'italic' }}>"{stats.mission}"</p>
                            </div>

                            {[{ title: '✅ Implemented Features', data: stats.implemented, color: '#10b981', label: 'MODULES READY' },
                              { title: '🚧 Missing Platform Gaps', data: stats.missing, color: '#ef4444', label: 'PENDING MODULES' }].map((section, si) => (
                                <div key={si} style={{ marginBottom: si === 0 ? '3rem' : 0 }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                                        <h3 data-cy={`h3-role-flows-page-${si + 3}`} style={{ margin: 0, fontSize: '1.3rem', fontWeight: 900, color: section.color, display: 'flex', alignItems: 'center', gap: '10px' }}>
                                            <span style={{ fontSize: '1.5rem' }}>{section.title.split(' ')[0]}</span> {section.title.slice(section.title.indexOf(' ') + 1)}
                                        </h3>
                                        <span style={{ fontSize: '0.8rem', fontWeight: 800, padding: '4px 12px', background: `${section.color}1a`, color: section.color, borderRadius: '20px' }}>{section.data.length} {section.label}</span>
                                    </div>
                                    <table data-cy="table-role-flows-page" className="blueprint-table">
                                        <thead><tr>
                                            <th style={{ width: '20%' }}>{si === 0 ? 'Requirement / Task' : 'Unmet Requirement'}</th>
                                            <th style={{ width: '25%' }}>{si === 0 ? 'Route Registry' : 'Planned Route'}</th>
                                            <th style={{ width: '25%' }}>{si === 0 ? 'Associated Component' : 'Target Component'}</th>
                                            <th style={{ width: '30%' }}>{si === 0 ? 'Technical Objective' : 'Implementation Goal'}</th>
                                        </tr></thead>
                                        <tbody>
                                            {section.data.map((p, i) => (
                                                <tr key={i}>
                                                    <td style={{ fontWeight: 800, color: si === 0 ? '#0f172a' : '#ef4444', opacity: si === 0 ? 1 : 0.8 }}>{p.name}</td>
                                                    <td><code style={{ fontSize: '0.75rem', color: si === 0 ? 'var(--brand-600)' : '#94a3b8', background: si === 0 ? 'var(--bg-100)' : '#f1f5f9', padding: '2px 6px', borderRadius: '4px' }}>{p.route}</code></td>
                                                    <td><code style={{ fontSize: '0.75rem', background: '#f8fafc', padding: '2px 6px', borderRadius: '4px', color: si === 0 ? undefined : '#94a3b8' }}>{p.component}</code></td>
                                                    <td style={{ fontSize: '0.85rem', color: si === 0 ? 'var(--text-300)' : '#64748b', lineHeight: '1.4', fontStyle: si === 0 ? undefined : 'italic' }}>{p.requirement}</td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                            ))}
                        </div>
                    )}
                </div>
            </div>

            {selectedStep && (
                <StepAuditModal
                    selectedStep={selectedStep}
                    roleFlows={roleFlows}
                    onClose={() => setSelectedStep(null)}
                />
            )}
        </div>
    );
}
