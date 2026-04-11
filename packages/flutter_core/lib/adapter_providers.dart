import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'api_providers.dart';
import 'dashboard_providers.dart';
import 'features/billing_admin_dashboard/data/adapters/billing_admin_dashboard_adapter.dart';
import 'features/billing_admin_dashboard/domain/models/billing_admin_dashboard_view_model.dart';
import 'features/ceo_dashboard/data/adapters/ceo_dashboard_adapter.dart';
import 'features/ceo_dashboard/domain/models/ceo_dashboard_view_model.dart';
import 'features/cfo_dashboard/data/adapters/cfo_dashboard_adapter.dart';
import 'features/cfo_dashboard/domain/models/cfo_dashboard_view_model.dart';
import 'features/client_dashboard/data/adapters/client_dashboard_adapter.dart';
import 'features/client_dashboard/domain/models/client_dashboard_view_model.dart';
import 'features/clinic_dashboard/data/adapters/clinic_dashboard_adapter.dart';
import 'features/clinic_dashboard/domain/models/clinic_dashboard_view_model.dart';
import 'features/community_outreach_dashboard/data/adapters/community_outreach_dashboard_adapter.dart';
import 'features/community_outreach_dashboard/domain/models/community_outreach_dashboard_view_model.dart';
import 'features/compliance_manager_dashboard/data/adapters/compliance_manager_dashboard_adapter.dart';
import 'features/compliance_manager_dashboard/domain/models/compliance_manager_dashboard_view_model.dart';
import 'features/coo_dashboard/data/adapters/coo_dashboard_adapter.dart';
import 'features/coo_dashboard/domain/models/coo_dashboard_view_model.dart';
import 'features/cto_dashboard/data/adapters/cto_dashboard_adapter.dart';
import 'features/cto_dashboard/domain/models/cto_dashboard_view_model.dart';
import 'features/customer_support_dashboard/data/adapters/customer_support_dashboard_adapter.dart';
import 'features/customer_support_dashboard/domain/models/customer_support_dashboard_view_model.dart';
import 'features/family_dashboard/data/adapters/family_dashboard_adapter.dart';
import 'features/family_dashboard/domain/models/family_dashboard_view_model.dart';
import 'features/franchise_owner_dashboard/data/adapters/franchise_owner_dashboard_adapter.dart';
import 'features/franchise_owner_dashboard/domain/models/franchise_owner_view_model.dart';
import 'features/franchise_sales_manager_dashboard/data/adapters/franchise_sales_manager_dashboard_adapter.dart';
import 'features/franchise_sales_manager_dashboard/domain/models/franchise_sales_manager_dashboard_view_model.dart';
import 'features/general_manager_dashboard/data/adapters/general_manager_dashboard_adapter.dart';
import 'features/general_manager_dashboard/domain/models/general_manager_dashboard_view_model.dart';
import 'features/guest_dashboard/data/adapters/guest_dashboard_adapter.dart';
import 'features/guest_dashboard/domain/models/guest_dashboard_view_model.dart';
import 'features/head_of_bus_dev_dashboard/data/adapters/head_of_bus_dev_dashboard_adapter.dart';
import 'features/head_of_bus_dev_dashboard/domain/models/head_of_bus_dev_dashboard_view_model.dart';
import 'features/head_of_marketing_dashboard/data/adapters/head_of_marketing_dashboard_adapter.dart';
import 'features/head_of_marketing_dashboard/domain/models/head_of_marketing_dashboard_view_model.dart';
import 'features/hr_hiring_dashboard/data/adapters/hr_hiring_dashboard_adapter.dart';
import 'features/hr_hiring_dashboard/domain/models/hr_hiring_dashboard_view_model.dart';
import 'features/intake_dashboard/data/adapters/intake_dashboard_adapter.dart';
import 'features/intake_dashboard/domain/models/intake_dashboard_view_model.dart';
import 'features/local_marketing_manager_dashboard/data/adapters/local_marketing_manager_dashboard_adapter.dart';
import 'features/local_marketing_manager_dashboard/domain/models/local_marketing_manager_dashboard_view_model.dart';
import 'features/operations_manager_dashboard/data/adapters/operations_manager_dashboard_adapter.dart';
import 'features/operations_manager_dashboard/domain/models/operations_manager_dashboard_view_model.dart';
import 'features/owner_dashboard/data/adapters/owner_dashboard_adapter.dart';
import 'features/owner_dashboard/domain/models/owner_dashboard_view_model.dart';
import 'features/partnership_manager_dashboard/data/adapters/partnership_manager_dashboard_adapter.dart';
import 'features/partnership_manager_dashboard/domain/models/partnership_manager_dashboard_view_model.dart';
import 'features/patient_dashboard/data/adapters/patient_dashboard_adapter.dart';
import 'features/patient_dashboard/domain/models/patient_dashboard_view_model.dart';
import 'features/qa_dashboard/data/adapters/qa_dashboard_adapter.dart';
import 'features/qa_dashboard/domain/models/qa_dashboard_view_model.dart';
import 'features/regional_manager_ontario_dashboard/data/adapters/regional_manager_ontario_dashboard_adapter.dart';
import 'features/regional_manager_ontario_dashboard/domain/models/regional_manager_ontario_dashboard_view_model.dart';
import 'features/regional_manager_usa_dashboard/data/adapters/regional_manager_usa_dashboard_adapter.dart';
import 'features/regional_manager_usa_dashboard/domain/models/regional_manager_usa_dashboard_view_model.dart';
import 'features/scheduler_dashboard/data/adapters/scheduler_dashboard_adapter.dart';
import 'features/scheduler_dashboard/domain/models/scheduler_dashboard_view_model.dart';
import 'features/scrum_master_dashboard/data/adapters/scrum_master_dashboard_adapter.dart';
import 'features/scrum_master_dashboard/domain/models/scrum_master_dashboard_view_model.dart';
import 'features/support_dashboard/data/adapters/support_dashboard_adapter.dart';
import 'features/support_dashboard/domain/models/support_dashboard_view_model.dart';
import 'features/territory_expansion_manager_dashboard/data/adapters/territory_expansion_manager_dashboard_adapter.dart';
import 'features/territory_expansion_manager_dashboard/domain/models/territory_expansion_manager_dashboard_view_model.dart';
import 'features/territory_sales_manager_dashboard/data/adapters/territory_sales_manager_dashboard_adapter.dart';
import 'features/territory_sales_manager_dashboard/domain/models/territory_sales_manager_dashboard_view_model.dart';
import 'features/training_coordinator_dashboard/data/adapters/training_coordinator_dashboard_adapter.dart';
import 'features/training_coordinator_dashboard/domain/models/training_coordinator_dashboard_view_model.dart';
import 'features/training_director_dashboard/data/adapters/training_director_dashboard_adapter.dart';
import 'features/training_director_dashboard/domain/models/training_director_dashboard_view_model.dart';
import 'features/franchise_refunds_dashboard/data/adapters/franchise_refunds_dashboard_adapter.dart';
import 'features/franchise_refunds_dashboard/domain/models/franchise_refunds_dashboard_view_model.dart';
import 'features/franchise_reports_dashboard/data/adapters/franchise_reports_dashboard_adapter.dart';
import 'features/franchise_reports_dashboard/domain/models/franchise_reports_dashboard_view_model.dart';
import 'features/admin_dashboard/domain/models/admin_dashboard_view_model.dart';
import 'features/admin_reconciliation_dashboard/data/adapters/admin_reconciliation_dashboard_adapter.dart';
import 'features/admin_reconciliation_dashboard/domain/models/admin_reconciliation_dashboard_view_model.dart';
import 'features/franchise_reconciliation_dashboard/data/adapters/franchise_reconciliation_dashboard_adapter.dart';
import 'features/franchise_reconciliation_dashboard/domain/models/franchise_reconciliation_dashboard_view_model.dart';

class FeatureViewModel {
  final String id;
  final String title;
  final String description;
  final String status;

  FeatureViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });
}

class FeatureAdapter {
  const FeatureAdapter();
  Future<List<FeatureViewModel>> getData(String endpointKey) async => [];
}

final adapterFeatureDataProvider =
    FutureProvider.family<List<FeatureViewModel>, String>((
      ref,
      endpointKey,
    ) async {
      return [];
    });

final billingAdminDashboardAdapterProvider =
    Provider<BillingAdminDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return BillingAdminDashboardAdapter(apiClient);
    });

final billingAdminDashboardDataProvider =
    FutureProvider.family<BillingAdminDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(billingAdminDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final ceoDashboardAdapterProvider = Provider<CeoDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CeoDashboardAdapter(apiClient);
});

final ceoDashboardDataProvider =
    FutureProvider.family<CeoDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(ceoDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final cfoDashboardAdapterProvider = Provider<CfoDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CfoDashboardAdapter(apiClient);
});

final cfoDashboardDataProvider =
    FutureProvider.family<CfoDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(cfoDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final clientDashboardAdapterProvider = Provider<ClientDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ClientDashboardAdapter(apiClient);
});

final clientDashboardDataProvider =
    FutureProvider.family<ClientDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(clientDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final clinicDashboardAdapterProvider = Provider<ClinicDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ClinicDashboardAdapter(apiClient);
});

final clinicDashboardDataProvider =
    FutureProvider.family<ClinicDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(clinicDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final communityOutreachDashboardAdapterProvider =
    Provider<CommunityOutreachDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return CommunityOutreachDashboardAdapter(apiClient);
    });

final communityOutreachDashboardDataProvider =
    FutureProvider.family<CommunityOutreachDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(communityOutreachDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final complianceManagerDashboardAdapterProvider =
    Provider<ComplianceManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return ComplianceManagerDashboardAdapter(apiClient);
    });

final complianceManagerDashboardDataProvider =
    FutureProvider.family<ComplianceManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(complianceManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final cooDashboardAdapterProvider = Provider<CooDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CooDashboardAdapter(apiClient);
});

final cooDashboardDataProvider =
    FutureProvider.family<CooDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(cooDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final ctoDashboardAdapterProvider = Provider<CtoDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return CtoDashboardAdapter(apiClient);
});

final ctoDashboardDataProvider =
    FutureProvider.family<CtoDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(ctoDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final customerSupportDashboardAdapterProvider =
    Provider<CustomerSupportDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return CustomerSupportDashboardAdapter(apiClient);
    });

final customerSupportDashboardDataProvider =
    FutureProvider.family<CustomerSupportDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(customerSupportDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final familyDashboardAdapterProvider = Provider<FamilyDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return FamilyDashboardAdapter(apiClient);
});

final familyDashboardDataProvider =
    FutureProvider.family<FamilyDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(familyDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final franchiseOwnerDashboardAdapterProvider =
    Provider<FranchiseOwnerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return FranchiseOwnerDashboardAdapter(apiClient);
    });

final franchiseOwnerDashboardDataProvider =
    FutureProvider.family<FranchiseOwnerViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(franchiseOwnerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final franchiseSalesManagerDashboardAdapterProvider =
    Provider<FranchiseSalesManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return FranchiseSalesManagerDashboardAdapter(apiClient);
    });

final franchiseSalesManagerDashboardDataProvider =
    FutureProvider.family<FranchiseSalesManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(franchiseSalesManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final generalManagerDashboardAdapterProvider =
    Provider<GeneralManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return GeneralManagerDashboardAdapter(apiClient);
    });

final generalManagerDashboardDataProvider =
    FutureProvider.family<GeneralManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(generalManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final guestDashboardAdapterProvider = Provider<GuestDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return GuestDashboardAdapter(apiClient);
});

final guestDashboardDataProvider =
    FutureProvider.family<GuestDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(guestDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final headOfBusDevDashboardAdapterProvider =
    Provider<HeadOfBusDevDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return HeadOfBusDevDashboardAdapter(apiClient);
    });

final headOfBusDevDashboardDataProvider =
    FutureProvider.family<HeadOfBusDevDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(headOfBusDevDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final headOfMarketingDashboardAdapterProvider =
    Provider<HeadOfMarketingDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return HeadOfMarketingDashboardAdapter(apiClient);
    });

final headOfMarketingDashboardDataProvider =
    FutureProvider.family<HeadOfMarketingDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(headOfMarketingDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final hrHiringDashboardAdapterProvider = Provider<HrHiringDashboardAdapter>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return HrHiringDashboardAdapter(apiClient);
});

final hrHiringDashboardDataProvider =
    FutureProvider.family<HrHiringDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(hrHiringDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final intakeDashboardAdapterProvider = Provider<IntakeDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return IntakeDashboardAdapter(apiClient);
});

final intakeDashboardDataProvider =
    FutureProvider.family<IntakeDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(intakeDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final localMarketingManagerDashboardAdapterProvider =
    Provider<LocalMarketingManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return LocalMarketingManagerDashboardAdapter(apiClient);
    });

final localMarketingManagerDashboardDataProvider =
    FutureProvider.family<LocalMarketingManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(localMarketingManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final operationsManagerDashboardAdapterProvider =
    Provider<OperationsManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return OperationsManagerDashboardAdapter(apiClient);
    });

final operationsManagerDashboardDataProvider =
    FutureProvider.family<OperationsManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(operationsManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final ownerDashboardAdapterProvider = Provider<OwnerDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return OwnerDashboardAdapter(apiClient);
});

final ownerDashboardDataProvider =
    FutureProvider.family<OwnerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(ownerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final partnershipManagerDashboardAdapterProvider =
    Provider<PartnershipManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return PartnershipManagerDashboardAdapter(apiClient);
    });

final partnershipManagerDashboardDataProvider =
    FutureProvider.family<PartnershipManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(partnershipManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final patientDashboardAdapterProvider = Provider<PatientDashboardAdapter>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return PatientDashboardAdapter(apiClient);
});

final patientDashboardDataProvider =
    FutureProvider.family<PatientDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(patientDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final qaDashboardAdapterProvider = Provider<QaDashboardAdapter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return QaDashboardAdapter(apiClient);
});

final qaDashboardDataProvider =
    FutureProvider.family<QaDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(qaDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final regionalManagerOntarioDashboardAdapterProvider =
    Provider<RegionalManagerOntarioDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return RegionalManagerOntarioDashboardAdapter(apiClient);
    });

final regionalManagerOntarioDashboardDataProvider =
    FutureProvider.family<RegionalManagerOntarioDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(regionalManagerOntarioDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final regionalManagerUsaDashboardAdapterProvider =
    Provider<RegionalManagerUsaDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return RegionalManagerUsaDashboardAdapter(apiClient);
    });

final regionalManagerUsaDashboardDataProvider =
    FutureProvider.family<RegionalManagerUsaDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(regionalManagerUsaDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final schedulerDashboardAdapterProvider = Provider<SchedulerDashboardAdapter>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return SchedulerDashboardAdapter(apiClient);
});

final schedulerDashboardDataProvider =
    FutureProvider.family<SchedulerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(schedulerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final scrumMasterDashboardAdapterProvider =
    Provider<ScrumMasterDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return ScrumMasterDashboardAdapter(apiClient);
    });

final scrumMasterDashboardDataProvider =
    FutureProvider.family<ScrumMasterDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(scrumMasterDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final supportDashboardAdapterProvider = Provider<SupportDashboardAdapter>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return SupportDashboardAdapter(apiClient);
});

final supportDashboardDataProvider =
    FutureProvider.family<SupportDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(supportDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final territoryExpansionManagerDashboardAdapterProvider =
    Provider<TerritoryExpansionManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return TerritoryExpansionManagerDashboardAdapter(apiClient);
    });

final territoryExpansionManagerDashboardDataProvider =
    FutureProvider.family<TerritoryExpansionManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(
        territoryExpansionManagerDashboardAdapterProvider,
      );
      return adapter.getData(endpointKey);
    });

final territorySalesManagerDashboardAdapterProvider =
    Provider<TerritorySalesManagerDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return TerritorySalesManagerDashboardAdapter(apiClient);
    });

final territorySalesManagerDashboardDataProvider =
    FutureProvider.family<TerritorySalesManagerDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(territorySalesManagerDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final trainingCoordinatorDashboardAdapterProvider =
    Provider<TrainingCoordinatorDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return TrainingCoordinatorDashboardAdapter(apiClient);
    });

final trainingCoordinatorDashboardDataProvider =
    FutureProvider.family<TrainingCoordinatorDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(trainingCoordinatorDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final trainingDirectorDashboardAdapterProvider =
    Provider<TrainingDirectorDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return TrainingDirectorDashboardAdapter(apiClient);
    });

final trainingDirectorDashboardDataProvider =
    FutureProvider.family<TrainingDirectorDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(trainingDirectorDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final franchiseRefundsDashboardAdapterProvider =
    Provider<FranchiseRefundsDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return FranchiseRefundsDashboardAdapter(apiClient);
    });

final franchiseRefundsDashboardDataProvider =
    FutureProvider.family<FranchiseRefundsDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(franchiseRefundsDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final franchiseReportsDashboardAdapterProvider =
    Provider<FranchiseReportsDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return FranchiseReportsDashboardAdapter(apiClient);
    });

final franchiseReportsDashboardDataProvider =
    FutureProvider.family<FranchiseReportsDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(franchiseReportsDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final adminReportsDataProvider = franchiseReportsDashboardDataProvider;

final adminReconciliationDashboardAdapterProvider =
    Provider<AdminReconciliationDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return AdminReconciliationDashboardAdapter(apiClient);
    });

final adminReconciliationDashboardDataProvider =
    FutureProvider.family<AdminReconciliationDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(adminReconciliationDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final adminReconciliationDataProvider = adminReconciliationDashboardDataProvider;

final franchiseReconciliationDashboardAdapterProvider =
    Provider<FranchiseReconciliationDashboardAdapter>((ref) {
      final apiClient = ref.watch(apiClientProvider);
      return FranchiseReconciliationDashboardAdapter(apiClient);
    });

final franchiseReconciliationDashboardDataProvider =
    FutureProvider.family<FranchiseReconciliationDashboardViewModel, String>((
      ref,
      endpointKey,
    ) async {
      final adapter = ref.watch(franchiseReconciliationDashboardAdapterProvider);
      return adapter.getData(endpointKey);
    });

final franchiseReconciliationDataProvider =
    franchiseReconciliationDashboardDataProvider;

final headOfMarketingCampaignsDataProvider = headOfMarketingDashboardDataProvider;
final headOfMarketingLeadsDataProvider = headOfMarketingDashboardDataProvider;
final headOfMarketingFunnelAnalyticsDataProvider =
    headOfMarketingDashboardDataProvider;
final headOfMarketingPerformanceReportsDataProvider =
    headOfMarketingDashboardDataProvider;

final regionalBdmFranchisePipelineDataProvider = regionalBdmSalesDataProvider;
final regionalBdmLeadsDataProvider = regionalBdmSalesDataProvider;
final regionalBdmMeetingsDataProvider = regionalBdmSalesDataProvider;

// Clinical Office
final PswDashboardScreenDataProvider = FutureProvider.family<ClinicDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return ClinicDashboardViewModel.fromDashboardMetrics(metrics);
});

// Legacy and Placeholder Aliases for Stitched Screens
final genericDashboardProvider = dashboardMetricsProvider;

// Admin Office
final AdminDashboardScreenDataProvider = FutureProvider.family<AdminDashboardViewModel, String>((ref, id) async {
  final metrics = await ref.watch(dashboardMetricsProvider(id).future);
  return AdminDashboardViewModel.fromDashboardMetrics(metrics);
});
final adminDashboardDataProvider = AdminDashboardScreenDataProvider;
final adminInvoicesDataProvider = AdminDashboardScreenDataProvider;

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


