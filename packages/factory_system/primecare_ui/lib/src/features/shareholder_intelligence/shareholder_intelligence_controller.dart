import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final shareholderIntelligenceAdapterProvider =
    StateNotifierProvider<
      ShareholderIntelligenceController,
      AsyncValue<Result<ShareholderIntelligenceViewModel>>
    >((ref) {
      return ShareholderIntelligenceController(ref);
    });

class ShareholderIntelligenceController
    extends
        StateNotifier<AsyncValue<Result<ShareholderIntelligenceViewModel>>> {
  final Ref ref;

  ShareholderIntelligenceController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('shareholder_intelligence');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => ShareholderIntelligenceViewModel(
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
