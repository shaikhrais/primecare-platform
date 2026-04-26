import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';

class ShareholderIntelligenceViewModel {
  final DashboardMetrics metrics;
  final bool isLoading;

  ShareholderIntelligenceViewModel({
    required this.metrics,
    this.isLoading = false,
  });

  factory ShareholderIntelligenceViewModel.empty() =>
      ShareholderIntelligenceViewModel(metrics: DashboardMetrics.empty());
}

class ShareholderIntelligenceNotifier
    extends StateNotifier<ShareholderIntelligenceViewModel> {
  final Ref ref;

  ShareholderIntelligenceNotifier(this.ref)
    : super(ShareholderIntelligenceViewModel.empty()) {
    _hydrateData();
  }

  Future<void> _hydrateData() async {
    state = ShareholderIntelligenceViewModel(
      metrics: state.metrics,
      isLoading: true,
    );

    // Simulate fetching pipeline and telemetry metrics
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    state = ShareholderIntelligenceViewModel(
      metrics: DashboardMetrics(
        kpis: [
          KpiMetric(
            title: LocaleKeys
                .dashboards_shareholderintelligence_labels_zero_error_compliance
                .tr(),
            value: '99%',
            status: 'success',
            trend: 'up',
            subtitle: LocaleKeys.dashboards_shareholderintelligence_labels_1_2
                .tr(),
          ),
          KpiMetric(
            title: LocaleKeys
                .dashboards_shareholderintelligence_labels_features_in_pipeline
                .tr(),
            value: '15',
            status: 'info',
            trend: 'up',
            subtitle: LocaleKeys
                .dashboards_shareholderintelligence_labels_active_development
                .tr(),
          ),
        ],
        recentActivity: [
          DashboardActivity(
            title: LocaleKeys
                .dashboards_shareholderintelligence_labels_telemetry_hydrated
                .tr(),
            subtitle: LocaleKeys
                .dashboards_shareholderintelligence_labels_regional_manager_ontario_dashboard
                .tr(),
            timestamp: 'Just now',
            icon: 'bolt',
            color: 'orange',
          ),
        ],
      ),
      isLoading: false,
    );
  }
}

final shareholderIntelligenceAdapterProvider =
    StateNotifierProvider<
      ShareholderIntelligenceNotifier,
      ShareholderIntelligenceViewModel
    >((ref) {
      // 1. Mandatory Governance Gate
      AdapterModulationGovernor.canExecute(ref, PlatformSubsystem.metrics);

      // 2. Instantiate and return notifier
      return ShareholderIntelligenceNotifier(ref);
    });
