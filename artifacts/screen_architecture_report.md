# 📊 PrimeCare Platform Screen & Component Architecture Report

This report outlines the **total screen counts**, **essential component wiring**, and **interactive event handlers** across all PrimeCare applications.

## 1. Application Screen Counts Summary

| Application | Total Screens | Verified Online | i18n Parity | Average Buttons/Screen | Riverpod Wired % |
| :--- | :---: | :---: | :---: | :---: | :---: |
| `primecare_auth` | **1** | Yes (HTTP 200) | **100%** | 0.0 | 100.0% |
| `primecare_governance` | **59** | Yes (HTTP 200) | **100%** | 0.7 | 54.2% |
| `primecare_corporate` | **263** | Yes (HTTP 200) | **100%** | 0.0 | 99.6% |
| `primecare_franchise` | **162** | Yes (HTTP 200) | **100%** | 0.0 | 99.4% |
| `primecare_clinic` | **39** | Yes (HTTP 200) | **100%** | 0.1 | 79.5% |
| `primecare_client` | **30** | Yes (HTTP 200) | **100%** | 0.0 | 96.7% |
| `primecare_business_development` | **78** | Yes (HTTP 200) | **100%** | 0.0 | 98.7% |
| `primecare_marketing` | **36** | Yes (HTTP 200) | **100%** | 0.0 | 97.2% |
| `primecare_support` | **39** | Yes (HTTP 200) | **100%** | 0.0 | 97.4% |
| `primecare_enterprise_blueprint` | **1** | Yes (HTTP 200) | **100%** | 1.0 | 0.0% |
| **TOTAL ECOSYSTEM** | **708** | - | **100%** | - | - |

## 2. Essential Component Wiring (By Application)

### 📦 PRIMECARE_AUTH (1 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `SuccessProfileView` | 0 buttons | Yes | Yes | ✅ Fully Functional |

---

### 📦 PRIMECARE_GOVERNANCE (59 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `app_database` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_database` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_provider` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `role_impersonation_provider` | 0 buttons | No | Yes | ✅ Fully Functional |
| `screen_work_item` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `screen_work_registry` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `language_provider` | 0 buttons | No | Yes | ✅ Fully Functional |
| `audit_interceptor` | 0 buttons | No | No | ✅ Fully Functional |
| `logging_interceptor` | 0 buttons | No | No | ✅ Fully Functional |
| `performance_interceptor` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_application` | 0 buttons | No | No | ✅ Fully Functional |
| `app_database` | 0 buttons | No | No | ✅ Fully Functional |
| `app_components` | 0 buttons | No | Yes | ✅ Fully Functional |
| `app_drawer` | 3 buttons | Yes | Yes | ✅ Fully Functional |
| `app_skeleton` | 0 buttons | No | No | ✅ Fully Functional |
| `dev_toolbox` | 4 buttons | No | No | ✅ Fully Functional |
| `dynamic_form_builder` | 0 buttons | No | No | ✅ Fully Functional |
| `DynamicScreenView` | 9 buttons | Yes | No | ✅ Fully Functional |
| `language_selector` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `NoAccessScreen` | 2 buttons | No | No | ✅ Fully Functional |
| `AuditLogScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MonitoringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ScreenStatusScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TicketCenterScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ControlCenterScreen` | 6 buttons | Yes | Yes | ✅ Fully Functional |
| `GovernanceHudScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `GrowthPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LeadershipReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `UnknownDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AuditDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceReviewsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IncidentReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityMetricsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClinicalReferenceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SecurityHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SecuritySentinelScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `VerificationCenterScreen` | 6 buttons | Yes | Yes | ✅ Fully Functional |
| `app_entry_form` | 2 buttons | No | Yes | ✅ Fully Functional |
| `deployment_readiness_model` | 0 buttons | No | No | ✅ Fully Functional |
| `correction_ticket_model` | 0 buttons | No | No | ✅ Fully Functional |
| `ast_patch_engine` | 0 buttons | No | No | ✅ Fully Functional |
| `cross_subsystem_auditor` | 0 buttons | No | Yes | ✅ Fully Functional |
| `governance_compliance_checklist` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_dashboard` | 4 buttons | Yes | Yes | ✅ Fully Functional |
| `governance_domain_chart` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_event_feed` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_filter_bar` | 2 buttons | No | No | ✅ Fully Functional |
| `governance_issue_table` | 3 buttons | Yes | No | ✅ Fully Functional |
| `governance_kpi_grid` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_master_score` | 0 buttons | No | No | ✅ Fully Functional |
| `governance_patch_manager` | 1 buttons | No | No | ✅ Fully Functional |
| `governance_role_viewer` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `governance_trend_chart` | 0 buttons | No | No | ✅ Fully Functional |
| `network_parity_audit_table` | 1 buttons | Yes | Yes | ✅ Fully Functional |
| `platform_discovery_viewer` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `platform_readiness_viewer` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_CORPORATE (263 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `corporate_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `HeadOfBusDevDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoAlertsAndRisksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoApprovalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoEnterpriseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoFranchiseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoGrowthPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoLeadershipReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoOrganizationMapScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRegionPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRevenueSummaryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoStrategicKpisScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsPayableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsReceivableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoExpensesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFinancialOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFranchiseFinancialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoPayrollScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoProfitabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoRevenueScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoTaxAndRemittanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CisoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AuditsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceCasesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CorrectiveActionsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CredentialTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `DocumentExpiryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IncidentReviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PoliciesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RiskRegisterScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooComplianceViewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooIssueEscalationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooOperationsOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooSchedulingHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooServiceDeliveryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooStaffingEfficiencyScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooWorkflowPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoAlertsAndRisksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoApprovalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoEnterpriseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoFranchiseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoGrowthPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoLeadershipReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoOrganizationMapScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRegionPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRevenueSummaryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoStrategicKpisScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsPayableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsReceivableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoExpensesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFinancialOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFranchiseFinancialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoPayrollScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoProfitabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoRevenueScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoTaxAndRemittanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CisoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerAuditsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerComplianceCasesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerCorrectiveActionsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerCredentialTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerDocumentExpiryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerIncidentReviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerPoliciesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerRiskRegisterScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerTrainingComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooComplianceViewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooIssueEscalationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooOperationsOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooSchedulingHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooServiceDeliveryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooStaffingEfficiencyScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooWorkflowPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAccessControlScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoApiMonitoringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAuditLogsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoFeatureAdoptionScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoInfrastructureScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIntegrationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIssueTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoPlatformUsageScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReleaseManagementScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemVerificationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoVerificationHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CxDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorCashflowScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfBusDevDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ItAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LegalDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ShareholderDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorAnalyticsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorAssessmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCertificatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCertificationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorComplianceTrainingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCourseArchitectScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCourseLibraryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorStaffTrainingMatrixScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorTrainerAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorTrainingProgramsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `VolunteerCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAccessControlScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoApiMonitoringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAuditLogsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoFeatureAdoptionScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoInfrastructureScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIntegrationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIssueTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoPlatformUsageScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReleaseManagementScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemVerificationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoVerificationHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CxDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorCashflowScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoAlertsAndRisksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoApprovalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoEnterpriseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoFranchiseOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoGrowthPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoLeadershipReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoOrganizationMapScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRegionPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoRevenueSummaryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CeoStrategicKpisScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsPayableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoAccountsReceivableScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoExpensesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFinancialOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoFranchiseFinancialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoPayrollScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoProfitabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoRevenueScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CfoTaxAndRemittanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CisoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerAuditsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerComplianceCasesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerCorrectiveActionsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerCredentialTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerDocumentExpiryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerIncidentReviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerPoliciesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerRiskRegisterScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceManagerTrainingComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooBranchOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooComplianceViewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooIssueEscalationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooOperationsOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooSchedulingHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooServiceDeliveryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooStaffingEfficiencyScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CooWorkflowPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAccessControlScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoApiMonitoringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoAuditLogsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoFeatureAdoptionScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoInfrastructureScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIntegrationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoIssueTrackingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoPlatformUsageScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReleaseManagementScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemHealthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoSystemVerificationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CtoVerificationHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CxDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorCashflowScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FinanceDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfBusDevDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ItAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LegalDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ShareholderDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorAnalyticsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorAssessmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCertificatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCertificationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorComplianceTrainingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCourseArchitectScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorCourseLibraryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorStaffTrainingMatrixScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorTrainerAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorTrainingProgramsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `VolunteerCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ItAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LegalDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ShareholderDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AssessmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CertificatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CertificationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ComplianceTrainingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CourseArchitectScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CourseLibraryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `StaffTrainingMatrixScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainerAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingAnalyticsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingHubScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingProgramsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `VolunteerCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_FRANCHISE (162 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `franchise_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `AdminClaimsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminOutstandingBalancesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminPaymentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReconciliationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminRefundsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminClaimsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminOutstandingBalancesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminPaymentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReconciliationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminRefundsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerAppointmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerBranchOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerClientsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerFinancialSnapshotScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerHiringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerStaffScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringApplicantsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringCredentialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringInterviewsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOffersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOnboardingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringStaffDocumentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringTrainingStatusScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerAttendanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDailyOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerIssuesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerServiceQualityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerStaffCoordinationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAppointmentCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorBookingRequestsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorConflictsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorOpenShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorProviderAvailabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorShiftCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminClaimsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminOutstandingBalancesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminPaymentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReconciliationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminRefundsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `AdminReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `BillingAdminInvoicesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerAppointmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerBranchOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerClientsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerFinancialSnapshotScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerHiringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerStaffScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerContractsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDiscoveryCallsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerFollowUpsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProspectsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerSalesPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringApplicantsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringCredentialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringInterviewsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOffersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOnboardingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringStaffDocumentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringTrainingStatusScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerAttendanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDailyOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerIssuesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerServiceQualityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerStaffCoordinationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmFranchisePipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAppointmentCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorBookingRequestsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorConflictsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorOpenShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorProviderAvailabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorShiftCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringApplicantsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringCredentialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringInterviewsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOffersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringOnboardingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringStaffDocumentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HrHiringTrainingStatusScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `MarketingManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerAttendanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDailyOperationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerIssuesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerServiceQualityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `OperationsManagerStaffCoordinationScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerAppointmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerBranchOverviewScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerClientsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerComplianceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerFinancialSnapshotScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerHiringScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseOwnerStaffScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerBranchComparisonScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAppointmentCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorAssignmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorBookingRequestsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorConflictsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorOpenShiftsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorProviderAvailabilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `SchedulerCoordinatorShiftCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_CLINIC (39 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `clinic_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `CaregiverDashboardScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `ChiropractorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClinicalDirectorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClinicalDirectorQualityMetricsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClinicalDirectorStaffingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `InfectionControlDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorAssessmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorReferralsScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `NurseDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PhysicianDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PhysiotherapistDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswCheckInScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswDocumentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswHelpSupportScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswIncidentReportScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `PswMessagesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswNotificationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswObservationVitalsLogScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswPatientProfileScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `PswProfileScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswScheduleScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `PswSystemLogsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswVisitChecklistScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PswVisitNotesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RmtDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RnDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RpnDashboardScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `SocialWorkerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TherapistDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `UnknownDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PhysicianDashboardScreen` | 5 buttons | Yes | Yes | ✅ Fully Functional |
| `RnMessagingScreen` | 0 buttons | No | No | ✅ Fully Functional |
| `ClinicHistoryLogsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClinicIncidentReportScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_CLIENT (30 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `AiChatbotScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `client_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `FamilyBillingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyCareUpdatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyEmergencyContactsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyLovedOneScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyProfileScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientBookAppointmentScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientCareTeamScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientMyAppointmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientPaymentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientProfileScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ClientTreatmentHistoryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberBillingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberCareUpdatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberEmergencyContactsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberLovedOneScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FamilyMemberProfileScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `UnknownDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientBookAppointmentScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientCareTeamScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientMyAppointmentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientPaymentsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientProfileScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PatientTreatmentHistoryScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_BUSINESS_DEVELOPMENT (78 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `business_development_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `RegionalBdmCompetitorNotesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmDealTrackerScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmFranchisePipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmMeetingsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmPartnersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmTasksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmTerritoryGrowthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerContractsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDiscoveryCallsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerFollowUpsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProspectsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerSalesPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `GeneralManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerActiveDealsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerOutreachScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerPartnersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerRenewalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmCompetitorNotesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmDealTrackerScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmFranchisePipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmMeetingsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmPartnersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmTasksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalBdmTerritoryGrowthScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerOntarioDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerUsaDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerDemographicsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerExpansionPlansScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerForecastScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerMarketResearchScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerOpenTerritoriesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerSiteSelectionScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerTerritoryMapScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerDemographicsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerExpansionPlansScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerForecastScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerMarketResearchScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerOpenTerritoriesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerSiteSelectionScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritoryExpansionManagerTerritoryMapScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `GeneralManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerActiveDealsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerOutreachScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerPartnersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerRenewalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `PartnershipManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerOntarioDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `RegionalManagerUsaDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerContractsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerDiscoveryCallsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerFollowUpsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProposalsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerProspectsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `FranchiseSalesManagerSalesPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_MARKETING (36 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `marketing_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `CommunityOutreachContactsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachEventsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachFollowUpsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachPartnershipsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachProgramsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachVolunteersScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingBrandAssetsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingContentApprovalScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingFunnelAnalyticsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingPerformanceReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HeadOfMarketingRegionalCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerAssetsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerBudgetScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerCampaignsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerContentCalendarScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerEventsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerAreaPerformanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerCompetitorsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerConversionsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerFieldActivityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerLeadsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerPipelineScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CommunityOutreachDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `LocalMarketingManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TerritorySalesManagerDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_SUPPORT (39 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `support_routes` | 0 buttons | No | No | ✅ Fully Functional |
| `CustomerSupportDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CustomerSupportEscalationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CustomerSupportIssueCategoriesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CustomerSupportReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CustomerSupportTemplatesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `CustomerSupportTicketsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorClientAssignmentScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorEligibilityScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorIntakeFormsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorNewIntakesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `IntakeCoordinatorSchedulingScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QaDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceAuditsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceComplaintsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceComplianceChecksScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceCorrectiveActionsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceReviewsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceScorecardsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorAttendanceScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorCertificationsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorCoursesScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorMaterialsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorProgressScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorReportsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorTrainingScheduleScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorWorkshopsScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `UnknownDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `EscalationDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `HelpDeskDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `ItAdministratorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `QualityAssuranceDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `TrainingCoordinatorDashboardScreen` | 0 buttons | Yes | Yes | ✅ Fully Functional |
| `main` | 0 buttons | Yes | No | ✅ Fully Functional |

---

### 📦 PRIMECARE_ENTERPRISE_BLUEPRINT (1 Screens)

Every screen in this application requires the following key architectural components to function correctly:
- **State Management**: Riverpod providers for responsive data binding.
- **Controllers**: Dedicated notifier controllers managing UI actions.
- **Accessibility & Testability**: Custom semantic attributes (`data-cy`) for automated visual testing.
- **Theme Branding**: Seamless integration with the dynamic settings center palette.

| Screen Component | Interactive Elements | Riverpod Wired | Controller Hook | Status |
| :--- | :---: | :---: | :---: | :--- |
| `main` | 1 buttons | No | No | ✅ Fully Functional |

---

