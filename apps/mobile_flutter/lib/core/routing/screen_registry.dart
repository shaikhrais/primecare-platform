import 'package:flutter/material.dart';

// Granular Screen Imports
import 'package:primecare_mobile/features/roles/corporate/screens/founder_ceo_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/coo_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/cfo_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/cto_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/compliance_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/head_bd_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/head_marketing_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/corporate/screens/training_director_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/bd_team_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/regional_bd_on_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/regional_bd_usa_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/franchise_sales_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/partnership_mgr_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/business_development/screens/territory_expansion_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/franchise_level_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/franchise_owner_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/operations_mgr_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/scheduler_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/billing_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/franchise_management/screens/hr_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/clinical_team_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/rn_granular_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/rpn_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/rmt_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/psw_granular_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/support/screens/support_team_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/support/screens/customer_support_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/support/screens/intake_coordinator_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/support/screens/quality_assurance_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/support/screens/training_coordinator_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/marketing/screens/marketing_growth_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/marketing/screens/local_marketing_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/marketing/screens/community_outreach_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/marketing/screens/territory_sales_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/client/screens/client_side_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/client/screens/client_granular_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/client/screens/family_member_dashboard_screen.dart';

// Phase 25: AI Generated Dynamic Screens
import 'package:primecare_mobile/features/roles/admin/client_clinics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_patients_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_financials_screen.dart';

// Phase 25: AI Generated Family Ecosystem
import 'package:primecare_mobile/features/roles/admin/family_appointments_screen.dart';
import 'package:primecare_mobile/features/roles/admin/family_care_plans_screen.dart';
import 'package:primecare_mobile/features/roles/admin/family_messages_screen.dart';

// Phase 26: Intake Coordinator Expansion
import 'package:primecare_mobile/features/roles/admin/intake_queue_screen.dart';
import 'package:primecare_mobile/features/roles/admin/intake_referrals_screen.dart';
import 'package:primecare_mobile/features/roles/admin/intake_upcoming_screen.dart';

// Phase 27: HR Coordinator Expansion
import 'package:primecare_mobile/features/roles/admin/hr_job_openings_screen.dart';
import 'package:primecare_mobile/features/roles/admin/hr_candidate_pipeline_screen.dart';
import 'package:primecare_mobile/features/roles/admin/hr_interviews_schedule_screen.dart';

// Phase 28: Billing Coordinator Expansion
import 'package:primecare_mobile/features/roles/admin/billing_invoices_screen.dart';
import 'package:primecare_mobile/features/roles/admin/billing_claims_screen.dart';
import 'package:primecare_mobile/features/roles/admin/billing_reports_screen.dart';

// Phase 29: Ops Manager Expansion
import 'package:primecare_mobile/features/roles/admin/ops_facilities_screen.dart';
import 'package:primecare_mobile/features/roles/admin/ops_staff_metrics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/ops_issue_tracker_screen.dart';

// Phase 30: QA & Compliance Expansion
import 'package:primecare_mobile/features/roles/admin/qa_incidents_screen.dart';
import 'package:primecare_mobile/features/roles/admin/qa_audits_screen.dart';
import 'package:primecare_mobile/features/roles/admin/qa_satisfaction_screen.dart';

// Phase 31: Territory BD & Sales Expansion
import 'package:primecare_mobile/features/roles/admin/bd_deals_screen.dart';
import 'package:primecare_mobile/features/roles/admin/bd_accounts_screen.dart';
import 'package:primecare_mobile/features/roles/admin/bd_performance_screen.dart';

// Phase 32: Marketing & Growth Command Center
import 'package:primecare_mobile/features/roles/admin/marketing_campaigns_screen.dart';
import 'package:primecare_mobile/features/roles/admin/marketing_analytics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/marketing_content_screen.dart';

// Phase 33 (Finale): Clinical Team Hub
import 'package:primecare_mobile/features/roles/clinical/screens/clinical_admissions_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/clinical_schedule_screen.dart';
import 'package:primecare_mobile/features/roles/clinical/screens/clinical_franchise_screen.dart';

// Phase 34: Support Team System Hub
import 'package:primecare_mobile/features/roles/admin/support_tickets_screen.dart';
import 'package:primecare_mobile/features/roles/admin/support_satisfaction_screen.dart';
import 'package:primecare_mobile/features/roles/admin/support_system_screen.dart';

// Phase 35: Training Coordinator Hub
import 'package:primecare_mobile/features/roles/admin/training_programs_screen.dart';
import 'package:primecare_mobile/features/roles/admin/training_facilitators_screen.dart';
import 'package:primecare_mobile/features/roles/admin/training_compliance_screen.dart';

// Phase 36: Franchise Owner Hub
import 'package:primecare_mobile/features/roles/admin/franchise_revenue_screen.dart';
import 'package:primecare_mobile/features/roles/admin/franchise_clinics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/franchise_appointments_screen.dart';

// Phase 37: Community Outreach Hub
import 'package:primecare_mobile/features/roles/admin/outreach_events_screen.dart';
import 'package:primecare_mobile/features/roles/admin/outreach_participants_screen.dart';
import 'package:primecare_mobile/features/roles/admin/outreach_budgets_screen.dart';

// Phase 38: Franchise Management Pipeline
import 'package:primecare_mobile/features/roles/admin/franchise_network_screen.dart';
import 'package:primecare_mobile/features/roles/admin/franchise_finances_screen.dart';
import 'package:primecare_mobile/features/roles/admin/franchise_activities_screen.dart';

// Phase 39: Local Marketing Pipeline
import 'package:primecare_mobile/features/roles/admin/local_marketing_analytics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/local_marketing_campaigns_screen.dart';
import 'package:primecare_mobile/features/roles/admin/local_marketing_content_screen.dart';

// Phase 40: Customer Support Hub
import 'package:primecare_mobile/features/roles/admin/support_desk_agents_screen.dart';
import 'package:primecare_mobile/features/roles/admin/support_desk_volume_screen.dart';
import 'package:primecare_mobile/features/roles/admin/support_desk_feedback_screen.dart';

// Phase 41: Client Side Hub
import 'package:primecare_mobile/features/roles/admin/client_side_trends_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_side_clinics_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_side_demographics_screen.dart';

// Phase 42: Client HealthNet Hub
import 'package:primecare_mobile/features/roles/admin/client_healthnet_revenue_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_healthnet_efficiency_screen.dart';
import 'package:primecare_mobile/features/roles/admin/client_healthnet_network_screen.dart';

// Phase 24 Baseline Screens
import 'package:primecare_mobile/features/roles/psw/psw_home_screen.dart';
import 'package:primecare_mobile/features/roles/psw/psw_live_visit_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/coordinator_hub_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_control_screen.dart';
import 'package:primecare_mobile/features/master/shared/role_sow_screen.dart';
import 'package:primecare_mobile/features/roles/client/client_wellness_pulse_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_audit_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_form_entry_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_home_screen.dart';
import 'package:primecare_mobile/features/roles/admin/screens/admin_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/admin/screens/admin_sow_screen.dart';
import 'package:primecare_mobile/features/roles/admin/screens/admin_role_matrix_screen.dart';
import 'package:primecare_mobile/features/roles/rn/screens/rn_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/rn/screens/rn_sow_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_sow_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_sow_screen.dart';
import 'package:primecare_mobile/features/roles/manager/screens/manager_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/manager/screens/manager_sow_screen.dart';
import 'package:primecare_mobile/features/roles/gm/screens/gm_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/gm/screens/gm_sow_screen.dart';
import 'package:primecare_mobile/features/roles/mt/screens/mt_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/mt/screens/mt_sow_screen.dart';
import 'package:primecare_mobile/features/roles/client/screens/client_inbox_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/screens/superuser_sow_screen.dart';


// Phase 24 Expanded Enterprise Role Matrices
import 'package:primecare_mobile/features/roles/rn/rn_patients_screen.dart';
import 'package:primecare_mobile/features/roles/manager/screens/manager_incidents_screen.dart';
import 'package:primecare_mobile/features/roles/gm/gm_executive_dashboard_screen.dart';
import 'package:primecare_mobile/features/roles/scrum_master/scrum_master_ops_screen.dart';
import 'package:primecare_mobile/features/roles/mt/mt_analytics_hub_screen.dart';

// Phase 24 Navigation Bottom Tab Extensions
import 'package:primecare_mobile/features/roles/psw/psw_timesheet_screen.dart';
import 'package:primecare_mobile/features/roles/psw/psw_earnings_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_shift_tracker_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_daily_entry_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_mar_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/psw_progress_notes_screen.dart';
import 'package:primecare_mobile/features/roles/psw/screens/incident_report_screen.dart';
import 'package:primecare_mobile/features/roles/rn/rn_care_plan_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/coordinator_approvals_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_callin_screen.dart';
import 'package:primecare_mobile/features/roles/coordinator/screens/coordinator_visit_adjustment_screen.dart';
import 'package:primecare_mobile/features/roles/manager/manager_teams_screen.dart';
import 'package:primecare_mobile/features/roles/manager/manager_payroll_screen.dart';
import 'package:primecare_mobile/features/roles/admin/admin_telemetry_screen.dart';
import 'package:primecare_mobile/features/roles/client/client_dispatch_tracker_screen.dart';
import 'package:primecare_mobile/features/master/payment/presentation/screens/client_payments_screen.dart';
import 'package:primecare_mobile/features/roles/gm/gm_pnl_screen.dart';
import 'package:primecare_mobile/features/roles/mt/mt_surge_config_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_territory_map_screen.dart';
import 'package:primecare_mobile/features/roles/superuser/superuser_registry_sync_screen.dart';
import 'package:primecare_mobile/features/master/shared/universal_inbox_screen.dart';
import 'package:primecare_mobile/features/master/shared/universal_chat_thread_screen.dart';
import 'package:primecare_mobile/features/master/shared/universal_telehealth_screen.dart';

/// Enterprise Reflection Registry
/// Resolves raw Database Schema string paths to natively compiled UI Widget trees.
class ScreenRegistry {
  static Widget resolveScreen(String name, Map<String, String> parameters) {
    switch (name) {
      // Phase 24 Baseline
      case 'PSW Home':
      case 'psw_home':
        return const PswHomeScreen();
      case 'PSW Live Visit':
      case 'psw_live_visit':
        return const PswLiveVisitScreen();
      case 'Coordinator Matrix':
      case 'coordinator_hub':
        return const CoordinatorHubScreen();
      case 'Admin Matrix':
      case 'admin_home':
        return const AdminHomeScreen();
      case 'Superuser Command':
      case 'superuser_home':
        return const SuperuserControlScreen();
      case 'Role Scope of Work':
      case 'role_sow':
        return const RoleSowScreen();
      case 'Client Care Feed':
      case 'client_care_feed':
        return const ClientWellnessPulseScreen();
        
      // Phase 24 Expanded Telemetry Rules
      case 'RN Medical Desk':
      case 'rn_home':
        return const RnPatientsScreen();
      case 'Manager Dashboard':
      case 'manager_home':
        return const ManagerIncidentsScreen();
      case 'Scrum Master Ops':
      case 'scrum_master_home':
        return const ScrumMasterOpsScreen();
      case 'GM Executive':
      case 'gm_home':
        return const GmExecutiveDashboardScreen();
      case 'MT Analytics Hub':
      case 'mt_home':
        return const MtAnalyticsHubScreen();

      // Navigation Bar Extensions
      case 'psw_timesheet': return const PswTimesheetScreen();
      case 'psw_earnings': return const PswEarningsScreen();
      case 'psw_shift_tracker': return const PswShiftTrackerScreen();
      case 'psw_daily_entry': return const PswDailyEntryScreen();
      case 'psw_mar': return const PswMarScreen();
      case 'psw_progress_notes': return const PswProgressNotesScreen();
      case 'psw_incident_report': return const IncidentReportScreen();
      case 'rn_care_plan': return const RnCarePlanScreen();
      case 'coordinator_approvals': return const CoordinatorApprovalsScreen();
      case 'coordinator_callin': return const CoordinatorCallinScreen();
      case 'coordinator_visit_adjust': return const CoordinatorVisitAdjustmentScreen();
      case 'manager_teams': return const ManagerTeamsScreen();
      case 'manager_payroll': return const ManagerPayrollScreen();
      case 'manager_incidents': return const ManagerIncidentsScreen();
      case 'admin_telemetry': return const AdminTelemetryScreen();
      case 'admin_forms': return const AdminFormEntryScreen();
      case 'admin_inbox': return const AdminInboxScreen();
      case 'admin_sow': return const AdminSowScreen();
      case 'admin_roles': return const AdminRoleMatrixScreen();
      case 'rn_inbox': return const RnInboxScreen();
      case 'rn_sow': return const RnSowScreen();
      case 'psw_inbox': return const PswInboxScreen();
      case 'psw_sow': return const PswSowScreen();
      case 'coordinator_inbox': return const CoordinatorInboxScreen();
      case 'coordinator_sow': return const CoordinatorSowScreen();
      case 'manager_inbox': return const ManagerInboxScreen();
      case 'manager_sow': return const ManagerSowScreen();
      case 'gm_inbox': return const GmInboxScreen();
      case 'gm_sow': return const GmSowScreen();
      case 'mt_inbox': return const MtInboxScreen();
      case 'mt_sow': return const MtSowScreen();
      case 'client_inbox': return const ClientInboxScreen();
      case 'superuser_sow': return const SuperuserSowScreen();

      case 'client_pulse': return const ClientWellnessPulseScreen();
      case 'client_dispatch': return const ClientDispatchTrackerScreen();
      case 'client_payments': return const ClientPaymentsScreen();
      case 'gm_pnl': return const GmPnlScreen();
      case 'mt_surge': return const MtSurgeConfigScreen();
      case 'superuser_territory': return const SuperuserTerritoryMapScreen();
      case 'superuser_registry': return const SuperuserRegistrySyncScreen();
      case 'universal_inbox': 
        return UniversalInboxScreen(rolePrefix: parameters['role'] ?? 'universal');
      case 'universal_chat':
        return UniversalChatThreadScreen(
          rolePrefix: parameters['role'] ?? 'universal',
          threadId: parameters['threadId'] ?? '',
        );
      case 'universal_telehealth':
        return UniversalTelehealthScreen(
          sessionType: parameters['sessionType'] ?? 'audio',
          peerId: parameters['peerId'] ?? '',
        );
        
      // Fault Tolerance Engine
      // Granular Registry Mappings
      case 'founder_ceo_dashboard': return const FounderCeoDashboardScreen();
      case 'coo_dashboard': return const CooDashboardScreen();
      case 'cfo_dashboard': return const CfoDashboardScreen();
      case 'cto_dashboard': return const CtoDashboardScreen();
      case 'compliance_dashboard': return const ComplianceDashboardScreen();
      case 'head_bd_dashboard': return const HeadBdDashboardScreen();
      case 'head_marketing_dashboard': return const HeadMarketingDashboardScreen();
      case 'training_director_dashboard': return const TrainingDirectorDashboardScreen();
      case 'bd_team_dashboard': return const BdTeamDashboardScreen();
      case 'regional_bd_on_dashboard': return const RegionalBdOnDashboardScreen();
      case 'regional_bd_usa_dashboard': return const RegionalBdUsaDashboardScreen();
      case 'franchise_sales_dashboard': return const FranchiseSalesDashboardScreen();
      case 'partnership_mgr_dashboard': return const PartnershipMgrDashboardScreen();
      case 'territory_expansion_dashboard': return const TerritoryExpansionDashboardScreen();
      case 'franchise_level_dashboard': return const FranchiseLevelDashboardScreen();
      case 'franchise_owner_dashboard': return const FranchiseOwnerDashboardScreen();
      case 'operations_mgr_dashboard': return const OperationsMgrDashboardScreen();
      case 'scheduler_dashboard': return const SchedulerDashboardScreen();
      case 'billing_dashboard': return const BillingDashboardScreen();
      case 'hr_dashboard': return const HrDashboardScreen();
      case 'clinical_team_dashboard': return const ClinicalTeamDashboardScreen();
      case 'rn_granular_dashboard': return const RnGranularDashboardScreen();
      case 'rpn_dashboard': return const RpnDashboardScreen();
      case 'rmt_dashboard': return const RmtDashboardScreen();
      case 'psw_granular_dashboard': return const PswGranularDashboardScreen();
      case 'support_team_dashboard': return const SupportTeamDashboardScreen();
      case 'customer_support_dashboard': return const CustomerSupportDashboardScreen();
      case 'intake_coordinator_dashboard': return const IntakeCoordinatorDashboardScreen();
      case 'quality_assurance_dashboard': return const QualityAssuranceDashboardScreen();
      case 'training_coordinator_dashboard': return const TrainingCoordinatorDashboardScreen();
      case 'marketing_growth_dashboard': return const MarketingGrowthDashboardScreen();
      case 'local_marketing_dashboard': return const LocalMarketingDashboardScreen();
      case 'community_outreach_dashboard': return const CommunityOutreachDashboardScreen();
      case 'territory_sales_dashboard': return const TerritorySalesDashboardScreen();
      case 'client_side_dashboard': return const ClientSideDashboardScreen();
      case 'client_granular_dashboard': return const ClientGranularDashboardScreen();
      case 'family_member_dashboard': return const FamilyMemberDashboardScreen();
      // Phase 25 AI Sub-Pages
      case 'client_clinics_screen': return const ClientClinicsScreen();
      case 'client_patients_screen': return const ClientPatientsScreen();
      case 'client_financials_screen': return const ClientFinancialsScreen();
      // Phase 25 Family Pages
      case 'family_appointments_screen': return const FamilyAppointmentsScreen();
      case 'family_care_plans_screen': return const FamilyCarePlansScreen();
      case 'family_messages_screen': return const FamilyMessagesScreen();
      // Phase 26 Intake Coordinator Pages
      case 'intake_queue_screen': return const IntakeQueueScreen();
      case 'intake_referrals_screen': return const IntakeReferralsScreen();
      case 'intake_upcoming_screen': return const IntakeUpcomingScreen();
      // Phase 27 HR Pages
      case 'hr_job_openings_screen': return const HrJobOpeningsScreen();
      case 'hr_candidate_pipeline_screen': return const HrCandidatePipelineScreen();
      case 'hr_interviews_schedule_screen': return const HrInterviewsScheduleScreen();
      // Phase 28 Billing Pages
      case 'billing_invoices_screen': return const BillingInvoicesScreen();
      case 'billing_claims_screen': return const BillingClaimsScreen();
      case 'billing_reports_screen': return const BillingReportsScreen();
      // Phase 29 Ops Pages
      case 'ops_facilities_screen': return const OpsFacilitiesScreen();
      case 'ops_staff_metrics_screen': return const OpsStaffMetricsScreen();
      case 'ops_issue_tracker_screen': return const OpsIssueTrackerScreen();
      // Phase 30 QA Pages
      case 'qa_incidents_screen': return const QaIncidentsScreen();
      case 'qa_audits_screen': return const QaAuditsScreen();
      case 'qa_satisfaction_screen': return const QaSatisfactionScreen();
      // Phase 31 BD Sales Pages
      case 'bd_deals_screen': return const BdDealsScreen();
      case 'bd_accounts_screen': return const BdAccountsScreen();
      case 'bd_performance_screen': return const BdPerformanceScreen();
      // Phase 32 Marketing Pages
      case 'marketing_campaigns_screen': return const MarketingCampaignsScreen();
      case 'marketing_analytics_screen': return const MarketingAnalyticsScreen();
      case 'marketing_content_screen': return const MarketingContentScreen();
      // Phase 33 Clinical Finale Pages
      case 'clinical_admissions_screen': return const ClinicalAdmissionsScreen();
      case 'clinical_schedule_screen': return const ClinicalScheduleScreen();
      case 'clinical_franchise_screen': return const ClinicalFranchiseScreen();
      // Phase 34 Support Hub Pages
      case 'support_tickets_screen': return const SupportTicketsScreen();
      case 'support_satisfaction_screen': return const SupportSatisfactionScreen();
      case 'support_system_screen': return const SupportSystemScreen();
      // Phase 35 Training Hub Pages
      case 'training_programs_screen': return const TrainingProgramsScreen();
      case 'training_facilitators_screen': return const TrainingFacilitatorsScreen();
      case 'training_compliance_screen': return const TrainingComplianceScreen();
      // Phase 36 Franchise Hub Pages
      case 'franchise_revenue_screen': return const FranchiseRevenueScreen();
      case 'franchise_clinics_screen': return const FranchiseClinicsScreen();
      case 'franchise_appointments_screen': return const FranchiseAppointmentsScreen();
      // Phase 37 Outreach Hub Pages
      case 'outreach_events_screen': return const OutreachEventsScreen();
      case 'outreach_participants_screen': return const OutreachParticipantsScreen();
      case 'outreach_budgets_screen': return const OutreachBudgetsScreen();
      // Phase 38 Franchise Management Pages
      case 'franchise_network_screen': return const FranchiseNetworkScreen();
      case 'franchise_finances_screen': return const FranchiseFinancesScreen();
      case 'franchise_activities_screen': return const FranchiseActivitiesScreen();
      // Phase 39 Local Marketing Pages
      case 'local_marketing_analytics_screen': return const LocalMarketingAnalyticsScreen();
      case 'local_marketing_campaigns_screen': return const LocalMarketingCampaignsScreen();
      case 'local_marketing_content_screen': return const LocalMarketingContentScreen();
      // Phase 40 Customer Support Pages
      case 'support_desk_agents_screen': return const SupportDeskAgentsScreen();
      case 'support_desk_volume_screen': return const SupportDeskVolumeScreen();
      case 'support_desk_feedback_screen': return const SupportDeskFeedbackScreen();
      // Phase 41 Client Side Hub
      case 'client_side_trends_screen': return const ClientSideTrendsScreen();
      case 'client_side_clinics_screen': return const ClientSideClinicsScreen();
      case 'client_side_demographics_screen': return const ClientSideDemographicsScreen();
      // Phase 42 Client HealthNet Hub
      case 'client_healthnet_revenue_screen': return const ClientHealthnetRevenueScreen();
      case 'client_healthnet_efficiency_screen': return const ClientHealthnetEfficiencyScreen();
      case 'client_healthnet_network_screen': return const ClientHealthnetNetworkScreen();
      default:
        return Scaffold(
          appBar: AppBar(title: const Text('Dynamic Route Mismatch')),
          body: Center(
            child: Text(
              'Dynamic Route Engine failed to resolve Widget: "$name"\nVerify the Backend payload array matches the Flutter `ScreenRegistry`.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.orangeAccent, fontSize: 16),
            ),
          ),
        );
    }
  }
}
