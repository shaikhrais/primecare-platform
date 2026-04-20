import 'dart:async';
import '../../../../flutter_core.dart';
import '../../domain/models/rpn_data.dart';
import '../../domain/models/rpn_state.dart';
import '../../domain/repositories/rpn_repository.dart';
import '../providers/providers.dart';

class RpnNotifier extends Notifier<RpnState>
    with ResilientNotifierMixin<RpnState> {
  @override
  RpnState build() => const RpnState.initial();

  IRpnRepository get _repository => ref.watch(rpnRepositoryProvider);

  Future<void> loadData() async {
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = const RpnState.error(
        'No internet connection. Please check your network and try again.',
      );
      return;
    }

    await guardHydration<RpnData>(
      fetch: () => _repository.getRpnData(),
      onSuccess: (RpnData data) => RpnState.loaded(data: data),
      onError: (String message) => RpnState.error(message),
      loadingState: const RpnState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
