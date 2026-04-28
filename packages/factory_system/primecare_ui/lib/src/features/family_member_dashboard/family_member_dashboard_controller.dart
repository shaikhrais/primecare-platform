import 'dart:async';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/features_model.dart';

final familyMemberDashboardAdapterProvider =
    StateNotifierProvider<
      FamilyMemberDashboardController,
      AsyncValue<Result<FamilyMemberDashboardViewModel>>
    >((ref) {
      return FamilyMemberDashboardController(ref);
    });

class FamilyMemberDashboardController
    extends StateNotifier<AsyncValue<Result<FamilyMemberDashboardViewModel>>> {
  final Ref ref;

  FamilyMemberDashboardController(this.ref)
    : super(const AsyncValue.loading()) {
    refresh();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);

    try {
      final result = await service.getMetrics('family_member');
      state = AsyncValue.data(
        result.map(
          (DashboardMetrics metrics) => FamilyMemberDashboardViewModel(
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
