import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final territoryExpansionManagerDashboardAdapterProvider =
    StateNotifierProvider<
      TerritoryExpansionManagerDashboardController,
      AsyncValue<Result<TerritoryExpansionManagerDashboardViewModel>>
    >((ref) {
      return TerritoryExpansionManagerDashboardController(ref);
    });

class TerritoryExpansionManagerDashboardController
    extends
        StateNotifier<
          AsyncValue<Result<TerritoryExpansionManagerDashboardViewModel>>
        > {
  final Ref ref;

  TerritoryExpansionManagerDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('territory_expansion_manager');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) =>
              TerritoryExpansionManagerDashboardViewModel(
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
