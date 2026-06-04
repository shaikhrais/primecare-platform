# 📋 PrimeCare Platform Screen-by-Screen Component & Purpose Guide

This guide provides an exhaustive list of screens across the 10 PrimeCare applications. For each screen, it documents the number of child UI components detected and explains the operational purpose it serves.

## 📦 Application: `primecare_auth` (1 Screens)

### 🖥️ Screen: `SuccessProfileView`
- **Detected UI Components**: 13
- **Purpose**: Confirms user identity, active SSO session token, and provides logout functionality.
- **Key Sub-Components**: `Divider`, `Provider: authProvider`, `Provider: sharedPreferencesProvider`, `LucideIcons.xCircle`, `LucideIcons.shieldCheck`, `Column`, `Row`, `LucideIcons.logOut`

---

## 📦 Application: `primecare_governance` (59 Screens)

### 🖥️ Screen: `app_database`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `governance_database`
- **Detected UI Components**: 1
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Column`

### 🖥️ Screen: `governance_provider`
- **Detected UI Components**: 4
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: governanceRemediationEngineProvider`, `Provider: governanceApiServiceProvider`, `Provider: governanceHistoryServiceProvider`, `Icons.auto_awesome_outlined`

### 🖥️ Screen: `role_impersonation_provider`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `screen_work_item`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: screenWorkItemControllerProvider`

### 🖥️ Screen: `screen_work_registry`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: screenWorkRegistryControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `language_provider`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `audit_interceptor`
- **Detected UI Components**: 0
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.

### 🖥️ Screen: `logging_interceptor`
- **Detected UI Components**: 0
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.

### 🖥️ Screen: `performance_interceptor`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `governance_application`
- **Detected UI Components**: 30
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `LucideIcons.listChecks`, `LucideIcons.home`, `LucideIcons.filePieChart`, `LucideIcons.clipboardList`, `LucideIcons.clock`, `LucideIcons.library`, `LucideIcons.shieldAlert`, `LucideIcons.messageSquare`

### 🖥️ Screen: `app_database`
- **Detected UI Components**: 1
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Column`

### 🖥️ Screen: `app_components`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `TextField`, `DataTable`, `Column`, `CircularProgressIndicator`, `SingleChildScrollView`

### 🖥️ Screen: `app_drawer`
- **Detected UI Components**: 23
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Divider`, `Icons.circle_outlined`, `Row`, `Icons.folder_open_outlined`, `Icons.theater_comedy_outlined`, `Icons.logout_outlined`, `Icons.person_search_outlined`, `Icons.person_outline`

### 🖥️ Screen: `app_skeleton`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Row`, `Column`, `ListView`

### 🖥️ Screen: `dev_toolbox`
- **Detected UI Components**: 8
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Divider`, `ElevatedButton`, `Icons.analytics_outlined`, `Icons.logout`, `Column`, `Row`, `Card`, `TextButton`

### 🖥️ Screen: `dynamic_form_builder`
- **Detected UI Components**: 4
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Column`, `Row`, `Icons.email`, `Icons.calendar_today`

### 🖥️ Screen: `DynamicScreenView`
- **Detected UI Components**: 45
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `LucideIcons.layout`, `LucideIcons.fileSearch`, `LucideIcons.layoutPanelLeft`, `LucideIcons.code`, `Divider`, `LucideIcons.cpu`, `LucideIcons.heartPulse`, `Row`

### 🖥️ Screen: `language_selector`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.language`, `Row`, `Provider: languageProvider`

### 🖥️ Screen: `NoAccessScreen`
- **Detected UI Components**: 4
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Column`, `Icons.lock_person_outlined`, `Icons.error_outline`, `ElevatedButton`

### 🖥️ Screen: `AuditLogScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: auditLogScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `MonitoringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: monitoringScreenControllerProvider`

### 🖥️ Screen: `ScreenStatusScreen`
- **Detected UI Components**: 26
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `LucideIcons.cpu`, `LucideIcons.mousePointerClick`, `Provider: languageSimulationProvider`, `Row`, `LucideIcons.shieldAlert`, `LucideIcons.chevronRight`, `Provider: screenSearchQueryProvider`, `Provider: localDeploymentsProvider`

### 🖥️ Screen: `TicketCenterScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ticketCenterScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ControlCenterScreen`
- **Detected UI Components**: 25
- **Purpose**: Main operational workspace for the ControlCenterScreen role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Divider`, `Icons.check_circle_outline`, `LucideIcons.terminal`, `ElevatedButton`, `Row`, `SingleChildScrollView`, `LucideIcons.list`, `LucideIcons.chevronRight`

### 🖥️ Screen: `GovernanceHudScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: governanceHudScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `GrowthPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: growthPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LeadershipReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: leadershipReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: proposalsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: regionalPerformanceScreenControllerProvider`

### 🖥️ Screen: `UnknownDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Unknown role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: unknownDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AuditDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Audit role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: auditDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceReviewsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Provider: complianceReviewsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IncidentReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: incidentReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityMetricsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityMetricsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClinicalReferenceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: clinicalReferenceScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SecurityHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Security role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: securityHubScreenControllerProvider`

### 🖥️ Screen: `SecuritySentinelScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: securitySentinelScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `VerificationCenterScreen`
- **Detected UI Components**: 22
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `LucideIcons.terminal`, `ElevatedButton`, `LucideIcons.x`, `Row`, `LucideIcons.alertOctagon`, `SingleChildScrollView`, `LucideIcons.tablet`, `LucideIcons.shieldCheck`

### 🖥️ Screen: `app_entry_form`
- **Detected UI Components**: 9
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `ElevatedButton`, `Icons.computer`, `Column`, `Icons.language`, `Icons.apple`, `TextFormField`, `Icons.window`, `Icons.android`

### 🖥️ Screen: `deployment_readiness_model`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `correction_ticket_model`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `ast_patch_engine`
- **Detected UI Components**: 0
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.

### 🖥️ Screen: `cross_subsystem_auditor`
- **Detected UI Components**: 0
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.

### 🖥️ Screen: `governance_compliance_checklist`
- **Detected UI Components**: 4
- **Purpose**: Guides caregivers through visit checklist compliance and captures session case notes.
- **Key Sub-Components**: `Icons.warning_amber_rounded`, `Column`, `Row`, `Icons.check_circle_rounded`

### 🖥️ Screen: `governance_dashboard`
- **Detected UI Components**: 14
- **Purpose**: Main operational workspace for the governance_dashboard role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `TextField`, `ElevatedButton`, `OutlinedButton`, `Icons.refresh_rounded`, `Icons.download_rounded`, `Icons.search`, `Icons.security`, `Column`

### 🖥️ Screen: `governance_domain_chart`
- **Detected UI Components**: 1
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Column`

### 🖥️ Screen: `governance_event_feed`
- **Detected UI Components**: 11
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Divider`, `Icons.speed_rounded`, `ListView`, `Icons.analytics_rounded`, `Icons.cloud_upload_rounded`, `Column`, `Row`, `Icons.info_outline_rounded`

### 🖥️ Screen: `governance_filter_bar`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.clear_all_rounded`, `Row`, `Icons.filter_list_rounded`, `Icons.arrow_drop_down`, `TextButton`

### 🖥️ Screen: `governance_issue_table`
- **Detected UI Components**: 9
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: platformEnvServiceProvider`, `IconButton`, `DataTable`, `Icons.build`, `Column`, `Row`, `Icons.code`, `SingleChildScrollView`

### 🖥️ Screen: `governance_kpi_grid`
- **Detected UI Components**: 10
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline_rounded`, `Icons.speed_rounded`, `Icons.accessibility_new_rounded`, `Icons.fact_check_rounded`, `Icons.bug_report_rounded`, `Row`, `Column`, `Icons.layers_rounded`

### 🖥️ Screen: `governance_master_score`
- **Detected UI Components**: 2
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `CircularProgressIndicator`, `Column`

### 🖥️ Screen: `governance_patch_manager`
- **Detected UI Components**: 6
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `ElevatedButton`, `Column`, `Row`, `Icons.build_circle`, `SingleChildScrollView`, `Icons.copy`

### 🖥️ Screen: `governance_role_viewer`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: governanceRoleViewerControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `governance_trend_chart`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.trending_up`, `Icons.analytics_outlined`, `Column`, `Row`, `Icons.trending_down`

### 🖥️ Screen: `network_parity_audit_table`
- **Detected UI Components**: 8
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `IconButton`, `DataTable`, `Icons.auto_fix_high`, `Icons.build`, `Column`, `SingleChildScrollView`, `Provider: governanceProvider`

### 🖥️ Screen: `platform_discovery_viewer`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: platformDiscoveryViewerControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `platform_readiness_viewer`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: platformReadinessViewerControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 1
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: appRouterProvider`

---

## 📦 Application: `primecare_corporate` (263 Screens)

### 🖥️ Screen: `corporate_routes`
- **Detected UI Components**: 1
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `Icons.admin_panel_settings`

### 🖥️ Screen: `HeadOfBusDevDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfBusDev role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: headOfBusDevDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoAlertsAndRisksScreen`
- **Detected UI Components**: 5
- **Purpose**: Lists system notifications, policy warnings, and critical operational events.
- **Key Sub-Components**: `Provider: ceoAlertsAndRisksScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoApprovalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ceoApprovalsScreenControllerProvider`

### 🖥️ Screen: `CeoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ceo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoEnterpriseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoEnterpriseOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoFranchiseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: ceoFranchiseOverviewScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoGrowthPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoGrowthPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoLeadershipReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoLeadershipReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoOrganizationMapScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoOrganizationMapScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRegionPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoRegionPerformanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRevenueSummaryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoRevenueSummaryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoStrategicKpisScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoStrategicKpisScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsPayableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsPayableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsReceivableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsReceivableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cfo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoExpensesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoExpensesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFinancialOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFinancialOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFranchiseFinancialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFranchiseFinancialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoInvoicesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoPayrollScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages payroll schedules, staff timesheet approvals, and payment disbursement logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: cfoPayrollScreenControllerProvider`

### 🖥️ Screen: `CfoProfitabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cfoProfitabilityScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CfoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoRevenueScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoRevenueScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoTaxAndRemittanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks government tax liabilities, HST/GST compliance calculations, and remittances.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoTaxAndRemittanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CisoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ciso role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cisoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AuditsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: auditsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceCasesScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceCasesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ComplianceManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CorrectiveActionsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: correctiveActionsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CredentialTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Provider: credentialTrackingScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `DocumentExpiryScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: documentExpiryScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IncidentReviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `Provider: incidentReviewScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PoliciesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: policiesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RiskRegisterScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: riskRegisterScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingComplianceScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `CircularProgressIndicator`, `Column`, `Provider: cooBranchComparisonScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooBranchOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooBranchOperationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooComplianceViewScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cooComplianceViewScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Coo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooIssueEscalationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooIssueEscalationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooOperationsOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooOperationsOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cooReportsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooSchedulingHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooSchedulingHealthScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooServiceDeliveryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooServiceDeliveryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooStaffingEfficiencyScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooStaffingEfficiencyScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooWorkflowPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooWorkflowPerformanceScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoAlertsAndRisksScreen`
- **Detected UI Components**: 5
- **Purpose**: Lists system notifications, policy warnings, and critical operational events.
- **Key Sub-Components**: `Provider: ceoAlertsAndRisksScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoApprovalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ceoApprovalsScreenControllerProvider`

### 🖥️ Screen: `CeoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ceo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoEnterpriseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoEnterpriseOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoFranchiseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: ceoFranchiseOverviewScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoGrowthPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoGrowthPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoLeadershipReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoLeadershipReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoOrganizationMapScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoOrganizationMapScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRegionPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoRegionPerformanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRevenueSummaryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoRevenueSummaryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoStrategicKpisScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoStrategicKpisScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsPayableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsPayableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsReceivableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsReceivableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cfo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoExpensesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoExpensesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFinancialOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFinancialOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFranchiseFinancialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFranchiseFinancialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoInvoicesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoPayrollScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages payroll schedules, staff timesheet approvals, and payment disbursement logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: cfoPayrollScreenControllerProvider`

### 🖥️ Screen: `CfoProfitabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cfoProfitabilityScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CfoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoRevenueScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoRevenueScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoTaxAndRemittanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks government tax liabilities, HST/GST compliance calculations, and remittances.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoTaxAndRemittanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CisoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ciso role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cisoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerAuditsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerAuditsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerComplianceCasesScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerComplianceCasesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerCorrectiveActionsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerCorrectiveActionsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerCredentialTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerCredentialTrackingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ComplianceManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerDocumentExpiryScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: complianceManagerDocumentExpiryScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ComplianceManagerIncidentReviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: complianceManagerIncidentReviewScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ComplianceManagerPoliciesScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerPoliciesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerRiskRegisterScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerRiskRegisterScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerTrainingComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Provider: complianceManagerTrainingComplianceScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `CircularProgressIndicator`, `Column`, `Provider: cooBranchComparisonScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooBranchOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooBranchOperationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooComplianceViewScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cooComplianceViewScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Coo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooIssueEscalationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooIssueEscalationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooOperationsOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooOperationsOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cooReportsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooSchedulingHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooSchedulingHealthScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooServiceDeliveryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooServiceDeliveryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooStaffingEfficiencyScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooStaffingEfficiencyScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooWorkflowPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooWorkflowPerformanceScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoAccessControlScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoAccessControlScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoApiMonitoringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoApiMonitoringScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoAuditLogsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoAuditLogsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cto role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoFeatureAdoptionScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoFeatureAdoptionScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoInfrastructureScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoInfrastructureScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIntegrationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoIntegrationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIssueTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoIssueTrackingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoPlatformUsageScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoPlatformUsageScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReleaseManagementScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReleaseManagementScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoSystemHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ctoSystemHealthScreenControllerProvider`

### 🖥️ Screen: `CtoSystemVerificationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoSystemVerificationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoVerificationHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CtoVerification role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoVerificationHubScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CxDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CxDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cxDirectorDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorCashflowScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides AI-driven cash flow forecasting models and historical trend analytics.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorCashflowScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FinanceDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfBusDevDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfBusDev role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: headOfBusDevDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfMarketing role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: headOfMarketingDashboardScreenControllerProvider`

### 🖥️ Screen: `HrDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ItAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ItAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: itAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LegalDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Legal role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: legalDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Owner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ownerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ShareholderDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Shareholder role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: shareholderDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorAnalyticsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorAnalyticsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorAssessmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Conducts care intake assessments, health checks, and records clinical conditions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorAssessmentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCertificatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorCertificatesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCertificationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorCertificationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorComplianceTrainingScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorComplianceTrainingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCourseArchitectScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorCourseArchitectScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCourseLibraryScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorCourseLibraryScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorHubScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Provider: trainingDirectorReportsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorStaffTrainingMatrixScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorStaffTrainingMatrixScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorTrainerAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorTrainerAssignmentsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorTrainingProgramsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorTrainingProgramsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `VolunteerCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the VolunteerCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: volunteerCoordinatorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CtoAccessControlScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoAccessControlScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoApiMonitoringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoApiMonitoringScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoAuditLogsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoAuditLogsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cto role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoFeatureAdoptionScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoFeatureAdoptionScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoInfrastructureScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoInfrastructureScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIntegrationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoIntegrationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIssueTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoIssueTrackingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoPlatformUsageScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoPlatformUsageScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReleaseManagementScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReleaseManagementScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoSystemHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ctoSystemHealthScreenControllerProvider`

### 🖥️ Screen: `CtoSystemVerificationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoSystemVerificationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoVerificationHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CtoVerification role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoVerificationHubScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CxDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CxDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cxDirectorDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorCashflowScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides AI-driven cash flow forecasting models and historical trend analytics.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorCashflowScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FinanceDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoAlertsAndRisksScreen`
- **Detected UI Components**: 5
- **Purpose**: Lists system notifications, policy warnings, and critical operational events.
- **Key Sub-Components**: `Provider: ceoAlertsAndRisksScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoApprovalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ceoApprovalsScreenControllerProvider`

### 🖥️ Screen: `CeoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ceo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoEnterpriseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoEnterpriseOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoFranchiseOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: ceoFranchiseOverviewScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoGrowthPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoGrowthPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoLeadershipReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoLeadershipReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoOrganizationMapScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoOrganizationMapScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRegionPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoRegionPerformanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoRevenueSummaryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ceoRevenueSummaryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CeoStrategicKpisScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ceoStrategicKpisScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsPayableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsPayableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoAccountsReceivableScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoAccountsReceivableScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cfo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoExpensesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoExpensesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFinancialOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFinancialOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoFranchiseFinancialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoFranchiseFinancialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoInvoicesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoPayrollScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages payroll schedules, staff timesheet approvals, and payment disbursement logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: cfoPayrollScreenControllerProvider`

### 🖥️ Screen: `CfoProfitabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cfoProfitabilityScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CfoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoRevenueScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cfoRevenueScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CfoTaxAndRemittanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks government tax liabilities, HST/GST compliance calculations, and remittances.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cfoTaxAndRemittanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CisoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Ciso role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cisoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerAuditsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerAuditsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerComplianceCasesScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerComplianceCasesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerCorrectiveActionsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerCorrectiveActionsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerCredentialTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerCredentialTrackingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ComplianceManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerDocumentExpiryScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: complianceManagerDocumentExpiryScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ComplianceManagerIncidentReviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: complianceManagerIncidentReviewScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ComplianceManagerPoliciesScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerPoliciesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: complianceManagerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerRiskRegisterScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceManagerRiskRegisterScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceManagerTrainingComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Provider: complianceManagerTrainingComplianceScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `CircularProgressIndicator`, `Column`, `Provider: cooBranchComparisonScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooBranchOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooBranchOperationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooComplianceViewScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cooComplianceViewScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Coo role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooIssueEscalationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: cooIssueEscalationsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooOperationsOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooOperationsOverviewScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: cooReportsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CooSchedulingHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooSchedulingHealthScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooServiceDeliveryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooServiceDeliveryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooStaffingEfficiencyScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooStaffingEfficiencyScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CooWorkflowPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: cooWorkflowPerformanceScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoAccessControlScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoAccessControlScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoApiMonitoringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoApiMonitoringScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoAuditLogsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoAuditLogsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Cto role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoFeatureAdoptionScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoFeatureAdoptionScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoInfrastructureScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoInfrastructureScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIntegrationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoIntegrationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoIssueTrackingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoIssueTrackingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoPlatformUsageScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoPlatformUsageScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReleaseManagementScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReleaseManagementScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoSystemHealthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: ctoSystemHealthScreenControllerProvider`

### 🖥️ Screen: `CtoSystemVerificationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ctoSystemVerificationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CtoVerificationHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CtoVerification role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: ctoVerificationHubScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CxDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CxDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: cxDirectorDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorCashflowScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides AI-driven cash flow forecasting models and historical trend analytics.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorCashflowScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FinanceDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FinanceDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: financeDirectorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfBusDevDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfBusDev role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: headOfBusDevDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfMarketing role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: headOfMarketingDashboardScreenControllerProvider`

### 🖥️ Screen: `HrDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ItAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ItAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: itAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LegalDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Legal role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: legalDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Owner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ownerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ShareholderDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Shareholder role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: shareholderDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorAnalyticsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorAnalyticsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorAssessmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Conducts care intake assessments, health checks, and records clinical conditions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorAssessmentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCertificatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorCertificatesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCertificationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorCertificationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorComplianceTrainingScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorComplianceTrainingScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCourseArchitectScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorCourseArchitectScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorCourseLibraryScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorCourseLibraryScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingDirectorHubScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Provider: trainingDirectorReportsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorStaffTrainingMatrixScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingDirectorStaffTrainingMatrixScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorTrainerAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorTrainerAssignmentsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingDirectorTrainingProgramsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorTrainingProgramsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `VolunteerCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the VolunteerCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: volunteerCoordinatorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `HrDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: hrManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ItAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ItAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: itAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LegalDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Legal role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: legalDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HeadOfMarketing role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: headOfMarketingDashboardScreenControllerProvider`

### 🖥️ Screen: `OwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Owner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: ownerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ShareholderDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Shareholder role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: shareholderDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `AssessmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Conducts care intake assessments, health checks, and records clinical conditions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: assessmentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CertificatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Provider: certificatesScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CertificationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: certificationsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ComplianceTrainingScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: complianceTrainingScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CourseArchitectScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: courseArchitectScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CourseLibraryScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: courseLibraryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `StaffTrainingMatrixScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: staffTrainingMatrixScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainerAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainerAssignmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingAnalyticsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingAnalyticsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: trainingDirectorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `TrainingHubScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Training role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingHubScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingProgramsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingProgramsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Provider: trainingReportsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `VolunteerCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the VolunteerCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: volunteerCoordinatorDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 2
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`

---

## 📦 Application: `primecare_franchise` (162 Screens)

### 🖥️ Screen: `franchise_routes`
- **Detected UI Components**: 1
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `LucideIcons.building`

### 🖥️ Screen: `AdminClaimsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminClaimsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Admin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminInvoicesScreenControllerProvider`

### 🖥️ Screen: `AdminOutstandingBalancesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminOutstandingBalancesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminPaymentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Processes client billing payments, card configurations, and transaction logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminPaymentsScreenControllerProvider`

### 🖥️ Screen: `AdminReconciliationScreen`
- **Detected UI Components**: 5
- **Purpose**: Matches system invoice receipts with bank records using automated fuzzy matching.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminReconciliationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminRefundsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminRefundsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: adminReportsScreenControllerProvider`

### 🖥️ Screen: `BillingAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the BillingAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `BillingAdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminInvoicesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminClaimsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminClaimsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Admin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminInvoicesScreenControllerProvider`

### 🖥️ Screen: `AdminOutstandingBalancesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminOutstandingBalancesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminPaymentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Processes client billing payments, card configurations, and transaction logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminPaymentsScreenControllerProvider`

### 🖥️ Screen: `AdminReconciliationScreen`
- **Detected UI Components**: 5
- **Purpose**: Matches system invoice receipts with bank records using automated fuzzy matching.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminReconciliationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminRefundsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminRefundsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: adminReportsScreenControllerProvider`

### 🖥️ Screen: `BillingAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the BillingAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `BillingAdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminInvoicesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerAppointmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerAppointmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerBranchOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerBranchOverviewScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerClientsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerClientsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerComplianceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseOwner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerFinancialSnapshotScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerFinancialSnapshotScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerHiringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerHiringScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerStaffScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerStaffScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringApplicantsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringApplicantsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringCredentialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringCredentialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringInterviewsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringInterviewsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOffersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringOffersScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOnboardingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringOnboardingScreenControllerProvider`

### 🖥️ Screen: `HrHiringReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringReportsScreenControllerProvider`

### 🖥️ Screen: `HrHiringStaffDocumentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringStaffDocumentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringTrainingStatusScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringTrainingStatusScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `MarketingManagerCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: marketingManagerCampaignsScreenControllerProvider`

### 🖥️ Screen: `MarketingManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the MarketingManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: marketingManagerDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerAttendanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerAttendanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDailyOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerDailyOperationsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the OperationsManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: operationsManagerDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerIssuesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerIssuesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerReportsScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerScheduleScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerServiceQualityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerServiceQualityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerStaffCoordinationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerStaffCoordinationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerBranchComparisonScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAppointmentCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorAppointmentCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: schedulerCoordinatorAssignmentsScreenControllerProvider`

### 🖥️ Screen: `SchedulerCoordinatorBookingRequestsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorBookingRequestsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorConflictsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorConflictsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorOpenShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorOpenShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorProviderAvailabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorProviderAvailabilityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorShiftCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorShiftCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Scheduler role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminClaimsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminClaimsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Admin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminInvoicesScreenControllerProvider`

### 🖥️ Screen: `AdminOutstandingBalancesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: adminOutstandingBalancesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminPaymentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Processes client billing payments, card configurations, and transaction logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: adminPaymentsScreenControllerProvider`

### 🖥️ Screen: `AdminReconciliationScreen`
- **Detected UI Components**: 5
- **Purpose**: Matches system invoice receipts with bank records using automated fuzzy matching.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminReconciliationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminRefundsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: adminRefundsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `AdminReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: adminReportsScreenControllerProvider`

### 🖥️ Screen: `BillingAdminDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the BillingAdmin role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `BillingAdminInvoicesScreen`
- **Detected UI Components**: 5
- **Purpose**: Enables invoice creation, processing status tracking, and line item billing reviews.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: billingAdminInvoicesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerAppointmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerAppointmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerBranchOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerBranchOverviewScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerClientsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerClientsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerComplianceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseOwner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerFinancialSnapshotScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerFinancialSnapshotScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerHiringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerHiringScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerStaffScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerStaffScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerContractsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerContractsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseSalesManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: franchiseSalesManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDiscoveryCallsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerDiscoveryCallsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerFollowUpsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerFollowUpsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerLeadsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerProposalsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProspectsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerProspectsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerSalesPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerSalesPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringApplicantsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringApplicantsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringCredentialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringCredentialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringInterviewsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringInterviewsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOffersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringOffersScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOnboardingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringOnboardingScreenControllerProvider`

### 🖥️ Screen: `HrHiringReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringReportsScreenControllerProvider`

### 🖥️ Screen: `HrHiringStaffDocumentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringStaffDocumentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringTrainingStatusScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringTrainingStatusScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `MarketingManagerCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: marketingManagerCampaignsScreenControllerProvider`

### 🖥️ Screen: `MarketingManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the MarketingManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: marketingManagerDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerAttendanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerAttendanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDailyOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerDailyOperationsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the OperationsManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: operationsManagerDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerIssuesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerIssuesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerReportsScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerScheduleScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerServiceQualityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerServiceQualityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerStaffCoordinationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerStaffCoordinationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmFranchisePipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmFranchisePipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerBranchComparisonScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAppointmentCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorAppointmentCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: schedulerCoordinatorAssignmentsScreenControllerProvider`

### 🖥️ Screen: `SchedulerCoordinatorBookingRequestsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorBookingRequestsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorConflictsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorConflictsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorOpenShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorOpenShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorProviderAvailabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorProviderAvailabilityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorShiftCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorShiftCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Scheduler role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringApplicantsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringApplicantsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringCredentialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringCredentialsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HrHiring role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringInterviewsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringInterviewsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOffersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: hrHiringOffersScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringOnboardingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringOnboardingScreenControllerProvider`

### 🖥️ Screen: `HrHiringReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: hrHiringReportsScreenControllerProvider`

### 🖥️ Screen: `HrHiringStaffDocumentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringStaffDocumentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HrHiringTrainingStatusScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: hrHiringTrainingStatusScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `MarketingManagerCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: marketingManagerCampaignsScreenControllerProvider`

### 🖥️ Screen: `MarketingManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the MarketingManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: marketingManagerDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerAttendanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerAttendanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDailyOperationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerDailyOperationsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the OperationsManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: operationsManagerDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerIssuesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: operationsManagerIssuesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerReportsScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: operationsManagerScheduleScreenControllerProvider`

### 🖥️ Screen: `OperationsManagerServiceQualityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerServiceQualityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `OperationsManagerStaffCoordinationScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: operationsManagerStaffCoordinationScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerAppointmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerAppointmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerBranchOverviewScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerBranchOverviewScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerClientsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerClientsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerComplianceScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerComplianceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseOwner role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerFinancialSnapshotScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: franchiseOwnerFinancialSnapshotScreenControllerProvider`

### 🖥️ Screen: `FranchiseOwnerHiringScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerHiringScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseOwnerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseOwnerStaffScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseOwnerStaffScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerBranchComparisonScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerBranchComparisonScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Scheduler role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAppointmentCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorAppointmentCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorAssignmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `AppBar`, `Column`, `CircularProgressIndicator`, `Provider: schedulerCoordinatorAssignmentsScreenControllerProvider`

### 🖥️ Screen: `SchedulerCoordinatorBookingRequestsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorBookingRequestsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorConflictsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorConflictsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorOpenShiftsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorOpenShiftsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorProviderAvailabilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorProviderAvailabilityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: schedulerCoordinatorReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `SchedulerCoordinatorShiftCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: schedulerCoordinatorShiftCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`, `Provider: executionGateProvider`

---

## 📦 Application: `primecare_clinic` (39 Screens)

### 🖥️ Screen: `clinic_routes`
- **Detected UI Components**: 26
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `LucideIcons.heartPulse`, `LucideIcons.terminal`, `LucideIcons.calendarDays`, `LucideIcons.home`, `LucideIcons.clipboardList`, `LucideIcons.fileBarChart`, `LucideIcons.clock`, `LucideIcons.mapPin`

### 🖥️ Screen: `CaregiverDashboardScreen`
- **Detected UI Components**: 6
- **Purpose**: Main operational workspace for the Caregiver role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `LucideIcons.activity`, `LucideIcons.shieldCheck`, `AppBar`, `Column`, `Row`, `SingleChildScrollView`

### 🖥️ Screen: `ChiropractorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Chiropractor role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: chiropractorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClinicalDirectorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ClinicalDirector role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: clinicalDirectorDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClinicalDirectorQualityMetricsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: clinicalDirectorQualityMetricsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClinicalDirectorStaffingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: clinicalDirectorStaffingScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `InfectionControlDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the InfectionControl role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: infectionControlDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorAssessmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Conducts care intake assessments, health checks, and records clinical conditions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: intakeCoordinatorAssessmentsScreenControllerProvider`

### 🖥️ Screen: `IntakeCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the IntakeCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: intakeCoordinatorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorReferralsScreen`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `SingleChildScrollView`, `Column`, `AppBar`

### 🖥️ Screen: `NurseDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Nurse role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: nurseDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PhysicianDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Physician role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: physicianDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PhysiotherapistDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Physiotherapist role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: physiotherapistDashboardScreenControllerProvider`

### 🖥️ Screen: `PswCheckInScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: pswCheckInScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Psw role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: pswDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswDocumentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: pswDocumentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswHelpSupportScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: pswHelpSupportScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswIncidentReportScreen`
- **Detected UI Components**: 3
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `SingleChildScrollView`, `Column`, `AppBar`

### 🖥️ Screen: `PswMessagesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides real-time secure communication channels between staff and clients.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: pswMessagesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswNotificationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Lists system notifications, policy warnings, and critical operational events.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: pswNotificationsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswObservationVitalsLogScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs vital signs (blood pressure, temperature, heart rate) and care team observations.
- **Key Sub-Components**: `Provider: pswObservationVitalsLogScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswPatientProfileScreen`
- **Detected UI Components**: 3
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `SingleChildScrollView`, `Column`, `AppBar`

### 🖥️ Screen: `PswProfileScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: pswProfileScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: pswReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswScheduleScreen`
- **Detected UI Components**: 3
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `SingleChildScrollView`, `Column`, `AppBar`

### 🖥️ Screen: `PswSystemLogsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: pswSystemLogsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PswVisitChecklistScreen`
- **Detected UI Components**: 5
- **Purpose**: Guides caregivers through visit checklist compliance and captures session case notes.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: pswVisitChecklistScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PswVisitNotesScreen`
- **Detected UI Components**: 5
- **Purpose**: Guides caregivers through visit checklist compliance and captures session case notes.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: pswVisitNotesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RmtDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Rmt role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: rmtDashboardScreenControllerProvider`

### 🖥️ Screen: `RnDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Rn role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: rnDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RpnDashboardScreen`
- **Detected UI Components**: 6
- **Purpose**: Main operational workspace for the Rpn role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `LucideIcons.activity`, `LucideIcons.shieldCheck`, `AppBar`, `Column`, `Row`, `SingleChildScrollView`

### 🖥️ Screen: `SocialWorkerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the SocialWorker role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: socialWorkerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TherapistDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Therapist role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: therapistDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `UnknownDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Unknown role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: unknownDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PhysicianDashboardScreen`
- **Detected UI Components**: 13
- **Purpose**: Main operational workspace for the Physician role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `ElevatedButton`, `LucideIcons.zap`, `IconButton`, `LucideIcons.activity`, `LucideIcons.shieldCheck`, `Column`, `LucideIcons.database`, `Row`

### 🖥️ Screen: `RnMessagingScreen`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `SingleChildScrollView`, `Column`, `AppBar`

### 🖥️ Screen: `ClinicHistoryLogsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: clinicHistoryLogsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClinicIncidentReportScreen`
- **Detected UI Components**: 5
- **Purpose**: Logs incident reports, safety compliance reviews, and tracks corrective actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: clinicIncidentReportScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 2
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`

---

## 📦 Application: `primecare_client` (30 Screens)

### 🖥️ Screen: `AiChatbotScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides real-time secure communication channels between staff and clients.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: aiChatbotScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `client_routes`
- **Detected UI Components**: 13
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `Icons.medical_services`, `Icons.dashboard`, `Icons.event`, `Icons.schedule`, `Icons.update`, `Icons.calendar_month`, `Icons.payment`, `Icons.person`

### 🖥️ Screen: `FamilyBillingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyBillingScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyCareUpdatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: familyCareUpdatesScreenControllerProvider`

### 🖥️ Screen: `FamilyDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Family role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: familyDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyEmergencyContactsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyEmergencyContactsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyLovedOneScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyLovedOneScheduleScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyProfileScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyProfileScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClientBookAppointmentScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: clientBookAppointmentScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClientCareTeamScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: clientCareTeamScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClientDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Client role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: clientDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `ClientMyAppointmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: clientMyAppointmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClientPaymentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Processes client billing payments, card configurations, and transaction logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: clientPaymentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ClientProfileScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: clientProfileScreenControllerProvider`

### 🖥️ Screen: `ClientTreatmentHistoryScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: clientTreatmentHistoryScreenControllerProvider`

### 🖥️ Screen: `FamilyMemberBillingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: familyMemberBillingScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `FamilyMemberCareUpdatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: familyMemberCareUpdatesScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyMemberDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FamilyMember role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyMemberDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyMemberEmergencyContactsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyMemberEmergencyContactsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyMemberLovedOneScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: familyMemberLovedOneScheduleScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FamilyMemberProfileScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: familyMemberProfileScreenControllerProvider`

### 🖥️ Screen: `UnknownDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Unknown role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: unknownDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientBookAppointmentScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: patientBookAppointmentScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientCareTeamScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: patientCareTeamScreenControllerProvider`

### 🖥️ Screen: `PatientDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Patient role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: patientDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientMyAppointmentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: patientMyAppointmentsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientPaymentsScreen`
- **Detected UI Components**: 5
- **Purpose**: Processes client billing payments, card configurations, and transaction logs.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: patientPaymentsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientProfileScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: patientProfileScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PatientTreatmentHistoryScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays full patient charts, care plans, histories, and clinical records.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: patientTreatmentHistoryScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`, `Provider: executionGateProvider`

---

## 📦 Application: `primecare_business_development` (78 Screens)

### 🖥️ Screen: `business_development_routes`
- **Detected UI Components**: 1
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `Icons.trending_up`

### 🖥️ Screen: `RegionalBdmCompetitorNotesScreen`
- **Detected UI Components**: 5
- **Purpose**: Guides caregivers through visit checklist compliance and captures session case notes.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmCompetitorNotesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalBdm role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmDealTrackerScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: regionalBdmDealTrackerScreenControllerProvider`

### 🖥️ Screen: `RegionalBdmFranchisePipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmFranchisePipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Provider: regionalBdmLeadsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmMeetingsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmMeetingsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmPartnersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmPartnersScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmTasksScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmTasksScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmTerritoryGrowthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: regionalBdmTerritoryGrowthScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerContractsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerContractsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseSalesManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: franchiseSalesManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDiscoveryCallsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerDiscoveryCallsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerFollowUpsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerFollowUpsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerLeadsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerProposalsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProspectsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerProspectsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerSalesPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerSalesPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `GeneralManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the GeneralManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: generalManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerActiveDealsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: partnershipManagerActiveDealsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the PartnershipManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: partnershipManagerDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerOutreachScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: partnershipManagerOutreachScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerPartnersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerPartnersScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerProposalsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerRenewalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerRenewalsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: partnershipManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmCompetitorNotesScreen`
- **Detected UI Components**: 5
- **Purpose**: Guides caregivers through visit checklist compliance and captures session case notes.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmCompetitorNotesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalBdm role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmDealTrackerScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: regionalBdmDealTrackerScreenControllerProvider`

### 🖥️ Screen: `RegionalBdmFranchisePipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmFranchisePipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Provider: regionalBdmLeadsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmMeetingsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmMeetingsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmPartnersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmPartnersScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmTasksScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: regionalBdmTasksScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalBdmTerritoryGrowthScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: regionalBdmTerritoryGrowthScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `RegionalManagerOntarioDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManagerOntario role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: regionalManagerOntarioDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerUsaDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManagerUsa role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: regionalManagerUsaDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TerritoryExpansionManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerDemographicsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerDemographicsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerExpansionPlansScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: territoryExpansionManagerExpansionPlansScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerForecastScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerForecastScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerMarketResearchScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerMarketResearchScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerOpenTerritoriesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerOpenTerritoriesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerSiteSelectionScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerSiteSelectionScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerTerritoryMapScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: territoryExpansionManagerTerritoryMapScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TerritoryExpansionManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerDemographicsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerDemographicsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerExpansionPlansScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: territoryExpansionManagerExpansionPlansScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerForecastScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerForecastScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerMarketResearchScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerMarketResearchScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerOpenTerritoriesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerOpenTerritoriesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerSiteSelectionScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territoryExpansionManagerSiteSelectionScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritoryExpansionManagerTerritoryMapScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: territoryExpansionManagerTerritoryMapScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `GeneralManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the GeneralManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: generalManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerActiveDealsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: partnershipManagerActiveDealsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the PartnershipManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: partnershipManagerDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerOutreachScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: partnershipManagerOutreachScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `PartnershipManagerPartnersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerPartnersScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerProposalsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerRenewalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: partnershipManagerRenewalsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `PartnershipManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: partnershipManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerOntarioDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManagerOntario role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: regionalManagerOntarioDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `RegionalManagerUsaDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the RegionalManagerUsa role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Provider: regionalManagerUsaDashboardScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerContractsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerContractsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the FranchiseSalesManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: franchiseSalesManagerDashboardScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerDiscoveryCallsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerDiscoveryCallsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerFollowUpsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerFollowUpsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerLeadsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProposalsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: franchiseSalesManagerProposalsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerProspectsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerProspectsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `FranchiseSalesManagerSalesPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: franchiseSalesManagerSalesPipelineScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`, `Provider: executionGateProvider`

---

## 📦 Application: `primecare_marketing` (36 Screens)

### 🖥️ Screen: `marketing_routes`
- **Detected UI Components**: 1
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `Icons.campaign`

### 🖥️ Screen: `CommunityOutreachContactsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: communityOutreachContactsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CommunityOutreach role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: communityOutreachDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachEventsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: communityOutreachEventsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachFollowUpsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: communityOutreachFollowUpsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachPartnershipsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `CircularProgressIndicator`, `Column`, `Provider: communityOutreachPartnershipsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CommunityOutreachProgramsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: communityOutreachProgramsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: communityOutreachReportsScreenControllerProvider`

### 🖥️ Screen: `CommunityOutreachVolunteersScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `CircularProgressIndicator`, `Column`, `Provider: communityOutreachVolunteersScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingBrandAssetsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: headOfMarketingBrandAssetsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: headOfMarketingCampaignsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingContentApprovalScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: headOfMarketingContentApprovalScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingFunnelAnalyticsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: headOfMarketingFunnelAnalyticsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: headOfMarketingLeadsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingPerformanceReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: headOfMarketingPerformanceReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `HeadOfMarketingRegionalCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: headOfMarketingRegionalCampaignsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerAssetsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerAssetsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerBudgetScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: localMarketingManagerBudgetScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerCampaignsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: localMarketingManagerCampaignsScreenControllerProvider`

### 🖥️ Screen: `LocalMarketingManagerContentCalendarScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerContentCalendarScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the LocalMarketingManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerEventsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerEventsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerLeadsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerAreaPerformanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: territorySalesManagerAreaPerformanceScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerCompetitorsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territorySalesManagerCompetitorsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerConversionsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: territorySalesManagerConversionsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TerritorySalesManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: territorySalesManagerDashboardScreenControllerProvider`

### 🖥️ Screen: `TerritorySalesManagerFieldActivityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: territorySalesManagerFieldActivityScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerLeadsScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Provider: territorySalesManagerLeadsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerPipelineScreen`
- **Detected UI Components**: 5
- **Purpose**: Manages business development pipelines, prospective lead status, and franchise sales tracking.
- **Key Sub-Components**: `Provider: territorySalesManagerPipelineScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: territorySalesManagerReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CommunityOutreachDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CommunityOutreach role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: communityOutreachDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `LocalMarketingManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the LocalMarketingManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: localMarketingManagerDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TerritorySalesManagerDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TerritorySalesManager role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: territorySalesManagerDashboardScreenControllerProvider`

### 🖥️ Screen: `main`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`, `Provider: executionGateProvider`

---

## 📦 Application: `primecare_support` (39 Screens)

### 🖥️ Screen: `support_routes`
- **Detected UI Components**: 1
- **Purpose**: Orchestrates URL navigation parameters and access authorization paths.
- **Key Sub-Components**: `Icons.support_agent`

### 🖥️ Screen: `CustomerSupportDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the CustomerSupport role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: customerSupportDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CustomerSupportEscalationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: customerSupportEscalationsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CustomerSupportIssueCategoriesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: customerSupportIssueCategoriesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CustomerSupportReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: customerSupportReportsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `CustomerSupportTemplatesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: customerSupportTemplatesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `CustomerSupportTicketsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: customerSupportTicketsScreenControllerProvider`

### 🖥️ Screen: `IntakeCoordinatorClientAssignmentScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: intakeCoordinatorClientAssignmentScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the IntakeCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: intakeCoordinatorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorEligibilityScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: intakeCoordinatorEligibilityScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorIntakeFormsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `Provider: intakeCoordinatorIntakeFormsScreenControllerProvider`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorNewIntakesScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: intakeCoordinatorNewIntakesScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: intakeCoordinatorReportsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `IntakeCoordinatorSchedulingScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: intakeCoordinatorSchedulingScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QaDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Qa role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: qaDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceAuditsScreen`
- **Detected UI Components**: 5
- **Purpose**: Displays detailed security audit events, platform telemetry, and debugging reports.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: qualityAssuranceAuditsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceComplaintsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityAssuranceComplaintsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceComplianceChecksScreen`
- **Detected UI Components**: 5
- **Purpose**: Tracks regulatory checklists, branch audits, and legal compliance states.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: qualityAssuranceComplianceChecksScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceCorrectiveActionsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityAssuranceCorrectiveActionsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the QualityAssurance role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityAssuranceDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Generates, filters, and exports operational performance and audit report sheets.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityAssuranceReportsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceReviewsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: qualityAssuranceReviewsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceScorecardsScreen`
- **Detected UI Components**: 5
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: qualityAssuranceScorecardsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorAttendanceScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorAttendanceScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorCertificationsScreen`
- **Detected UI Components**: 5
- **Purpose**: Monitors professional credentials, driver licenses, and training expiry tracking.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingCoordinatorCertificationsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorCoursesScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Provider: trainingCoordinatorCoursesScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorMaterialsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: trainingCoordinatorMaterialsScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorProgressScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorProgressScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorReportsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Provider: trainingCoordinatorReportsScreenControllerProvider`, `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorTrainingScheduleScreen`
- **Detected UI Components**: 5
- **Purpose**: Visualizes, plans, and coordinates clinician visits, shifts, and client bookings.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorTrainingScheduleScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorWorkshopsScreen`
- **Detected UI Components**: 5
- **Purpose**: Hosts the employee training portal, curriculum designs, and compliance modules.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorWorkshopsScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `UnknownDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Unknown role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: unknownDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `EscalationDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the Escalation role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `CircularProgressIndicator`, `AppBar`, `Provider: escalationDashboardScreenControllerProvider`

### 🖥️ Screen: `HelpDeskDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the HelpDesk role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Column`, `Provider: helpDeskDashboardScreenControllerProvider`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `ItAdministratorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the ItAdministrator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: itAdministratorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `QualityAssuranceDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the QualityAssurance role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: qualityAssuranceDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `TrainingCoordinatorDashboardScreen`
- **Detected UI Components**: 5
- **Purpose**: Main operational workspace for the TrainingCoordinator role, highlighting KPIs, alerts, and quick actions.
- **Key Sub-Components**: `Icons.check_circle_outline`, `Provider: trainingCoordinatorDashboardScreenControllerProvider`, `Column`, `CircularProgressIndicator`, `AppBar`

### 🖥️ Screen: `main`
- **Detected UI Components**: 3
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Provider: deepLinkServiceProvider`, `Provider: appRouterProvider`, `Provider: executionGateProvider`

---

## 📦 Application: `primecare_enterprise_blueprint` (1 Screens)

### 🖥️ Screen: `main`
- **Detected UI Components**: 4
- **Purpose**: Provides specialized role-based operations and details for the PrimeCare ecosystem.
- **Key Sub-Components**: `Icons.add`, `Column`, `FloatingActionButton`, `AppBar`

---
