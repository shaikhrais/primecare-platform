import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final chiropractorDashboardAdapterProvider =
    StateNotifierProvider<
      ChiropractorController,
      AsyncValue<Result<ChiropractorViewModel>>
    >((ref) {
      return ChiropractorController(ref);
    });

class ChiropractorController
    extends StateNotifier<AsyncValue<Result<ChiropractorViewModel>>> {
  final Ref ref;

  ChiropractorController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('chiropractor');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              ChiropractorViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
