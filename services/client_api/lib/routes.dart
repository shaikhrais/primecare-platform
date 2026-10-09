// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.partnershipmanageractivedeal...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/partnership_manager_active_deals_screen_routes/partnership_manager_active_deals_screen_routes.dart';
part 'src/features/partnership_manager_outreach_screen_routes/partnership_manager_outreach_screen_routes.dart';
part 'src/features/partnership_manager_partners_screen_routes/partnership_manager_partners_screen_routes.dart';
part 'src/features/partnership_manager_proposals_screen_routes/partnership_manager_proposals_screen_routes.dart';
part 'src/features/partnership_manager_renewals_screen_routes/partnership_manager_renewals_screen_routes.dart';
part 'src/features/partnership_manager_reports_screen_routes/partnership_manager_reports_screen_routes.dart';
part 'src/features/regional_bdm_competitor_notes_screen_routes/regional_bdm_competitor_notes_screen_routes.dart';
part 'src/features/regional_bdm_deal_tracker_screen_routes/regional_bdm_deal_tracker_screen_routes.dart';
part 'src/features/regional_bdm_meetings_screen_routes/regional_bdm_meetings_screen_routes.dart';
part 'src/features/regional_bdm_partners_screen_routes/regional_bdm_partners_screen_routes.dart';
part 'src/features/regional_bdm_reports_screen_routes/regional_bdm_reports_screen_routes.dart';
part 'src/features/regional_bdm_tasks_screen_routes/regional_bdm_tasks_screen_routes.dart';
part 'src/features/regional_bdm_territory_growth_screen_routes/regional_bdm_territory_growth_screen_routes.dart';
part 'src/features/territory_expansion_manager_demographics_screen_routes/territory_expansion_manager_demographics_screen_routes.dart';
part 'src/features/territory_expansion_manager_expansion_plans_screen_routes/territory_expansion_manager_expansion_plans_screen_routes.dart';
part 'src/features/territory_expansion_manager_forecast_screen_routes/territory_expansion_manager_forecast_screen_routes.dart';
part 'src/features/territory_expansion_manager_market_research_screen_routes/territory_expansion_manager_market_research_screen_routes.dart';
part 'src/features/territory_expansion_manager_open_territories_screen_routes/territory_expansion_manager_open_territories_screen_routes.dart';
part 'src/features/territory_expansion_manager_reports_screen_routes/territory_expansion_manager_reports_screen_routes.dart';
part 'src/features/territory_expansion_manager_site_selection_screen_routes/territory_expansion_manager_site_selection_screen_routes.dart';
part 'src/features/territory_expansion_manager_territory_map_screen_routes/territory_expansion_manager_territory_map_screen_routes.dart';
part 'src/features/client_book_appointment_screen_routes/client_book_appointment_screen_routes.dart';
part 'src/features/client_care_team_screen_routes/client_care_team_screen_routes.dart';
part 'src/features/client_dashboard_screen_routes/client_dashboard_screen_routes.dart';
part 'src/features/client_my_appointments_screen_routes/client_my_appointments_screen_routes.dart';
part 'src/features/client_profile_screen_routes/client_profile_screen_routes.dart';
part 'src/features/client_treatment_history_screen_routes/client_treatment_history_screen_routes.dart';
part 'src/features/family_member_care_updates_screen_routes/family_member_care_updates_screen_routes.dart';
part 'src/features/family_member_emergency_contacts_screen_routes/family_member_emergency_contacts_screen_routes.dart';
part 'src/features/family_member_profile_screen_routes/family_member_profile_screen_routes.dart';
part 'src/features/clinical_director_quality_metrics_screen_routes/clinical_director_quality_metrics_screen_routes.dart';
part 'src/features/clinical_director_staffing_screen_routes/clinical_director_staffing_screen_routes.dart';
part 'src/features/intake_coordinator_assessments_screen_routes/intake_coordinator_assessments_screen_routes.dart';
part 'src/features/intake_coordinator_referrals_screen_routes/intake_coordinator_referrals_screen_routes.dart';
part 'src/features/psw_check_in_screen_routes/psw_check_in_screen_routes.dart';
part 'src/features/psw_documents_screen_routes/psw_documents_screen_routes.dart';
part 'src/features/psw_incident_report_screen_routes/psw_incident_report_screen_routes.dart';
part 'src/features/psw_messages_screen_routes/psw_messages_screen_routes.dart';
part 'src/features/psw_notifications_screen_routes/psw_notifications_screen_routes.dart';
part 'src/features/psw_observation_vitals_log_screen_routes/psw_observation_vitals_log_screen_routes.dart';
part 'src/features/psw_patient_profile_screen_routes/psw_patient_profile_screen_routes.dart';
part 'src/features/psw_profile_screen_routes/psw_profile_screen_routes.dart';
part 'src/features/psw_reports_screen_routes/psw_reports_screen_routes.dart';
part 'src/features/psw_system_logs_screen_routes/psw_system_logs_screen_routes.dart';
part 'src/features/psw_visit_checklist_screen_routes/psw_visit_checklist_screen_routes.dart';
part 'src/features/psw_visit_notes_screen_routes/psw_visit_notes_screen_routes.dart';
part 'src/features/ceo_alerts_and_risks_screen_routes/ceo_alerts_and_risks_screen_routes.dart';
part 'src/features/ceo_approvals_screen_routes/ceo_approvals_screen_routes.dart';
part 'src/features/ceo_enterprise_overview_screen_routes/ceo_enterprise_overview_screen_routes.dart';
part 'src/features/ceo_growth_pipeline_screen_routes/ceo_growth_pipeline_screen_routes.dart';
part 'src/features/ceo_organization_map_screen_routes/ceo_organization_map_screen_routes.dart';
part 'src/features/ceo_region_performance_screen_routes/ceo_region_performance_screen_routes.dart';
part 'src/features/ceo_reports_screen_routes/ceo_reports_screen_routes.dart';
part 'src/features/ceo_revenue_summary_screen_routes/ceo_revenue_summary_screen_routes.dart';
part 'src/features/ceo_strategic_kpis_screen_routes/ceo_strategic_kpis_screen_routes.dart';
part 'src/features/cfo_accounts_payable_screen_routes/cfo_accounts_payable_screen_routes.dart';
part 'src/features/cfo_accounts_receivable_screen_routes/cfo_accounts_receivable_screen_routes.dart';
part 'src/features/cfo_expenses_screen_routes/cfo_expenses_screen_routes.dart';
part 'src/features/cfo_financial_overview_screen_routes/cfo_financial_overview_screen_routes.dart';
part 'src/features/cfo_payroll_screen_routes/cfo_payroll_screen_routes.dart';
part 'src/features/cfo_profitability_screen_routes/cfo_profitability_screen_routes.dart';
part 'src/features/cfo_reports_screen_routes/cfo_reports_screen_routes.dart';
part 'src/features/cfo_revenue_screen_routes/cfo_revenue_screen_routes.dart';
part 'src/features/cfo_tax_and_remittance_screen_routes/cfo_tax_and_remittance_screen_routes.dart';
part 'src/features/coo_branch_comparison_screen_routes/coo_branch_comparison_screen_routes.dart';
part 'src/features/coo_branch_operations_screen_routes/coo_branch_operations_screen_routes.dart';
part 'src/features/coo_operations_overview_screen_routes/coo_operations_overview_screen_routes.dart';
part 'src/features/coo_reports_screen_routes/coo_reports_screen_routes.dart';
part 'src/features/coo_scheduling_health_screen_routes/coo_scheduling_health_screen_routes.dart';
part 'src/features/coo_service_delivery_screen_routes/coo_service_delivery_screen_routes.dart';
part 'src/features/coo_staffing_efficiency_screen_routes/coo_staffing_efficiency_screen_routes.dart';
part 'src/features/coo_workflow_performance_screen_routes/coo_workflow_performance_screen_routes.dart';
part 'src/features/cto_access_control_screen_routes/cto_access_control_screen_routes.dart';
part 'src/features/cto_api_monitoring_screen_routes/cto_api_monitoring_screen_routes.dart';
part 'src/features/cto_feature_adoption_screen_routes/cto_feature_adoption_screen_routes.dart';
part 'src/features/cto_infrastructure_screen_routes/cto_infrastructure_screen_routes.dart';
part 'src/features/cto_integrations_screen_routes/cto_integrations_screen_routes.dart';
part 'src/features/cto_issue_tracking_screen_routes/cto_issue_tracking_screen_routes.dart';
part 'src/features/cto_platform_usage_screen_routes/cto_platform_usage_screen_routes.dart';
part 'src/features/cto_release_management_screen_routes/cto_release_management_screen_routes.dart';
part 'src/features/cto_reports_screen_routes/cto_reports_screen_routes.dart';
part 'src/features/cto_system_health_screen_routes/cto_system_health_screen_routes.dart';
part 'src/features/cto_system_verification_screen_routes/cto_system_verification_screen_routes.dart';
part 'src/features/cto_verification_hub_screen_routes/cto_verification_hub_screen_routes.dart';
part 'src/features/finance_director_cashflow_screen_routes/finance_director_cashflow_screen_routes.dart';
part 'src/features/training_director_analytics_screen_routes/training_director_analytics_screen_routes.dart';
part 'src/features/training_director_assessments_screen_routes/training_director_assessments_screen_routes.dart';
part 'src/features/training_director_certificates_screen_routes/training_director_certificates_screen_routes.dart';
part 'src/features/training_director_certifications_screen_routes/training_director_certifications_screen_routes.dart';
part 'src/features/training_director_course_architect_screen_routes/training_director_course_architect_screen_routes.dart';
part 'src/features/training_director_course_library_screen_routes/training_director_course_library_screen_routes.dart';
part 'src/features/training_director_hub_screen_routes/training_director_hub_screen_routes.dart';
part 'src/features/training_director_reports_screen_routes/training_director_reports_screen_routes.dart';
part 'src/features/training_director_staff_training_matrix_screen_routes/training_director_staff_training_matrix_screen_routes.dart';
part 'src/features/training_director_trainer_assignments_screen_routes/training_director_trainer_assignments_screen_routes.dart';
part 'src/features/training_director_training_programs_screen_routes/training_director_training_programs_screen_routes.dart';
part 'src/features/admin_claims_screen_routes/admin_claims_screen_routes.dart';
part 'src/features/admin_outstanding_balances_screen_routes/admin_outstanding_balances_screen_routes.dart';
part 'src/features/admin_reconciliation_screen_routes/admin_reconciliation_screen_routes.dart';
part 'src/features/admin_refunds_screen_routes/admin_refunds_screen_routes.dart';
part 'src/features/admin_reports_screen_routes/admin_reports_screen_routes.dart';
part 'src/features/franchise_owner_clients_screen_routes/franchise_owner_clients_screen_routes.dart';
part 'src/features/hr_hiring_applicants_screen_routes/hr_hiring_applicants_screen_routes.dart';
part 'src/features/hr_hiring_credentials_screen_routes/hr_hiring_credentials_screen_routes.dart';
part 'src/features/hr_hiring_interviews_screen_routes/hr_hiring_interviews_screen_routes.dart';
part 'src/features/hr_hiring_offers_screen_routes/hr_hiring_offers_screen_routes.dart';
part 'src/features/hr_hiring_onboarding_screen_routes/hr_hiring_onboarding_screen_routes.dart';
part 'src/features/hr_hiring_reports_screen_routes/hr_hiring_reports_screen_routes.dart';
part 'src/features/hr_hiring_staff_documents_screen_routes/hr_hiring_staff_documents_screen_routes.dart';
part 'src/features/hr_hiring_training_status_screen_routes/hr_hiring_training_status_screen_routes.dart';
part 'src/features/operations_manager_attendance_screen_routes/operations_manager_attendance_screen_routes.dart';
part 'src/features/operations_manager_daily_operations_screen_routes/operations_manager_daily_operations_screen_routes.dart';
part 'src/features/operations_manager_issues_screen_routes/operations_manager_issues_screen_routes.dart';
part 'src/features/operations_manager_reports_screen_routes/operations_manager_reports_screen_routes.dart';
part 'src/features/operations_manager_service_quality_screen_routes/operations_manager_service_quality_screen_routes.dart';
part 'src/features/operations_manager_staff_coordination_screen_routes/operations_manager_staff_coordination_screen_routes.dart';
part 'src/features/regional_manager_branch_comparison_screen_routes/regional_manager_branch_comparison_screen_routes.dart';
part 'src/features/screen_registry_routes/screen_registry_routes.dart';
part 'src/features/screen_work_item_g_routes/screen_work_item_g_routes.dart';
part 'src/features/screen_work_item_routes/screen_work_item_routes.dart';
part 'src/features/screen_work_registry_routes/screen_work_registry_routes.dart';
part 'src/features/platform_discovery_viewer_routes/platform_discovery_viewer_routes.dart';
part 'src/features/platform_readiness_viewer_routes/platform_readiness_viewer_routes.dart';
part 'src/features/community_outreach_contacts_screen_routes/community_outreach_contacts_screen_routes.dart';
part 'src/features/community_outreach_events_screen_routes/community_outreach_events_screen_routes.dart';
part 'src/features/community_outreach_follow_ups_screen_routes/community_outreach_follow_ups_screen_routes.dart';
part 'src/features/community_outreach_partnerships_screen_routes/community_outreach_partnerships_screen_routes.dart';
part 'src/features/community_outreach_programs_screen_routes/community_outreach_programs_screen_routes.dart';
part 'src/features/community_outreach_reports_screen_routes/community_outreach_reports_screen_routes.dart';
part 'src/features/community_outreach_volunteers_screen_routes/community_outreach_volunteers_screen_routes.dart';
part 'src/features/territory_sales_manager_area_performance_screen_routes/territory_sales_manager_area_performance_screen_routes.dart';
part 'src/features/territory_sales_manager_competitors_screen_routes/territory_sales_manager_competitors_screen_routes.dart';
part 'src/features/territory_sales_manager_conversions_screen_routes/territory_sales_manager_conversions_screen_routes.dart';
part 'src/features/territory_sales_manager_field_activity_screen_routes/territory_sales_manager_field_activity_screen_routes.dart';
part 'src/features/territory_sales_manager_pipeline_screen_routes/territory_sales_manager_pipeline_screen_routes.dart';
part 'src/features/territory_sales_manager_reports_screen_routes/territory_sales_manager_reports_screen_routes.dart';
part 'src/features/intake_coordinator_client_assignment_screen_routes/intake_coordinator_client_assignment_screen_routes.dart';
part 'src/features/intake_coordinator_eligibility_screen_routes/intake_coordinator_eligibility_screen_routes.dart';
part 'src/features/intake_coordinator_intake_forms_screen_routes/intake_coordinator_intake_forms_screen_routes.dart';
part 'src/features/intake_coordinator_new_intakes_screen_routes/intake_coordinator_new_intakes_screen_routes.dart';
part 'src/features/intake_coordinator_reports_screen_routes/intake_coordinator_reports_screen_routes.dart';
part 'src/features/intake_coordinator_scheduling_screen_routes/intake_coordinator_scheduling_screen_routes.dart';
part 'src/features/quality_assurance_complaints_screen_routes/quality_assurance_complaints_screen_routes.dart';
part 'src/features/quality_assurance_corrective_actions_screen_routes/quality_assurance_corrective_actions_screen_routes.dart';
part 'src/features/quality_assurance_reports_screen_routes/quality_assurance_reports_screen_routes.dart';
part 'src/features/quality_assurance_reviews_screen_routes/quality_assurance_reviews_screen_routes.dart';
part 'src/features/quality_assurance_scorecards_screen_routes/quality_assurance_scorecards_screen_routes.dart';
part 'src/features/training_coordinator_attendance_screen_routes/training_coordinator_attendance_screen_routes.dart';
part 'src/features/training_coordinator_certifications_screen_routes/training_coordinator_certifications_screen_routes.dart';
part 'src/features/training_coordinator_courses_screen_routes/training_coordinator_courses_screen_routes.dart';
part 'src/features/training_coordinator_materials_screen_routes/training_coordinator_materials_screen_routes.dart';
part 'src/features/training_coordinator_progress_screen_routes/training_coordinator_progress_screen_routes.dart';
part 'src/features/training_coordinator_reports_screen_routes/training_coordinator_reports_screen_routes.dart';
part 'src/features/training_coordinator_workshops_screen_routes/training_coordinator_workshops_screen_routes.dart';
part 'src/features/ai_chat_routes/ai_chat_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    PartnershipManagerActiveDealsScreenRoutes(prisma),
    PartnershipManagerOutreachScreenRoutes(prisma),
    PartnershipManagerPartnersScreenRoutes(prisma),
    PartnershipManagerProposalsScreenRoutes(prisma),
    PartnershipManagerRenewalsScreenRoutes(prisma),
    PartnershipManagerReportsScreenRoutes(prisma),
    RegionalBdmCompetitorNotesScreenRoutes(prisma),
    RegionalBdmDealTrackerScreenRoutes(prisma),
    RegionalBdmMeetingsScreenRoutes(prisma),
    RegionalBdmPartnersScreenRoutes(prisma),
    RegionalBdmReportsScreenRoutes(prisma),
    RegionalBdmTasksScreenRoutes(prisma),
    RegionalBdmTerritoryGrowthScreenRoutes(prisma),
    TerritoryExpansionManagerDemographicsScreenRoutes(prisma),
    TerritoryExpansionManagerExpansionPlansScreenRoutes(prisma),
    TerritoryExpansionManagerForecastScreenRoutes(prisma),
    TerritoryExpansionManagerMarketResearchScreenRoutes(prisma),
    TerritoryExpansionManagerOpenTerritoriesScreenRoutes(prisma),
    TerritoryExpansionManagerReportsScreenRoutes(prisma),
    TerritoryExpansionManagerSiteSelectionScreenRoutes(prisma),
    TerritoryExpansionManagerTerritoryMapScreenRoutes(prisma),
    ClientBookAppointmentScreenRoutes(prisma),
    ClientCareTeamScreenRoutes(prisma),
    ClientDashboardScreenRoutes(prisma),
    ClientMyAppointmentsScreenRoutes(prisma),
    ClientProfileScreenRoutes(prisma),
    ClientTreatmentHistoryScreenRoutes(prisma),
    FamilyMemberCareUpdatesScreenRoutes(prisma),
    FamilyMemberEmergencyContactsScreenRoutes(prisma),
    FamilyMemberProfileScreenRoutes(prisma),
    ClinicalDirectorQualityMetricsScreenRoutes(prisma),
    ClinicalDirectorStaffingScreenRoutes(prisma),
    IntakeCoordinatorAssessmentsScreenRoutes(prisma),
    IntakeCoordinatorReferralsScreenRoutes(prisma),
    PswCheckInScreenRoutes(prisma),
    PswDocumentsScreenRoutes(prisma),
    PswIncidentReportScreenRoutes(prisma),
    PswMessagesScreenRoutes(prisma),
    PswNotificationsScreenRoutes(prisma),
    PswObservationVitalsLogScreenRoutes(prisma),
    PswPatientProfileScreenRoutes(prisma),
    PswProfileScreenRoutes(prisma),
    PswReportsScreenRoutes(prisma),
    PswSystemLogsScreenRoutes(prisma),
    PswVisitChecklistScreenRoutes(prisma),
    PswVisitNotesScreenRoutes(prisma),
    CeoAlertsAndRisksScreenRoutes(prisma),
    CeoApprovalsScreenRoutes(prisma),
    CeoEnterpriseOverviewScreenRoutes(prisma),
    CeoGrowthPipelineScreenRoutes(prisma),
    CeoOrganizationMapScreenRoutes(prisma),
    CeoRegionPerformanceScreenRoutes(prisma),
    CeoReportsScreenRoutes(prisma),
    CeoRevenueSummaryScreenRoutes(prisma),
    CeoStrategicKpisScreenRoutes(prisma),
    CfoAccountsPayableScreenRoutes(prisma),
    CfoAccountsReceivableScreenRoutes(prisma),
    CfoExpensesScreenRoutes(prisma),
    CfoFinancialOverviewScreenRoutes(prisma),
    CfoPayrollScreenRoutes(prisma),
    CfoProfitabilityScreenRoutes(prisma),
    CfoReportsScreenRoutes(prisma),
    CfoRevenueScreenRoutes(prisma),
    CfoTaxAndRemittanceScreenRoutes(prisma),
    CooBranchComparisonScreenRoutes(prisma),
    CooBranchOperationsScreenRoutes(prisma),
    CooOperationsOverviewScreenRoutes(prisma),
    CooReportsScreenRoutes(prisma),
    CooSchedulingHealthScreenRoutes(prisma),
    CooServiceDeliveryScreenRoutes(prisma),
    CooStaffingEfficiencyScreenRoutes(prisma),
    CooWorkflowPerformanceScreenRoutes(prisma),
    CtoAccessControlScreenRoutes(prisma),
    CtoApiMonitoringScreenRoutes(prisma),
    CtoFeatureAdoptionScreenRoutes(prisma),
    CtoInfrastructureScreenRoutes(prisma),
    CtoIntegrationsScreenRoutes(prisma),
    CtoIssueTrackingScreenRoutes(prisma),
    CtoPlatformUsageScreenRoutes(prisma),
    CtoReleaseManagementScreenRoutes(prisma),
    CtoReportsScreenRoutes(prisma),
    CtoSystemHealthScreenRoutes(prisma),
    CtoSystemVerificationScreenRoutes(prisma),
    CtoVerificationHubScreenRoutes(prisma),
    FinanceDirectorCashflowScreenRoutes(prisma),
    TrainingDirectorAnalyticsScreenRoutes(prisma),
    TrainingDirectorAssessmentsScreenRoutes(prisma),
    TrainingDirectorCertificatesScreenRoutes(prisma),
    TrainingDirectorCertificationsScreenRoutes(prisma),
    TrainingDirectorCourseArchitectScreenRoutes(prisma),
    TrainingDirectorCourseLibraryScreenRoutes(prisma),
    TrainingDirectorHubScreenRoutes(prisma),
    TrainingDirectorReportsScreenRoutes(prisma),
    TrainingDirectorStaffTrainingMatrixScreenRoutes(prisma),
    TrainingDirectorTrainerAssignmentsScreenRoutes(prisma),
    TrainingDirectorTrainingProgramsScreenRoutes(prisma),
    AdminClaimsScreenRoutes(prisma),
    AdminOutstandingBalancesScreenRoutes(prisma),
    AdminReconciliationScreenRoutes(prisma),
    AdminRefundsScreenRoutes(prisma),
    AdminReportsScreenRoutes(prisma),
    FranchiseOwnerClientsScreenRoutes(prisma),
    HrHiringApplicantsScreenRoutes(prisma),
    HrHiringCredentialsScreenRoutes(prisma),
    HrHiringInterviewsScreenRoutes(prisma),
    HrHiringOffersScreenRoutes(prisma),
    HrHiringOnboardingScreenRoutes(prisma),
    HrHiringReportsScreenRoutes(prisma),
    HrHiringStaffDocumentsScreenRoutes(prisma),
    HrHiringTrainingStatusScreenRoutes(prisma),
    OperationsManagerAttendanceScreenRoutes(prisma),
    OperationsManagerDailyOperationsScreenRoutes(prisma),
    OperationsManagerIssuesScreenRoutes(prisma),
    OperationsManagerReportsScreenRoutes(prisma),
    OperationsManagerServiceQualityScreenRoutes(prisma),
    OperationsManagerStaffCoordinationScreenRoutes(prisma),
    RegionalManagerBranchComparisonScreenRoutes(prisma),
    ScreenRegistryRoutes(prisma),
    ScreenWorkItemGRoutes(prisma),
    ScreenWorkItemRoutes(prisma),
    ScreenWorkRegistryRoutes(prisma),
    PlatformDiscoveryViewerRoutes(prisma),
    PlatformReadinessViewerRoutes(prisma),
    CommunityOutreachContactsScreenRoutes(prisma),
    CommunityOutreachEventsScreenRoutes(prisma),
    CommunityOutreachFollowUpsScreenRoutes(prisma),
    CommunityOutreachPartnershipsScreenRoutes(prisma),
    CommunityOutreachProgramsScreenRoutes(prisma),
    CommunityOutreachReportsScreenRoutes(prisma),
    CommunityOutreachVolunteersScreenRoutes(prisma),
    TerritorySalesManagerAreaPerformanceScreenRoutes(prisma),
    TerritorySalesManagerCompetitorsScreenRoutes(prisma),
    TerritorySalesManagerConversionsScreenRoutes(prisma),
    TerritorySalesManagerFieldActivityScreenRoutes(prisma),
    TerritorySalesManagerPipelineScreenRoutes(prisma),
    TerritorySalesManagerReportsScreenRoutes(prisma),
    IntakeCoordinatorClientAssignmentScreenRoutes(prisma),
    IntakeCoordinatorEligibilityScreenRoutes(prisma),
    IntakeCoordinatorIntakeFormsScreenRoutes(prisma),
    IntakeCoordinatorNewIntakesScreenRoutes(prisma),
    IntakeCoordinatorReportsScreenRoutes(prisma),
    IntakeCoordinatorSchedulingScreenRoutes(prisma),
    QualityAssuranceComplaintsScreenRoutes(prisma),
    QualityAssuranceCorrectiveActionsScreenRoutes(prisma),
    QualityAssuranceReportsScreenRoutes(prisma),
    QualityAssuranceReviewsScreenRoutes(prisma),
    QualityAssuranceScorecardsScreenRoutes(prisma),
    TrainingCoordinatorAttendanceScreenRoutes(prisma),
    TrainingCoordinatorCertificationsScreenRoutes(prisma),
    TrainingCoordinatorCoursesScreenRoutes(prisma),
    TrainingCoordinatorMaterialsScreenRoutes(prisma),
    TrainingCoordinatorProgressScreenRoutes(prisma),
    TrainingCoordinatorReportsScreenRoutes(prisma),
    TrainingCoordinatorWorkshopsScreenRoutes(prisma),
    AiChatRoutes(prisma),
  ];
}
