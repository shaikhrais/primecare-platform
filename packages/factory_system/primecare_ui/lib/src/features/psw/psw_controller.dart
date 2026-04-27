import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'psw_model.dart';

final pswAdapterProvider = StateNotifierProvider<PswController, AsyncValue<Result<PswViewModel>>>((ref) {
  return PswController(ref);
});

class PswController extends StateNotifier<AsyncValue<Result<PswViewModel>>> {
  final Ref ref;
  
  PswController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('psw');
      state = AsyncValue.data(result.map((metrics) => PswViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
