import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
