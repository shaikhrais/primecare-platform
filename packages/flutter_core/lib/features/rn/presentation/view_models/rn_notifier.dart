import 'dart:async';
import '../../../../flutter_core.dart';
import '../../domain/models/rn_data.dart';
import '../../domain/models/rn_state.dart';
import '../../domain/repositories/rn_repository.dart';
import '../providers/providers.dart';

class RnNotifier extends Notifier<RnState>
    with ResilientNotifierMixin<RnState> {
  @override
  RnState build() => const RnState.initial();

  IRnRepository get _repository => ref.watch(rnRepositoryProvider);

  Future<void> loadData() async {
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = const RnState.error(
        'No internet connection. Please check your network and try again.',
      );
      return;
    }

    await guardHydration<RnData>(
      fetch: () => _repository.getRnData(),
      onSuccess: (RnData data) => RnState.loaded(data: data),
      onError: (String message) => RnState.error(message),
      loadingState: const RnState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
