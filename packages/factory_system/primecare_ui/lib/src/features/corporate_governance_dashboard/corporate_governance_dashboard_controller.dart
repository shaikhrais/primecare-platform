import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final corporateGovernanceDashboardAdapterProvider =
    StateNotifierProvider<
      CorporateGovernanceDashboardController,
      AsyncValue<Result<CorporateGovernanceDashboardViewModel>>
    >((ref) {
      return CorporateGovernanceDashboardController(ref);
    });

class CorporateGovernanceDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<CorporateGovernanceDashboardViewModel>>
        > {
  final Ref ref;

  CorporateGovernanceDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('corporate_governance');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => CorporateGovernanceDashboardViewModel(
            metrics: metrics,
            insights: const [],
          ),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void triggerRemediation() {
    // Remediation logic here
  }
}
