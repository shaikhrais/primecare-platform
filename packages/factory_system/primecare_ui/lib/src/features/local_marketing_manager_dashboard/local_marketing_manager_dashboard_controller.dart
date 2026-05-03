import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
            campaigns: const [],
            referrals: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
