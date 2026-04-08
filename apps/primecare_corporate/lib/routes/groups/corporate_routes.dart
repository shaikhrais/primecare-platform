import 'package:go_router/go_router.dart';
import 'package:primecare_core/routes/app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/corporate/roles/ceo/analytics_dashboard.dart' as ceo_dash;
import '../../offices/corporate/roles/coo/coo_dashboard.dart' as coo_dash;
import '../../offices/corporate/roles/cfo/cfo_dashboard.dart' as cfo_dash;
import '../../offices/corporate/roles/cto/cto_dashboard.dart' as cto_dash;
import '../../offices/corporate/roles/compliance_manager/compliance_dashboard.dart'
    as compliance_manager_dash;
import '../../offices/corporate/roles/head_of_bus_dev/bus_dev_dashboard.dart'
    as head_of_bus_dev_dash;
import '../../offices/corporate/roles/training_director/training_admin_dashboard.dart'
    as training_director_dash;
import '../../offices/corporate/roles/ceo/enterprise_overview.dart'
    as ceo_enterprise_overview;
import '../../offices/corporate/roles/ceo/franchise_overview.dart'
    as ceo_franchise_overview;
import '../../offices/corporate/roles/ceo/region_performance.dart'
    as ceo_region_performance;
import '../../offices/corporate/roles/ceo/revenue_summary.dart'
    as ceo_revenue_summary;
import '../../offices/corporate/roles/ceo/strategic_kpis.dart'
    as ceo_strategic_kpis;
import '../../offices/corporate/roles/ceo/growth_pipeline.dart'
    as ceo_growth_pipeline;
import '../../offices/corporate/roles/ceo/leadership_reports.dart'
    as ceo_leadership_reports;
import '../../offices/corporate/roles/ceo/alerts_and_risks.dart'
    as ceo_alerts_and_risks;
import '../../offices/corporate/roles/ceo/organization_map.dart'
    as ceo_organization_map;
import '../../offices/corporate/roles/ceo/approvals.dart' as ceo_approvals;
import '../../offices/corporate/roles/ceo/reports.dart' as ceo_reports;
import '../../offices/corporate/roles/coo/operations_overview.dart'
    as coo_operations_overview;
import '../../offices/corporate/roles/coo/branch_operations.dart'
    as coo_branch_operations;
import '../../offices/corporate/roles/coo/staffing_efficiency.dart'
    as coo_staffing_efficiency;
import '../../offices/corporate/roles/coo/scheduling_health.dart'
    as coo_scheduling_health;
import '../../offices/corporate/roles/coo/service_delivery.dart'
    as coo_service_delivery;
import '../../offices/corporate/roles/coo/issue_escalations.dart'
    as coo_issue_escalations;
import '../../offices/corporate/roles/coo/compliance_view.dart'
    as coo_compliance_view;
import '../../offices/corporate/roles/coo/workflow_performance.dart'
    as coo_workflow_performance;
import '../../offices/corporate/roles/coo/branch_comparison.dart'
    as coo_branch_comparison;
import '../../offices/corporate/roles/coo/reports.dart' as coo_reports;
import '../../offices/corporate/roles/cfo/financial_overview.dart'
    as cfo_financial_overview;
import '../../offices/corporate/roles/cfo/revenue.dart' as cfo_revenue;
import '../../offices/corporate/roles/cfo/expenses.dart' as cfo_expenses;
import '../../offices/corporate/roles/cfo/franchise_financials.dart'
    as cfo_franchise_financials;
import '../../offices/corporate/roles/cfo/payroll.dart' as cfo_payroll;
import '../../offices/corporate/roles/cfo/accounts_receivable.dart'
    as cfo_accounts_receivable;
import '../../offices/corporate/roles/cfo/accounts_payable.dart'
    as cfo_accounts_payable;
import '../../offices/corporate/roles/cfo/invoices.dart' as cfo_invoices;
import '../../offices/corporate/roles/cfo/profitability.dart'
    as cfo_profitability;
import '../../offices/corporate/roles/cfo/tax_and_remittance.dart'
    as cfo_tax_and_remittance;
import '../../offices/corporate/roles/cfo/reports.dart' as cfo_reports;
import '../../offices/corporate/roles/cto/system_health.dart'
    as cto_system_health;
import '../../offices/corporate/roles/cto/platform_usage.dart'
    as cto_platform_usage;
import '../../offices/corporate/roles/cto/feature_adoption.dart'
    as cto_feature_adoption;
import '../../offices/corporate/roles/cto/api_monitoring.dart'
    as cto_api_monitoring;
import '../../offices/corporate/roles/cto/integrations.dart'
    as cto_integrations;
import '../../offices/corporate/roles/cto/audit_logs.dart' as cto_audit_logs;
import '../../offices/corporate/roles/cto/access_control.dart'
    as cto_access_control;
import '../../offices/corporate/roles/cto/release_management.dart'
    as cto_release_management;
import '../../offices/corporate/roles/cto/issue_tracking.dart'
    as cto_issue_tracking;
import '../../offices/corporate/roles/cto/infrastructure.dart'
    as cto_infrastructure;
import '../../offices/corporate/roles/cto/reports.dart' as cto_reports;
import '../../offices/corporate/roles/compliance_manager/compliance_cases.dart'
    as compliance_manager_compliance_cases;
import '../../offices/corporate/roles/compliance_manager/policies.dart'
    as compliance_manager_policies;
import '../../offices/corporate/roles/compliance_manager/audits.dart'
    as compliance_manager_audits;
import '../../offices/corporate/roles/compliance_manager/incident_review.dart'
    as compliance_manager_incident_review;
import '../../offices/corporate/roles/compliance_manager/credential_tracking.dart'
    as compliance_manager_credential_tracking;
import '../../offices/corporate/roles/compliance_manager/document_expiry.dart'
    as compliance_manager_document_expiry;
import '../../offices/corporate/roles/compliance_manager/risk_register.dart'
    as compliance_manager_risk_register;
import '../../offices/corporate/roles/compliance_manager/corrective_actions.dart'
    as compliance_manager_corrective_actions;
import '../../offices/corporate/roles/compliance_manager/training_compliance.dart'
    as compliance_manager_training_compliance;
import '../../offices/corporate/roles/compliance_manager/reports.dart'
    as compliance_manager_reports;
import '../../offices/corporate/roles/training_director/training_programs.dart'
    as training_director_training_programs;
import '../../offices/corporate/roles/training_director/staff_training_matrix.dart'
    as training_director_staff_training_matrix;
import '../../offices/corporate/roles/training_director/compliance_training.dart'
    as training_director_compliance_training;
import '../../offices/corporate/roles/training_director/course_library.dart'
    as training_director_course_library;
import '../../offices/corporate/roles/training_director/assessments.dart'
    as training_director_assessments;
import '../../offices/corporate/roles/training_director/certifications.dart'
    as training_director_certifications;
import '../../offices/corporate/roles/training_director/trainer_assignments.dart'
    as training_director_trainer_assignments;
import '../../offices/corporate/roles/training_director/reports.dart'
    as training_director_reports;

final List<RouteBase> corporateRoutes = [
  GoRoute(
    path: AppRoutes.ceoDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cfoDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorDashboard,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ceoEnterpriseOverview,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ceoFranchiseOverview,
    builder: (context, state) =>
        const ceo_franchise_overview.CeoFranchiseOverviewScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoRegionPerformance,
    builder: (context, state) =>
        const ceo_region_performance.CeoRegionPerformanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoRevenueSummary,
    builder: (context, state) =>
        const ceo_revenue_summary.CeoRevenueSummaryScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoStrategicKpis,
    builder: (context, state) =>
        const ceo_strategic_kpis.CeoStrategicKpisScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoGrowthPipeline,
    builder: (context, state) =>
        const ceo_growth_pipeline.CeoGrowthPipelineScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoLeadershipReports,
    builder: (context, state) =>
        const ceo_leadership_reports.CeoLeadershipReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoAlertsAndRisks,
    builder: (context, state) =>
        const ceo_alerts_and_risks.CeoAlertsAndRisksScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoOrganizationMap,
    builder: (context, state) =>
        const ceo_organization_map.CeoOrganizationMapScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoApprovals,
    builder: (context, state) => const ceo_approvals.CeoApprovalsScreen(),
  ),
  GoRoute(
    path: AppRoutes.ceoReports,
    builder: (context, state) => const ceo_reports.CeoReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.cooOperationsOverview,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooBranchOperations,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooStaffingEfficiency,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooSchedulingHealth,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooServiceDelivery,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooIssueEscalations,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooComplianceView,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooWorkflowPerformance,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooBranchComparison,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cooReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.cfoFinancialOverview,
    builder: (context, state) =>
        const cfo_financial_overview.CfoFinancialOverviewScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoRevenue,
    builder: (context, state) => const cfo_revenue.CfoRevenueScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoExpenses,
    builder: (context, state) => const cfo_expenses.CfoExpensesScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoFranchiseFinancials,
    builder: (context, state) =>
        const cfo_franchise_financials.CfoFranchiseFinancialsScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoPayroll,
    builder: (context, state) => const cfo_payroll.CfoPayrollScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoAccountsReceivable,
    builder: (context, state) =>
        const cfo_accounts_receivable.CfoAccountsReceivableScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoAccountsPayable,
    builder: (context, state) =>
        const cfo_accounts_payable.CfoAccountsPayableScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoInvoices,
    builder: (context, state) => const cfo_invoices.CfoInvoicesScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoProfitability,
    builder: (context, state) =>
        const cfo_profitability.CfoProfitabilityScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoTaxAndRemittance,
    builder: (context, state) =>
        const cfo_tax_and_remittance.CfoTaxAndRemittanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.cfoReports,
    builder: (context, state) => const cfo_reports.CfoReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.ctoSystemHealth,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoPlatformUsage,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoFeatureAdoption,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoApiMonitoring,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoIntegrations,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoAuditLogs,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoAccessControl,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoReleaseManagement,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoIssueTracking,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoInfrastructure,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.ctoReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerComplianceCases,
    builder: (context, state) =>
        const compliance_manager_compliance_cases.ComplianceCasesScreen(),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerPolicies,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerAudits,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerIncidentReview,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerCredentialTracking,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerDocumentExpiry,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerRiskRegister,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerCorrectiveActions,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerTrainingCompliance,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.complianceManagerReports,
    builder: (context, state) =>
        const compliance_manager_reports.ComplianceReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorTrainingPrograms,
    builder: (context, state) =>
        const training_director_training_programs.TrainingProgramsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorStaffTrainingMatrix,
    builder: (context, state) =>
        const training_director_staff_training_matrix.StaffTrainingMatrixScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorComplianceTraining,
    builder: (context, state) =>
        const training_director_compliance_training.ComplianceTrainingScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorCourseLibrary,
    builder: (context, state) =>
        const training_director_course_library.CourseLibraryScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorAssessments,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorCertifications,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorTrainerAssignments,
    builder: (context, state) =>
        const training_director_trainer_assignments.TrainerAssignmentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.trainingDirectorReports,
    builder: (context, state) =>
        const training_director_reports.TrainingReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.schedulerCoordinatorReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.intakeCoordinatorReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorCertifications,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
  GoRoute(
    path: AppRoutes.trainingCoordinatorReports,
    builder: (context, state) =>
        const GenericFeatureScreen(featureId: 'pending'),
  ),
];
