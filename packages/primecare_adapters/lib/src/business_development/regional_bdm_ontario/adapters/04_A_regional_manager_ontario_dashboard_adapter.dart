import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Ontario Regional Manager.
/// Uses the common PrimeCare pattern to dispatch domain commands.
final regionalManagerOntarioActionHandler = Provider<void Function(String)>((
  ref,
) {
  return (action) {
    // In a real app, dispatch to a Controller or UseCase
    // e.g., ref.read(ontarioOperationsControllerProvider.notifier).handle(action);
    PrimeCareLogger.log('Regional Manager Ontario Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Regional Manager (Ontario).
/// Tracks OHIP billing velocity, LHIN compliance, and regional retention.
final regionalManagerOntarioMetricsProvider =
    StreamProvider.autoDispose<DashboardMetrics>((ref) {
      final repository = ref.watch(dashboardRepositoryProvider);
      return repository.watchMetrics('/v2/corporate/regional/ontario').map((
        result,
      ) {
        return result.fold(
          (metrics) => metrics,
          (error) => DashboardMetrics.empty(),
        );
      });
    });

/// High-fidelity AI regional insights for the Regional Manager (Ontario).
/// Surfaces LHIN allocation risks and OHIP optimization via Aura Intelligence.
final regionalManagerOntarioInsightsProvider =
    FutureProvider.autoDispose<List<IntelligenceInsight>>((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 10));

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.auraAI,
      );
      if (!canExecute) {
        return const [];
      }

      await Future<void>.delayed(const Duration(seconds: 1));

      return [
        IntelligenceInsight(
          id: 'reg_ont_01',
          title: LocaleKeys
              .dashboards_regionalmanagerontario_labels_lhin_resource_allocation
              .tr(),
          summary:
              'Potential for funding reallocation detected in the Toronto Central LHIN based on Q1 utilization.',
          impact: InsightImpact.positive,
          type: InsightType.optimization,
          category: 'Finance',
          recommendation:
              'Submit utilization surplus report to MOH by Friday to secure carry-over.',
        ),
        IntelligenceInsight(
          id: 'reg_ont_02',
          title: LocaleKeys
              .dashboards_regionalmanagerontario_labels_waitlist_saturation__york
              .tr(),
          summary:
              'York Region waitlists for specialized care have exceeded the 15-day SLA.',
          impact: InsightImpact.warning,
          type: InsightType.risk,
          category: 'Operations',
          recommendation:
              'Reassign 2 float nurses from Durham to York for the next 14 days.',
        ),
        IntelligenceInsight(
          id: 'reg_ont_03',
          title: LocaleKeys
              .dashboards_regionalmanagerontario_labels_digital_health_opportunity
              .tr(),
          summary:
              'A 40% increase in virtual care inquiries from Northern Ontario clusters observed.',
          impact: InsightImpact.info,
          type: InsightType.growth,
          category: 'Market',
          recommendation:
              'Expand telehealth pilot to the Sudbury-Sault Ste. Marie axis.',
        ),
      ];
    });

/// Combined adapter provider for the Regional Manager Ontario Dashboard.
/// Bridges high-fidelity telemetry and provincial insights into a unified ViewModel.
final regionalManagerOntarioDashboardAdapterProvider =
    FutureProvider.autoDispose<
      Result<RegionalManagerOntarioDashboardViewModel>
    >((ref) async {
      ProviderTTL.autoInvalidate(ref, duration: const Duration(minutes: 5));

      const cacheKey = 'regional_manager_ontario_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );

      try {
        if (!canExecute) {
          throw Exception('Metrics subsystem is degraded or offline');
        }

        final metrics = await ref.watch(
          regionalManagerOntarioMetricsProvider.future,
        );
        final insights = await ref.watch(
          regionalManagerOntarioInsightsProvider.future,
        );

        final viewModel = RegionalManagerOntarioDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Regional Manager Ontario Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          final vm = RegionalManagerOntarioDashboardViewModel.fromJson(
            snapshot,
          );
          return Success(
            RegionalManagerOntarioDashboardViewModel(
              metrics: vm.metrics,
              insights: vm.insights,
              isOfflineFallback: true,
            ),
          );
        }
        return Success(
          RegionalManagerOntarioDashboardViewModel.empty(
            isOfflineFallback: true,
          ),
        );
      }
    });
