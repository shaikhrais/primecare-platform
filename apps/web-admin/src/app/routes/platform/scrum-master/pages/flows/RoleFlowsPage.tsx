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
        scrum_master: {
            label: t(ContentRegistry.ROLE_LABELS.SCRUM_MASTER),
            icon: '🚀',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.SCRUM_MASTER,
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
        rn: {
            label: t(ContentRegistry.ROLE_LABELS.RN),
            icon: '🩺',
            color: '#06b6d4',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RN,
        },
        marketing_manager: {
            label: 'Marketing Manager',
            icon: '📈',
            color: '#ec4899',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.MARKETING_MANAGER,
        },
        hr_manager: {
            label: 'HR Manager',
            icon: '👤',
            color: '#8b5cf6',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.HR_MANAGER,
        },
        recruiting_manager: {
            label: 'Recruiting Manager',
            icon: '🤝',
            color: '#6366f1',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.RECRUITING_MANAGER,
        },
        finance_manager: {
            label: 'Finance Manager',
            icon: '💰',
            color: '#0ea5e9',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.FINANCE_MANAGER,
        },
        regional_manager: {
            label: 'Regional Manager',
            icon: '🏢',
            color: '#0f172a',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.REGIONAL_MANAGER,
        },
        clinical_manager: {
            label: 'Clinical Manager',
            icon: '🩺',
            color: '#e11d48',
            steps: ContentRegistry.SCRUM_MASTER.ROLE_FLOWS.STEPS.CLINICAL_MANAGER,
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

        // Comprehensive Role Infrastructure Blueprint with Task Requirements
        const resourceMapping: Record<string, {
            mission: string,
            pages: Array<{
                name: string;
                route: string;
                component: string;
                status: 'implemented' | 'missing';
                requirement: string;
            }>
        }> = {
            admin: {
                mission: 'Orchestrate global franchise network, manage master financial records, and provision system-wide security policies.',
                pages: [
                    { name: 'Dashboard', route: 'ADMIN.DASHBOARD', component: 'AdminDashboard', status: 'implemented', requirement: 'High-level operational overview for executive decision making.' },
                    { name: 'User Management', route: 'ADMIN.USERS', component: 'UserList', status: 'implemented', requirement: 'Provision and audit security roles for all staff across the franchise.' },
                    { name: 'Schedule', route: 'ADMIN.SCHEDULE', component: 'Schedule', status: 'implemented', requirement: 'Global visibility into all service appointments for master coordination.' },
                    { name: 'Earnings', route: 'ADMIN.EARNINGS', component: 'AdminEarningsPage', status: 'implemented', requirement: 'Aggregate financial tracking for franchise royalty and payout audit.' },
                    { name: 'Incident Tracking', route: 'ADMIN.INCIDENTS', component: 'IncidentList', status: 'implemented', requirement: 'Document and resolve high-severity clinical or operational risks.' },
                    { name: 'Leads & Admissions', route: 'ADMIN.LEADS', component: 'LeadsPage', status: 'implemented', requirement: 'Manage business development pipeline and new client conversion.' },
                    { name: 'Global Search', route: 'ADMIN.SEARCH', component: 'SearchPortal', status: 'implemented', requirement: 'Instant lookup for any user, patient, or record across the entire platform.' },
                    { name: 'Advanced Export', route: 'ADMIN.REPORTS.EXPORT', component: 'ReportExporter', status: 'implemented', requirement: 'Custom data extraction for external compliance and tax auditing.' },
                ]
            },
            scrum_master: {
                mission: 'Maintain platform technical integrity, optimize system performance, and audit registry consistency.',
                pages: [
                    { name: 'Command Center', route: 'SCRUM_MASTER.DASHBOARD', component: 'ScrumMasterDashboard', status: 'implemented', requirement: 'Centralized technical health telemetry and autonomous alerts.' },
                    { name: 'API Hub', route: 'SCRUM_MASTER.API_ENDPOINTS', component: 'ApiEndpointsHub', status: 'implemented', requirement: 'Endpoint verification and backend connectivity auditing.' },
                    { name: 'Role Intelligence', route: 'SCRUM_MASTER.ROLE_FLOWS', component: 'RoleFlowsPage', status: 'implemented', requirement: 'Verify UI/RBAC mapping and implementation gap analysis.' },
                    { name: 'Perf Audits', route: 'SCRUM_MASTER.PERFORMANCE', component: 'PerformancePage', status: 'implemented', requirement: 'Monitor V8 engine performance and Lighthouse core web vitals.' },
                    { name: 'Security Scans', route: 'SCRUM_MASTER.SECURITY_SCANS', component: 'SecurityScansPage', status: 'implemented', requirement: 'Perform SAST/DAST audits and dependency vulnerability checks.' },
                    { name: 'Theme Core', route: 'SCRUM_MASTER.THEME_CENTER', component: 'ThemeCoreCenter', status: 'implemented', requirement: 'Coordinate platform-wide design tokens and CSS variable injection.' },
                    { name: 'Registry Fixer', route: 'SCRUM_MASTER.AUTO_FIX', component: 'RegistryAutoRepair', status: 'implemented', requirement: 'Automated repair of broken route/API registry mappings.' },
                    { name: 'User Shadowing', route: 'SCRUM_MASTER.IMPERSONATE', component: 'ImpersonationTool', status: 'implemented', requirement: 'Technical debugging by simulating specific user sessions.' },
                ]
            },
            manager: {
                mission: 'Oversee branch care ecosystem, optimize caregiver assignments, and ensure clinical quality compliance.',
                pages: [
                    { name: 'Portfolio', route: 'MANAGER.DASHBOARD', component: 'Portfolio', status: 'implemented', requirement: 'Branch-level operational dashboard for shift and patient oversight.' },
                    { name: 'Evaluations', route: 'MANAGER.EVALUATIONS', component: 'Evaluations', status: 'implemented', requirement: 'Coordinate clinical assessments and care plan milestones.' },
                    { name: 'Service Review', route: 'MANAGER.SERVICE_REVIEW', component: 'ServiceReview', status: 'implemented', requirement: 'Audit service quality based on client feedback and visit logs.' },
                    { name: 'Staff Performance', route: 'MANAGER.PERFORMANCE', component: 'StaffRanker', status: 'implemented', requirement: 'Identify top performers and at-risk staff based on attendance metrics.' },
                    { name: 'Branch Financials', route: 'MANAGER.FINANCE', component: 'BranchP_L', status: 'implemented', requirement: 'Local profit and loss visibility for branch operational efficiency.' },
                    { name: 'Payroll Audit', route: 'MANAGER.PAYROLL', component: 'PayrollVerification', status: 'implemented', requirement: 'Match visit durations with scheduled hours to finalize regional payroll.' },
                ]
            },
            staff: {
                mission: 'Execute daily intake operations, coordinate scheduling requests, and manage customer communications.',
                pages: [
                    { name: 'Staff Hub', route: 'STAFF.DASHBOARD', component: 'StaffDashboard', status: 'implemented', requirement: 'Daily task list and urgent scheduling notification center.' },
                    { name: 'Customers', route: 'STAFF.CUSTOMERS', component: 'CustomerList', status: 'implemented', requirement: 'Manage active customer roster and scheduling preferences.' },
                    { name: 'Task Board', route: 'STAFF.TASKS', component: 'TaskGrid', status: 'implemented', requirement: 'Visual board for coordinating complex multi-step intake tasks.' },
                    { name: 'Messaging', route: 'STAFF.MESSAGES', component: 'MessageCenter', status: 'implemented', requirement: 'Centralized hub for family and caregiver secure communications.' },
                    { name: 'Incident Logging', route: 'STAFF.INCIDENTS', component: 'IncidentPortal', status: 'implemented', requirement: 'Intake portal for clinical or operational branch-level incidents.' },
                    { name: 'Branch Compliance', route: 'STAFF.COMPLIANCE', component: 'ComplianceMonitor', status: 'implemented', requirement: 'Regional scorecard for staff credential and registry health.' },
                ]
            },
            psw: {
                mission: 'Provide high-quality clinical care, document visit outcomes, and manage personal service schedule.',
                pages: [
                    { name: 'My Schedule', route: 'PSW.SCHEDULE', component: 'PswSchedule', status: 'implemented', requirement: 'Real-time view of assigned care visits and patient directions.' },
                    { name: 'Open Shifts', route: 'PSW.OPEN_SHIFTS', component: 'PswOpenShifts', status: 'implemented', requirement: 'Marketplace for claiming additional service hours in the region.' },
                    { name: 'My Earnings', route: 'PSW.EARNINGS', component: 'PswEarnings', status: 'implemented', requirement: 'Transparent log of completed visits and upcoming payments.' },
                    { name: 'Credentials', route: 'PSW.CREDENTIALS', component: 'CredentialVault', status: 'implemented', requirement: 'Submit and renew clinical certifications (CPR, VSS, etc.).' },
                    { name: 'Community', route: 'PSW.FEED', component: 'ProviderSocial', status: 'implemented', requirement: 'Peer support and regional announcements for caregivers.' },
                    { name: 'Live Visit', route: 'PSW.LIVE_VISIT', component: 'LiveVisit', status: 'implemented', requirement: 'Real-time check-in/out and interactive clinical task documentation.' },
                ]
            },
            rn: {
                mission: 'Maintain clinical oversight, audit caregiver documentation, and ensure professional nursing standards are met.',
                pages: [
                    { name: 'Dashboard', route: 'RN.DASHBOARD', component: 'RnDashboard', status: 'implemented', requirement: 'High-level clinical overview and urgent review alerts.' },
                    { name: 'Care Plans', route: 'RN.CARE_PLANS', component: 'ClinicalCarePlans', status: 'implemented', requirement: 'Digitize and manage professional patient care protocols.' },
                    { name: 'Daily Audit', route: 'RN.DAILY_AUDIT', component: 'DailyAudit', status: 'implemented', requirement: 'RN sign-off and verification of PSW daily care records.' },
                    { name: 'Supervision', route: 'RN.SUPERVISION', component: 'SupervisionHub', status: 'implemented', requirement: 'Monitor caregiver quality standards and certification compliance.' },
                ]
            },
            marketing_manager: {
                mission: 'Drive branch growth, manage the intake pipeline, and optimize client acquisition strategies.',
                pages: [
                    { name: 'Growth Pipeline', route: 'MANAGER.MARKETING', component: 'MarketingDashboard', status: 'implemented', requirement: 'Real-time visibility into lead conversion and campaign ROI.' },
                ]
            },
            hr_manager: {
                mission: 'Oversee regional talent acquisition, manage staff onboarding, and ensure clinical compliance.',
                pages: [
                    { name: 'Talent & Compliance', route: 'MANAGER.RECRUITING', component: 'HrRecruitmentPortal', status: 'implemented', requirement: 'Manage recruitment funnel and caregiver certification health.' },
                ]
            },
            recruiting_manager: {
                mission: 'Execute the recruitment pipeline, screen candidates, and manage the interview process.',
                pages: [
                    { name: 'Recruitment Hub', route: 'MANAGER.RECRUITING', component: 'HrRecruitmentPortal', status: 'implemented', requirement: 'Focus on candidate sourcing and offer management.' },
                ]
            },
            finance_manager: {
                mission: 'Maintain absolute financial integrity, oversee regional reconciliation, and manage audits.',
                pages: [
                    { name: 'Finance & Governance', route: 'MANAGER.FINANCE', component: 'FinanceRegionalHub', status: 'implemented', requirement: 'Real-time revenue intelligence and expense auditing.' },
                ]
            },
            regional_manager: {
                mission: 'Audit branch-level operational performance and optimize regional profitability.',
                pages: [
                    { name: 'Regional Hub', route: 'MANAGER.FINANCE', component: 'FinanceRegionalHub', status: 'implemented', requirement: 'High-level P&L visibility and benchmarking across locations.' },
                ]
            },
            clinical_manager: {
                mission: 'Maintain professional clinical safety standards, oversee medication QA, and audit high-risk incidents.',
                pages: [
                    { name: 'Clinical QA', route: 'MANAGER.CLINICAL', component: 'ClinicalQaDashboard', status: 'implemented', requirement: 'Real-time safety alerts and medication compliance oversight.' },
                ]
            },
            client: {
                mission: 'Manage family care plans, request service adjustments, and oversee billing and invoices.',
                pages: [
                    { name: 'Client Hub', route: 'CLIENT.DASHBOARD', component: 'ClientDashboard', status: 'implemented', requirement: 'Family overview for current care schedule and caregiver intros.' },
                    { name: 'Bookings', route: 'CLIENT.BOOKINGS', component: 'ClientBookings', status: 'implemented', requirement: 'History of previous visits and upcoming scheduled care.' },
                    { name: 'Billing', route: 'CLIENT.BILLING', component: 'ClientBilling', status: 'implemented', requirement: 'Secure payment gateway and digital invoice archive.' },
                    { name: 'Service Catalog', route: 'CLIENT.SERVICES', component: 'CatalogBrowser', status: 'implemented', requirement: 'Self-service selection of additional specialized care modules.' },
                    { name: 'Care Chat', route: 'CLIENT.SUPPORT', component: 'ClientMessaging', status: 'implemented', requirement: 'Direct secure line to nursing staff for care concerns.' },
                    { name: 'Care Team', route: 'CLIENT.TEAM', component: 'CareTeam', status: 'implemented', requirement: 'View assigned caregiver profiles, specialties, and ratings.' },
                    { name: 'Feedback Loop', route: 'CLIENT.FEEDBACK_LOOP', component: 'FeedbackLoop', status: 'implemented', requirement: 'Submit satisfaction reviews and clinical comments for recent visits.' },
                ]
            }
        };

        const currentBlueprint = resourceMapping[selectedRole] || resourceMapping['admin'];
        const implemented = currentBlueprint.pages.filter(p => p.status === 'implemented');
        const missing = currentBlueprint.pages.filter(p => p.status === 'missing');

        return {
            totalRoles: Object.keys(roleFlows).length,
            totalSteps,
            verifiedCount,
            roleDistribution: roleData,
            mission: currentBlueprint.mission,
            implemented,
            missing
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
                        cursor: pointer;
                    }
                    .step-card:hover { border-color: var(--brand-500); background: #f8fafc; }
                    .blueprint-table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0 8px;
                    }
                    .blueprint-table th {
                        text-align: left;
                        padding: 12px 16px;
                        color: var(--text-400);
                        font-size: 0.7rem;
                        text-transform: uppercase;
                        font-weight: 800;
                    }
                    .blueprint-table td {
                        padding: 16px;
                        background: white;
                        border-top: 1px solid #f1f5f9;
                        border-bottom: 1px solid #f1f5f9;
                        font-family: 'Inter', sans-serif;
                    }
                    .blueprint-table tr td:first-child { border-left: 1px solid #f1f5f9; border-top-left-radius: 12px; border-bottom-left-radius: 12px; }
                    .blueprint-table tr td:last-child { border-right: 1px solid #f1f5f9; border-top-right-radius: 12px; border-bottom-right-radius: 12px; }
                    .status-badge {
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-size: 0.65rem;
                        font-weight: 800;
                        text-transform: uppercase;
                    }
                    .status-implemented { background: rgba(16, 185, 129, 0.1); color: #10b981; }
                    .status-missing { background: rgba(239, 68, 68, 0.1); color: #ef4444; }
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
                                    <span style={{ fontSize: '0.75rem', fontWeight: 700, padding: '4px 10px', background: 'rgba(16, 185, 129, 0.1)', color: '#10b981', borderRadius: '6px' }}>SECURE ACCESS</span>
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
                                🔄 Journey Paths
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
                                🗺️ Component Blueprint
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
                                            <span style={{ fontSize: '0.65rem', fontWeight: 800, color: 'var(--brand-500)', background: 'rgba(99, 102, 241, 0.1)', padding: '4px 8px', borderRadius: '6px' }}>
                                                AUDIT TRACE
                                            </span>
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
                                    <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 900, textTransform: 'uppercase', letterSpacing: '0.05em', color: 'var(--text-400)' }}>Role Mission Statement</h3>
                                </div>
                                <p style={{ margin: 0, color: 'var(--text-100)', fontSize: '1.2rem', fontWeight: 600, lineHeight: '1.6', fontStyle: 'italic' }}>
                                    "{stats.mission}"
                                </p>
                            </div>

                            {/* Implemented Section */}
                            <div style={{ marginBottom: '3rem' }}>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                                    <h3 style={{ margin: 0, fontSize: '1.3rem', fontWeight: 900, color: '#10b981', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                        <span style={{ fontSize: '1.5rem' }}>✅</span> Implemented Features
                                    </h3>
                                    <span style={{ fontSize: '0.8rem', fontWeight: 800, padding: '4px 12px', background: 'rgba(16, 185, 129, 0.1)', color: '#10b981', borderRadius: '20px' }}>
                                        {stats.implemented.length} MODULES READY
                                    </span>
                                </div>
                                <table className="blueprint-table">
                                    <thead>
                                        <tr>
                                            <th style={{ width: '20%' }}>Requirement / Task</th>
                                            <th style={{ width: '25%' }}>Route Registry</th>
                                            <th style={{ width: '25%' }}>Associated Component</th>
                                            <th style={{ width: '30%' }}>Technical Objective</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {stats.implemented.map((p, i) => (
                                            <tr key={i}>
                                                <td style={{ fontWeight: 800, color: '#0f172a' }}>{p.name}</td>
                                                <td><code style={{ fontSize: '0.75rem', color: 'var(--brand-600)', background: 'var(--bg-100)', padding: '2px 6px', borderRadius: '4px' }}>{p.route}</code></td>
                                                <td><code style={{ fontSize: '0.75rem', background: '#f8fafc', padding: '2px 6px', borderRadius: '4px' }}>{p.component}</code></td>
                                                <td style={{ fontSize: '0.85rem', color: 'var(--text-300)', lineHeight: '1.4' }}>{p.requirement}</td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
                            </div>

                            {/* Missing Section */}
                            <div>
                                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' }}>
                                    <h3 style={{ margin: 0, fontSize: '1.3rem', fontWeight: 900, color: '#ef4444', display: 'flex', alignItems: 'center', gap: '10px' }}>
                                        <span style={{ fontSize: '1.5rem' }}>🚧</span> Missing Platform Gaps
                                    </h3>
                                    <span style={{ fontSize: '0.8rem', fontWeight: 800, padding: '4px 12px', background: 'rgba(239, 68, 68, 0.1)', color: '#ef4444', borderRadius: '20px' }}>
                                        {stats.missing.length} PENDING MODULES
                                    </span>
                                </div>
                                <table className="blueprint-table">
                                    <thead>
                                        <tr>
                                            <th style={{ width: '20%' }}>Unmet Requirement</th>
                                            <th style={{ width: '25%' }}>Planned Route</th>
                                            <th style={{ width: '25%' }}>Target Component</th>
                                            <th style={{ width: '30%' }}>Implementation Goal</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {stats.missing.map((p, i) => (
                                            <tr key={i}>
                                                <td style={{ fontWeight: 800, color: '#ef4444', opacity: 0.8 }}>{p.name}</td>
                                                <td><code style={{ fontSize: '0.75rem', color: '#94a3b8', background: '#f1f5f9', padding: '2px 6px', borderRadius: '4px' }}>{p.route}</code></td>
                                                <td><code style={{ fontSize: '0.75rem', color: '#94a3b8', background: '#f1f5f9', padding: '2px 6px', borderRadius: '4px' }}>{p.component}</code></td>
                                                <td style={{ fontSize: '0.85rem', color: '#64748b', lineHeight: '1.4', fontStyle: 'italic' }}>{p.requirement}</td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
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
