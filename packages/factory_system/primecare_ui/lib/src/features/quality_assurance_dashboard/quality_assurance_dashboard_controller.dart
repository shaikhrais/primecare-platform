import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final qualityAssuranceDashboardAdapterProvider =
    StateNotifierProvider<
      QualityAssuranceDashboardController,
      AsyncValue<Result<QualityAssuranceDashboardViewModel>>
    >((ref) {
      return QualityAssuranceDashboardController(ref);
    });

class QualityAssuranceDashboardController
    extends
        StateNotifier<AsyncValue<Result<QualityAssuranceDashboardViewModel>>> {
  final Ref ref;

  QualityAssuranceDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('quality_assurance');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => QualityAssuranceDashboardViewModel(
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
