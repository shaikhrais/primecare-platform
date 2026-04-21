// Layer: 04_VIEW_MODELS
import 'dart:async';
import '../../../../00_B_flutter_core.dart';
import '../../domain/models/02_M_chiropractor_data.dart';
import '../../domain/models/02_M_chiropractor_state.dart';
import '../../domain/repositories/03_D_chiropractor_repository.dart';
import '../providers/03_D_providers.dart';

class ChiropractorNotifier extends Notifier<ChiropractorState>
    with ResilientNotifierMixin<ChiropractorState> {
  @override
  ChiropractorState build() => const ChiropractorState.initial();

  IChiropractorRepository get _repository =>
      ref.watch(chiropractorRepositoryProvider);

  Future<void> loadData() async {
    final bool isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = const ChiropractorState.error(
        'Offline. Chiropractor dashboard requires an active connection.',
      );
      return;
    }

    await guardHydration<DomainResponse>(
      fetch: () => _repository.getChiropractorData(),
      onSuccess: (DomainResponse data) =>
          ChiropractorState.loaded(data: ChiropractorData(metrics: data.data)),
      onError: (String message) => ChiropractorState.error(message),
      loadingState: const ChiropractorState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
