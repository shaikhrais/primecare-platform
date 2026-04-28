import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final familyDashboardAdapterProvider =
    StateNotifierProvider<
      FamilyDashboardController,
      AsyncValue<Result<FamilyDashboardViewModel>>
    >((ref) {
      return FamilyDashboardController(ref);
    });

class FamilyDashboardController
    extends StateNotifier<AsyncValue<Result<FamilyDashboardViewModel>>> {
  final Ref ref;

  FamilyDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('family');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              FamilyDashboardViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
