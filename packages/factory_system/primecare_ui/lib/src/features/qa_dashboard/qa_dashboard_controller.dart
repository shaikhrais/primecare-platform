import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

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
