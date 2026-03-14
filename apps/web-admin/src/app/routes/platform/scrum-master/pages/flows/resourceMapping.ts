// Resource mapping — role infrastructure blueprint with page/component references

export interface BlueprintPage {
    name: string;
    route: string;
    component: string;
    status: 'implemented' | 'missing';
    requirement: string;
}

export interface RoleBlueprint {
    mission: string;
    pages: BlueprintPage[];
}

export const resourceMapping: Record<string, RoleBlueprint> = {
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
            { name: 'User Shadowing', route: 'SCRUM_MASTER.IMPERSONATE', component: 'ImpersonationTool', status: 'implemented', requirement: 'Technical debugging by impersonating specific user sessions.' },
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
