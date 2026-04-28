import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
