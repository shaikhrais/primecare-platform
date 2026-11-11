// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_corporate/features/compliance/screens/audits_screen.dart' as migrated0;
import 'package:primecare_corporate/features/compliance/screens/compliance_cases_screen.dart' as migrated1;
import 'package:primecare_corporate/features/compliance/screens/compliance_reports_screen.dart' as migrated2;
import 'package:primecare_corporate/features/compliance/screens/corrective_actions_screen.dart' as migrated3;
import 'package:primecare_corporate/features/compliance/screens/credential_tracking_screen.dart' as migrated4;
import 'package:primecare_corporate/features/compliance/screens/document_expiry_screen.dart' as migrated5;
import 'package:primecare_corporate/features/compliance/screens/policies_screen.dart' as migrated6;
import 'package:primecare_corporate/features/compliance/screens/risk_register_screen.dart' as migrated7;
import 'package:primecare_corporate/features/compliance/screens/training_compliance_screen.dart' as migrated8;
import 'package:primecare_corporate/features/generated_screens/ceo_alerts_and_risks_screen.dart' as migrated9;
import 'package:primecare_corporate/features/generated_screens/ceo_approvals_screen.dart' as migrated10;
import 'package:primecare_corporate/features/generated_screens/ceo_dashboard_screen.dart' as migrated11;
import 'package:primecare_corporate/features/generated_screens/ceo_enterprise_overview_screen.dart' as migrated12;
import 'package:primecare_corporate/features/generated_screens/ceo_franchise_overview_screen.dart' as migrated13;
import 'package:primecare_corporate/features/generated_screens/ceo_growth_pipeline_screen.dart' as migrated14;
import 'package:primecare_corporate/features/generated_screens/ceo_leadership_reports_screen.dart' as migrated15;
import 'package:primecare_corporate/features/generated_screens/ceo_organization_map_screen.dart' as migrated16;
import 'package:primecare_corporate/features/generated_screens/ceo_region_performance_screen.dart' as migrated17;
import 'package:primecare_corporate/features/generated_screens/ceo_reports_screen.dart' as migrated18;
import 'package:primecare_corporate/features/generated_screens/ceo_revenue_summary_screen.dart' as migrated19;
import 'package:primecare_corporate/features/generated_screens/ceo_strategic_kpis_screen.dart' as migrated20;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_payable_screen.dart' as migrated21;
import 'package:primecare_corporate/features/generated_screens/cfo_accounts_receivable_screen.dart' as migrated22;
import 'package:primecare_corporate/features/generated_screens/cfo_financial_overview_screen.dart' as migrated23;
import 'package:primecare_corporate/features/generated_screens/cfo_franchise_financials_screen.dart' as migrated24;
import 'package:primecare_corporate/features/generated_screens/cfo_reports_screen.dart' as migrated25;
import 'package:primecare_corporate/features/generated_screens/cfo_tax_and_remittance_screen.dart' as migrated26;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_audits_screen.dart' as migrated27;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_compliance_cases_screen.dart' as migrated28;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_corrective_actions_screen.dart' as migrated29;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_credential_tracking_screen.dart' as migrated30;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_document_expiry_screen.dart' as migrated31;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_incident_review_screen.dart' as migrated32;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_policies_screen.dart' as migrated33;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_reports_screen.dart' as migrated34;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_risk_register_screen.dart' as migrated35;
import 'package:primecare_corporate/features/generated_screens/compliance_manager_training_compliance_screen.dart' as migrated36;
import 'package:primecare_corporate/features/generated_screens/coo_branch_operations_screen.dart' as migrated37;
import 'package:primecare_corporate/features/generated_screens/coo_issue_escalations_screen.dart' as migrated38;
import 'package:primecare_corporate/features/generated_screens/coo_reports_screen.dart' as migrated39;
import 'package:primecare_corporate/features/generated_screens/coo_service_delivery_screen.dart' as migrated40;
import 'package:primecare_corporate/features/generated_screens/coo_staffing_efficiency_screen.dart' as migrated41;
import 'package:primecare_corporate/features/generated_screens/coo_workflow_performance_screen.dart' as migrated42;
import 'package:primecare_corporate/features/generated_screens/cto_access_control_screen.dart' as migrated43;
import 'package:primecare_corporate/features/generated_screens/cto_api_monitoring_screen.dart' as migrated44;
import 'package:primecare_corporate/features/generated_screens/cto_audit_logs_screen.dart' as migrated45;
import 'package:primecare_corporate/features/generated_screens/cto_feature_adoption_screen.dart' as migrated46;
import 'package:primecare_corporate/features/generated_screens/cto_infrastructure_screen.dart' as migrated47;
import 'package:primecare_corporate/features/generated_screens/cto_integrations_screen.dart' as migrated48;
import 'package:primecare_corporate/features/generated_screens/cto_issue_tracking_screen.dart' as migrated49;
import 'package:primecare_corporate/features/generated_screens/cto_platform_usage_screen.dart' as migrated50;
import 'package:primecare_corporate/features/generated_screens/cto_release_management_screen.dart' as migrated51;
import 'package:primecare_corporate/features/generated_screens/cto_reports_screen.dart' as migrated52;
import 'package:primecare_corporate/features/generated_screens/cto_system_health_screen.dart' as migrated53;
import 'package:primecare_corporate/features/generated_screens/cto_system_verification_screen.dart' as migrated54;
import 'package:primecare_corporate/features/generated_screens/cto_verification_hub_screen.dart' as migrated55;
import 'package:primecare_corporate/features/generated_screens/finance_director_cashflow_screen.dart' as migrated56;
import 'package:primecare_corporate/features/generated_screens/training_director_assessments_screen.dart' as migrated57;
import 'package:primecare_corporate/features/generated_screens/training_director_certificates_screen.dart' as migrated58;
import 'package:primecare_corporate/features/generated_screens/training_director_certifications_screen.dart' as migrated59;
import 'package:primecare_corporate/features/generated_screens/training_director_compliance_training_screen.dart' as migrated60;
import 'package:primecare_corporate/features/generated_screens/training_director_course_architect_screen.dart' as migrated61;
import 'package:primecare_corporate/features/generated_screens/training_director_course_library_screen.dart' as migrated62;
import 'package:primecare_corporate/features/generated_screens/training_director_hub_screen.dart' as migrated63;
import 'package:primecare_corporate/features/generated_screens/training_director_reports_screen.dart' as migrated64;
import 'package:primecare_corporate/features/generated_screens/training_director_staff_training_matrix_screen.dart' as migrated65;
import 'package:primecare_corporate/features/generated_screens/training_director_trainer_assignments_screen.dart' as migrated66;
import 'package:primecare_corporate/features/generated_screens/training_director_training_programs_screen.dart' as migrated67;
import 'package:primecare_corporate/features/itadmin/screens/it_admin_dashboard_screen.dart' as migrated68;
import 'package:primecare_corporate/features/training/screens/assessments_screen.dart' as migrated69;
import 'package:primecare_corporate/features/training/screens/certificates_screen.dart' as migrated70;
import 'package:primecare_corporate/features/training/screens/certifications_screen.dart' as migrated71;
import 'package:primecare_corporate/features/training/screens/compliance_training_screen.dart' as migrated72;
import 'package:primecare_corporate/features/training/screens/course_architect_screen.dart' as migrated73;
import 'package:primecare_corporate/features/training/screens/course_library_screen.dart' as migrated74;
import 'package:primecare_corporate/features/training/screens/staff_training_matrix_screen.dart' as migrated75;
import 'package:primecare_corporate/features/training/screens/trainer_assignments_screen.dart' as migrated76;
import 'package:primecare_corporate/features/training/screens/training_analytics_screen.dart' as migrated77;
import 'package:primecare_corporate/features/training/screens/training_hub_screen.dart' as migrated78;
import 'package:primecare_corporate/features/training/screens/training_programs_screen.dart' as migrated79;
import 'package:primecare_corporate/features/training/screens/training_reports_screen.dart' as migrated80;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.AuditsScreenState,
    migrated1.ComplianceCasesScreenState,
    migrated2.ComplianceReportsScreenState,
    migrated3.CorrectiveActionsScreenState,
    migrated4.CredentialTrackingScreenState,
    migrated5.DocumentExpiryScreenState,
    migrated6.PoliciesScreenState,
    migrated7.RiskRegisterScreenState,
    migrated8.TrainingComplianceScreenState,
    migrated9.CeoAlertsAndRisksScreenState,
    migrated10.CeoApprovalsScreenState,
    migrated11.CeoDashboardScreenState,
    migrated12.CeoEnterpriseOverviewScreenState,
    migrated13.CeoFranchiseOverviewScreenState,
    migrated14.CeoGrowthPipelineScreenState,
    migrated15.CeoLeadershipReportsScreenState,
    migrated16.CeoOrganizationMapScreenState,
    migrated17.CeoRegionPerformanceScreenState,
    migrated18.CeoReportsScreenState,
    migrated19.CeoRevenueSummaryScreenState,
    migrated20.CeoStrategicKpisScreenState,
    migrated21.CfoAccountsPayableScreenState,
    migrated22.CfoAccountsReceivableScreenState,
    migrated23.CfoFinancialOverviewScreenState,
    migrated24.CfoFranchiseFinancialsScreenState,
    migrated25.CfoReportsScreenState,
    migrated26.CfoTaxAndRemittanceScreenState,
    migrated27.ComplianceManagerAuditsScreenState,
    migrated28.ComplianceManagerComplianceCasesScreenState,
    migrated29.ComplianceManagerCorrectiveActionsScreenState,
    migrated30.ComplianceManagerCredentialTrackingScreenState,
    migrated31.ComplianceManagerDocumentExpiryScreenState,
    migrated32.ComplianceManagerIncidentReviewScreenState,
    migrated33.ComplianceManagerPoliciesScreenState,
    migrated34.ComplianceManagerReportsScreenState,
    migrated35.ComplianceManagerRiskRegisterScreenState,
    migrated36.ComplianceManagerTrainingComplianceScreenState,
    migrated37.CooBranchOperationsScreenState,
    migrated38.CooIssueEscalationsScreenState,
    migrated39.CooReportsScreenState,
    migrated40.CooServiceDeliveryScreenState,
    migrated41.CooStaffingEfficiencyScreenState,
    migrated42.CooWorkflowPerformanceScreenState,
    migrated43.CtoAccessControlScreenState,
    migrated44.CtoApiMonitoringScreenState,
    migrated45.CtoAuditLogsScreenState,
    migrated46.CtoFeatureAdoptionScreenState,
    migrated47.CtoInfrastructureScreenState,
    migrated48.CtoIntegrationsScreenState,
    migrated49.CtoIssueTrackingScreenState,
    migrated50.CtoPlatformUsageScreenState,
    migrated51.CtoReleaseManagementScreenState,
    migrated52.CtoReportsScreenState,
    migrated53.CtoSystemHealthScreenState,
    migrated54.CtoSystemVerificationScreenState,
    migrated55.CtoVerificationHubScreenState,
    migrated56.FinanceDirectorCashflowScreenState,
    migrated57.TrainingDirectorAssessmentsScreenState,
    migrated58.TrainingDirectorCertificatesScreenState,
    migrated59.TrainingDirectorCertificationsScreenState,
    migrated60.TrainingDirectorComplianceTrainingScreenState,
    migrated61.TrainingDirectorCourseArchitectScreenState,
    migrated62.TrainingDirectorCourseLibraryScreenState,
    migrated63.TrainingDirectorHubScreenState,
    migrated64.TrainingDirectorReportsScreenState,
    migrated65.TrainingDirectorStaffTrainingMatrixScreenState,
    migrated66.TrainingDirectorTrainerAssignmentsScreenState,
    migrated67.TrainingDirectorTrainingProgramsScreenState,
    migrated68.ItAdminDashboardScreenState,
    migrated69.AssessmentsScreenState,
    migrated70.CertificatesScreenState,
    migrated71.CertificationsScreenState,
    migrated72.ComplianceTrainingScreenState,
    migrated73.CourseArchitectScreenState,
    migrated74.CourseLibraryScreenState,
    migrated75.StaffTrainingMatrixScreenState,
    migrated76.TrainerAssignmentsScreenState,
    migrated77.TrainingAnalyticsScreenState,
    migrated78.TrainingHubScreenState,
    migrated79.TrainingProgramsScreenState,
    migrated80.TrainingReportsScreenState,
    ];
    expect(migratedTypes, hasLength(81));
  });
}
