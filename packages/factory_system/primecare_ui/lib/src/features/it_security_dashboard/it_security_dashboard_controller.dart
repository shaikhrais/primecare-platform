import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
