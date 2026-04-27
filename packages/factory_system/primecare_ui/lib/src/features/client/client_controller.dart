import 'package:primecare_ui/src/shared/primecare_adapters.dart' hide Result;
import 'client_model.dart';

final clientAdapterProvider = StateNotifierProvider<ClientController, AsyncValue<Result<ClientViewModel>>>((ref) {
  return ClientController(ref);
});

class ClientController extends StateNotifier<AsyncValue<Result<ClientViewModel>>> {
  final Ref ref;
  
  ClientController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('client');
      state = AsyncValue.data(result.map((metrics) => ClientViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
