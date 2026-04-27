import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'rpn_model.dart';

final rpnAdapterProvider = StateNotifierProvider<RpnController, AsyncValue<Result<RpnViewModel>>>((ref) {
  return RpnController(ref);
});

class RpnController extends StateNotifier<AsyncValue<Result<RpnViewModel>>> {
  final Ref ref;
  
  RpnController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('rpn');
      state = AsyncValue.data(result.map((metrics) => RpnViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
