import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../infrastructure/01_I_adapter_modulation_governor.dart';
import '../../../infrastructure/01_I_modulation_governance_registry.dart';
import '../../../models/core/02_M_dashboard_models.dart';

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

class ShareholderIntelligenceNotifier extends StateNotifier<ShareholderIntelligenceViewModel> {
  final Ref ref;

  ShareholderIntelligenceNotifier(this.ref) : super(ShareholderIntelligenceViewModel.empty()) {
    _hydrateData();
  }

  Future<void> _hydrateData() async {
    state = ShareholderIntelligenceViewModel(metrics: state.metrics, isLoading: true);
    
    // Simulate fetching pipeline and telemetry metrics
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    state = ShareholderIntelligenceViewModel(
      metrics: DashboardMetrics(
        kpis: [
          const KpiMetric(
            title: 'Zero-Error Compliance',
            value: '99%',
            status: 'success',
            trend: 'up',
            subtitle: '+1.2%',
          ),
          const KpiMetric(
            title: 'Features in Pipeline',
            value: '15',
            status: 'info',
            trend: 'up',
            subtitle: 'Active development',
          ),
        ],
        recentActivity: [
          const DashboardActivity(
            title: 'Telemetry Hydrated',
            subtitle: 'regional-manager-ontario-dashboard',
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

final shareholderIntelligenceAdapterProvider = StateNotifierProvider<
    ShareholderIntelligenceNotifier, ShareholderIntelligenceViewModel>((ref) {
  // 1. Mandatory Governance Gate
  AdapterModulationGovernor.canExecute(ref, PlatformSubsystem.metrics);

  // 2. Instantiate and return notifier
  return ShareholderIntelligenceNotifier(ref);
});
