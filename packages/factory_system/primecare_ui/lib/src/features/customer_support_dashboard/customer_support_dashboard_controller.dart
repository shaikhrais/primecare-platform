import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
