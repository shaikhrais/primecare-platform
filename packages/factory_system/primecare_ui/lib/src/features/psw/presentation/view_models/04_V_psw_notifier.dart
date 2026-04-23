import 'package:primecare_ui/primecare_ui.dart';
// Layer: 04_VIEW_MODELS
import 'dart:async';
import 'package:flutter_core/00_B_flutter_core.dart';
import '../../domain/models/02_M_psw_data.dart';
import '../../domain/models/02_M_psw_state.dart';
import '../../domain/repositories/03_D_psw_repository.dart';
import '../providers/03_D_providers.dart';

class PswNotifier extends Notifier<PswState>
    with ResilientNotifierMixin<PswState> {
  @override
  PswState build() => const PswState.initial();

  IPswRepository get _repository => ref.watch(pswRepositoryProvider);

  Future<void> loadData() async {
    final isOnline = ref.read(isOnlineProvider);
    if (!isOnline) {
      state = const PswState.error(
        'No internet connection. Please check your network and try again.',
      );
      return;
    }

    await guardHydration<PswData>(
      fetch: () => _repository.getPswData(),
      onSuccess: (PswData data) => PswState.loaded(data: data),
      onError: (String message) => PswState.error(message),
      loadingState: const PswState.loading(),
      category: ExecutionGateCategory.domainApi,
    );
  }
}
