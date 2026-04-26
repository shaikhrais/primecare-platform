import 'package:primecare_ui/primecare_ui.dart';
// Layer: 04_VIEW_MODELS
import 'dart:async';
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../domain/models/02_M_rpn_data.dart';
import '../../domain/models/02_M_rpn_state.dart';
import '../../domain/repositories/03_D_rpn_repository.dart';
import '../providers/03_D_providers.dart';

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
