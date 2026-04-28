// PRIMECARE CONSOLIDATED FILE
import 'dart:async';
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide
        isOnlineProvider,
        ProviderTTL,
        tr,
        FranchiseOwnerViewModel,
        PrimeCareViewModel;

// --- MISSING INFRASTRUCTURE ---
abstract class RnNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

typedef RnState = dynamic;

abstract class PhysiotherapistNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

abstract class PswNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

abstract class RpnNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

abstract class FranchiseOwnerNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

abstract class ChiropractorNotifier<T> extends Notifier<T>
    with ResilientNotifierMixin<T> {
  T build();
}

// --- MANDATORY RESILIENCE INFRASTRUCTURE ---

/// Base mixin for all PrimeCare Notifiers providing standardized hydration logic.
mixin ResilientNotifierMixin<T> on Notifier<T> {
  /// Standardized method to hydrate data from a repository with error handling and telemetry.
  Future<void> guardHydration<D>({
    required Future<Result<D>> Function() fetch,
    required T Function(D data) onSuccess,
    required T Function(String message) onError,
    required T loadingState,
    ExecutionGateCategory category = ExecutionGateCategory.domainApi,
  }) async {
    state = loadingState;
    final result = await fetch();
    result.fold(
      (data) {
        state = onSuccess(data);
      },
      (error) {
        state = onError(error.toString());
      },
    );
  }
}

// Feature-specific mixin stubs to maintain backward compatibility with generated code
mixin PhysiotherapistResilientNotifierMixin<T> on Notifier<T>
    implements ResilientNotifierMixin<T> {}
mixin PswResilientNotifierMixin<T> on Notifier<T>
    implements ResilientNotifierMixin<T> {}
mixin RpnResilientNotifierMixin<T> on Notifier<T>
    implements ResilientNotifierMixin<T> {}

// --- Global Provider Aliases ---
typedef PhysiotherapistNotifierProvider<T extends Notifier<S>, S> =
    NotifierProvider<T, S>;
typedef PswNotifierProvider<T extends Notifier<S>, S> = NotifierProvider<T, S>;
typedef RnNotifierProvider<T extends Notifier<S>, S> = NotifierProvider<T, S>;
typedef RpnNotifierProvider<T extends Notifier<S>, S> = NotifierProvider<T, S>;
typedef FranchiseOwnerNotifierProvider<T extends Notifier<S>, S> =
    NotifierProvider<T, S>;
typedef ChiropractorNotifierProvider<T extends Notifier<S>, S> =
    NotifierProvider<T, S>;

typedef PswProvider<T> = Provider<T>;
typedef RnProvider<T> = Provider<T>;
// Registry Typedefs
typedef FranchiseOwnerProvider<T> = Provider<T>;
typedef ChiropractorProvider<T> = Provider<T>;
typedef PhysiotherapistProvider<T> = Provider<T>;

// --- DASHBOARD ADAPTER PROVIDER ALIASES ---
final architecturePlanningDashboardAdapterProvider =
    genericDashboardAdapterProvider(
      PrimeCareForm.architecturePlanningDashboard,
    );
final billingAdminDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.billingAdminDashboard,
);
final ceoDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ceoDashboard,
);
final cfoDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cfoDashboard,
);
final cooDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cooDashboard,
);
final ctoDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ctoDashboard,
);
final customerSupportDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.customerSupportDashboard,
);
final cxDirectorDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cxDirectorDashboard,
);
final financeDirectorDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.financeDirectorDashboard,
);
final franchiseOwnerAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.franchiseOwnerDashboard,
);
final generalManagerDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.generalManagerDashboard,
);
final headOfBusDevDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.headOfBusDevDashboard,
);
final headOfMarketingDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.headOfMarketingDashboard,
);
final itAdminDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.itAdminDashboard,
);
final operationsManagerDashboardAdapterProvider =
    genericDashboardAdapterProvider(PrimeCareForm.operationsManagerDashboard);

// --- NEWLY RESTORED ADAPTER PROVIDERS ---
final systemVerificationAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.systemVerificationDashboard,
);
final trainingHubAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.trainingHub,
);
final incidentReportAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.incidentReports,
);
final complianceAuditAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.complianceAudit,
);
final clinicalIntelligenceAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.clinicalIntelligence,
);
final financialSnapshotAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.financialSnapshot,
);
final billingLedgerAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.billingLedger,
);
final messagingAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.messaging,
);
final userManagementAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.userManagement,
);
final franchiseOperationsAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.franchiseOperations,
);
final marketingCampaignAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.marketingCampaigns,
);
final salesPipelineAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.salesPipeline,
);
final itSupportAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.itSupport,
);
final strategicGrowthAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.strategicGrowth,
);
final revenueAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.revenueAnalysis,
);
final operationalEfficiencyAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.operationalEfficiency,
);
final marketExpansionAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.marketExpansion,
);
final ebitdaAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ebitdaAnalysis,
);
final cashOnHandAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cashOnHand,
);
final netMarginAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.netMarginAnalysis,
);
final operationalBurnAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.operationalBurn,
);
final taxOptimizationAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.taxOptimization,
);
final arAlertAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.arAlert,
);
final capitalEfficiencyAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.capitalEfficiency,
);
final operationalInsightsAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.operationalInsights,
);
final burnRateAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.burnRateAnalysis,
);
final operationalVolumeAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.operationalVolume,
);
final uptimeMonitorAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.uptimeMonitor,
);
final latencyAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.latencyAnalysis,
);
final errorRateAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.errorRate,
);
final securityPostureAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.securityPosture,
);
final devOpsVelocityAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.devOpsVelocity,
);
final staffingMatrixAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.staffingMatrix,
);
final protocolComplianceAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.protocolCompliance,
);
final incidentTrendAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.incidentTrend,
);
final cashFlowAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cashFlow,
);
final ledgerCommandAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ledgerCommand,
);
final roiAnalysisAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.roiAnalysis,
);
final cacVolatilityAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.cacVolatility,
);
final businessOverviewAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.businessOverview,
);
final financialPerformanceAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.financialPerformance,
);
final complianceStatusAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.complianceStatus,
);
final appointmentAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.appointment,
);
final carePlanAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.carePlan,
);
final ticketAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ticket,
);
final responseTimeAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.responseTime,
);
final satisfactionScoreAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.satisfactionScore,
);
final slaBreachRiskAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.slaBreachRisk,
);
final leadManagementAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.leadManagement,
);
final pendingVerificationAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.pendingVerification,
);
final recentAuditAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.recentAudit,
);
final systemStatusAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.systemStatus,
);
final featureIntakeAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.featureIntake,
);
final platformMetricsAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.platformMetrics,
);
final ownerDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.ownerDashboard,
);
final trainingDirectorDashboardAdapterProvider =
    genericDashboardAdapterProvider(PrimeCareForm.trainingDirectorDashboard);
final franchiseSalesManagerDashboardAdapterProvider =
    genericDashboardAdapterProvider(
      PrimeCareForm.franchiseSalesManagerDashboard,
    );
final localMarketingManagerDashboardAdapterProvider =
    genericDashboardAdapterProvider(
      PrimeCareForm.localMarketingManagerDashboard,
    );
final partnershipManagerDashboardAdapterProvider =
    genericDashboardAdapterProvider(PrimeCareForm.partnershipManagerDashboard);
final patientDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.patientDashboard,
);
final regionalBdmDashboardAdapterProvider = genericDashboardAdapterProvider(
  PrimeCareForm.regionalBdmDashboard,
);
final regionalManagerUsaDashboardAdapterProvider =
    genericDashboardAdapterProvider(PrimeCareForm.regionalManagerUsaDashboard);

// --- Start of administrative_forms\administrative_forms_controller.dart ---

final administrativeFormsControllerProvider =
    StateNotifierProvider<
      AdministrativeFormsController,
      AdministrativeFormsViewModel
    >((ref) {
      return AdministrativeFormsController();
    });

class AdministrativeFormsController
    extends StateNotifier<AdministrativeFormsViewModel> {
  AdministrativeFormsController()
    : super(AdministrativeFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> approveForm(String formId) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}

// --- End of administrative_forms\administrative_forms_controller.dart ---

// --- Start of architectural_planning\architectural_planning_controller.dart ---

final architecturalPlanningAdapterProvider =
    FutureProvider<Result<ArchitecturalPlanningModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        // Architectural Planning might use 'cto' or similar, but let's try a specific role
        final result = await service.getMetrics('architectural_planning');
        return result.map(
          (DashboardMetrics metrics) =>
              ArchitecturalPlanningModel(metrics: metrics, insights: const []),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class ArchitecturalPlanningController {
  final WidgetRef ref;

  ArchitecturalPlanningController(this.ref);

  void refresh() {
    ref.invalidate(architecturalPlanningAdapterProvider);
  }
}

// --- End of architectural_planning\architectural_planning_controller.dart ---

// --- Start of billing_admin_dashboard\billing_admin_dashboard_controller.dart ---

class BillingAdminDashboardController {
  final WidgetRef ref;

  BillingAdminDashboardController(this.ref);

  void refresh() {
    ref.invalidate(billingAdminDashboardAdapterProvider);
  }
}

// --- End of billing_admin_dashboard\billing_admin_dashboard_controller.dart ---

// --- Start of ceo_dashboard\ceo_dashboard_controller.dart ---

// Alias for backwards compatibility
final ceoMetricsProvider = ceoDashboardAdapterProvider;

class CeoDashboardController {
  final WidgetRef ref;

  CeoDashboardController(this.ref);

  void refresh() {
    ref.invalidate(ceoDashboardAdapterProvider);
  }
}

// --- End of ceo_dashboard\ceo_dashboard_controller.dart ---

// --- Start of cfo_dashboard\cfo_dashboard_controller.dart ---

// Alias for registry compatibility if needed
final cfoMetricsProvider = cfoDashboardAdapterProvider;

class CFODashboardController
    extends StateNotifier<AsyncValue<Result<CFODashboardModel>>> {
  CFODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      // Mock data for now, real implementation would call a service
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = CFODashboardModel(
        kpis: [
          KpiData(
            title: 'Total Revenue',
            value: '\$1.2M',
            subtitle: '+12% from last month',
          ),
          KpiData(
            title: 'Operating Expenses',
            value: '\$450K',
            subtitle: '-5% optimization',
          ),
          KpiData(title: 'Net Profit Margin', value: '28%', subtitle: 'Stable'),
          KpiData(
            title: 'Outstanding Claims',
            value: '\$85K',
            subtitle: '12 pending',
          ),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}

// --- End of cfo_dashboard\cfo_dashboard_controller.dart ---

// --- Start of chiropractor\chiropractor_controller.dart ---

final chiropractorControllerProvider =
    StateNotifierProvider<ChiropractorController, ChiropractorViewModel>((ref) {
      return ChiropractorController();
    });

class ChiropractorController extends StateNotifier<ChiropractorViewModel> {
  ChiropractorController() : super(ChiropractorViewModel.initial());
}

// --- End of chiropractor\chiropractor_controller.dart ---

// --- Start of client\client_controller.dart ---

final clientAdapterProvider =
    StateNotifierProvider<
      ClientController,
      AsyncValue<Result<ClientViewModel>>
    >((ref) {
      return ClientController(ref);
    });

class ClientController
    extends StateNotifier<AsyncValue<Result<ClientViewModel>>> {
  final Ref ref;

  ClientController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('client');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              ClientViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of client\client_controller.dart ---

// --- Start of client_dashboard\client_dashboard_controller.dart ---

final clientDashboardAdapterProvider =
    FutureProvider<Result<ClientDashboardViewModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('client');
        return result.map(
          (DashboardMetrics metrics) =>
              ClientDashboardViewModel(metrics: metrics, insights: const []),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class ClientDashboardController {
  final WidgetRef ref;

  ClientDashboardController(this.ref);

  void refresh() {
    ref.invalidate(clientDashboardAdapterProvider);
  }
}

// --- End of client_dashboard\client_dashboard_controller.dart ---

// --- Start of clinical_director\clinical_director_controller.dart ---

final clinicalDirectorAdapterProvider =
    StateNotifierProvider<
      ClinicalDirectorController,
      AsyncValue<Result<ClinicalDirectorViewModel>>
    >((ref) {
      return ClinicalDirectorController(ref);
    });

class ClinicalDirectorController
    extends StateNotifier<AsyncValue<Result<ClinicalDirectorViewModel>>> {
  final Ref ref;

  ClinicalDirectorController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('clinical_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              ClinicalDirectorViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of clinical_director\clinical_director_controller.dart ---

// --- Start of clinical_director_dashboard\clinical_director_dashboard_controller.dart ---

final clinicalDirectorDashboardAdapterProvider =
    FutureProvider<Result<ClinicalDirectorDashboardViewModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('clinical_director');
        return result.map<ClinicalDirectorDashboardViewModel>(
          (metrics) => ClinicalDirectorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        );
      } catch (e, st) {
        return Failure<ClinicalDirectorDashboardViewModel>(e, st);
      }
    });

class ClinicalDirectorDashboardController {
  final WidgetRef ref;

  ClinicalDirectorDashboardController(this.ref);

  void refresh() {
    ref.invalidate(clinicalDirectorDashboardAdapterProvider);
  }
}

// --- End of clinical_director_dashboard\clinical_director_dashboard_controller.dart ---

// --- Start of clinical_forms\clinical_forms_controller.dart ---

final clinicalFormsControllerProvider =
    StateNotifierProvider<ClinicalFormsController, ClinicalFormsViewModel>((
      ref,
    ) {
      return ClinicalFormsController();
    });

class ClinicalFormsController extends StateNotifier<ClinicalFormsViewModel> {
  ClinicalFormsController() : super(ClinicalFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}

// --- End of clinical_forms\clinical_forms_controller.dart ---

// --- Start of clinic_dashboard\clinic_dashboard_controller.dart ---

final clinicDashboardAdapterProvider =
    FutureProvider<Result<ClinicDashboardModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('clinic');
        return result.map(
          (DashboardMetrics metrics) => ClinicDashboardModel(
            metrics: metrics,
            recentActivity: metrics.recentActivity,
          ),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class ClinicDashboardController {
  final WidgetRef ref;

  ClinicDashboardController(this.ref);

  void refresh() {
    ref.invalidate(clinicDashboardAdapterProvider);
  }
}

// --- End of clinic_dashboard\clinic_dashboard_controller.dart ---

// --- Start of common_forms\common_forms_controller.dart ---

final commonFormsControllerProvider =
    StateNotifierProvider<CommonFormsController, CommonFormsViewModel>((ref) {
      return CommonFormsController();
    });

class CommonFormsController extends StateNotifier<CommonFormsViewModel> {
  CommonFormsController() : super(CommonFormsViewModel.initial());

  void selectForm(String form) {
    state = CommonFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}

// --- End of common_forms\common_forms_controller.dart ---

// --- Start of community_outreach_dashboard\community_outreach_dashboard_controller.dart ---

final communityOutreachDashboardAdapterProvider =
    FutureProvider<Result<CommunityOutreachDashboardViewModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        final result = await service.getMetrics('community_outreach');
        return result.map(
          (DashboardMetrics metrics) => CommunityOutreachDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class CommunityOutreachDashboardController {
  final WidgetRef ref;

  CommunityOutreachDashboardController(this.ref);

  void refresh() {
    ref.invalidate(communityOutreachDashboardAdapterProvider);
  }
}

// --- End of community_outreach_dashboard\community_outreach_dashboard_controller.dart ---

// --- Start of compliance_hub\compliance_hub_controller.dart ---

final complianceHubAdapterProvider = FutureProvider<Result<ComplianceHubModel>>(
  (ref) async {
    final service = ref.watch(dashboardServiceProvider);

    try {
      // Using 'compliance_manager' as the role identifier for metrics
      final result = await service.getMetrics('compliance_manager');
      return result.map(
        (DashboardMetrics metrics) =>
            ComplianceHubModel(metrics: metrics, insights: const []),
      );
    } catch (e, st) {
      return Failure(e, st);
    }
  },
);

// Alias for backwards compatibility with registry lookups
final complianceManagerDashboardAdapterProvider = complianceHubAdapterProvider;

class ComplianceHubController {
  final WidgetRef ref;

  ComplianceHubController(this.ref);

  void refresh() {
    ref.invalidate(complianceHubAdapterProvider);
  }
}

// --- End of compliance_hub\compliance_hub_controller.dart ---

// --- Start of compliance_manager\compliance_manager_controller.dart ---

final complianceManagerControllerProvider =
    StateNotifierProvider<
      ComplianceManagerController,
      ComplianceManagerViewModel
    >((ref) {
      return ComplianceManagerController();
    });

class ComplianceManagerController
    extends StateNotifier<ComplianceManagerViewModel> {
  ComplianceManagerController() : super(ComplianceManagerViewModel.initial());
}

// --- End of compliance_manager\compliance_manager_controller.dart ---

// --- Start of coo_dashboard\coo_dashboard_controller.dart ---

// Alias for registry compatibility
final cooMetricsProvider = cooDashboardAdapterProvider;

class COODashboardController
    extends StateNotifier<AsyncValue<Result<COODashboardModel>>> {
  COODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = COODashboardModel(
        kpis: [
          KpiData(
            title: 'Logistics Efficiency',
            value: '94%',
            subtitle: 'On track',
          ),
          KpiData(
            title: 'Warehouse Utilization',
            value: '78%',
            subtitle: 'Optimal',
          ),
          KpiData(
            title: 'Avg Delivery Time',
            value: '1.2 days',
            subtitle: '-0.2 days improvement',
          ),
          KpiData(
            title: 'Active Fleet',
            value: '45 vehicles',
            subtitle: '5 in maintenance',
          ),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}

// --- End of coo_dashboard\coo_dashboard_controller.dart ---

// --- Start of corporate_governance_dashboard\corporate_governance_dashboard_controller.dart ---

final corporateGovernanceDashboardAdapterProvider =
    StateNotifierProvider<
      CorporateGovernanceDashboardController,
      AsyncValue<Result<CorporateGovernanceDashboardViewModel>>
    >((ref) {
      return CorporateGovernanceDashboardController(ref);
    });

class CorporateGovernanceDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<CorporateGovernanceDashboardViewModel>>
        > {
  final Ref ref;

  CorporateGovernanceDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('corporate_governance');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => CorporateGovernanceDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void triggerRemediation() {
    // Remediation logic here
  }
}

// --- End of corporate_governance_dashboard\corporate_governance_dashboard_controller.dart ---

// --- Start of course_architect_dashboard\course_architect_dashboard_controller.dart ---

final courseArchitectAdapterProvider =
    StateNotifierProvider<
      CourseArchitectDashboardController,
      AsyncValue<Result<CourseArchitectDashboardViewModel>>
    >((ref) {
      return CourseArchitectDashboardController(ref);
    });

class CourseArchitectDashboardController
    extends
        StateNotifier<AsyncValue<Result<CourseArchitectDashboardViewModel>>> {
  final Ref ref;

  CourseArchitectDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('course_architect');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => CourseArchitectDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of course_architect_dashboard\course_architect_dashboard_controller.dart ---

// --- Start of crm_forms\crm_forms_controller.dart ---

final crmFormsControllerProvider =
    StateNotifierProvider<CrmFormsController, CrmFormsViewModel>((ref) {
      return CrmFormsController();
    });

class CrmFormsController extends StateNotifier<CrmFormsViewModel> {
  CrmFormsController() : super(CrmFormsViewModel.initial());

  void selectForm(String form) {
    state = CrmFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}

// --- End of crm_forms\crm_forms_controller.dart ---

// --- Start of cto_dashboard\cto_dashboard_controller.dart ---

// Alias for registry compatibility
final ctoMetricsProvider = ctoDashboardAdapterProvider;

class CTODashboardController
    extends StateNotifier<AsyncValue<Result<CTODashboardModel>>> {
  CTODashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = CTODashboardModel(
        kpis: [
          KpiData(
            title: 'System Uptime',
            value: '99.99%',
            subtitle: 'High availability',
          ),
          KpiData(
            title: 'Active Users',
            value: '1,240',
            subtitle: '+15% this week',
          ),
          KpiData(
            title: 'API Latency',
            value: '120ms',
            subtitle: '-10ms optimization',
          ),
          KpiData(
            title: 'Security Incidents',
            value: '0',
            subtitle: 'All clear',
          ),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}

// --- End of cto_dashboard\cto_dashboard_controller.dart ---

// --- Start of customer_support_dashboard\customer_support_dashboard_controller.dart ---

class CustomerSupportDashboardController
    extends
        StateNotifier<AsyncValue<Result<CustomerSupportDashboardViewModel>>> {
  final Ref ref;

  CustomerSupportDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('customer_support');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => CustomerSupportDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of customer_support_dashboard\customer_support_dashboard_controller.dart ---

// --- Start of cx_director_dashboard\cx_director_dashboard_controller.dart ---

class CXDirectorDashboardController
    extends StateNotifier<AsyncValue<Result<CXDirectorDashboardViewModel>>> {
  final Ref ref;

  CXDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('cx_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => CXDirectorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of cx_director_dashboard\cx_director_dashboard_controller.dart ---

// --- Start of dynamic_screen_dashboard\dynamic_screen_dashboard_controller.dart ---

final dynamicScreenDashboardAdapterProvider =
    StateNotifierProvider<
      DynamicScreenDashboardController,
      AsyncValue<Result<DynamicScreenDashboardViewModel>>
    >((ref) {
      return DynamicScreenDashboardController(ref);
    });

class DynamicScreenDashboardController
    extends StateNotifier<AsyncValue<Result<DynamicScreenDashboardViewModel>>> {
  final Ref ref;

  DynamicScreenDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('dynamic_screen');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => DynamicScreenDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of dynamic_screen_dashboard\dynamic_screen_dashboard_controller.dart ---

// --- Start of family_dashboard\family_dashboard_controller.dart ---

final familyDashboardAdapterProvider =
    StateNotifierProvider<
      FamilyDashboardController,
      AsyncValue<Result<FamilyDashboardViewModel>>
    >((ref) {
      return FamilyDashboardController(ref);
    });

class FamilyDashboardController
    extends StateNotifier<AsyncValue<Result<FamilyDashboardViewModel>>> {
  final Ref ref;

  FamilyDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('family');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              FamilyDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of family_dashboard\family_dashboard_controller.dart ---

// --- Start of family_member\family_member_controller.dart ---

final familyMemberControllerProvider =
    StateNotifierProvider<FamilyMemberController, FamilyMemberViewModel>((ref) {
      return FamilyMemberController();
    });

class FamilyMemberController extends StateNotifier<FamilyMemberViewModel> {
  FamilyMemberController() : super(FamilyMemberViewModel.initial());
}

// --- End of family_member\family_member_controller.dart ---

// --- Start of family_member_dashboard\family_member_dashboard_controller.dart ---

final familyMemberDashboardAdapterProvider =
    StateNotifierProvider<
      FamilyMemberDashboardController,
      AsyncValue<Result<FamilyMemberDashboardViewModel>>
    >((ref) {
      return FamilyMemberDashboardController(ref);
    });

class FamilyMemberDashboardController
    extends StateNotifier<AsyncValue<Result<FamilyMemberDashboardViewModel>>> {
  final Ref ref;

  FamilyMemberDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('family_member');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => FamilyMemberDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of family_member_dashboard\family_member_dashboard_controller.dart ---

// --- Start of finance_director_dashboard\finance_director_dashboard_controller.dart ---

class FinanceDirectorDashboardController
    extends
        StateNotifier<AsyncValue<Result<FinanceDirectorDashboardViewModel>>> {
  final Ref ref;

  FinanceDirectorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('finance_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => FinanceDirectorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of finance_director_dashboard\finance_director_dashboard_controller.dart ---

// --- Start of financial_forms\financial_forms_controller.dart ---

final financialFormsControllerProvider =
    StateNotifierProvider<FinancialFormsController, FinancialFormsViewModel>((
      ref,
    ) {
      return FinancialFormsController();
    });

class FinancialFormsController extends StateNotifier<FinancialFormsViewModel> {
  FinancialFormsController() : super(FinancialFormsViewModel.initial());

  void selectForm(String form) {
    state = FinancialFormsViewModel(
      availableForms: state.availableForms,
      selectedForm: form,
    );
  }
}

// --- End of financial_forms\financial_forms_controller.dart ---

// --- Start of franchise_owner\franchise_owner_controller.dart ---

final franchiseOwnerControllerProvider =
    StateNotifierProvider<FranchiseOwnerController, FranchiseOwnerViewModel>((
      ref,
    ) {
      return FranchiseOwnerController();
    });

class FranchiseOwnerController extends StateNotifier<FranchiseOwnerViewModel> {
  FranchiseOwnerController() : super(FranchiseOwnerViewModel.initial());
}

// --- End of franchise_owner\franchise_owner_controller.dart ---

// --- Start of franchise_owner_dashboard\franchise_owner_dashboard_controller.dart ---

class FranchiseOwnerDashboardController
    extends
        StateNotifier<AsyncValue<Result<FranchiseOwnerDashboardViewModel>>> {
  final Ref ref;

  FranchiseOwnerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('franchise_owner');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => FranchiseOwnerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of franchise_owner_dashboard\franchise_owner_dashboard_controller.dart ---

// --- Start of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_controller.dart ---

final franchiseSalesAdapterProvider =
    StateNotifierProvider<
      FranchiseSalesManagerDashboardController,
      AsyncValue<Result<FranchiseSalesManagerDashboardViewModel>>
    >((ref) {
      return FranchiseSalesManagerDashboardController(ref);
    });

class FranchiseSalesManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<FranchiseSalesManagerDashboardViewModel>>
        > {
  final Ref ref;

  FranchiseSalesManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('franchise_sales_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => FranchiseSalesManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of franchise_sales_manager_dashboard\franchise_sales_manager_dashboard_controller.dart ---

// --- Start of general_manager_dashboard\general_manager_dashboard_controller.dart ---

final generalManagerAdapterProvider =
    StateNotifierProvider<
      GeneralManagerDashboardController,
      AsyncValue<Result<GeneralManagerDashboardViewModel>>
    >((ref) {
      return GeneralManagerDashboardController(ref);
    });

class GeneralManagerDashboardController
    extends
        StateNotifier<AsyncValue<Result<GeneralManagerDashboardViewModel>>> {
  final Ref ref;

  GeneralManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('general_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => GeneralManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of general_manager_dashboard\general_manager_dashboard_controller.dart ---

// --- Start of guest_dashboard\guest_dashboard_controller.dart ---

final guestDashboardAdapterProvider =
    StateNotifierProvider<
      GuestDashboardController,
      AsyncValue<Result<GuestDashboardViewModel>>
    >((ref) {
      return GuestDashboardController(ref);
    });

class GuestDashboardController
    extends StateNotifier<AsyncValue<Result<GuestDashboardViewModel>>> {
  final Ref ref;

  GuestDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('guest');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              GuestDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of guest_dashboard\guest_dashboard_controller.dart ---

// --- Start of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_controller.dart ---

final headOfBusDevAdapterProvider =
    StateNotifierProvider<
      HeadOfBusDevDashboardController,
      AsyncValue<Result<HeadOfBusDevDashboardViewModel>>
    >((ref) {
      return HeadOfBusDevDashboardController(ref);
    });

class HeadOfBusDevDashboardController
    extends StateNotifier<AsyncValue<Result<HeadOfBusDevDashboardViewModel>>> {
  final Ref ref;

  HeadOfBusDevDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('head_of_bus_dev');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => HeadOfBusDevDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of head_of_bus_dev_dashboard\head_of_bus_dev_dashboard_controller.dart ---

// --- Start of head_of_marketing_dashboard\head_of_marketing_dashboard_controller.dart ---

final headOfMarketingAdapterProvider =
    StateNotifierProvider<
      HeadOfMarketingDashboardController,
      AsyncValue<Result<HeadOfMarketingDashboardViewModel>>
    >((ref) {
      return HeadOfMarketingDashboardController(ref);
    });

class HeadOfMarketingDashboardController
    extends
        StateNotifier<AsyncValue<Result<HeadOfMarketingDashboardViewModel>>> {
  final Ref ref;

  HeadOfMarketingDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('head_of_marketing');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => HeadOfMarketingDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of head_of_marketing_dashboard\head_of_marketing_dashboard_controller.dart ---

// --- Start of hr_director_dashboard\hr_director_dashboard_controller.dart ---

final hrDirectorDashboardAdapterProvider =
    StateNotifierProvider<
      HrDirectorDashboardController,
      AsyncValue<Result<HumanResourcesDirectorDashboardViewModel>>
    >((ref) {
      return HrDirectorDashboardController(ref);
    });

class HrDirectorDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<HumanResourcesDirectorDashboardViewModel>>
        > {
  final Ref ref;

  HrDirectorDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('hr_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              HumanResourcesDirectorDashboardViewModel(
                metrics: metrics,
                insights: const [],
              ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of hr_director_dashboard\hr_director_dashboard_controller.dart ---

// --- Start of hr_forms\hr_forms_controller.dart ---

final hrFormsControllerProvider =
    StateNotifierProvider<HrFormsController, HrFormsViewModel>((ref) {
      return HrFormsController();
    });

class HrFormsController extends StateNotifier<HrFormsViewModel> {
  HrFormsController() : super(HrFormsViewModel.initial());

  void selectForm(String form) {
    state = state.copyWith(selectedForm: form);
  }

  Future<void> submitForm(Map<String, dynamic> data) async {
    state = state.copyWith(isSubmitting: true);
    // Simulation of form submission
    await Future<void>.delayed(const Duration(seconds: 1));
    state = state.copyWith(isSubmitting: false);
  }
}

// --- End of hr_forms\hr_forms_controller.dart ---

// --- Start of hr_hiring_dashboard\hr_hiring_dashboard_controller.dart ---

final hrHiringDashboardAdapterProvider =
    StateNotifierProvider<
      HrHiringDashboardController,
      AsyncValue<Result<HrHiringDashboardViewModel>>
    >((ref) {
      return HrHiringDashboardController(ref);
    });

class HrHiringDashboardController
    extends StateNotifier<AsyncValue<Result<HrHiringDashboardViewModel>>> {
  final Ref ref;

  HrHiringDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('hr_hiring');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              HrHiringDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of hr_hiring_dashboard\hr_hiring_dashboard_controller.dart ---

// --- Start of hr_manager_dashboard\hr_manager_dashboard_controller.dart ---

final hrManagerDashboardAdapterProvider =
    StateNotifierProvider<
      HrManagerDashboardController,
      AsyncValue<Result<HumanResourcesManagerDashboardViewModel>>
    >((ref) {
      return HrManagerDashboardController(ref);
    });

class HrManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<HumanResourcesManagerDashboardViewModel>>
        > {
  final Ref ref;

  HrManagerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('hr_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => HumanResourcesManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of hr_manager_dashboard\hr_manager_dashboard_controller.dart ---

// --- Start of infection_control_dashboard\infection_control_dashboard_controller.dart ---

final infectionControlDashboardAdapterProvider =
    StateNotifierProvider<
      InfectionControlDashboardController,
      AsyncValue<Result<InfectionControlDashboardViewModel>>
    >((ref) {
      return InfectionControlDashboardController(ref);
    });

class InfectionControlDashboardController
    extends
        StateNotifier<AsyncValue<Result<InfectionControlDashboardViewModel>>> {
  final Ref ref;

  InfectionControlDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('infection_control');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => InfectionControlDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of infection_control_dashboard\infection_control_dashboard_controller.dart ---

// --- Start of intake_coordinator\intake_coordinator_controller.dart ---

final intakeCoordinatorAdapterProvider =
    StateNotifierProvider<
      IntakeCoordinatorController,
      AsyncValue<Result<IntakeCoordinatorViewModel>>
    >((ref) {
      return IntakeCoordinatorController(ref);
    });

class IntakeCoordinatorController
    extends StateNotifier<AsyncValue<Result<IntakeCoordinatorViewModel>>> {
  final Ref ref;

  IntakeCoordinatorController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('intake_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              IntakeCoordinatorViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of intake_coordinator\intake_coordinator_controller.dart ---

// --- Start of intake_coordinator_dashboard\intake_coordinator_dashboard_controller.dart ---

final intakeCoordinatorDashboardAdapterProvider =
    StateNotifierProvider<
      IntakeCoordinatorDashboardController,
      AsyncValue<Result<IntakeCoordinatorDashboardViewModel>>
    >((ref) {
      return IntakeCoordinatorDashboardController(ref);
    });

class IntakeCoordinatorDashboardController
    extends
        StateNotifier<AsyncValue<Result<IntakeCoordinatorDashboardViewModel>>> {
  final Ref ref;

  IntakeCoordinatorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('intake_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => IntakeCoordinatorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of intake_coordinator_dashboard\intake_coordinator_dashboard_controller.dart ---

// --- Start of intake_dashboard\intake_dashboard_controller.dart ---

final intakeDashboardAdapterProvider =
    StateNotifierProvider<
      IntakeDashboardController,
      AsyncValue<Result<IntakeDashboardViewModel>>
    >((ref) {
      return IntakeDashboardController(ref);
    });

class IntakeDashboardController
    extends StateNotifier<AsyncValue<Result<IntakeDashboardViewModel>>> {
  final Ref ref;

  IntakeDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('intake');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              IntakeDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of intake_dashboard\intake_dashboard_controller.dart ---

// --- Start of it_security_dashboard\it_security_dashboard_controller.dart ---

final itSecurityDashboardAdapterProvider =
    StateNotifierProvider<
      ItSecurityDashboardController,
      AsyncValue<Result<ITSecurityDashboardViewModel>>
    >((ref) {
      return ItSecurityDashboardController(ref);
    });

class ItSecurityDashboardController
    extends StateNotifier<AsyncValue<Result<ITSecurityDashboardViewModel>>> {
  final Ref ref;

  ItSecurityDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('it_security');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ITSecurityDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of it_security_dashboard\it_security_dashboard_controller.dart ---

// --- Start of local_marketing_manager_dashboard\local_marketing_manager_dashboard_controller.dart ---

class LocalMarketingManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<LocalMarketingManagerDashboardViewModel>>
        > {
  final Ref ref;

  LocalMarketingManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('local_marketing');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => LocalMarketingManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of local_marketing_manager_dashboard\local_marketing_manager_dashboard_controller.dart ---

// --- Start of marketing_manager\marketing_manager_controller.dart ---

final marketingManagerControllerProvider =
    StateNotifierProvider<
      MarketingManagerController,
      MarketingManagerViewModel
    >((ref) {
      return MarketingManagerController();
    });

class MarketingManagerController
    extends StateNotifier<MarketingManagerViewModel> {
  MarketingManagerController() : super(MarketingManagerViewModel.initial());
}

// --- End of marketing_manager\marketing_manager_controller.dart ---

// --- Start of marketing_manager\marketing_manager_dashboard_controller.dart ---

final marketingManagerDashboardAdapterProvider =
    StateNotifierProvider<
      MarketingManagerDashboardController,
      AsyncValue<Result<MarketingManagerDashboardViewModel>>
    >((ref) {
      return MarketingManagerDashboardController(ref);
    });

class MarketingManagerDashboardController
    extends
        StateNotifier<AsyncValue<Result<MarketingManagerDashboardViewModel>>> {
  final Ref ref;

  MarketingManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('marketing_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => MarketingManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of marketing_manager\marketing_manager_dashboard_controller.dart ---

// --- Start of operations_manager_dashboard\operations_manager_dashboard_controller.dart ---

class OperationsManagerDashboardController
    extends
        StateNotifier<AsyncValue<Result<OperationsManagerDashboardViewModel>>> {
  final Ref ref;

  OperationsManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('operations_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => OperationsManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of operations_manager_dashboard\operations_manager_dashboard_controller.dart ---

// --- Start of owner_dashboard\owner_dashboard_controller.dart ---

class OwnerDashboardController
    extends StateNotifier<AsyncValue<Result<OwnerDashboardViewModel>>> {
  final Ref ref;

  OwnerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('owner');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              OwnerDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of owner_dashboard\owner_dashboard_controller.dart ---

// --- Start of partnership_manager_dashboard\partnership_manager_dashboard_controller.dart ---

class PartnershipManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<PartnershipManagerDashboardViewModel>>
        > {
  final Ref ref;

  PartnershipManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('partnership_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => PartnershipManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of partnership_manager_dashboard\partnership_manager_dashboard_controller.dart ---

// --- Start of patient_dashboard\patient_dashboard_controller.dart ---

class PatientDashboardController {
  final WidgetRef ref;

  PatientDashboardController(this.ref);

  void refresh() {
    ref.invalidate(patientDashboardAdapterProvider);
  }
}

// --- End of patient_dashboard\patient_dashboard_controller.dart ---

// --- Start of physiotherapist\physiotherapist_controller.dart ---

final physiotherapistControllerProvider =
    StateNotifierProvider<PhysiotherapistController, PhysiotherapistViewModel>((
      ref,
    ) {
      return PhysiotherapistController();
    });

class PhysiotherapistController
    extends StateNotifier<PhysiotherapistViewModel> {
  PhysiotherapistController() : super(PhysiotherapistViewModel.initial());
}

// --- End of physiotherapist\physiotherapist_controller.dart ---

// --- Start of psw\psw_controller.dart ---

final pswAdapterProvider =
    StateNotifierProvider<PswController, AsyncValue<Result<PswViewModel>>>((
      ref,
    ) {
      return PswController(ref);
    });

class PswController extends StateNotifier<AsyncValue<Result<PswViewModel>>> {
  final Ref ref;

  PswController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('psw');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              PswViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of psw\psw_controller.dart ---

// --- Start of psw_dashboard\psw_dashboard_controller.dart ---

final pswDashboardAdapterProvider =
    StateNotifierProvider<
      PswDashboardController,
      AsyncValue<Result<PswDashboardViewModel>>
    >((ref) {
      return PswDashboardController(ref);
    });

class PswDashboardController
    extends StateNotifier<AsyncValue<Result<PswDashboardViewModel>>> {
  final Ref ref;

  PswDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('psw');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              PswDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of psw_dashboard\psw_dashboard_controller.dart ---

// --- Start of qa_dashboard\qa_dashboard_controller.dart ---

final qaDashboardAdapterProvider =
    StateNotifierProvider<
      QaDashboardController,
      AsyncValue<Result<QaDashboardViewModel>>
    >((ref) {
      return QaDashboardController(ref);
    });

class QaDashboardController
    extends StateNotifier<AsyncValue<Result<QaDashboardViewModel>>> {
  final Ref ref;

  QaDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('qa');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              QaDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of qa_dashboard\qa_dashboard_controller.dart ---

// --- Start of quality_assurance_dashboard\quality_assurance_dashboard_controller.dart ---

final qualityAssuranceDashboardAdapterProvider =
    StateNotifierProvider<
      QualityAssuranceDashboardController,
      AsyncValue<Result<QualityAssuranceDashboardViewModel>>
    >((ref) {
      return QualityAssuranceDashboardController(ref);
    });

class QualityAssuranceDashboardController
    extends
        StateNotifier<AsyncValue<Result<QualityAssuranceDashboardViewModel>>> {
  final Ref ref;

  QualityAssuranceDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('quality_assurance');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => QualityAssuranceDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of quality_assurance_dashboard\quality_assurance_dashboard_controller.dart ---

// --- Start of receptionist_dashboard\receptionist_dashboard_controller.dart ---

final receptionistDashboardAdapterProvider =
    StateNotifierProvider<
      ReceptionistDashboardController,
      AsyncValue<Result<ReceptionistDashboardViewModel>>
    >((ref) {
      return ReceptionistDashboardController(ref);
    });

class ReceptionistDashboardController
    extends StateNotifier<AsyncValue<Result<ReceptionistDashboardViewModel>>> {
  final Ref ref;

  ReceptionistDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('receptionist');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ReceptionistDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of receptionist_dashboard\receptionist_dashboard_controller.dart ---

// --- Start of regional_bdm_dashboard\regional_bdm_dashboard_controller.dart ---

class RegionalBdmDashboardController
    extends StateNotifier<AsyncValue<Result<RegionalBdmDashboardViewModel>>> {
  final Ref ref;

  RegionalBdmDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_bdm');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => RegionalBdmDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of regional_bdm_dashboard\regional_bdm_dashboard_controller.dart ---

// --- Start of regional_manager\regional_manager_dashboard_controller.dart ---

final regionalManagerDashboardAdapterProvider =
    StateNotifierProvider<
      RegionalManagerDashboardController,
      AsyncValue<Result<RegionalManagerDashboardViewModel>>
    >((ref) {
      return RegionalManagerDashboardController(ref);
    });

class RegionalManagerDashboardController
    extends
        StateNotifier<AsyncValue<Result<RegionalManagerDashboardViewModel>>> {
  final Ref ref;

  RegionalManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => RegionalManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of regional_manager\regional_manager_dashboard_controller.dart ---

// --- Start of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_controller.dart ---

final regionalManagerOntarioDashboardAdapterProvider =
    StateNotifierProvider<
      RegionalManagerOntarioDashboardController,
      AsyncValue<Result<RegionalManagerOntarioDashboardViewModel>>
    >((ref) {
      return RegionalManagerOntarioDashboardController(ref);
    });

class RegionalManagerOntarioDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<RegionalManagerOntarioDashboardViewModel>>
        > {
  final Ref ref;

  RegionalManagerOntarioDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager_ontario');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RegionalManagerOntarioDashboardViewModel(
                metrics: metrics,
                insights: const [],
              ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of regional_manager_ontario_dashboard\regional_manager_ontario_dashboard_controller.dart ---

// --- Start of regional_manager_usa_dashboard\regional_manager_usa_dashboard_controller.dart ---

class RegionalManagerUsaDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<RegionalManagerUsaDashboardViewModel>>
        > {
  final Ref ref;

  RegionalManagerUsaDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('regional_manager_usa');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => RegionalManagerUsaDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of regional_manager_usa_dashboard\regional_manager_usa_dashboard_controller.dart ---

// --- Start of region_dashboard\region_dashboard_controller.dart ---

final regionDashboardAdapterProvider =
    StateNotifierProvider<
      RegionDashboardController,
      AsyncValue<Result<RegionDashboardModel>>
    >((ref) {
      return RegionDashboardController();
    });

// Alias for registry compatibility
final regionalManagerOntarioMetricsProvider = regionDashboardAdapterProvider;

class RegionDashboardController
    extends StateNotifier<AsyncValue<Result<RegionDashboardModel>>> {
  RegionDashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = RegionDashboardModel(
        kpis: [
          KpiData(
            title: 'Regional Growth',
            value: '15%',
            subtitle: 'Ahead of target',
          ),
          KpiData(
            title: 'Clinic Density',
            value: '8.2',
            subtitle: 'Per 100k pop',
          ),
          KpiData(
            title: 'Resource Utilization',
            value: '82%',
            subtitle: 'Optimized',
          ),
          KpiData(title: 'Compliance Rate', value: '98%', subtitle: 'High'),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}

// --- End of region_dashboard\region_dashboard_controller.dart ---

// --- Start of rmt_dashboard\rmt_dashboard_controller.dart ---

final rmtDashboardAdapterProvider =
    StateNotifierProvider<
      RmtDashboardController,
      AsyncValue<Result<RmtDashboardViewModel>>
    >((ref) {
      return RmtDashboardController(ref);
    });

class RmtDashboardController
    extends StateNotifier<AsyncValue<Result<RmtDashboardViewModel>>> {
  final Ref ref;

  RmtDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rmt');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RmtDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of rmt_dashboard\rmt_dashboard_controller.dart ---

// --- Start of rn\rn_controller.dart ---

final rnAdapterProvider =
    StateNotifierProvider<RnController, AsyncValue<Result<RnViewModel>>>((ref) {
      return RnController(ref);
    });

class RnController extends StateNotifier<AsyncValue<Result<RnViewModel>>> {
  final Ref ref;

  RnController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rn');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RnViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of rn\rn_controller.dart ---

// --- Start of rn_dashboard\rn_dashboard_controller.dart ---

final rnDashboardAdapterProvider =
    StateNotifierProvider<
      RnDashboardController,
      AsyncValue<Result<RnDashboardViewModel>>
    >((ref) {
      return RnDashboardController(ref);
    });

class RnDashboardController
    extends StateNotifier<AsyncValue<Result<RnDashboardViewModel>>> {
  final Ref ref;

  RnDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rn');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RnDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of rn_dashboard\rn_dashboard_controller.dart ---

// --- Start of rpn\rpn_controller.dart ---

final rpnAdapterProvider =
    StateNotifierProvider<RpnController, AsyncValue<Result<RpnViewModel>>>((
      ref,
    ) {
      return RpnController(ref);
    });

class RpnController extends StateNotifier<AsyncValue<Result<RpnViewModel>>> {
  final Ref ref;

  RpnController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('rpn');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              RpnViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of rpn\rpn_controller.dart ---

// --- Start of scheduler_dashboard\scheduler_dashboard_controller.dart ---

final schedulerDashboardAdapterProvider =
    StateNotifierProvider<
      SchedulerDashboardController,
      AsyncValue<Result<SchedulerDashboardViewModel>>
    >((ref) {
      return SchedulerDashboardController(ref);
    });

class SchedulerDashboardController
    extends StateNotifier<AsyncValue<Result<SchedulerDashboardViewModel>>> {
  final Ref ref;

  SchedulerDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('scheduler');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              SchedulerDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of scheduler_dashboard\scheduler_dashboard_controller.dart ---

// --- Start of scrum_master_dashboard\scrum_master_dashboard_controller.dart ---

final scrumMasterDashboardAdapterProvider =
    StateNotifierProvider<
      ScrumMasterDashboardController,
      AsyncValue<Result<ScrumMasterDashboardViewModel>>
    >((ref) {
      return ScrumMasterDashboardController(ref);
    });

class ScrumMasterDashboardController
    extends StateNotifier<AsyncValue<Result<ScrumMasterDashboardViewModel>>> {
  final Ref ref;

  ScrumMasterDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('scrum_master');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ScrumMasterDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of scrum_master_dashboard\scrum_master_dashboard_controller.dart ---

// --- Start of shareholder_intelligence\shareholder_intelligence_controller.dart ---

final shareholderIntelligenceAdapterProvider =
    StateNotifierProvider<
      ShareholderIntelligenceController,
      AsyncValue<Result<ShareholderIntelligenceViewModel>>
    >((ref) {
      return ShareholderIntelligenceController(ref);
    });

class ShareholderIntelligenceController
    extends
        StateNotifier<AsyncValue<Result<ShareholderIntelligenceViewModel>>> {
  final Ref ref;

  ShareholderIntelligenceController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('shareholder_intelligence');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ShareholderIntelligenceViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of shareholder_intelligence\shareholder_intelligence_controller.dart ---

// --- Start of sign_in_view\sign_in_controller.dart ---

final signInControllerProvider =
    StateNotifierProvider<SignInController, AsyncValue<SignInViewModel>>((ref) {
      return SignInController(ref);
    });

class SignInController extends StateNotifier<AsyncValue<SignInViewModel>> {
  final Ref ref;

  SignInController(this.ref) : super(const AsyncValue.data(SignInViewModel()));

  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    // Implementation for sign in logic
    state = const AsyncValue.data(SignInViewModel());
  }
}

// --- End of sign_in_view\sign_in_controller.dart ---

// --- Start of sign_out_view\sign_out_controller.dart ---

final signOutControllerProvider =
    StateNotifierProvider<SignOutController, AsyncValue<SignOutViewModel>>((
      ref,
    ) {
      return SignOutController(ref);
    });

class SignOutController extends StateNotifier<AsyncValue<SignOutViewModel>> {
  final Ref ref;

  SignOutController(this.ref)
    : super(const AsyncValue.data(SignOutViewModel()));

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    // Implementation for sign out logic
    state = const AsyncValue.data(SignOutViewModel());
  }
}

// --- End of sign_out_view\sign_out_controller.dart ---

// --- Start of sign_up_view\sign_up_controller.dart ---

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, AsyncValue<SignUpViewModel>>((ref) {
      return SignUpController(ref);
    });

class SignUpController extends StateNotifier<AsyncValue<SignUpViewModel>> {
  final Ref ref;

  SignUpController(this.ref) : super(const AsyncValue.data(SignUpViewModel()));

  Future<void> signUp(String email, String password) async {
    state = const AsyncValue.loading();
    // Implementation for sign up logic
    state = const AsyncValue.data(SignUpViewModel());
  }
}

// --- End of sign_up_view\sign_up_controller.dart ---

// --- Start of social_worker_dashboard\social_worker_dashboard_controller.dart ---

final socialWorkerDashboardAdapterProvider =
    StateNotifierProvider<
      SocialWorkerDashboardController,
      AsyncValue<Result<SocialWorkerDashboardViewModel>>
    >((ref) {
      return SocialWorkerDashboardController(ref);
    });

final socialWorkerActionHandler = Provider(
  (ref) => (String action) {
    // Action logic here
  },
);

class SocialWorkerDashboardController
    extends StateNotifier<AsyncValue<Result<SocialWorkerDashboardViewModel>>> {
  final Ref ref;

  SocialWorkerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('social_worker');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => SocialWorkerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of social_worker_dashboard\social_worker_dashboard_controller.dart ---

// --- Start of support_dashboard\support_dashboard_controller.dart ---

final supportDashboardAdapterProvider =
    StateNotifierProvider<
      SupportDashboardController,
      AsyncValue<Result<SupportDashboardViewModel>>
    >((ref) {
      return SupportDashboardController(ref);
    });

class SupportDashboardController
    extends StateNotifier<AsyncValue<Result<SupportDashboardViewModel>>> {
  final Ref ref;

  SupportDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('support');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              SupportDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of support_dashboard\support_dashboard_controller.dart ---

// --- Start of system_dashboard\system_dashboard_controller.dart ---

final systemDashboardAdapterProvider =
    StateNotifierProvider<
      SystemDashboardController,
      AsyncValue<Result<SystemDashboardModel>>
    >((ref) {
      return SystemDashboardController();
    });

// Alias for registry compatibility (mapping generalManagerMetricsProvider to this)
final generalManagerMetricsProvider = systemDashboardAdapterProvider;

class SystemDashboardController
    extends StateNotifier<AsyncValue<Result<SystemDashboardModel>>> {
  SystemDashboardController() : super(const AsyncValue.loading()) {
    loadData();
  }

  Future<void> loadData() async {
    state = const AsyncValue.loading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));

      final model = SystemDashboardModel(
        kpis: [
          KpiData(title: 'Global Efficiency', value: '88%', subtitle: 'Stable'),
          KpiData(
            title: 'Active Clinics',
            value: '42',
            subtitle: '3 new this month',
          ),
          KpiData(
            title: 'Patient Satisfaction',
            value: '4.8/5',
            subtitle: 'Excellent',
          ),
          KpiData(
            title: 'Budget Compliance',
            value: '92%',
            subtitle: 'On target',
          ),
        ],
      );

      state = AsyncValue.data(Success(model));
    } catch (e) {
      state = AsyncValue.data(Failure(e));
    }
  }

  void refresh() => loadData();
}

// --- End of system_dashboard\system_dashboard_controller.dart ---

// --- Start of system_verification_dashboard\system_verification_dashboard_controller.dart ---

final systemVerificationDashboardAdapterProvider =
    StateNotifierProvider<
      SystemVerificationDashboardController,
      AsyncValue<Result<SystemVerificationDashboardViewModel>>
    >((ref) {
      return SystemVerificationDashboardController(ref);
    });

class SystemVerificationDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<SystemVerificationDashboardViewModel>>
        > {
  final Ref ref;

  SystemVerificationDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('system_verification');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => SystemVerificationDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of system_verification_dashboard\system_verification_dashboard_controller.dart ---

// --- Start of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_controller.dart ---

final territoryExpansionManagerDashboardAdapterProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerDashboardController,
      AsyncValue<Result<TerritoryExpansionManagerDashboardViewModel>>
    >((ref) {
      return TerritoryExpansionManagerDashboardController(ref);
    });

class TerritoryExpansionManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TerritoryExpansionManagerDashboardViewModel>>
        > {
  final Ref ref;

  TerritoryExpansionManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('territory_expansion_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              TerritoryExpansionManagerDashboardViewModel(
                metrics: metrics,
                insights: const [],
              ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of territory_expansion_manager_dashboard\territory_expansion_manager_dashboard_controller.dart ---

// --- Start of territory_sales_manager_dashboard\territory_sales_manager_dashboard_controller.dart ---

final territorySalesManagerDashboardAdapterProvider =
    StateNotifierProvider<
      TerritorySalesManagerDashboardController,
      AsyncValue<Result<TerritorySalesManagerDashboardViewModel>>
    >((ref) {
      return TerritorySalesManagerDashboardController(ref);
    });

class TerritorySalesManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TerritorySalesManagerDashboardViewModel>>
        > {
  final Ref ref;

  TerritorySalesManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('territory_sales_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => TerritorySalesManagerDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of territory_sales_manager_dashboard\territory_sales_manager_dashboard_controller.dart ---

// --- Start of training_coordinator_dashboard\training_coordinator_dashboard_controller.dart ---

final trainingCoordinatorDashboardAdapterProvider =
    StateNotifierProvider<
      TrainingCoordinatorDashboardController,
      AsyncValue<Result<TrainingCoordinatorDashboardViewModel>>
    >((ref) {
      return TrainingCoordinatorDashboardController(ref);
    });

class TrainingCoordinatorDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TrainingCoordinatorDashboardViewModel>>
        > {
  final Ref ref;

  TrainingCoordinatorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('training_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => TrainingCoordinatorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of training_coordinator_dashboard\training_coordinator_dashboard_controller.dart ---

// --- Start of training_director_certificate_dashboard\training_director_certificate_dashboard_controller.dart ---

final trainingDirectorCertDashboardAdapterProvider =
    StateNotifierProvider<
      TrainingDirectorCertificateDashboardController,
      AsyncValue<Result<TrainingDirectorCertificateDashboardViewModel>>
    >((ref) {
      return TrainingDirectorCertificateDashboardController(ref);
    });

class TrainingDirectorCertificateDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TrainingDirectorCertificateDashboardViewModel>>
        > {
  final Ref ref;

  TrainingDirectorCertificateDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('training_director_certificate');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              TrainingDirectorCertificateDashboardViewModel(
                metrics: metrics,
                insights: const [],
              ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of training_director_certificate_dashboard\training_director_certificate_dashboard_controller.dart ---

// --- Start of training_director_dashboard\training_director_dashboard_controller.dart ---

class TrainingDirectorDashboardController
    extends
        StateNotifier<AsyncValue<Result<TrainingDirectorDashboardViewModel>>> {
  final Ref ref;

  TrainingDirectorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('training_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => TrainingDirectorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of training_director_dashboard\training_director_dashboard_controller.dart ---

// --- Start of training_hub_dashboard\training_hub_dashboard_controller.dart ---

final trainingHubDashboardAdapterProvider =
    StateNotifierProvider<
      TrainingHubDashboardController,
      AsyncValue<Result<TrainingHubDashboardViewModel>>
    >((ref) {
      return TrainingHubDashboardController(ref);
    });

class TrainingHubDashboardController
    extends StateNotifier<AsyncValue<Result<TrainingHubDashboardViewModel>>> {
  final Ref ref;

  TrainingHubDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('training_hub');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => TrainingHubDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of training_hub_dashboard\training_hub_dashboard_controller.dart ---

// --- Start of verification_hub\verification_hub_controller.dart ---

final verificationHubAdapterProvider =
    FutureProvider<Result<VerificationHubModel>>((ref) async {
      final service = ref.watch(dashboardServiceProvider);

      try {
        // Verification Hub might use 'verification_hub' or similar
        final result = await service.getMetrics('verification_hub');
        return result.map(
          (DashboardMetrics metrics) =>
              VerificationHubModel(metrics: metrics, insights: const []),
        );
      } catch (e, st) {
        return Failure(e, st);
      }
    });

class VerificationHubController {
  final WidgetRef ref;

  VerificationHubController(this.ref);

  void refresh() {
    ref.invalidate(verificationHubAdapterProvider);
  }
}

// --- End of verification_hub\verification_hub_controller.dart ---

// --- Start of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_controller.dart ---

final volunteerCoordinatorDashboardAdapterProvider =
    StateNotifierProvider<
      VolunteerCoordinatorDashboardController,
      AsyncValue<Result<VolunteerCoordinatorDashboardViewModel>>
    >((ref) {
      return VolunteerCoordinatorDashboardController(ref);
    });

class VolunteerCoordinatorDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<VolunteerCoordinatorDashboardViewModel>>
        > {
  final Ref ref;

  VolunteerCoordinatorDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('volunteer_coordinator');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => VolunteerCoordinatorDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

// --- End of volunteer_coordinator_dashboard\volunteer_coordinator_dashboard_controller.dart ---
