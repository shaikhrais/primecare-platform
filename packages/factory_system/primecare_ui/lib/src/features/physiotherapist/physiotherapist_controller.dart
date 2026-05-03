import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final physiotherapistDashboardAdapterProvider =
    StateNotifierProvider<
      PhysiotherapistController,
      AsyncValue<Result<PhysiotherapistViewModel>>
    >((ref) {
      return PhysiotherapistController(ref);
    });

class PhysiotherapistController
    extends StateNotifier<AsyncValue<Result<PhysiotherapistViewModel>>> {
  final Ref ref;

  PhysiotherapistController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('physiotherapist');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              PhysiotherapistViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
