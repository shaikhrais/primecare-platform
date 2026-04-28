import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final clinicalDirectorAdapterProvider =
    StateNotifierProvider<
      ClinicalDirectorController,
      AsyncValue<Result<ClinicalDirectorViewModel>>
    >((ref) {
      return ClinicalDirectorController(ref);
    });

class ClinicalDirectorController
    extends StateNotifier<AsyncValue<Result<ClinicalDirectorViewModel>>> {
  final Ref ref;

  ClinicalDirectorController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('clinical_director');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              ClinicalDirectorViewModel(metrics: metrics, insights: const []),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
