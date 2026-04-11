import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/common/domain/models/common_feature_view_model.dart';
import 'features/developer_samples/demo_dashboard_view_model.dart';

import 'dashboard_providers.dart';
import 'features/billing_admin_dashboard/domain/models/billing_admin_dashboard_view_model.dart';
import 'features/ceo_dashboard/domain/models/ceo_dashboard_view_model.dart';
import 'features/cfo_dashboard/domain/models/cfo_dashboard_view_model.dart';
import 'features/client_dashboard/domain/models/client_dashboard_view_model.dart';
import 'features/clinic_dashboard/domain/models/clinic_dashboard_view_model.dart';
import 'features/community_outreach_dashboard/domain/models/community_outreach_dashboard_view_model.dart';
import 'features/compliance_manager_dashboard/domain/models/compliance_manager_dashboard_view_model.dart';
import 'features/coo_dashboard/domain/models/coo_dashboard_view_model.dart';
import 'features/cto_dashboard/domain/models/cto_dashboard_view_model.dart';
import 'features/customer_support_dashboard/domain/models/customer_support_dashboard_view_model.dart';
import 'features/family_dashboard/domain/models/family_dashboard_view_model.dart';
import 'features/franchise_owner_dashboard/domain/models/franchise_owner_view_model.dart';
import 'features/franchise_sales_manager_dashboard/domain/models/franchise_sales_manager_dashboard_view_model.dart';
import 'features/general_manager_dashboard/domain/models/general_manager_dashboard_view_model.dart';
import 'features/guest_dashboard/domain/models/guest_dashboard_view_model.dart';
import 'features/head_of_bus_dev_dashboard/domain/models/head_of_bus_dev_dashboard_view_model.dart';
import 'features/head_of_marketing_dashboard/domain/models/head_of_marketing_dashboard_view_model.dart';
import 'features/hr_hiring_dashboard/domain/models/hr_hiring_dashboard_view_model.dart';
import 'features/intake_dashboard/domain/models/intake_dashboard_view_model.dart';
import 'features/local_marketing_manager_dashboard/domain/models/local_marketing_manager_dashboard_view_model.dart';
import 'features/operations_manager_dashboard/domain/models/operations_manager_dashboard_view_model.dart';
import 'features/owner_dashboard/domain/models/owner_dashboard_view_model.dart';
import 'features/partnership_manager_dashboard/domain/models/partnership_manager_dashboard_view_model.dart';
import 'features/patient_dashboard/domain/models/patient_dashboard_view_model.dart';
import 'features/qa_dashboard/domain/models/qa_dashboard_view_model.dart';
import 'features/regional_manager_ontario_dashboard/domain/models/regional_manager_ontario_dashboard_view_model.dart';
import 'features/regional_manager_usa_dashboard/domain/models/regional_manager_usa_dashboard_view_model.dart';
import 'features/scheduler_dashboard/domain/models/scheduler_dashboard_view_model.dart';
import 'features/scrum_master_dashboard/domain/models/scrum_master_dashboard_view_model.dart';
import 'features/support_dashboard/domain/models/support_dashboard_view_model.dart';
import 'features/territory_expansion_manager_dashboard/domain/models/territory_expansion_manager_dashboard_view_model.dart';
import 'features/territory_sales_manager_dashboard/domain/models/territory_sales_manager_dashboard_view_model.dart';
import 'features/training_coordinator_dashboard/domain/models/training_coordinator_dashboard_view_model.dart';
import 'features/training_director_dashboard/domain/models/training_director_dashboard_view_model.dart';
import 'features/franchise_refunds_dashboard/domain/models/franchise_refunds_dashboard_view_model.dart';
import 'features/franchise_reports_dashboard/domain/models/franchise_reports_dashboard_view_model.dart';
import 'features/admin_dashboard/domain/models/admin_dashboard_view_model.dart';
import 'features/franchise_reconciliation_dashboard/domain/models/franchise_reconciliation_dashboard_view_model.dart';
import 'features/regional_bdm_dashboard/domain/models/regional_bdm_dashboard_view_model.dart';
import 'features/franchise_dashboard/domain/models/franchise_dashboard_view_model.dart';

import 'features/admin_reconciliation_dashboard/domain/models/admin_reconciliation_dashboard_view_model.dart';

/// --- DEVELOPER SAMPLES ---

final commonFeatureDataProvider = FutureProvider.family<CommonFeatureViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CommonFeatureViewModel.fromDashboardMetrics(metrics);
});

final demoDashboardDataProvider = FutureProvider.family<DemoDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return DemoDashboardViewModel.fromDashboardMetrics(metrics);
});

final billingAdminDashboardDataProvider = FutureProvider.family<BillingAdminDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return BillingAdminDashboardViewModel.fromDashboardMetrics(metrics);
});

final ceoDashboardDataProvider = FutureProvider.family<CeoDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CeoDashboardViewModel.fromDashboardMetrics(metrics);
});

final cfoDashboardDataProvider = FutureProvider.family<CfoDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CfoDashboardViewModel.fromDashboardMetrics(metrics);
});

final clientDashboardDataProvider = FutureProvider.family<ClientDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ClientDashboardViewModel.fromDashboardMetrics(metrics);
});

final clinicDashboardDataProvider = FutureProvider.family<ClinicDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ClinicDashboardViewModel.fromDashboardMetrics(metrics);
});

final communityOutreachDashboardDataProvider = FutureProvider.family<CommunityOutreachDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CommunityOutreachDashboardViewModel.fromDashboardMetrics(metrics);
});

final complianceManagerDashboardDataProvider = FutureProvider.family<ComplianceManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ComplianceManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final cooDashboardDataProvider = FutureProvider.family<CooDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CooDashboardViewModel.fromDashboardMetrics(metrics);
});

final ctoDashboardDataProvider = FutureProvider.family<CtoDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CtoDashboardViewModel.fromDashboardMetrics(metrics);
});

final customerSupportDashboardDataProvider = FutureProvider.family<CustomerSupportDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return CustomerSupportDashboardViewModel.fromDashboardMetrics(metrics);
});

final familyDashboardDataProvider = FutureProvider.family<FamilyDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FamilyDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseOwnerDashboardDataProvider = FutureProvider.family<FranchiseOwnerViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseOwnerViewModel.fromDashboardMetrics(metrics);
});

final franchiseSalesManagerDashboardDataProvider = FutureProvider.family<FranchiseSalesManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseSalesManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final generalManagerDashboardDataProvider = FutureProvider.family<GeneralManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return GeneralManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final guestDashboardDataProvider = FutureProvider.family<GuestDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return GuestDashboardViewModel.fromDashboardMetrics(metrics);
});

final headOfBusDevDashboardDataProvider = FutureProvider.family<HeadOfBusDevDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return HeadOfBusDevDashboardViewModel.fromDashboardMetrics(metrics);
});

final headOfMarketingDashboardDataProvider = FutureProvider.family<HeadOfMarketingDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return HeadOfMarketingDashboardViewModel.fromDashboardMetrics(metrics);
});

final hrHiringDashboardDataProvider = FutureProvider.family<HrHiringDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return HrHiringDashboardViewModel.fromDashboardMetrics(metrics);
});

final intakeDashboardDataProvider = FutureProvider.family<IntakeDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return IntakeDashboardViewModel.fromDashboardMetrics(metrics);
});

final localMarketingManagerDashboardDataProvider = FutureProvider.family<LocalMarketingManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return LocalMarketingManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final operationsManagerDashboardDataProvider = FutureProvider.family<OperationsManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return OperationsManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final ownerDashboardDataProvider = FutureProvider.family<OwnerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return OwnerDashboardViewModel.fromDashboardMetrics(metrics);
});

final partnershipManagerDashboardDataProvider = FutureProvider.family<PartnershipManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return PartnershipManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final patientDashboardDataProvider = FutureProvider.family<PatientDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return PatientDashboardViewModel.fromDashboardMetrics(metrics);
});

final qaDashboardDataProvider = FutureProvider.family<QaDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return QaDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalManagerOntarioDashboardDataProvider = FutureProvider.family<RegionalManagerOntarioDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalManagerUsaDashboardDataProvider = FutureProvider.family<RegionalManagerUsaDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(metrics);
});

final schedulerDashboardDataProvider = FutureProvider.family<SchedulerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return SchedulerDashboardViewModel.fromDashboardMetrics(metrics);
});

final scrumMasterDashboardDataProvider = FutureProvider.family<ScrumMasterDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ScrumMasterDashboardViewModel.fromDashboardMetrics(metrics);
});

final supportDashboardDataProvider = FutureProvider.family<SupportDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return SupportDashboardViewModel.fromDashboardMetrics(metrics);
});

final territoryExpansionManagerDashboardDataProvider = FutureProvider.family<TerritoryExpansionManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return TerritoryExpansionManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final territorySalesManagerDashboardDataProvider = FutureProvider.family<TerritorySalesManagerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return TerritorySalesManagerDashboardViewModel.fromDashboardMetrics(metrics);
});

final trainingCoordinatorDashboardDataProvider = FutureProvider.family<TrainingCoordinatorDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return TrainingCoordinatorDashboardViewModel.fromDashboardMetrics(metrics);
});

final trainingDirectorDashboardDataProvider = FutureProvider.family<TrainingDirectorDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return TrainingDirectorDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseRefundsDashboardDataProvider = FutureProvider.family<FranchiseRefundsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseRefundsDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseReportsDashboardDataProvider = FutureProvider.family<FranchiseReportsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseReportsDashboardViewModel.fromDashboardMetrics(metrics);
});

final adminDashboardDataProvider = FutureProvider.family<AdminDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return AdminDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseReconciliationDashboardDataProvider = FutureProvider.family<FranchiseReconciliationDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseReconciliationDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmDashboardDataProvider = FutureProvider.family<RegionalBdmDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseDashboardDataProvider = FutureProvider.family<FranchiseDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseDashboardViewModel.fromDashboardMetrics(metrics);
});

final adminReconciliationDashboardDataProvider = FutureProvider.family<AdminReconciliationDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return AdminReconciliationDashboardViewModel.fromDashboardMetrics(metrics);
});

final adminReportsDataProvider = franchiseReportsDashboardDataProvider;
final adminReconciliationDataProvider = adminReconciliationDashboardDataProvider;
final franchiseReconciliationDataProvider = franchiseReconciliationDashboardDataProvider;

final headOfMarketingCampaignsDataProvider = headOfMarketingDashboardDataProvider;
final headOfMarketingLeadsDataProvider = headOfMarketingDashboardDataProvider;
final headOfMarketingFunnelAnalyticsDataProvider = headOfMarketingDashboardDataProvider;
final headOfMarketingPerformanceReportsDataProvider = headOfMarketingDashboardDataProvider;

final regionalBdmFranchisePipelineDataProvider = regionalBdmSalesDataProvider;
final regionalBdmLeadsDataProvider = regionalBdmSalesDataProvider;
final regionalBdmMeetingsDataProvider = regionalBdmSalesDataProvider;

// Clinical Office
final pswDashboardScreenDataProvider = FutureProvider.family<ClinicDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ClinicDashboardViewModel.fromDashboardMetrics(metrics);
});

// Legacy and Placeholder Aliases for Stitched Screens
final genericDashboardProvider = dashboardMetricsProvider;

// Admin Office
final adminInvoicesDataProvider = adminDashboardDataProvider;
final adminDashboardScreenDataProvider = adminDashboardDataProvider;

// Marketing Office (Regional BDM)
final regionalBdmSalesDataProvider = FutureProvider.family<RegionalBdmSalesDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmSalesDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmDealTrackerDataProvider = FutureProvider.family<RegionalBdmDealTrackerDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmDealTrackerDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmCompetitorNotesDataProvider = FutureProvider.family<RegionalBdmCompetitorNotesDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmCompetitorNotesDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmRecruitmentDataProvider = FutureProvider.family<RegionalBdmRecruitmentDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmRecruitmentDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmPartnersDataProvider = FutureProvider.family<RegionalBdmPartnersDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmPartnersDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmReportsDataProvider = FutureProvider.family<RegionalBdmReportsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmReportsDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmTasksDataProvider = FutureProvider.family<RegionalBdmTasksDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmTasksDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmTerritoryGrowthDataProvider = FutureProvider.family<RegionalBdmTerritoryGrowthDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmTerritoryGrowthDashboardViewModel.fromDashboardMetrics(metrics);
});

final regionalBdmActivityDataProvider = FutureProvider.family<RegionalBdmDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return RegionalBdmDashboardViewModel.fromDashboardMetrics(metrics);
});

// Finance Office
final financeDirectorCashFlowDataProvider = dashboardMetricsProvider;
final financeDirectorTaxRemittanceDataProvider = dashboardMetricsProvider;

// Franchise (Financials)
final franchiseClaimsDataProvider = FutureProvider.family<FranchiseClaimsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseClaimsDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseInvoicesDataProvider = FutureProvider.family<FranchiseInvoicesDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseInvoicesDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseOutstandingBalancesDataProvider = FutureProvider.family<FranchiseOutstandingBalancesDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseOutstandingBalancesDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchisePaymentsDataProvider = FutureProvider.family<FranchisePaymentsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchisePaymentsDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseRefundsDataProvider = FutureProvider.family<FranchiseRefundsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseRefundsDashboardViewModel.fromDashboardMetrics(metrics);
});

final franchiseReportsDataProvider = FutureProvider.family<FranchiseReportsDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return FranchiseReportsDashboardViewModel.fromDashboardMetrics(metrics);
});

// Inventory
final inventoryManagerDashboardDataProvider = dashboardMetricsProvider;
final inventoryManagerSupplyChainDataProvider = dashboardMetricsProvider;
