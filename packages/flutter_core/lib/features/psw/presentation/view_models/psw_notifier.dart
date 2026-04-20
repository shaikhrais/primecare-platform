import 'dart:async';
import '../../../../flutter_core.dart';
import '../../domain/models/psw_data.dart';
import '../../domain/models/psw_state.dart';
import '../../domain/repositories/psw_repository.dart';
import '../providers/providers.dart';

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
