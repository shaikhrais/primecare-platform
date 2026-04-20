import 'dart:async';
import '../../../../flutter_core.dart';
import '../../domain/models/chiropractor_data.dart';
import '../../domain/models/chiropractor_state.dart';
import '../../domain/repositories/chiropractor_repository.dart';
import '../providers/providers.dart';

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
